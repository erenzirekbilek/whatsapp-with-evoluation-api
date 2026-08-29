# Plan: Agent operating system (bootstrap)

- **Spec:** `docs/work/2026-08-29-agent-operating-system/spec.md`
- **Status:** done

## Architecture

Cursor reads `AGENTS.md` and `.cursor/rules/*.mdc` in the parent. Custom specialists are markdown files under `.cursor/agents/`. Human-facing contracts live under `docs/`.

## Files

| Path | Action | Responsibility |
|------|--------|----------------|
| `AGENTS.md` | create | Orchestrator routing |
| `.cursor/rules/spec-driven.mdc` | create | Always-on gate |
| `.cursor/rules/work-items.mdc` | create | Doc conventions |
| `.cursor/agents/*.md` | create | Five specialists |
| `docs/templates/*` | create | Copy-paste contracts |
| `docs/decisions/0001-spec-driven-agents.md` | create | Lasting WHY |

## Risks

- Naming a subagent `explorer` could collide with Cursor built-in Explore → use `codebase-explorer`.
- An `orchestrator` subagent would steal work from the parent → not created.

## Order

Single bootstrap; no parallel implementation wave.

## Out of this plan

Product code under `src/`.
