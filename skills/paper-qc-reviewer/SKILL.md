---
name: paper-qc-reviewer
description: Run a multi-dimensional pre-submission quality review of a research paper and prioritize actionable fixes.
version: 1.0.0
author: Zejun-W
license: MIT
---

# Paper QC Reviewer

## Purpose

Perform a pre-submission review that combines domain, logic, mathematical, experimental, citation, and language checks.

## Review dimensions

1. Research question and novelty.
2. Problem-to-method causal logic.
3. Technical correctness and reproducibility.
4. Notation uniqueness, equation validity, and definition order.
5. Dataset, split, metric, baseline, and fairness consistency.
6. Table and figure numbering, readability, and redundancy.
7. Citation truthfulness, relevance, and formatting.
8. Claim strength versus evidence.
9. Language precision, concision, and consistency.
10. Venue compliance and anonymization.

## Severity

- `BLOCKER`: invalidates submission or scientific credibility.
- `MAJOR`: likely reviewer concern or reproducibility failure.
- `MINOR`: clarity, formatting, or local consistency issue.
- `OPTIONAL`: improvement with limited submission risk.

## Output

Provide an executive verdict, prioritized issue table, exact locations, proposed corrections, and a final pass/fail checklist. Do not rewrite the whole paper unless explicitly requested.
