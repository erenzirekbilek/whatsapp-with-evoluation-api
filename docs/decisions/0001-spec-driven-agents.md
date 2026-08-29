# ADR 0001: Spec-driven parent agent and subagents

- **Status:** accepted
- **Date:** 2026-08-29

## Context

The repo needed a repeatable way to build software with Cursor: specs on disk, a parent orchestrator, and specialized subagents — without treating chat history as the contract.

## Decision

- Parent conversation agent = orchestrator (`AGENTS.md`). No `orchestrator` subagent.
- Project subagents live in `.cursor/agents/`: spec-writer, planner, implementer, reviewer, codebase-explorer.
- Work lives in `docs/work/YYYY-MM-DD-short-name/` with spec / plan / tasks / evidence copied from `docs/templates/`.
- Always-on rule: `.cursor/rules/spec-driven.mdc`.

## Consequences

- New features start with spec-writer and a human gate.
- Reviewer is read-only so implementation and review stay separated.
- Role count stays at five until a real queue demands another specialist.
