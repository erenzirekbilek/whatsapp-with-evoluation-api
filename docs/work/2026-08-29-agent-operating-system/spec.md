# Spec: Agent operating system (bootstrap)

- **Status:** done
- **Date:** 2026-08-29
- **Owner:** repo
- **Work folder:** `docs/work/2026-08-29-agent-operating-system/`

## Problem

The repository had no shared contract for how agents plan and ship work. Chat would become the only memory.

## Goals

- A parent orchestrator defined in `AGENTS.md`.
- Five project subagents with Cursor-compatible frontmatter.
- Templates and one accepted ADR so the next feature can copy the path.

## Non-goals

- Application features (complaints product, APIs, UI).
- Extra specialist subagents (frontend-only, security-only, etc.).
- CI enforcement of this process.

## Users and context

Humans and Cursor agents working in this repo.

## Acceptance criteria

1. Given the repo root, when an agent starts, then `AGENTS.md` tells it to orchestrate and lists the five subagents.
2. Given `.cursor/agents/`, when Cursor loads project subagents, then `spec-writer`, `planner`, `implementer`, `reviewer`, and `codebase-explorer` exist as `.md` files with `name` and `description`.
3. Given a new feature request, when spec-writer runs, then it can copy `docs/templates/spec.md` into a dated folder under `docs/work/`.
4. Given `reviewer` frontmatter, when it is launched, then `readonly: true` is set. Same for `codebase-explorer`.
5. Given always-on rules, when any chat runs, then `.cursor/rules/spec-driven.mdc` has `alwaysApply: true`.

## Constraints

- Cursor subagent format: YAML frontmatter + markdown body; no `tools:` field.
- Do not commit unless a human asks.

## Open questions

- None for this bootstrap.
