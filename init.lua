require('modules.inputsource_aurora')

hs.hotkey.bind({'option', 'cmd'}, 'r', hs.reload)
local f17_mode = hs.hotkey.modal.new()

hs.hotkey.bind({}, 'f17', function() f17_mode:enter() end, function() f17_mode:exit() end)

function vimesc()
  local inputEnglish = "com.apple.keylayout.ABC"
  local input_source = hs.keycodes.currentSourceID()

  if not (input_source == inputEnglish) then
    hs.eventtap.keyStroke({}, 'right')
    hs.keycodes.currentSourceID(inputEnglish)
  end
  hs.eventtap.keyStroke({}, 'escape')   
end

hs.hotkey.bind({}, 'f13', vimesc)

hs.alert.show('Hammerspoon Reloaded')

--- A closure function
function open(name)
  return function()
    hs.application.launchOrFocus(name)
    if name == 'Finder' then
      hs.appfinder.appForName(name):activate()
    end
  end
end

do -- app toggle
    local app_man = require('modules.appman')
    local mode = f17_mode;

    mode:bind({}, 'J', app_man:toggle("IntelliJ Idea"))
    mode:bind({}, 'N', app_man:toggle("Notion"))
    mode:bind({}, 'C', app_man:toggle("Google Chrome"))
    mode:bind({}, 'T', app_man:toggle("iTerm"))
    mode:bind({}, 'R', app_man:toggle("Reminders"))
    mode:bind({}, 'I', app_man:toggle("Music"))
    mode:bind({}, 'K', app_man:toggle("KakaoTalk"))
    mode:bind({}, 'F', app_man:toggle("Firefox"))
    mode:bind({}, 'S', app_man:toggle("Slack"))
    mode:bind({}, '/', app_man:toggle("Notes"))
end
