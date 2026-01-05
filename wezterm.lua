-------------------------------------------------------------------------------
-- WezTerm Configuration
-- Cyberpunk Orange Theme with Rounded Tabs
-- Features: Rounded tabs, proper colors, integrated buttons
-------------------------------------------------------------------------------

local wezterm = require 'wezterm'
local act = wezterm.action

-- Initialize configuration table
local config = {}

-------------------------------------------------------------------------------
-- SECTION 1: FONT CONFIGURATION
-------------------------------------------------------------------------------
config.font = wezterm.font_with_fallback {
  'CaskaydiaMono NF',  -- Primary font with Nerd Font icons
  'Consolas',          -- Windows fallback font
  'Microsoft YaHei UI',-- Chinese character fallback
}
config.font_size = 12.0
config.line_height = 1.0
config.freetype_load_target = "Light"  -- Smoother font rendering
config.freetype_render_target = "Normal"

-------------------------------------------------------------------------------
-- SECTION 2: COLOR SCHEME AND THEME
-------------------------------------------------------------------------------
config.color_scheme = 'Catppuccin Mocha'

-- Custom colors for cyberpunk theme
config.colors = {
  -- Cursor colors - Bright green for cyberpunk feel
  cursor_bg = '#00FF00',
  cursor_border = '#00FF00',
  cursor_fg = '#000000',
  
  -- Tab bar colors - Cyberpunk Orange theme
  tab_bar = {
    background = '#0a0a14',     -- Deep dark background
    
    -- Active tab - Cyberpunk Orange
    active_tab = {
      bg_color = '#FF8C00',     -- Dark orange
      fg_color = '#000000',     -- Black text for contrast
      intensity = 'Bold',
    },
    
    -- Inactive tab
    inactive_tab = {
      bg_color = '#1a1a2e',     -- Dark blue-gray
      fg_color = '#666699',     -- Muted purple text
    },
    
    -- Hover states
    inactive_tab_hover = {
      bg_color = '#2a2a3e',
      fg_color = '#8888CC',
      italic = true,
    },
    
    new_tab_hover = {
      bg_color = '#1a1a2e',
      fg_color = '#FF8C00',
      italic = true,
    },
  },
  
  -- Customize selection colors
  selection_bg = 'rgba(255, 140, 0, 0.3)',
  selection_fg = '#ffffff',
  
  -- Customize scrollbar
  scrollbar_thumb = '#FF8C00',
}

-------------------------------------------------------------------------------
-- SECTION 3: WINDOW CONFIGURATION
-------------------------------------------------------------------------------
config.window_background_opacity = 0.92
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 5,
}
config.initial_cols = 120
config.initial_rows = 30
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"  -- Integrated min/max/close buttons
config.adjust_window_size_when_changing_font_size = true
config.window_close_confirmation = 'AlwaysPrompt'

-- Window startup event: maximize on launch
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-------------------------------------------------------------------------------
-- SECTION 4: TAB BAR CONFIGURATION
-------------------------------------------------------------------------------
config.enable_tab_bar = true
config.use_fancy_tab_bar = false       -- Use custom tab rendering
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = true
config.show_tab_index_in_tab_bar = false
config.tab_max_width = 40  -- Maximum width for tabs

-- Cursor style
config.default_cursor_style = "SteadyBlock"
config.cursor_blink_rate = 0
config.cursor_blink_ease_in = "Constant"
config.cursor_thickness = 1.5

-------------------------------------------------------------------------------
-- SECTION 5: DEFAULT SHELL AND SSH DOMAINS
-------------------------------------------------------------------------------
config.default_prog = { 'ubuntu1804.exe' }

-- SSH domains configuration
config.ssh_domains = {
  {
    name = 'goertek-server',
    remote_address = '192.168.1.100',
    username = 'jiangmingxing',
  },
}

-------------------------------------------------------------------------------
-- SECTION 6: KEY BINDINGS
-------------------------------------------------------------------------------
config.leader = { key = 'Space', mods = 'CTRL|SHIFT', timeout_milliseconds = 1000 }

