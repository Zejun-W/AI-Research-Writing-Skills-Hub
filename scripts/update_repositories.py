#!/usr/bin/env python3
"""Refresh GitHub repository metadata and regenerate README rankings."""
from __future__ import annotations
import argparse
import datetime as dt
import json
import os
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "repositories.json"


def github_get(repo: str, token: str | None) -> dict:
    req = urllib.request.Request(
        f"https://api.github.com/repos/{repo}",
        headers={
            "Accept": "application/vnd.github+json",
            "User-Agent": "AI-Research-Writing-Skills-Hub",
            **({"Authorization": f"Bearer {token}"} if token else {}),
        },
    )
    with urllib.request.urlopen(req, timeout=30) as response:
        return json.load(response)


def replace_block(path: Path, table: str) -> None:
    text = path.read_text(encoding="utf-8")
    pattern = re.compile(r"<!-- REPO_TABLE_START -->.*?<!-- REPO_TABLE_END -->", re.S)
    if not pattern.search(text):
        raise RuntimeError(f"Missing table markers in {path}")
    path.write_text(pattern.sub(table, text), encoding="utf-8")


def zh_table(items: list[dict]) -> str:
    lines = [
        "<!-- REPO_TABLE_START -->",
        "> Stars、Forks、Issues 和更新时间由 GitHub Actions 每日同步。",
        "",
        "| 排名 | 仓库 | Stars | Forks | 类型 | 最适合 | 综合建议 |",
        "|---:|---|---:|---:|---|---|---:|",
    ]
    for i, r in enumerate(items, 1):
        lines.append(f"| {i} | [{r['repo']}]({r['url']}) | {r.get('stars',0):,} | {r.get('forks',0):,} | {r['category']} | {r['best_zh']} | {r['recommendation']:.1f}/5 |")
    lines.append("<!-- REPO_TABLE_END -->")
    return "\n".join(lines)


def en_table(items: list[dict]) -> str:
    lines = [
        "<!-- REPO_TABLE_START -->",
        "> Stars, forks, issues, and update dates are refreshed daily by GitHub Actions.",
        "",
        "| Rank | Repository | Stars | Forks | Type | Best for | Score |",
        "|---:|---|---:|---:|---|---|---:|",
    ]
    for i, r in enumerate(items, 1):
        lines.append(f"| {i} | [{r['repo']}]({r['url']}) | {r.get('stars',0):,} | {r.get('forks',0):,} | {r['category']} | {r['best_en']} | {r['recommendation']:.1f}/5 |")
    lines.append("<!-- REPO_TABLE_END -->")
    return "\n".join(lines)


def validate(items: list[dict]) -> None:
    required = {"repo", "url", "category", "focus_zh", "focus_en", "best_zh", "best_en", "recommendation"}
    seen = set()
    for idx, item in enumerate(items):
        missing = required - item.keys()
        if missing:
            raise ValueError(f"Entry {idx} missing fields: {sorted(missing)}")
        if item["repo"] in seen:
            raise ValueError(f"Duplicate repository: {item['repo']}")
        seen.add(item["repo"])
        if not 0 <= float(item["recommendation"]) <= 5:
            raise ValueError(f"Invalid score for {item['repo']}")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true", help="Validate local data without network calls")
    args = parser.parse_args()
    items = json.loads(DATA.read_text(encoding="utf-8"))
    validate(items)
    if args.check:
        print(f"Validated {len(items)} repository entries.")
        return 0

    token = os.getenv("GITHUB_TOKEN")
    today = dt.datetime.now(dt.timezone.utc).date().isoformat()
    failures = []
    for item in items:
        try:
            meta = github_get(item["repo"], token)
            item.update({
                "stars": meta.get("stargazers_count", item.get("stars", 0)),
                "forks": meta.get("forks_count", item.get("forks", 0)),
                "open_issues": meta.get("open_issues_count", item.get("open_issues", 0)),
                "updated_at": meta.get("updated_at", ""),
                "archived": bool(meta.get("archived", False)),
                "license": (meta.get("license") or {}).get("spdx_id") or item.get("license", "Unknown"),
                "last_checked": today,
            })
        except (urllib.error.URLError, urllib.error.HTTPError, TimeoutError, json.JSONDecodeError) as exc:
            failures.append(f"{item['repo']}: {exc}")

    items.sort(key=lambda r: (r.get("stars", 0), r["repo"].lower()), reverse=True)
    DATA.write_text(json.dumps(items, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    replace_block(ROOT / "README.md", zh_table(items))
    replace_block(ROOT / "README_EN.md", en_table(items))
    print(f"Updated {len(items) - len(failures)}/{len(items)} repositories.")
    if failures:
        print("Warnings:", *failures, sep="\n- ", file=sys.stderr)
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
