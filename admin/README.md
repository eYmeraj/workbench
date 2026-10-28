# workbench (admin)

My coding setup for macOS: Neovim, WezTerm, zsh, and config for coding agents (Claude Code, Codex, opencode).
For a Mac where you **have admin access**: standard Homebrew (`/opt/homebrew`), apps in `/Applications`.
No admin? Use `../no-admin` instead.

## Set up a new machine

```sh
git clone https://github.com/eYmeraj/workbench.git ~/workbench
cd ~/workbench/admin
./install.sh          # every step, idempotent - safe to re-run
./install.sh 17 20    # only the steps you name (by number prefix)
```

| Step | What it does |
|---|---|
| `00-homebrew.sh` | Installs Homebrew with the official installer (asks for your password) |
| `10-packages.sh` | `brew bundle` the `Brewfile`: git, Neovim, Node, ripgrep, fd, fzf, jq, lazygit, gh, uv, starship, zsh plugins, WezTerm, Claude Code, Hack Nerd Font |
| `17-language-servers.sh` | Installs or updates every language server Neovim uses, see below |
| `20-link-configs.sh` | Symlinks `home/*` into `$HOME`, backing up any real file already there to `*.bak.<timestamp>` |
| `30-agent-tools.sh` | `no-mistakes` (validation pipeline) and `treehouse` (worktree pool) into `~/.local/bin` |
| `40-macos-defaults.sh` | Dark mode, fast key repeat, auto-hidden menu bar and Dock, Finder list view, no desktop icons, tap to click |
| `50-neovim-plugins.sh` | Pre-installs Neovim plugins pinned in `lazy-lock.json` |

Git identity is deliberately not set by the scripts: `git config --global user.name ... && git config --global user.email ...`

## Language servers

`./install.sh 17` installs them all, and re-running it updates them. Neovim starts them automatically
when you open a matching file (`home/.config/nvim/lua/plugins/lsp.lua`).

| Language | Server | From |
|---|---|---|
| TypeScript, JavaScript, React | `vtsls` | npm |
| Python | `pyright` | npm |
| Lua | `lua_ls` | brew |
| Swift | `sourcekit-lsp` (+ `xcode-build-server` for `.xcodeproj`) | Xcode (+ brew) |
| HTML, CSS, JSON | `html`, `cssls`, `jsonls` | npm (`vscode-langservers-extracted`) |
| Tailwind CSS | `tailwindcss` | npm |
| Bash / shell | `bashls` (+ `shellcheck` for diagnostics) | npm (+ brew) |
| YAML | `yamlls` | npm |
| Markdown | `marksman` | GitHub release binary |

To add a language: find its server in `~/.local/share/nvim/lazy/nvim-lspconfig/lsp/` (each file's header says how to install it),
add the install to `scripts/17-language-servers.sh`, and the name to `vim.lsp.enable({ ... })` in `lsp.lua`.

- Swift: in an Xcode project run `xcode-build-server config -project <Name>.xcodeproj -scheme <Scheme>` once, then build it (Xcode or `xcodebuild`)
- Python: pyright uses the project's `.venv` when there is one (`uv venv` creates it)

## Editing

The files under `home/` are the live configs. `~/.zshrc`, `~/.config/{nvim,wezterm,starship.toml}`,
`~/.claude/settings.json` and the shared agent policy all point here, so edits take effect immediately.

- `home/AGENTS.md` - global agent policy, linked as `~/.claude/CLAUDE.md`, `~/.codex/AGENTS.md`, `~/.config/opencode/AGENTS.md`
- `home/.claude/settings.json` - Claude Code theme, plugins, and a status line showing model and context-window %
- `home/.zshrc` - brew PATH, autosuggestions (`Ctrl+F` accepts), syntax highlighting, starship, aliases
- `~/.zshrc.local` - machine-only overrides (not tracked)

## Using the tools

- Neovim - `docs/neovim-guide.html` (or `.pdf`): every key, the language servers, and how to maintain them
- `no-mistakes` - run `no-mistakes init` in a repo, then `git push no-mistakes` to get review, tests and a PR from the pipeline
- `treehouse` - hands out a worktree from a reusable pool so you can run several agents in parallel
