---
name: daily-note-triage
description: >-
  Morning triage of Obsidian daily notes. Reads un-triaged notes from the
  think_vault, classifies content into tasks, knowledge, plans, references,
  and journal entries, then files them to their proper destinations with
  user approval. Use when the user wants to process their daily brain dump
  notes. Triggers on: "triage my notes", "process yesterday's notes",
  "morning triage", "review daily notes".
---

# Daily Note Triage

Process un-triaged daily notes, classify content, and file it to the right destinations with user approval.

**Use emojis consistently throughout all output** — they help the user quickly scan separated concerns.

## Config

| Key | Value |
|-----|-------|
| Vault path | `/home/jakub/Documents/think_vault/` |
| Employer tag | `#firefish` |
| Work tags | `#work` + employer tag |
| CLI tool | `obsidian` (bash CLI, run via Bash tool) |

| Folder | Purpose |
|--------|---------|
| `Dailies/` | Raw daily brain dumps (input) |
| `Knowledge/` | Distilled insights and learnings |
| `Plans/` | Strategic docs, decisions, evolving threads |
| `References/` | Links and resources to check out |

## Daily Note Structure

Notes use this template. The `triaged` property is a boolean — `false` when created, set to `true` after processing.

```yaml
---
date: YYYY-MM-DD
tags: daily
triaged: false
---
```

| Section | Content type |
|---------|-------------|
| `## 🧠 Brain Dump` | Mixed — tasks, thoughts, links, meeting notes. Triage classification happens here. |
| `## 📓 Journal -- Work` | Work reflections → pre-classified as journal, no action needed |
| `## 🌿 Journal -- Personal` | Personal reflections → pre-classified as journal, no action needed |

## Workflow

The workflow uses **subagents** to keep the main conversation clean. The main agent only handles presenting summaries and collecting user decisions.

### Phase 1: Gather context (subagent)

Dispatch a subagent with the Agent tool using `model: "haiku"` and this prompt:

```
You are a triage assistant for an Obsidian vault at /home/jakub/Documents/think_vault/.

**Task:** Find and classify all un-triaged daily notes.

**Step 1 — Find un-triaged notes:**
Run: obsidian search query='"triaged: false"' path="Dailies"
Exclude today's date (the user is still writing it).
If no results (or only today), return: "NO_UNTRIAGED_NOTES"

**Step 2 — For each un-triaged note:**
Read it: obsidian read path="Dailies/YYYY-MM-DD.md"

**Step 3 — Search for existing destination notes:**
Run: obsidian search query="relevant keywords" path="Knowledge"
Run: obsidian search query="relevant keywords" path="Plans"
Use these results to suggest appending to existing notes rather than creating new ones.

**Step 4 — Classify Brain Dump content into these types:**
- 📋 Task: actionable item (- [ ] checkbox is always a task, - [x] is completed — note it and skip)
- 💡 Knowledge: insight, learning, or fact worth preserving
- 📐 Plan: strategic thread, decision, or evolving direction
- 🔗 Reference: link, resource, or "check this out"
- 📓 Journal: opinion, feeling, reflection (stays in note)

Content under Journal sections (## 📓 / ## 🌿) is already classified as journal — skip it.

Meeting notes are multi-type: extract tasks and knowledge separately, keep the full meeting as a knowledge item.

If a classification is ambiguous, mark it with "⚠️ AMBIGUOUS" so the main agent can ask the user.

**Step 5 — Return a structured report in this exact format for EACH note:**

NOTE: YYYY-MM-DD
ITEMS:
- TYPE: Task | CONTENT: "description" | DESTINATION: Shortcut #work #firefish | TAGS: work, firefish
- TYPE: Knowledge | CONTENT: "title" | DESTINATION: append to "Existing Note" OR create "New Note" | TAGS: work, firefish
- TYPE: Plan | CONTENT: "description" | DESTINATION: append to "Existing Plan" OR create "New Plan" | TAGS: work, firefish
- TYPE: Reference | CONTENT: "title" | URL: https://... | DESTINATION: Reading List
JOURNAL_WORK: one-line summary or "empty"
JOURNAL_PERSONAL: one-line summary or "empty"
---

Report under 200 words per note. Be precise with destinations.
```

