---
name: evidence-and-citation-auditor
description: Audit scientific claims, citations, provenance, and reference placement without fabricating missing evidence.
version: 1.0.0
author: Zejun-W
license: MIT
---

# Evidence and Citation Auditor

## Purpose

Check whether every material scientific claim is supported by appropriate evidence and whether each citation is real, relevant, and correctly placed.

## Procedure

1. Extract claims sentence by sentence.
2. Classify each claim as background fact, prior-work description, method statement, experimental observation, interpretation, or speculation.
3. Record the required evidence type for each claim.
4. Verify citation existence using primary sources when external access is available.
5. Compare cited content with the wording of the claim; title similarity is not evidence.
6. Flag version conflicts among arXiv, conference, and journal editions.
7. Check that numerical claims trace to experiment logs or tables.
8. Produce an audit table with: claim, evidence, citation, status, risk, and required action.

## Status values

- `SUPPORTED`
- `PARTIALLY_SUPPORTED`
- `MISPLACED_CITATION`
- `SOURCE_NOT_VERIFIED`
- `CONTRADICTED`
- `NEEDS_PRIMARY_SOURCE`
- `AUTHOR_CONFIRMATION_REQUIRED`

## Rules

Never generate a plausible-looking reference to fill a gap. A missing citation remains missing until verified.
