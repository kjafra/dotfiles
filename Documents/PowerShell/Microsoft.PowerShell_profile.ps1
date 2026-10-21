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
    $dfArgs = "--git-dir=$env:USERPROFILE\.dotfiles.git", "--work-tree=$env:USERPROFILE"
    git @dfArgs @args
    if ($LASTEXITCODE -ne 0) { return }
    # Re-apply the sparse list (.sparse/windows) in case the pull changed it.
    if ($args[0] -in 'pull', 'merge') {
        git @dfArgs show HEAD:.sparse/windows | git @dfArgs sparse-checkout set --no-cone --stdin
    }
}
