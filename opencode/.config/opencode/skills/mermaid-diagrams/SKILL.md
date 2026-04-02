---
name: mermaid-diagrams
description: Creates diagrams in Mermaid.js syntax and should trigger when users ask for flowcharts, sequence diagrams, architecture diagrams, state diagrams, or other visual graphs that can be rendered with Mermaid CLI for display in OpenCode.
---

# Mermaid Diagrams

## What it does

- Turns a diagram request into valid Mermaid.js markup.
- Renders the diagram with Mermaid CLI so the result exists as an image file that OpenCode can display.
- Keeps the Mermaid source and rendered output aligned so the user can revise either the diagram structure or the final image.

## When to use it

Use this skill when the task involves:
- creating a diagram from a text description
- converting notes, flows, systems, or relationships into Mermaid syntax
- rendering a Mermaid diagram to `png` or `svg`
- updating an existing Mermaid diagram and regenerating its image output
- producing a diagram artifact that should be viewable inside OpenCode

## Do not use it when

- the user explicitly wants a different diagram language or tool such as PlantUML, Graphviz, or Excalidraw
- the task is pure visual design work that Mermaid cannot represent well
- the request is only to explain a system in prose with no diagram output

## Workflow

1. Determine the diagram type that best matches the request. Prefer Mermaid-native diagram types such as `flowchart`, `sequenceDiagram`, `classDiagram`, `stateDiagram-v2`, `erDiagram`, `journey`, `gitGraph`, or `mindmap`.
2. Draft the diagram in valid Mermaid syntax. Keep labels short, avoid unnecessary styling, and prefer a readable layout over dense detail.
3. Save the Mermaid source to a `.mmd` file. Unless the user asked for a repo file, write render artifacts to a temporary or clearly disposable location such as `/tmp/opencode-diagrams/`.
4. Render the diagram with Mermaid CLI using `mmdc`. Prefer `png` for OpenCode previews unless the user asked for `svg` or needs a scalable artifact.
5. Read the rendered image file so OpenCode can display it in the conversation, and report the source and output paths.
6. If rendering fails, fix the Mermaid syntax and rerun `mmdc` instead of handing off an unrendered diagram.

## Guardrails

- Use Mermaid syntax, not pseudocode or mixed diagram formats.
- Do not assume Mermaid supports arbitrary layout precision; simplify the structure when the requested layout is too manual or pixel-specific.
- Do not leave the user with source only when Mermaid CLI is available; render the image as part of the workflow.
- Prefer stable node IDs and clear labels so follow-up edits are easy.
- If the diagram includes secrets, credentials, or internal-only identifiers, redact or generalize them unless the user explicitly needs the exact values.
- If `mmdc` is unavailable or rendering is blocked by the environment, provide the Mermaid source and clearly state that the image could not be generated.

## Verification

- Confirm the Mermaid source parses successfully by rendering it with `mmdc`.
- Confirm the output image file was created at the expected path.
- Confirm the rendered diagram matches the user's requested structure at a high level.
- Confirm the final response includes the Mermaid source location and rendered image location.
