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
    local mode = f17_mode;

    mode:bind({}, 'J', open("IntelliJ Idea"))
    mode:bind({}, 'N', open("Notion"))
    mode:bind({}, 'C', open("Google Chrome"))
    mode:bind({}, 'T', open("iTerm"))
    mode:bind({}, 'R', open("Reminders"))
    mode:bind({}, 'I', open("Music"))
    mode:bind({}, 'K', open("KakaoTalk"))
    mode:bind({}, 'F', open("Firefox"))
end
