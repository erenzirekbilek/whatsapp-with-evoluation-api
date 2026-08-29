# Agent operating system

This repo is spec-driven. Chat is not the source of truth. Disk is.

The **parent agent in this conversation is the orchestrator**. Do not spawn an extra “orchestrator” subagent. Delegate specialized work to project subagents in `.cursor/agents/`.

## When to use whom

| Role | File | Use when |
|------|------|----------|
| Orchestrator | this file (parent) | Clarify, gate, dispatch, merge, ask the human |
| spec-writer | `.cursor/agents/spec-writer.md` | New work, scope change, missing or stale `spec.md` |
| planner | `.cursor/agents/planner.md` | Spec exists and is approved; need files + ordered tasks |
| implementer | `.cursor/agents/implementer.md` | One task from `tasks.md` (or a tightly bounded pair) |
| reviewer | `.cursor/agents/reviewer.md` | After implementation, before calling work done |
| codebase-explorer | `.cursor/agents/codebase-explorer.md` | Unknown code, impact analysis, “where does X live?” |

Cursor’s built-in Explore/Bash/Browser subagents still apply for noisy tool output. Prefer `codebase-explorer` when the answer must follow this repo’s work-item contract.

## Workflow

1. If the request is a product or process change and there is no matching folder under `docs/work/`, create one (`YYYY-MM-DD-short-name/`) and run **spec-writer**. Stop for human approval of `spec.md` unless the human already approved the same scope in this thread.
2. Run **planner** against that spec. For large work, stop for plan approval.
3. Run **implementer** one task at a time. Parallelize only when tasks share **no** files.
4. Run **reviewer**. If it fails, send a new implementer with the review findings — do not self-merge a failing review.
5. Record verification in `evidence.md`.

Tiny fixes still get a short spec (even a handful of acceptance lines). “Too small for a spec” is not allowed.

## Parallelism

- Shared files → sequential implementers.
- Independent files and no shared contract change → parallel implementers.
- Never run spec-writer and implementer on the same work item at the same time.

## Hard rules

- Spec describes **what / why / acceptance**. Plan describes **where / order**. Tasks are checkboxes. Code does not invent product decisions.
- Implementer must not edit `spec.md` to match the code. If the spec is wrong, stop and return to spec-writer.
- Reviewer must not implement. Explorer must not write product or spec files.
- Do not commit unless the human asked.
