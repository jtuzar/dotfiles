---
name: test-suite-review
description: Reviews a test suite like a QA engineer and should trigger when asked to assess whether tests are useful, overlapping, redundant, brittle, or missing important coverage.
---

# Test Suite Review

## What it does

- Reviews test files and test directories for usefulness, overlap, coverage gaps, maintainability, and flakiness risk.
- Produces a ranked assessment of which tests are high value, redundant, brittle, outdated, or good candidates for consolidation.
- Explains the reasoning behind each finding instead of giving generic quality advice.

## When to use it

Use this skill when the task involves:
- reviewing a test suite or a subset of test files
- deciding whether tests are useful, redundant, stale, or safe to remove
- checking whether multiple tests cover the same behavior with little added value
- identifying important missing scenarios or edge cases in existing tests
- assessing test quality before cleanup, refactoring, or consolidation

## Do not use it when

- the task is to write new tests rather than review existing ones
- the task is mainly about fixing production code instead of evaluating tests
- the user only wants command execution such as running the suite or collecting coverage output
- the request is about framework setup, CI wiring, or tooling configuration rather than test quality

## Workflow

1. Inspect the provided test files, related source files when needed, and any nearby fixtures, helpers, or mocks needed to understand intent.
2. Group tests by behavior, code path, or user scenario so overlap and gaps can be evaluated at the behavior level, not just file by file.
3. Judge each group for:
   - value: does it protect an important behavior or regression risk?
   - uniqueness: does it add coverage not already provided elsewhere?
   - clarity: is the purpose obvious from the setup, naming, and assertions?
   - resilience: is it likely to be flaky, over-mocked, over-specified, or tightly coupled to implementation details?
   - coverage shape: what meaningful scenarios, branches, or edge cases appear untested?
4. Rank findings by impact. Start with duplicate or near-duplicate coverage, stale or low-signal tests, brittle tests, and major missing scenarios.
5. Return a concise review that says what to keep, what to merge, what to rewrite, what may be removable, and why.
6. If confidence depends on runtime evidence, note exactly what should be verified next, such as targeted test runs or coverage checks, rather than pretending certainty.

## Guardrails

- Default to analysis and recommendations only; do not edit tests unless the user separately asks for changes.
- Do not recommend deleting a test solely because it looks similar. Explain what behavior overlap makes it redundant and call out uncertainty when intent is ambiguous.
- Prefer behavior-level reasoning over assertion counting or file size heuristics.
- Treat tests that document business-critical behavior as valuable even when they overlap partially with broader coverage.
- Distinguish clearly between redundant coverage, complementary coverage, and repeated setup.
- Avoid broad claims about product correctness; evaluate what the suite demonstrates and what it does not.
- If you cannot infer the intended behavior from tests alone, say so and anchor conclusions to the available evidence.

## Verification

- Confirm the review identifies concrete behaviors or scenarios, not just file-level impressions.
- Confirm each deletion or consolidation candidate includes a reason grounded in overlap, low signal, or brittleness.
- Confirm missing coverage findings are tied to specific branches, edge cases, or user flows.
- Confirm the output is prioritized so the user can act on the highest-value cleanup or improvement work first.