### Phase 2: Present and get user approval (main agent)

Parse the subagent's report and present ONE note at a time:

```
📅 Daily note: YYYY-MM-DD (Note N of M)

📋 Tasks:
  1. "Task description" → destination (tags)

💡 Knowledge:
  2. "Insight title" → create new / append to "Existing Note" (tags)

📐 Plans:
  3. "Decision or direction" → create new / append to "Existing Plan" (tags)

🔗 References:
  4. URL or resource → Reading List

📓 Journal:
  Work: summary (or "empty")
  Personal: summary (or "empty")

---
✅ Approve  ⏭️ Skip  ✏️ Edit
Which items to approve? (e.g., "all", "1,3", "skip 2", "edit 4")
```

Wait for the user's response before proceeding.

### Phase 3: Execute approved actions (subagent)

After collecting approvals for a note, dispatch a subagent with `model: "haiku"` and this prompt:

```
You are a triage executor for an Obsidian vault at /home/jakub/Documents/think_vault/.

**Execute these approved triage actions, then report what you did.**

DAILY NOTE: Dailies/YYYY-MM-DD.md
APPROVED ITEMS:
[paste the approved items here with their destinations]

**Execution rules:**

📋 Work tasks → Shortcut:
Use mcp__shortcut__stories-create. Apply labels matching the tags.

📋 Personal tasks:
Report: "⚠️ Personal task app not connected. User should add manually: [task]"

💡 Knowledge / 📐 Plans → vault:
- New note: obsidian create path="[Folder]/[Title].md" content="---\ntags:\n  - work\n  - firefish\n---\n\n# [Title]\n\n[Content]"
- Append: obsidian append path="[Folder]/[Existing Note].md" content="\n## [Section Title] (from YYYY-MM-DD daily)\n\n[Content]"

🔗 References → vault:
obsidian append path="References/Reading List.md" content="\n- [Title](URL) — description (from YYYY-MM-DD daily)"

**After each write, verify by reading the note back:**
obsidian read path="[path]"

**After all items are filed, mark the daily note as triaged:**
obsidian property:set name="triaged" value="true" type="checkbox" path="Dailies/YYYY-MM-DD.md"

**Return a report in this format:**
EXECUTED:
- ✅ [item description] → [where it was filed]
- ✅ [item description] → [where it was filed]
- ⚠️ [item description] → [issue encountered]
SKIPPED: N items
TRIAGED: Dailies/YYYY-MM-DD.md
```

### Phase 4: Report (main agent)

After the execute subagent returns, present a clean summary:

```
✅ Triaged Dailies/YYYY-MM-DD.md

Filed:
  - 📋 "Task X" → Shortcut story created
  - 💡 "Knowledge Y" → appended to Knowledge/Existing Note.md
  - 🔗 URL → Reading List

Skipped: 2 items (journal)
```

Then proceed to the next note, or if all done:

> 🎉 All daily notes triaged!

## Gotchas

- **`obsidian frontmatter` command does NOT exist.** Use `property:read`, `property:set`, and `property:remove` for frontmatter changes.
- **Tags are inline in Brain Dump content** (`#firefish` in bullet text), but use YAML `tags:` arrays when creating Knowledge/Plan notes.
- **Journal sections are pre-classified.** Don't re-triage content under `## 📓 Journal -- Work` or `## 🌿 Journal -- Personal`.
- **Prefer appending over creating.** Always search before proposing a new Knowledge or Plan note.
- **Meeting notes are multi-type.** Extract tasks + knowledge separately, keep full meeting as knowledge item.
- **Subagent model:** Use `haiku` for gather/execute subagents — they do mechanical work, not creative decisions.
