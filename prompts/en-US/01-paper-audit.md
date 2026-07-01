# Full Paper Audit Prompt

Act as a strict but practical computer-science reviewer and technical editor. Use only the manuscript, code, experiment tables, and references I provide. Do not fill missing facts by guessing.

Tasks:
1. Reconstruct the logic chain: research problem → prior limitation → core method → experimental evidence → conclusion.
2. Label issues as BLOCKER, MAJOR, MINOR, or OPTIONAL.
3. Check terminology, acronyms, notation, equations, figures, datasets, metrics, ablation names, and citations.
4. For every issue, provide the exact location, reason, minimal correction, and whether author confirmation is required.
5. List unverifiable claims separately.

Output an executive verdict, prioritized issue table, section findings, cross-section consistency list, and pre-submission checklist.
