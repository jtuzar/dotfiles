---
name: triage
description: >-
  Morning triage of Obsidian daily notes. Reads un-triaged notes from the
  think_vault, classifies content into tasks, knowledge, plans, references,
  and journal entries, then files them to their proper destinations with
  user approval. Use when the user wants to process their daily brain dump
  notes. Triggers on: "triage my notes", "process yesterday's notes",
  "morning triage", "review daily notes".
---

# 🌅 Daily Note Triage

Process un-triaged daily notes from the Obsidian vault, classify content, and file it to the right destinations with user approval.

**Use emojis consistently throughout all output** — they help the user quickly scan and focus on separated concerns.

## Vault Layout

The vault lives at `/home/jakub/Documents/think_vault/`. Use the `obsidian` CLI for all vault interactions (read, create, append, search, tags).

| Folder | Purpose |
|--------|---------|
| `Dailies/` | Raw daily brain dumps (input) |
| `Knowledge/` | Distilled insights and learnings |
| `Plans/` | Strategic docs, decisions, evolving threads |
| `References/` | Links and resources to check out |

Tags are flat and combinable: `#work`, `#firefish`, `#personal`. Work notes always get both `#work` and the employer tag (currently `#firefish`).

## Workflow

### Step 1: Find un-triaged notes

List all files in `Dailies/` using Glob, then for each file read the frontmatter and check if it contains a `triaged:` field. Collect files that do NOT have this field, sorted chronologically (oldest first).

```bash
obsidian search query="triaged" path="Dailies" format=json
```

Cross-reference against the full list of daily notes to find which ones are missing the field.

If no un-triaged notes exist, report:

> 🎉 All caught up! No un-triaged daily notes found.

If today's note is the only un-triaged note, skip it — the user is still writing it. Only process notes from previous days.

### Step 2: Read and classify

For each un-triaged note, read it:

```bash
obsidian read path="Dailies/YYYY-MM-DD.md"
```

Classify every meaningful block into one of five types:

| Type | Emoji | What it is | Where it goes |
|------|-------|------------|---------------|
| Task | 📋 | Actionable item with a clear next step | Shortcut (work) or personal task app |
| Knowledge | 💡 | Insight, learning, or fact worth preserving | `Knowledge/` as new or appended note |
| Plan | 📐 | Strategic thread, decision, or evolving direction | `Plans/` as new or appended note |
| Reference | 🔗 | Link, resource, or "check this out" item | `References/Reading List.md` or dedicated note |
| Journal | 📓 | Personal reflection | Stays in daily note, no action |

Classification guidance:
- Meeting notes often contain multiple types — extract tasks and knowledge separately while noting the meeting context.
- A bullet with a checkbox (`- [ ]`) is always a task.
- A bare URL or "check out X" is a reference.
- "We decided to..." or "The approach is..." is a plan.
- Opinions, feelings, reflections are journal.
- If ambiguous, ask the user.

### Step 3: Present triage summary

Present the summary for ONE note at a time. Format:

```
📅 Daily note: YYYY-MM-DD (Note N of M)

📋 Tasks:
  1. "Task description" → destination (tags)
  2. "Task description" → destination (tags)

💡 Knowledge:
  3. "Insight title" → create new note / append to "Existing Note" (tags)

📐 Plans:
  4. "Decision or direction" → create new note / append to "Existing Plan" (tags)

🔗 References:
  5. URL or resource → Reading List

📓 Journal:
  Work: summary of what was written (or "empty")
  Personal: summary of what was written (or "empty")

---
✅ Approve  ⏭️ Skip  ✏️ Edit
Which items to approve? (e.g., "all", "1,3,5", "skip 2", "edit 4")
```

Before proposing a knowledge or plan destination, search for existing notes that could be appended to:

```bash
obsidian search query="relevant keywords" path="Knowledge"
obsidian search query="relevant keywords" path="Plans"
```

Prefer appending to an existing note over creating a new one, to avoid topic fragmentation.

### Step 4: Execute approved actions

For each approved item:

**📋 Work tasks → Shortcut:**
Use the Shortcut MCP to create a story. Ask the user which project/workflow to use if not obvious. Apply relevant labels.

**📋 Personal tasks:**
Personal task app integration is not yet configured. For now, present personal tasks clearly and tell the user:
> ⚠️ Personal task app not yet connected. Please add this task manually: "task description"

**💡 Knowledge → vault:**
Create or append via obsidian CLI:
```bash
# New note
obsidian create path="Knowledge/Note Title.md" content="---\ntags:\n  - work\n  - firefish\n---\n\n# Note Title\n\nContent here"

# Append to existing
obsidian append path="Knowledge/Existing Note.md" content="\n## New Section\n\nContent here"
```

**📐 Plans → vault:**
Same as knowledge but in `Plans/`:
```bash
obsidian create path="Plans/Plan Title.md" content="---\ntags:\n  - work\n  - firefish\n---\n\n# Plan Title\n\nContent here"
```

**🔗 References → vault:**
```bash
obsidian append path="References/Reading List.md" content="\n- [Title](URL) — one-line description (from YYYY-MM-DD daily)"
```

### Step 5: Mark as triaged

After processing all approved items for a note, add the `triaged` field to its frontmatter. Read the current frontmatter, add `triaged: YYYY-MM-DD` (today's date), and write it back.

The frontmatter should look like:
```yaml
---
date: 2026-04-08
tags: daily
triaged: 2026-04-09
---
```

Use the Edit tool to add the triaged line to the existing frontmatter block.

Report completion:
> ✅ Triaged Dailies/YYYY-MM-DD.md — N items filed, M skipped.

Then move to the next un-triaged note, or if done:
> 🎉 All daily notes triaged! Have a good day.

## Edge Cases

- **Multiple un-triaged notes:** Process each one separately in chronological order. Show a progress indicator: "📅 Note 1 of 3: 2026-04-05"
- **Empty or near-empty notes:** Skip with "⏭️ YYYY-MM-DD is empty, skipping."
- **Mixed content blocks:** Extract tasks separately from meeting notes. Keep the full meeting content as a knowledge item and note which tasks were extracted from it.
- **Ambiguous classification:** Ask the user. Don't guess.
- **Existing tasks with checkboxes already marked done** (`- [x]`): Note them as already completed and skip unless the user wants to file them somewhere.

## Tools Reference

| Tool | Use for |
|------|---------|
| `obsidian read path="..."` | Read note content |
| `obsidian append path="..." content="..."` | Add content to existing notes |
| `obsidian create path="..." content="..."` | Create new notes |
| `obsidian search query="..." path="..."` | Find existing notes to append to |
| `obsidian tags` | Verify tag usage across vault |
| `obsidian tasks path="Dailies/..."` | Check existing task state in a note |
| Shortcut MCP (`mcp__shortcut__stories-create`) | Create work tasks |
| Edit tool | Update frontmatter (add triaged field) |
