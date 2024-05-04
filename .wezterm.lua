local wezterm = require 'wezterm'
local launch_menu = {}
local keys = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'pwsh.exe', '-NoLogo' },
  })

  -- Find installed visual studio version(s) and add their compilation
  -- environment command prompts to the menu
  for _, vsvers in
    ipairs(
      wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files')
    )
  do
    local year = vsvers:gsub('Microsoft Visual Studio/', '')
    table.insert(launch_menu, {
      label = 'x64 Native Tools VS ' .. year,
      args = {
        'cmd.exe',
        '/k',
        'C:/Program Files (x86)/'
          .. vsvers
          .. '/BuildTools/VC/Auxiliary/Build/vcvars64.bat',
      },
    })
  end
  -- Find installed visual studio version(s) and add their compilation
  -- environment command prompts to the menu
  for _, vsvers in
    ipairs(
      wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files')
    )
  do
    local year = vsvers:gsub('Microsoft Visual Studio/', '')
    table.insert(launch_menu, {
      label = 'x64 Native Tools VS PowerShell ' .. year,
      args = {
        'powershell.exe',
        '-NoExit',
        '-Command',
        '&{Import-Module "C:/Program Files/Microsoft Visual Studio/2022/Community/Common7/Tools/Microsoft.VisualStudio.DevShell.dll"; Enter-VsDevShell ece39202 -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64"}'      
      },
    })
  end
end



keys = {
    -- This will create a new split and run your default program inside it
    {key="d", mods="CTRL|SHIFT",
      action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="d", mods="CTRL",
      action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
   {
      key = 'c',
      mods = 'CTRL',
      action = wezterm.action_callback(function(window, pane)
        local sel = window:get_selection_text_for_pane(pane)
        if (not sel or sel == '') then
          window:perform_action(wezterm.action.SendKey{ key='c', mods='CTRL' }, pane)
        else
          window:perform_action(wezterm.action{ CopyTo = 'ClipboardAndPrimarySelection' }, pane)
        end
      end),
    },
  }

return {
  font = wezterm.font("JetBrains Mono"),
  --color_scheme = "Alabaster",
  front_end = "WebGpu",
  default_prog = { 'pwsh.exe', '-NoLogo' },
  keys = keys,
  launch_menu = launch_menu
}
