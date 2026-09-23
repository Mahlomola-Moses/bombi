# bombi

**One AI development setup. Any assistant.**

Your team uses Claude Code, Gemini CLI, Copilot, Cursor, Codex, or plain ChatGPT.
`bombi` makes them all follow the same architecture rules, with the same workflow,
enforced by the same build — without anyone configuring anything.

```bash
curl -fsSL https://raw.githubusercontent.com/Mahlomola-Moses/bombi/main/install.sh | bash
bombi doctor --fix        # sets up PATH, node, uv and spec kit for you

cd your-repo
bombi init                # tech lead, once
bombi setup               # every dev, after cloning
bombi check               # before every PR
```

Nothing to configure by hand. `bombi` detects your OS and shell — macOS zsh gets
`~/.zshrc`, macOS bash gets `~/.bash_profile` (the login-shell quirk), Linux bash
gets `~/.bashrc`, fish gets `fish_add_path` — then installs what is missing.

---

## Why

Written rules get ignored — by tired humans and by AI agents halfway through a long
session. Config files only bind the people using that tool. So bombi puts the rules
in the repo where every agent reads them, and puts the *enforcement* in lint and CI
where it binds everyone equally.

**The repo is the source of truth. The tool is disposable.**

---

## What `bombi init` creates

| File | Read by |
|---|---|
| `AGENTS.md` | Codex, Copilot, Cursor, Gemini CLI, Aider, Zed, Windsurf — ~30 agents |
| `CLAUDE.md` | Claude Code. One line: `@AGENTS.md` |
| `.gemini/settings.json` | Gemini CLI — `context.fileName` points at AGENTS.md |
| `.specify/memory/constitution.md` | Spec Kit — checked at plan and analyze time |
| `.dependency-cruiser.cjs` | **the build** — the only rule that binds every tool equally |
| `scripts/verify.sh` | the gate: typecheck + boundaries + lint + tests |
| `.githooks/pre-commit` | blocks new violations before CI sees them |
| `.github/workflows/verify.yml` | CI |
| `AI-QUICKSTART.md` | your devs, in two minutes |

If `specify` is installed, Spec Kit slash commands are set up for each agent too, so
the feature workflow is identical no matter what anyone is running.

---

## Existing codebases: the ratchet

`bombi init` detects a legacy repo and **records** the architecture violations that
already exist instead of demanding you fix them. CI goes green on day one; only
*new* violations fail the build.

```bash
bombi debt        # what's recorded, grouped by rule
bombi baseline    # re-record after fixing some — REFUSES to grow
```

That refusal is the point. Nobody can launder a fresh violation into the forgiven
list. The number only goes down.

```
✗ Baseline would GROW: 5 → 6
  New violations must be fixed, not recorded.
```

Not ready to enforce boundaries on an old project at all? Skip them:

```bash
bombi init --no-boundaries        # AI setup + your existing gates, no dependency-cruiser
bombi update --boundaries         # turn them on later
```

---

## Commands

```
bombi init              set up this repo          (tech lead, once)
bombi setup [agent]     set up my machine         (every dev, after cloning)
bombi check             run all gates             (you, CI, your agent)
bombi debt              list baselined violations
bombi baseline          re-record after fixing some
bombi update            refresh bombi's generated tooling in this repo
bombi upgrade           replace this bombi with the latest release
bombi context [topic]   dump rules + code to paste into ChatGPT
bombi doctor            what's installed, what's missing
```

`bombi update` rewrites only the files bombi owns — `scripts/verify.sh`,
`.dependency-cruiser.cjs`, `.githooks/pre-commit` and the CI workflow — and only
when git can restore the old version. `AGENTS.md` and the quickstart are yours and
are never touched. Preview with `--dry-run`; `--force` replaces edited files and
keeps a `.bak`. After `bombi upgrade`, run `bombi update` in each repo.

`agent` is one of: `claude` `gemini` `copilot` `cursor` `codex` `none`

---

## The feature workflow

```
/speckit.specify    the requirement, in business language — what, not how
/speckit.clarify    answer its questions. Do not skip this one.
/speckit.plan       technical plan, checked against your constitution
/speckit.tasks      dependency-ordered task list
/speckit.analyze    must come back clean
/speckit.implement
```

Claude Code in skills mode uses hyphens (`/speckit-specify`); Gemini CLI uses dots.

**Required** for migrations, new endpoints, API contract changes, or anything
touching more than three files. **Not required** for bug fixes, copy, styling, or
dependency bumps.

---

## Requirements

Node 18+ and git. Everything else — `uv`, Spec Kit, your agent's CLI — is detected
and offered by `bombi doctor --fix` and `bombi setup`.

```
bombi doctor          # what's installed, what's missing (read-only)
bombi doctor --fix    # fix it
bombi doctor --fix -y # fix it without prompting (CI, scripts)
```

On macOS it prefers Homebrew when available and falls back to the official
installers. Every repair is idempotent: re-running never duplicates a PATH line.

---

## Notes

- `bombi init` never overwrites an existing file. It reports and moves on, so it's
  safe to re-run.
- **Review the generated `AGENTS.md`.** It's assembled from guesses about your repo.
  A wrong rule is worse than no rule.
- Boundary rules are generated from your actual directory names — if your data layer
  is `src/models/`, that's what the rules say.

## License

MIT