config.keys = {
  -- Clipboard operations
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
  { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'Clipboard' },
  
  -- Tab management
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = false } },
  { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
  
  -- Pane management
  { key = '"', mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = '%', mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Right' },
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },
  
  -- Configuration and utilities
  { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },
  { key = 'p', mods = 'CTRL|SHIFT', action = act.ShowLauncher },
  { key = 'P', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
  { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
  
  -- SSH connection shortcut
  { key = 'P', mods = 'LEADER', action = act.AttachDomain('goertek-server') },
  
  -- Tab navigation with number keys
  { key = '1', mods = 'LEADER', action = act.ActivateTab(0) },
  { key = '2', mods = 'LEADER', action = act.ActivateTab(1) },
  { key = '3', mods = 'LEADER', action = act.ActivateTab(2) },
  { key = '4', mods = 'LEADER', action = act.ActivateTab(3) },
  { key = '5', mods = 'LEADER', action = act.ActivateTab(4) },
  { key = '6', mods = 'LEADER', action = act.ActivateTab(5) },
  { key = '7', mods = 'LEADER', action = act.ActivateTab(6) },
  { key = '8', mods = 'LEADER', action = act.ActivateTab(7) },
  { key = '9', mods = 'LEADER', action = act.ActivateTab(8) },
  { key = '0', mods = 'LEADER', action = act.ActivateTab(9) },
  
  -- Tab renaming shortcut
  {
    key = 'r',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new tab name:',
      action = wezterm.action_callback(function(window, pane, line)
        if line and #line > 0 then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  
  -- Create new window
  { key = 'n', mods = 'LEADER', action = act.SpawnWindow },
  
  -- Copy mode (like tmux)
  { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = ']', mods = 'LEADER', action = act.PasteFrom 'Clipboard' },
  
  -- Search mode
  { key = '/', mods = 'LEADER', action = act.Search { CaseSensitiveString = '' } },
}

-------------------------------------------------------------------------------
-- SECTION 7: LAUNCH MENU
-------------------------------------------------------------------------------
config.launch_menu = {
  {
    label = "PowerShell",
    args = { "powershell.exe" },
  },
  {
    label = "CMD",
    args = { "cmd.exe" },
  },
  {
    label = "Ubuntu WSL",
    args = { "wsl.exe" },
  },
  {
    label = "Goertek SSH",
    args = { "wezterm", "connect", "goertek-server" },
  },
  {
    label = "PowerShell (Admin)",
    args = { "powershell.exe", "-NoExit", "-Command", "Start-Process powershell -Verb RunAs" },
  },
  {
    label = "Git Bash",
    args = { "C:\\Program Files\\Git\\bin\\bash.exe" },
  },
}

-------------------------------------------------------------------------------
-- SECTION 8: MOUSE AND INPUT SETTINGS
-------------------------------------------------------------------------------
config.enable_kitty_keyboard = true
config.disable_default_key_bindings = false
config.swallow_mouse_click_on_pane_focus = true
config.swallow_mouse_click_on_window_focus = true

-- Mouse bindings
config.mouse_bindings = {
  -- Ctrl+Wheel for font size
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'CTRL',
    action = act.IncreaseFontSize,
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'CTRL',
    action = act.DecreaseFontSize,
  },
  -- Alt+Wheel for tab switching
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'ALT',
    action = act.ActivateTabRelative(-1),
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'ALT',
    action = act.ActivateTabRelative(1),
  },
  -- Right click to paste
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = act.PasteFrom 'Clipboard',
  },
}

-------------------------------------------------------------------------------
-- SECTION 9: PERFORMANCE AND ERROR HANDLING
-------------------------------------------------------------------------------
config.warn_about_missing_glyphs = false
config.check_for_updates = false
config.front_end = 'WebGpu'  -- Use GPU rendering
config.webgpu_power_preference = 'HighPerformance'
config.max_fps = 60
config.animation_fps = 60
config.enable_scroll_bar = false  -- Disable scroll bar
config.scrollback_lines = 10000
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = 'CursorColor',
}

-------------------------------------------------------------------------------
-- SECTION 10: ROUNDED TAB IMPLEMENTATION WITH DYNAMIC INFO
-------------------------------------------------------------------------------

-- Get shell type
local function get_shell_type(process_name)
  if not process_name then return "term" end
  
  local proc_lower = process_name:lower()
  
  if proc_lower:find("powershell") then
    return "ps"
  elseif proc_lower:find("cmd%.exe") then
    return "cmd"
  elseif proc_lower:find("ubuntu1804.exe") or proc_lower:find("ubuntu") then
    return "wsl"
  elseif proc_lower:find("bash") then
    return "bash"
  elseif proc_lower:find("ssh") then
    return "ssh"
  else
    return "term"
  end
end

-- Rounded tab formatter - fixed color issues
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  
  -- Get process name
  local process_name = ""
  local proc_success, proc = pcall(function()
    return pane:get_foreground_process_name()
  end)
  if proc_success then
    process_name = proc
  end
  
  -- Get shell type
  local shell_type = get_shell_type(process_name)
  local display_text = shell_type
  
  -- Ensure minimum width
  if #display_text < 20 then
    display_text = display_text .. string.rep(" ", 20 - #display_text)
  end
  
  -- Powerline rounded corner characters
  local left_corner = ""  -- Powerline left rounded corner
  local right_corner = "" -- Powerline right rounded corner
  
  if tab.is_active then
    -- Active tab: orange background, black text, rounded corners
    return wezterm.format({
      -- Left corner: transition from tab bar background to orange
      { Foreground = { Color = "#FF8C00" } },    -- Orange foreground (triangle color)
      { Background = { Color = "#0a0a14" } },    -- Tab bar background
      { Text = left_corner },
      
      -- Tab content: orange background, black text
      { Background = { Color = "#FF8C00" } },    -- Orange background
      { Foreground = { Color = "#000000" } },    -- Black text
      { Text = " " .. display_text .. " " },
      
      -- Right corner: transition from orange to tab bar background
      { Foreground = { Color = "#FF8C00" } },    -- Orange foreground (triangle color) 
      { Background = { Color = "#0a0a14" } },    -- Tab bar background
      { Text = right_corner },
    })
  else
    -- Inactive tab: dark background, purple text, rounded corners
    return wezterm.format({
      -- Left corner: transition from tab bar background to dark blue-gray
      { Foreground = { Color = "#1a1a2e" } },    -- Dark blue-gray foreground (triangle color)
      { Background = { Color = "#0a0a14" } },    -- Tab bar background
      { Text = left_corner },
      
      -- Tab content: dark blue-gray background, purple text
      { Background = { Color = "#1a1a2e" } },    -- Dark blue-gray background
      { Foreground = { Color = "#666699" } },    -- Purple text
      { Text = " " .. display_text .. " " },
      
      -- Right corner: transition from dark blue-gray to tab bar background
      { Foreground = { Color = "#1a1a2e" } },    -- Dark blue-gray foreground (triangle color)
      { Background = { Color = "#0a0a14" } },    -- Tab bar background
      { Text = right_corner },
    })
  end
end)

-- Dynamically update pane title
wezterm.on('update-title', function(window, pane, title)
  pane:set_title(pane:get_title())
end)

-------------------------------------------------------------------------------
-- RETURN CONFIGURATION
-------------------------------------------------------------------------------
return config
