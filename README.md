# dotfiles

Personal Windows dotfiles, managed as a [bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles) checked out directly into `$env:USERPROFILE` (your home directory). No symlinks, no extra tooling — just Git.

## Setup on a new machine

1. Clone this repo as a **bare** repo into your home directory:
   ```powershell
   git clone --bare https://github.com/kjafra/dotfiles.git $env:USERPROFILE\.dotfiles.git
   ```
2. Do the one-time setup (hide untracked files, then check out into your home directory) using raw `git` invocations with the same `--git-dir`/`--work-tree` flags. Back up any conflicting existing files first:
   ```powershell
   $gitDir = "$env:USERPROFILE\.dotfiles.git"
   git --git-dir=$gitDir --work-tree=$env:USERPROFILE config --local status.showUntrackedFiles no
   git --git-dir=$gitDir --work-tree=$env:USERPROFILE checkout
   ```
3. The PowerShell 7 profile (`Documents\PowerShell\Microsoft.PowerShell_profile.ps1`) is tracked and provides a `dotfiles` helper locked down to pull/sync subcommands only (`pull`, `fetch`, `merge`, `status`, `log`, `diff`) — see the TIP below for why. WSL-Setup's `Install-Dotfiles.ps1` automates steps 1–2.

## Per-OS sparse checkout

This repo is shared by Windows and Ubuntu (WSL); each checkout only materialises its own files via git sparse-checkout (non-cone), driven by lists stored here:

- `.sparse/windows` — **allowlist**: only these paths reach `%USERPROFILE%`. A new Windows tool needs one line added.
- `.sparse/ubuntu` — **denylist**: everything except the Windows-only paths (`.config/wezterm/`, `AppData/`, `Documents/`) and repo docs. A new Linux tool config (e.g. `.config/k9s/`) lands automatically.

The installers apply the list for their OS, and the `dotfiles` helper re-applies it after `pull`/`merge`. Don't forget: a file that needs to exist on both sides must match both lists.

## What's in here

This repo mirrors real paths under your home directory and tracks configuration files for the tools installed on this machine (terminal, editor, shell profile, etc.). Each top-level folder corresponds to where that tool expects its config on Windows (e.g. `.config\`, `AppData\Roaming\`, `Documents\`). Check the folder/file itself for details — this list is intentionally not exhaustive so it doesn't need to be kept in sync every time a config changes.

## TIP: Working with an AI coding agent

Don't point an agent at your live home directory checkout. Instead:

1. Clone this repo normally (not bare) into a separate working subdirectory, e.g. `Desktop\dotfiles`.
2. Let the agent make and commit changes there, then push to the remote.
3. Back in your home directory, run `dotfiles pull` (or `fetch` + `merge`) to sync those changes in.

The `dotfiles` command itself (PowerShell profile on Windows, `.zshrc` in WSL) is restricted to `pull`/`fetch`/`merge`/`status`/`log`/`diff` — it will refuse `add`, `commit`, `push`, etc. It exists solely to **pull/sync** changes into your home directory, never to author or commit changes directly there.