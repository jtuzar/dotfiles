---
name: skill-authoring
description: Creates, rewrites, reviews, and installs reusable agent skills. Use when drafting `SKILL.md`, improving skill routing, choosing skill names or descriptions, splitting oversized skills, or applying skill authoring best practices.
---

# Skill Authoring

## What it does

- Produces or rewrites a skill as a ready-to-save `SKILL.md`.
- Improves skill metadata, routing language, structure, workflow, guardrails, and verification.
- Keeps skills concise, specific, and easy for agents to discover and execute.

## When to use it

Use this skill when the task involves:
- creating a new skill
- rewriting or reviewing an existing skill
- converting a prompt, checklist, or runbook into a skill
- choosing a skill name, description, or install location
- reorganizing a skill to use progressive disclosure

## Do not use it when

- the user wants general advice, not a reusable skill
- the task is to use a skill rather than author one
- the request is about generic agent behavior with no skill file involved

## Defaults

- Keep one skill focused on one job. Split broad requests into multiple skills.
- Prefer a gerund-style name when it reads naturally.
- Keep `name` lowercase with hyphens only and match the directory name.
- Write `description` in third person and include both what the skill does and when it should trigger.
- Keep `SKILL.md` short; move large references into sibling files only when they add real value.
- Prefer one recommended approach with a clear escape hatch over long option lists.
- If the request is still underspecified, use `skill-briefing` first to gather a clean authoring brief.

## Workflow

1. If the request is still vague or missing scope, triggers, or guardrails, use `skill-briefing` first and work from its brief.
2. Infer the audience, scope, and install location from the request and existing skill layout.
3. Identify the minimum reusable behavior. Remove background Claude already knows.
4. Write or tighten frontmatter:
   - `name`: valid, specific, memorable
   - `description`: routing-focused, third person, includes triggers
5. Draft the body around execution, not theory:
   - what the skill handles
   - when it should trigger
   - when it should not trigger
   - the default workflow
   - guardrails and verification
6. If the skill is getting long, move detailed references or examples into files linked directly from `SKILL.md`.
7. Before finishing, review for brevity, routing quality, and realistic verification steps.

## Progressive disclosure

- Keep core instructions in `SKILL.md`.
- Put large references, examples, or domain-specific details in sibling files linked directly from `SKILL.md`.
- Avoid nested references from one reference file to another.
- If a reference file grows past roughly 100 lines, add a short table of contents.

## Evaluation loop

Before expanding documentation, create at least three representative checks:

1. A task that should trigger the skill.
2. A neighboring task that should not trigger the skill.
3. A realistic task that tests the workflow end to end.

Use failures from those checks to decide what instructions to add or remove.

## Guardrails

- Do not write vague skills that just say to follow best practices.
- Do not repeat global agent instructions unless the skill truly specializes them.
- Do not add unsupported frontmatter keys.
- Do not include time-sensitive guidance in the main path; move legacy behavior into a clearly labeled section if needed.
- Do not invent tests, tools, or scripts that are not actually available.
- Use forward slashes in all file references.
- Do not force authoring when the request still needs discovery; use `skill-briefing` instead.

## Template

````md
---
name: example-skill
description: Performs a specific job and should trigger for the concrete files, tools, or requests that indicate that job.
---

# Example Skill

## What it does
- State the concrete responsibility.

## When to use it
- List the trigger tasks, files, or technologies.

## Do not use it when
- List adjacent tasks that belong elsewhere.

## Workflow
1. Inspect the most relevant files or inputs.
2. Apply the preferred pattern.
3. Validate the result.

## Guardrails
- List scope limits, safety rules, and defaults.

## Verification
- List the real checks to run.
````

## Verification

- Confirm the skill solves one class of tasks well.
- Confirm the description is specific enough for routing.
- Confirm the body is concise and stays well under 500 lines.
- Confirm any linked files are one level deep from `SKILL.md`.
- Confirm workflows include clear validation or review steps when the task is error-prone.

## Output

- Return the finished `SKILL.md`.
- If the skill is installed, report the exact directory.
- Briefly note any assumptions, proposed splits, or reference files added.
