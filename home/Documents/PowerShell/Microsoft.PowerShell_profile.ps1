# PowerShell 7 profile, deployed to Documents\PowerShell by chezmoi.

# --- dotfiles sync helper -------------------------------------------------
# chezmoi wrapper, intentionally locked down to sync/inspect operations,
# mirroring the .zshrc `dotfiles` function. The chezmoi source clone
# (~\.local\share\chezmoi) is only ever pulled into; author changes in a
# separate normal clone of kjafra/dotfiles, push, then:
#   dotfiles pull; dotfiles diff; dotfiles apply
function dotfiles {
    $allowed = 'pull', 'diff', 'apply', 'status', 'verify', 'managed', 'doctor'
    if ($args.Count -eq 0 -or $allowed -notcontains $args[0]) {
        Write-Error "dotfiles: only these subcommands are allowed: $($allowed -join ', ')"
        return
    }
    if ($args[0] -eq 'pull') {
        chezmoi git -- pull --ff-only
    }
    else {
        chezmoi @args
    }
}
