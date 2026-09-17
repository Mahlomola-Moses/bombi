# bombi

One AI development setup. Any assistant.

Your team uses Claude Code, Gemini CLI, Copilot, Cursor, Codex, or plain ChatGPT.
`bombi` makes them all follow the same architecture rules, with the same workflow,
enforced by the same build — without anyone configuring anything.

```bash
curl -fsSL <your-url>/install.sh | bash

cd your-repo
bombi init          # tech lead, once
bombi setup         # every dev, after cloning
bombi check         # before every PR
```

## What it sets up

| File | Read by |
|---|---|
| `AGENTS.md` | Codex, Copilot, Cursor, Gemini CLI, Jules, Aider, Zed, Windsurf (~30 agents) |
| `CLAUDE.md` | Claude Code — one line, `@AGENTS.md` |
| `.gemini/settings.json` | Gemini CLI — `context.fileName` points at AGENTS.md |
| `.specify/memory/constitution.md` | Spec Kit — checked at plan and analyze time |
| `.dependency-cruiser.cjs` | **the build** — the only rule that binds every tool equally |
| `scripts/verify.sh`, `.githooks/`, CI | the gates |
| `AI-QUICKSTART.md` | your devs, in two minutes |

Spec Kit slash commands are installed for each agent, so the feature workflow
(`specify → clarify → plan → tasks → analyze → implement`) is identical no matter
what anyone is running.

## Existing codebases: the ratchet

`bombi init` detects a legacy repo and **records** the architecture violations that
already exist instead of demanding you fix them. CI goes green on day one, and only
*new* violations fail the build.

```bash
bombi debt        # what's recorded, grouped by rule
bombi baseline    # re-record after fixing some — REFUSES to grow
```

That refusal is the point. A dev can't launder a new violation into the baseline;
the number only goes down.

## Commands

```
bombi init              set up this repo          (tech lead, once)
bombi setup [agent]     set up my machine         (every dev, after cloning)
bombi check             run all gates             (you, CI, your agent)
bombi debt              list baselined violations
bombi baseline          re-record after fixing some
bombi context [topic]   dump rules + code to paste into ChatGPT
bombi doctor            what's installed, what's missing
```

## The design principle

The repo is the source of truth; the tool is disposable. Rules live in plain
markdown any agent reads and any human can paste. Enforcement lives in lint and CI,
because a written rule binds only the sessions that read it carefully — a failing
build binds everyone.

## Requirements

Node 18+, git. Spec Kit (optional but recommended) needs `uv`:

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

## Notes

- `bombi init` never overwrites an existing file; it reports and moves on.
- Review the generated `AGENTS.md`. It's assembled from guesses about your repo.
  Wrong rules are worse than no rules.
- Claude Code in skills mode uses `/speckit-specify` (hyphens); Gemini CLI uses
  `/speckit.specify` (dots).
