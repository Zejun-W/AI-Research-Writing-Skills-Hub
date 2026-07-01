---
name: paper-section-rewriter
description: Rewrite one academic-paper section while preserving technical meaning, constraints, notation, and author voice.
version: 1.0.0
author: Zejun-W
license: MIT
---

# Paper Section Rewriter

## Purpose

Produce a complete replacement for one bounded paper section, not a broad rewrite of the entire manuscript.

## Before writing

- Identify section type and rhetorical purpose.
- Capture protected facts, equations, citations, terminology, and length constraints.
- List any inconsistencies that cannot be fixed within the section.

## Section patterns

- **Abstract:** task → limitation → proposed method → key mechanisms → evidence and conclusion.
- **Introduction:** context → concrete limitation → challenge → solution mapping → contributions.
- **Related work:** chronological or conceptual development → representative methods → shared gap → relation to this work.
- **Method:** input and notation → module motivation → operation/equation → output → connection to next module.
- **Experiments:** question → setup → observation → evidence-based explanation → takeaway.
- **Conclusion:** solved problem → technical idea → strongest evidence → limitations → specific future work.

## Style constraints

Use precise verbs, explicit logical links, and moderate sentence length. Remove repeated motivation, empty transition sentences, exaggerated novelty, and unsupported generalization.

## Output

Return the full replacement section, a compact change table, and unresolved issues.
