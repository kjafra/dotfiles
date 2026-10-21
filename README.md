# dotfiles

Personal dotfiles for Windows (PowerShell/WezTerm) and Ubuntu on WSL, managed with [chezmoi](https://www.chezmoi.io/). One repo serves both OSes; the live home directory is never a git work tree — chezmoi keeps its own clone of this repo in a separate source directory and *copies* files into the home directory.

## Layout

- `.chezmoiroot` points at `home/`; everything outside it (this README, LICENSE, `.gitattributes`, `.gitignore`) is repo-only and never deployed.
- `home/` uses chezmoi naming: `dot_zshrc` → `~/.zshrc`, `dot_config/helix/` → `~/.config/helix/`, `executable_commit-msg` → executable `commit-msg`. Windows-only paths (`AppData/`, `Documents/PowerShell/`, `dot_config/wezterm/`) sit alongside.
- `home/.chezmoiignore` decides what each OS receives:
  - **Windows**: allowlist. Only the listed paths are applied, so Linux configs never reach `%USERPROFILE%`. A new Windows tool needs one line.
  - **Linux/WSL**: denylist. Everything except the Windows-only paths is applied, so a new Linux tool config (e.g. `home/dot_config/k9s/`) lands automatically.
- `~/.gitconfig.local` (identity, credential helpers) is machine-specific and **not** managed; copy it from `~/.gitconfig.local.example`.

## Setup on a new machine

Use WSL-Setup's `Install-Dotfiles.ps1` (Windows) or Ubuntu-Setup's `install-dotfiles.sh` (Ubuntu). Manually:

```sh
chezmoi init kjafra/dotfiles   # clones into ~/.local/share/chezmoi
chezmoi diff                   # review
chezmoi apply
```

## Working with an AI coding agent

The chezmoi source directory is only ever pulled into. Author changes in a separate normal clone (e.g. `~/src/dotfiles` or `Desktop\Github\dotfiles`), push, then in the home directory:

```sh
dotfiles pull && dotfiles diff && dotfiles apply
```

The `dotfiles` function (PowerShell profile, `.zshrc`) is a restricted chezmoi wrapper: `pull`, `diff`, `apply`, `status`, `verify`, `managed`, `doctor`. It refuses `add`, `edit`, `re-add`, `forget`, etc.
