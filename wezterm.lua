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
config.font_size = 10.0
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
config.default_prog = { "E:\\Tool\\msys64\\usr\\bin\\zsh.exe -l" }

-- SSH domains configuration
config.ssh_domains = {
  {
    name = 'goertek-server',
    remote_address = '10.10.204.47:22',
    username = 'jiangmingxing',
    multiplexing = 'None',
    ssh_option = {
        identityfile = "C:\\Users\\astor.jiang\\.ssh\\id_rsa_gtk_service",
    }
  },
}

-------------------------------------------------------------------------------
-- SECTION 6: KEY BINDINGS (Nvim/Tmux Compatible)
-------------------------------------------------------------------------------

-- Use Alt as leader key instead of Ctrl+Shift+Space to avoid conflicts
config.leader = { key = 'a', mods = 'ALT', timeout_milliseconds = 2000 }

-- Disable default key bindings to avoid conflicts
config.disable_default_key_bindings = true

config.keys = {
  -- Copy and paste (standard system shortcuts)
  { key = 'c', mods = 'CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'Clipboard' },
  
  -- Font size (common terminal shortcuts)
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
  
  -- Tab management
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'X', mods = 'ALT', action = act.CloseCurrentTab { confirm = true } },
  { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
  
  -- Pane management with Alt as modifier (less conflicts)
  { key = '-', mods = 'ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = '\\', mods = 'ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'x', mods = 'ALT', action = act.CloseCurrentPane { confirm = false } },
  { key = 'z', mods = 'ALT', action = act.TogglePaneZoomState },
  
  -- Pane resizing with Alt+Shift
  { key = 'h', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'j', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },
  { key = 'k', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'l', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },
  
  -- Configuration and utilities
  { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },
  { key = ',', mods = 'CTRL|SHIFT', action = act.ShowLauncher },
  { key = 'p', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
  { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
  { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
  
  -- SSH connection
  { key = 's', mods = 'ALT', action = act.AttachDomain('goertek-server') },
  
  -- Quick window management
  { key = 'q', mods = 'CTRL|SHIFT', action = act.QuitApplication },
  
  -- Tab navigation with Alt+Number
  { key = '1', mods = 'ALT', action = act.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = act.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = act.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = act.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = act.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = act.ActivateTab(8) },
  { key = '0', mods = 'ALT', action = act.ActivateTab(-1) },  -- Last tab
  
  -- Copy mode (Vim-like, not conflicting with tmux)
  { key = '[', mods = 'CTRL', action = act.ActivateCopyMode },
  
  -- Search
  { key = 'f', mods = 'CTRL', action = act.Search { CaseSensitiveString = '' } },
  { key = 'n', mods = 'CTRL', action = act.ActivateCopyMode },
  { key = 'N', mods = 'CTRL|SHIFT', action = act.CopyMode 'NextMatch' },
  
  -- Clear terminal
  { key = 'l', mods = 'CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
  { key = 'k', mods = 'CTRL|SHIFT', action = act.ClearScrollback 'ScrollbackAndViewport' },
  
  -- Quick actions
  { key = 'd', mods = 'ALT', action = act.ShowDebugOverlay },
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
  -- Double click to select word
  {
    event = { Down = { streak = 2, button = 'Left' } },
    mods = 'NONE',
    action = act.SelectTextAtMouseCursor 'Word',
  },
  -- Triple click to select line
  {
    event = { Down = { streak = 3, button = 'Left' } },
    mods = 'NONE',
    action = act.SelectTextAtMouseCursor 'Line',
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
  elseif proc_lower:find("zsh") then
    return "zsh"
  else
    return "term"
  end
end

-- Get meaningful tab title
local function get_tab_title(tab)
  -- Use user-set tab title if available
  if tab.tab_title and #tab.tab_title > 0 then
    return tab.tab_title
  end
  
  local pane = tab.active_pane
  local title = pane.title
  
  -- If title is default (like "zsh" or "bash"), try to get more meaningful title
  if title == "zsh" or title == "bash" or title == "cmd.exe" or title == "powershell.exe" then
    -- Try to get process info
    local success, proc = pcall(function()
      return pane:get_foreground_process_name()
    end)
    
    if success and proc then
      local proc_name = proc:match("([^/\\]+)$") or proc
      -- If process is zsh/bash, try to get current directory
      if proc_name:find("zsh") or proc_name:find("bash") then
        local dir = pane.current_working_dir
        if dir then
          -- Extract directory name
          local dir_name = dir:match("([^/\\]+)$") or dir
          if dir_name and #dir_name > 0 then
            return "zsh: " .. dir_name
          end
        end
      end
      return proc_name
    end
    
    -- Check if SSH connection
    if pane.domain_name and pane.domain_name ~= "local" then
      return "ssh: " .. pane.domain_name
    end
  end
  
  return title
end

-- Powerline rounded corner characters
local left_corner = ""  -- Powerline left rounded corner
local right_corner = "" -- Powerline right rounded corner

-- Rounded tab formatter
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = get_tab_title(tab)
  
  -- Truncate long titles
  local max_title_length = 25
  if #title > max_title_length then
    title = title:sub(1, max_title_length - 3) .. "..."
  end
  
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
      { Text = " " .. title .. " " },
      
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
      { Text = " " .. title .. " " },
      
      -- Right corner: transition from dark blue-gray to tab bar background
      { Foreground = { Color = "#1a1a2e" } },    -- Dark blue-gray foreground (triangle color)
      { Background = { Color = "#0a0a14" } },    -- Tab bar background
      { Text = right_corner },
    })
  end
end)

-- Update pane title with more info
wezterm.on('update-title', function(window, pane, title)
  local cwd = pane.current_working_dir
  local domain = pane.domain_name
  
  -- For SSH connections, show remote host info
  if domain and domain ~= "local" then
    pane:set_title("ssh: " .. domain)
  -- For local shell, show current directory
  elseif cwd then
    local dir_name = cwd:match("([^/\\]+)$")
    if dir_name then
      pane:set_title(dir_name)
    else
      pane:set_title(title)
    end
  else
    pane:set_title(title)
  end
end)

-- Update title when pane is activated
wezterm.on('activate-pane', function(window, pane)
  wezterm.emit('update-title', window, pane, pane.title)
end)

-------------------------------------------------------------------------------
-- SECTION 11: SET DEFAULT PANE TITLES
-------------------------------------------------------------------------------

-- Set meaningful title when creating new panes
wezterm.on('open-uri', function(window, pane, uri)
  local domain = pane.domain_name
  if domain and domain ~= "local" then
    pane:set_title("ssh: " .. domain)
  end
end)

-- Ensure new panes have correct title
wezterm.on('spawn-command', function(window, pane, args)
  local cmd = args.args and args.args[1] or ""
  if cmd:find("ssh") then
    wezterm.time.call_after(1, function()
      local domain = pane.domain_name
      if domain and domain ~= "local" then
        pane:set_title("ssh: " .. domain)
      end
    end)
  end
end)

-------------------------------------------------------------------------------
-- SECTION 12: STATUS BAR WITH ROUNDED CORNERS
-------------------------------------------------------------------------------

-- Update status bar with rounded corners
wezterm.on('update-status', function(window, pane)
  local time = wezterm.strftime("%H:%M")
  local date = wezterm.strftime("%Y-%m-%d")
  
  -- Right side: time with rounded corners
  local right_status = wezterm.format({
    -- Left corner: transition from tab bar background to dark blue-gray
    { Foreground = { Color = "#1a1a2e" } },    -- Dark blue-gray foreground (triangle color)
    { Background = { Color = "#0a0a14" } },    -- Tab bar background
    { Text = left_corner },
    
    -- Content: dark blue-gray background, purple text
    { Background = { Color = "#1a1a2e" } },    -- Dark blue-gray background
    { Foreground = { Color = "#666699" } },    -- Purple text
    { Text = " " .. time .. " " },
    
    -- Right corner: transition from dark blue-gray to tab bar background
    { Foreground = { Color = "#1a1a2e" } },    -- Dark blue-gray foreground (triangle color)
    { Background = { Color = "#0a0a14" } },    -- Tab bar background
    { Text = right_corner },

    -- Left corner: transition from tab bar background to orange
    { Foreground = { Color = "#FF8C00" } },    -- Orange foreground (triangle color)
    { Background = { Color = "#0a0a14" } },    -- Tab bar background
    { Text = left_corner },
    
    -- Tab content: orange background, black text
    { Background = { Color = "#FF8C00" } },    -- Orange background
    { Foreground = { Color = "#000000" } },    -- Black text
    { Text = " " .. date .. " " },
    
    -- Right corner: transition from orange to tab bar background
    { Foreground = { Color = "#FF8C00" } },    -- Orange foreground (triangle color) 
    { Background = { Color = "#0a0a14" } },    -- Tab bar background
    { Text = right_corner },
  })
  
  window:set_right_status(right_status)
end)

-------------------------------------------------------------------------------
-- SECTION 13: ADDITIONAL CONFIGURATIONS
-------------------------------------------------------------------------------

-- Quick select mode
config.quick_select_patterns = {
  -- Select and copy URLs
  '[a-zA-Z]+://[0-9a-zA-Z-.]+(/[0-9a-zA-Z_\\-./?=&%#]*)?',
  -- Select and copy email addresses
  '\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b',
  -- Select and copy IP addresses
  '\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}',
  -- Select and copy hex colors
  '#[0-9a-fA-F]{6}',
}

-- Unicode input configuration
config.use_ime = true
config.use_dead_keys = false
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

-- Bell configuration
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 50,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 50,
  target = 'CursorColor',
}

-- Tab bar appearance
config.show_tabs_in_tab_bar = true
config.tab_bar_style = {
  new_tab = wezterm.format {
    -- Left corner: transition from tab bar background to dark blue-gray
    { Foreground = { Color = "#1a1a2e" } },    -- Dark blue-gray foreground (triangle color)
    { Background = { Color = "#0a0a14" } },    -- Tab bar background
    { Text = left_corner },
    
    -- Content: dark blue-gray background, purple text
    { Background = { Color = "#1a1a2e" } },    -- Dark blue-gray background
    { Foreground = { Color = "#666699" } },    -- Purple text
    { Text = " " .. ' + ' .. " " },
    
    -- Right corner: transition from dark blue-gray to tab bar background
    { Foreground = { Color = "#1a1a2e" } },    -- Dark blue-gray foreground (triangle color)
    { Background = { Color = "#0a0a14" } },    -- Tab bar background
    { Text = right_corner },
  },
  new_tab_hover = wezterm.format {
    { Foreground = { Color = "#FF8C00" } },    -- Orange foreground (triangle color)
    { Background = { Color = "#0a0a14" } },    -- Tab bar background
    { Text = left_corner },
    
    -- Tab content: orange background, black text
    { Background = { Color = "#FF8C00" } },    -- Orange background
    { Foreground = { Color = "#000000" } },    -- Black text
    { Text = " " .. ' + ' .. " " },
    { Attribute = { Italic = true } },
    
    -- Right corner: transition from orange to tab bar background
    { Foreground = { Color = "#FF8C00" } },    -- Orange foreground (triangle color) 
    { Background = { Color = "#0a0a14" } },    -- Tab bar background
    { Text = right_corner },
    
  },
}

-------------------------------------------------------------------------------
-- RETURN CONFIGURATION
-------------------------------------------------------------------------------
return config
