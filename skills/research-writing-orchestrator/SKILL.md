---
name: research-writing-orchestrator
description: Orchestrate evidence-grounded, section-by-section academic writing and revision with explicit quality gates.
version: 1.0.0
author: Zejun-W
license: MIT
---

# Research Writing Orchestrator

## Purpose

Coordinate an academic paper project without taking authorship responsibility away from the researcher. Work section by section, preserve a traceable evidence base, and stop unsupported claims before they enter the manuscript.

## Activation

Use when the user asks to plan, draft, revise, translate, or quality-check a research paper or a substantial paper section.

## Required inputs

Prefer, when available: current manuscript, target venue, reference paper or style guide, source code, experiment tables, bibliography, figure list, terminology list, and explicit non-editable constraints.

## Workflow

1. **Scope lock**
   - Identify the exact section and files in scope.
   - List content that must not be changed.
   - Do not silently modify figures, tables, numbering, references, or other sections.

2. **Evidence map**
   - Map each intended claim to one of: manuscript source, code, experiment output, cited paper, or author-provided fact.
   - Mark unsupported items as `NEEDS_VERIFICATION` instead of completing them by guesswork.

3. **Section diagnosis**
   - State the section's rhetorical job.
   - Detect missing logical steps, repetition, terminology drift, overclaiming, and mismatches with figures/equations.

4. **Atomic revision**
   - Revise only the smallest coherent section.
   - Preserve correct technical content and author intent.
   - Prefer precise, compact sentences over generic academic filler.

5. **Quality gates**
   - Technical claims supported.
   - Terms and symbols defined before use.
   - Equations dimensionally and semantically consistent.
   - Figures and tables referenced correctly.
   - Citations placed after the exact claims they support.
   - Conclusions do not exceed evidence.

6. **Deliverables**
   - Complete replacement text.
   - Concise change log.
   - Unresolved verification list.
   - Cross-section issues to handle later.

## Non-negotiable rules

- Never invent papers, authors, DOIs, data, experiments, results, or reviewer comments.
- Never claim to have read a paper unless its content was actually provided or retrieved.
- Separate factual reconstruction from editorial recommendation.
- The author must approve scientific interpretation and final claims.
