# PowerShell 7 profile, deployed to Documents\PowerShell by the dotfiles
# bare-repo checkout.

# --- dotfiles sync helper -------------------------------------------------
# Intentionally locked down to read-only / sync operations, mirroring the
# .zshrc `dotfiles` function. It only pulls changes made elsewhere (e.g. in
# a separate clone) into this home directory checkout; author and push
# from a plain clone of the repo instead.
function dotfiles {
    $allowed = 'pull', 'fetch', 'merge', 'status', 'log', 'diff'
    if ($args.Count -eq 0 -or $allowed -notcontains $args[0]) {
        Write-Error "dotfiles: only these subcommands are allowed: $($allowed -join ', ')"
        return
    }
    git --git-dir="$env:USERPROFILE\.dotfiles.git" --work-tree="$env:USERPROFILE" @args
}
