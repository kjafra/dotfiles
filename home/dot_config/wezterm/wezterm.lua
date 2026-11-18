
--- wezterm.lua
--- $ figlet -f small Wezterm
--- __      __      _
--- \ \    / /__ __| |_ ___ _ _ _ __
---  \ \/\/ / -_)_ /  _/ -_) '_| '  \
---   \_/\_/\___/__|\__\___|_| |_|_|_|
---
--- My Wezterm config file

local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

-- Settings
config.default_prog = { "pwsh" }

-- Custom palette matching Helix's github_dark_high_contrast (WezTerm only
-- ships the regular "GitHub Dark"). Colors follow GitHub Primer.
config.color_schemes = {
  ["GitHub Dark High Contrast"] = {
    foreground = "#f0f3f6",
    background = "#0a0c10",
    cursor_bg = "#71b7ff",
    cursor_fg = "#0a0c10",
    cursor_border = "#71b7ff",
    selection_bg = "#264f78",
    selection_fg = "#f0f3f6",
    ansi = { "#272b33", "#ff9492", "#26cd4d", "#f0b72f", "#71b7ff", "#cb9eff", "#39c5cf", "#d9dee3" },
    brights = { "#4c5461", "#ffb1af", "#4ae168", "#f7c843", "#91cbff", "#dbb7ff", "#56d4dd", "#ffffff" },
  },
}
config.color_scheme = "GitHub Dark High Contrast"

-- Pinned explicitly (rather than relying on WezTerm's built-in fallback
-- font) for consistently crisp rendering of Nerd Font glyphs (herdr status
-- icons, eza/shell prompt icons, etc.) instead of the fallback.
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 11
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000

-- herdr owns tabs, panes, workspaces and the status line, so WezTerm's
-- tab bar is hidden entirely.
config.enable_tab_bar = false

-- Copy selected text straight to the system clipboard (in addition to the
-- primary selection) as soon as the mouse button is released.
config.mouse_bindings = {
  { event = { Up = { streak = 1, button = "Left" } }, mods = "NONE", action = act.CompleteSelection("ClipboardAndPrimarySelection") },
  { event = { Up = { streak = 2, button = "Left" } }, mods = "NONE", action = act.CompleteSelection("ClipboardAndPrimarySelection") },
  { event = { Up = { streak = 3, button = "Left" } }, mods = "NONE", action = act.CompleteSelection("ClipboardAndPrimarySelection") },
}

-- Keys
-- Leaning on WezTerm's default keybindings (no custom LEADER prefix); see
-- https://wezterm.org/config/default-keys.html for the full list.
--
-- Everything that duplicates herdr (tabs, panes, splits, copy mode,
-- search, scrollback, launcher) is disabled below, so those keypresses fall
-- through to herdr/the shell instead. Each entry undoes exactly one
-- default assignment (see
-- https://wezterm.org/config/lua/keyassignment/DisableDefaultAssignment.html).
-- Kept: clipboard, font size, fullscreen, new window, reload, palette, debug.
config.keys = {
  -- Tabs (herdr tabs)
  { key = "t", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- SpawnTab
  { key = "T", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- SpawnTab
  { key = "w", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- CloseCurrentTab
  { key = "W", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- CloseCurrentTab
  { key = "Tab", mods = "CTRL", action = act.DisableDefaultAssignment }, -- ActivateTabRelative +1
  { key = "Tab", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- ActivateTabRelative -1
  { key = "PageUp", mods = "CTRL", action = act.DisableDefaultAssignment }, -- ActivateTabRelative -1
  { key = "PageDown", mods = "CTRL", action = act.DisableDefaultAssignment }, -- ActivateTabRelative +1
  { key = "PageUp", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- MoveTabRelative -1
  { key = "PageDown", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- MoveTabRelative +1
  { key = "1", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- ActivateTab
  { key = "2", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "3", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "4", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "5", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "6", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "7", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "8", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "9", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "!", mods = "CTRL", action = act.DisableDefaultAssignment }, -- ActivateTab via shifted digit (Shift is implicit)
  { key = "@", mods = "CTRL", action = act.DisableDefaultAssignment },
  { key = "#", mods = "CTRL", action = act.DisableDefaultAssignment },
  { key = "$", mods = "CTRL", action = act.DisableDefaultAssignment },
  { key = "%", mods = "CTRL", action = act.DisableDefaultAssignment },
  { key = "^", mods = "CTRL", action = act.DisableDefaultAssignment },
  { key = "&", mods = "CTRL", action = act.DisableDefaultAssignment },
  { key = "*", mods = "CTRL", action = act.DisableDefaultAssignment },
  { key = "(", mods = "CTRL", action = act.DisableDefaultAssignment },
  { key = "!", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "@", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "#", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "$", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "%", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "^", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "&", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "*", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "(", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },

  -- Copy mode, search, quick select (herdr copy mode covers these)
  { key = "x", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- ActivateCopyMode
  { key = "X", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- ActivateCopyMode
  { key = "f", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- Search
  { key = "F", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- Search
  { key = "Space", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- QuickSelect

  -- Scrollback (herdr keeps its own scrollback)
  { key = "PageUp", mods = "SHIFT", action = act.DisableDefaultAssignment }, -- ScrollByPage -1
  { key = "PageDown", mods = "SHIFT", action = act.DisableDefaultAssignment }, -- ScrollByPage +1
  { key = "k", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- ClearScrollback
  { key = "K", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- ClearScrollback

  -- Panes and splits

  { key = "\"", mods = "CTRL|ALT", action = act.DisableDefaultAssignment }, -- SplitVertical
  { key = "\"", mods = "CTRL|SHIFT|ALT", action = act.DisableDefaultAssignment }, -- SplitVertical
  { key = "'", mods = "CTRL|ALT", action = act.DisableDefaultAssignment }, -- SplitVertical (raw apostrophe key)
  { key = "'", mods = "CTRL|SHIFT|ALT", action = act.DisableDefaultAssignment }, -- SplitVertical (raw apostrophe key + shift)
  { key = "%", mods = "CTRL|ALT", action = act.DisableDefaultAssignment }, -- SplitHorizontal
  { key = "%", mods = "CTRL|SHIFT|ALT", action = act.DisableDefaultAssignment }, -- SplitHorizontal
  { key = "5", mods = "CTRL|ALT", action = act.DisableDefaultAssignment }, -- SplitHorizontal (raw 5 key)
  { key = "5", mods = "CTRL|SHIFT|ALT", action = act.DisableDefaultAssignment }, -- SplitHorizontal (raw 5 key + shift)
  { key = "LeftArrow", mods = "CTRL|SHIFT|ALT", action = act.DisableDefaultAssignment }, -- AdjustPaneSize Left
  { key = "RightArrow", mods = "CTRL|SHIFT|ALT", action = act.DisableDefaultAssignment }, -- AdjustPaneSize Right
  { key = "UpArrow", mods = "CTRL|SHIFT|ALT", action = act.DisableDefaultAssignment }, -- AdjustPaneSize Up
  { key = "DownArrow", mods = "CTRL|SHIFT|ALT", action = act.DisableDefaultAssignment }, -- AdjustPaneSize Down
  { key = "LeftArrow", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- ActivatePaneDirection Left
  { key = "RightArrow", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- ActivatePaneDirection Right
  { key = "UpArrow", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- ActivatePaneDirection Up
  { key = "DownArrow", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- ActivatePaneDirection Down
  { key = "Z", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }, -- TogglePaneZoomState
}

return config
