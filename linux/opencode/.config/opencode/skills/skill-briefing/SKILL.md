---
name: skill-briefing
description: Collects the missing requirements for a new reusable skill and turns them into a concise brief for `skill-authoring`. Use when a user wants a new skill but the request is still too vague to draft `SKILL.md` well.
---

# Skill Briefing

## What it does

- Turns a rough skill idea into a compact authoring brief.
- Asks only the questions needed to define scope, triggers, workflow, guardrails, and verification.
- Packages the answers so `skill-authoring` can draft the final `SKILL.md` with minimal follow-up.

## When to use it

Use this skill when the task involves:
- creating a new skill from a vague or partial idea
- gathering missing requirements before writing `SKILL.md`
- clarifying the audience, boundaries, and triggers for a proposed skill
- preparing structured input for `skill-authoring`
- turning a rough idea into a draftable skill brief

## Do not use it when

- the user already provided enough detail to draft the skill directly
- the task is to rewrite or review an existing skill file
- the request is about using a skill rather than defining one

## Defaults

- Aim to collect the minimum viable detail, not a full specification.
- Prefer one concise batch of questions over a long back-and-forth.
- Ask about behavior, not implementation prose.
- Surface a recommended default when the user has no preference.
- End with a brief that can be handed directly to `skill-authoring`.

## Workflow

1. Restate the proposed skill in one sentence to confirm the intended job.
2. Check whether the request already covers the essentials: purpose, trigger, exclusions, workflow, guardrails, and verification.
3. If anything important is missing, ask a short grouped set of targeted questions that covers only the gaps, such as:
   - what the skill should do
   - when it should trigger
   - when it should not trigger
   - the preferred default workflow
   - required constraints or safety rules
   - how success should be verified
4. Infer reasonable defaults from the repo and the user's wording instead of asking low-value questions.
5. Produce a brief for `skill-authoring` with these headings:
   - `Name`
   - `Goal`
   - `Use when`
   - `Do not use when`
   - `Workflow`
   - `Guardrails`
   - `Verification`
   - `Open choices` if any meaningful ambiguity remains
6. Hand off to `skill-authoring` only after the brief is specific enough to draft a focused `SKILL.md`.

## Questioning guide

- Ask no more than one compact batch unless the first answers leave a material gap.
- Prefer concrete prompts over open-ended brainstorming.
- Good: "What files, tools, or requests should trigger this skill?"
- Good: "What should the skill refuse or leave to another skill?"
- Avoid: "Anything else?"
- If the user says "you decide," choose the simplest reasonable default and record it in the brief.

## Guardrails

- Do not start drafting the final `SKILL.md`; this skill gathers inputs.
- Do not ask for information that can be inferred from existing skills or repo structure.
- Do not force the user to answer naming questions early if the behavior is still unclear.
- Do not over-specify reference files or examples unless they are clearly needed.
- Keep the handoff brief crisp enough that `skill-authoring` can use it directly.

## Verification

- Confirm the brief clearly describes one reusable job.
- Confirm routing is specific enough to tell when the skill should and should not trigger.
- Confirm the workflow includes real validation criteria, not just "follow best practices."
- Confirm any remaining ambiguity is isolated under `Open choices`.

## Output

- Return a concise authoring brief ready for `skill-authoring`.
- Note any defaults you chose on the user's behalf.
