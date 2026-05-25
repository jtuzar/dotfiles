---
name: writing-meaningful-tests
description: Writes high-value tests that protect behavior and should trigger when asked to add, improve, or rewrite tests with meaningful coverage instead of superficial assertions.
---

# Writing Meaningful Tests

## What it does

- Writes or rewrites tests that protect important behavior, likely regressions, and edge cases.
- Prefers behavior-focused coverage over tests that only exercise implementation details or inflate test counts.
- Produces concise explanations of what the new tests prove and any meaningful gaps that remain.

## When to use it

Use this skill when the task involves:
- adding tests for a new feature, bug fix, refactor, or regression
- improving weak, brittle, shallow, or low-signal tests
- deciding what scenarios are worth testing before writing the tests
- rewriting tests so they verify behavior and outcomes instead of internal steps
- covering edge cases, failure paths, or user-visible flows that matter to correctness

## Do not use it when

- the task is to review a test suite without changing it; use `test-suite-review` instead
- the task is mainly about test framework setup, CI wiring, or tooling configuration
- the user only wants to run tests, collect coverage, or debug an environment issue
- the request is about changing production code with no real test-writing task

## Workflow

1. Identify the behavior under change by reading the relevant production code, existing tests, and the user request. State what failure or regression the test should catch.
2. Choose the highest-value coverage first:
   - the main success path
   - the bug or regression path
   - important edge cases or failure states
   - contract boundaries that could break during refactors
3. Write tests at the highest practical level of behavior. Prefer public interfaces, observable outputs, and user-visible effects over private helpers, call counts, or incidental intermediate state.
4. Keep each test focused on one meaningful behavior. Use clear setup, minimal mocking, and assertions that explain what must remain true.
5. Avoid duplicate coverage. If a scenario is already protected elsewhere, add a new test only when it covers a distinct behavior, branch, or failure mode.
6. Run the most relevant test command available. If full validation is not practical, run the narrowest useful test target and say what still needs verification.

## Guardrails

- Do not write tests that merely restate the implementation line by line.
- Do not over-mock when a real integration boundary or public API can be exercised directly.
- Do not assert every incidental field or intermediate call if the behavior can be proven with fewer, stronger assertions.
- Prefer regression-oriented scenarios over coverage-chasing additions.
- When behavior is ambiguous, anchor the test to existing product expectations, bug reports, or surrounding tests instead of inventing new rules silently.
- If a code path is hard to test meaningfully, say why and choose the least brittle test seam available.

## Verification

- Confirm each new or updated test protects a concrete behavior, bug, edge case, or contract.
- Confirm assertions would fail for a real regression, not just cosmetic implementation changes.
- Confirm the tests avoid obvious duplication with nearby coverage.
- Confirm the reported validation includes the test command run, or clearly states what could not be run.
