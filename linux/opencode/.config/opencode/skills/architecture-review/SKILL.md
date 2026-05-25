---
name: architecture-review
description: Reviews a codebase or subsystem for architectural quality and should trigger when asked to assess boundaries, dependency flow, layering, coupling, scalability, maintainability, or design risks.
---

# Architecture Review

## What it does

- Reviews a codebase, subsystem, or proposed design for architectural strengths, weaknesses, and tradeoffs.
- Evaluates boundaries, dependency direction, module responsibilities, cohesion, coupling, and how well the structure supports change.
- Produces prioritized findings with concrete evidence from the code instead of generic design advice.

## When to use it

Use this skill when the task involves:
- reviewing the architecture of a repository, service, app, or major subsystem
- assessing layering, module boundaries, dependency flow, ownership, or separation of concerns
- identifying maintainability, scalability, extensibility, or testability risks rooted in structure
- checking whether an implementation matches an intended architecture or design pattern
- preparing an architecture critique, technical due diligence review, or refactor plan grounded in code

## Do not use it when

- the task is to fix a specific bug or implement a feature rather than evaluate structure
- the task is a security review, performance profile, or test-suite assessment unless architecture is the main question
- the request is for framework setup instructions or style nitpicks rather than system design reasoning
- the user only wants a summary of files without analysis of responsibilities and relationships

## Workflow

1. Establish the review scope first: whole repository, specific service, or a bounded slice such as API layer, domain layer, or data access layer.
2. Inspect the structure that defines architecture: entry points, package and directory layout, dependency edges, interfaces, state boundaries, persistence access, cross-cutting concerns, and major runtime flows.
3. Reconstruct the intended design from the code and docs that exist. Identify the main components, what each owns, and how data and control move between them.
4. Evaluate the design against architecture-focused criteria:
   - boundaries: are responsibilities clearly separated?
   - dependencies: do lower-level details leak upward or create cycles?
   - cohesion and coupling: do modules group the right reasons to change?
   - changeability: how hard is it to add features or swap implementations safely?
   - operational fit: does the structure support expected scale, failure handling, and observability needs?
5. Rank findings by impact. Start with structural issues that increase change cost, create hidden coupling, duplicate business logic, or make correctness hard to preserve.
6. Return a concise review with strengths, risks, and recommended next moves. Tie every major point to concrete files, dependency patterns, or runtime paths.
7. If certainty is limited, say what to inspect next, such as missing services, deployment context, production constraints, or targeted runtime verification.

## Guardrails

- Default to analysis and recommendations; do not rewrite the architecture unless the user separately asks for changes.
- Prefer evidence from actual module relationships and code paths over pattern-name checking.
- Do not call something an architecture problem just because it differs from a textbook pattern; explain the practical consequence.
- Distinguish local code smells from structural problems that materially affect change, reliability, or team ownership.
- Acknowledge tradeoffs. A shortcut may be acceptable in a small codebase but risky in a growing or multi-team system.
- When inferring intent, separate what the architecture appears to be from what it should become.

## Verification

- Confirm the review identifies concrete architectural units, boundaries, or dependency flows rather than only file-by-file commentary.
- Confirm each major finding explains why it matters for change cost, correctness, scalability, operability, or team velocity.
- Confirm recommendations are prioritized and proportional, not a blanket rewrite.
- Confirm uncertainty is called out wherever the code alone does not reveal runtime or organizational constraints.
