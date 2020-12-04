require('modules.inputsource_aurora')

hs.hotkey.bind({'option', 'cmd'}, 'r', hs.reload)
local f16_mode = hs.hotkey.modal.new()
local f17_mode = hs.hotkey.modal.new()
local inputEnglish = "com.apple.keylayout.ABC"

hs.hotkey.bind({}, 'f16', function() f16_mode:enter() end, function() f16_mode:exit() end)
hs.hotkey.bind({}, 'f17', function() f17_mode:enter() end, function() f17_mode:exit() end)

function vimesc()
  local input_source = hs.keycodes.currentSourceID()

  if not (input_source == inputEnglish) then
    hs.eventtap.keyStroke({}, 'right')
    hs.keycodes.currentSourceID(inputEnglish)
  end
  hs.eventtap.keyStroke({}, 'escape')
end

hs.hotkey.bind({}, 'f13', vimesc)

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
    mode:bind({}, 'R', app_man:toggle("Reminders"))
    mode:bind({}, 'I', app_man:toggle("Music"))
    mode:bind({}, 'K', app_man:toggle("KakaoTalk"))
    mode:bind({}, 'F', app_man:toggle("Firefox"))
    mode:bind({}, 'S', app_man:toggle("Slack"))
    mode:bind({}, 'T', app_man:toggle("Things3"))
    mode:bind({}, '.', app_man:toggle("Notes"))
    mode:bind({}, '/', app_man:toggle("iTerm"))
    mode:bind({}, 'M', app_man:toggle("MindNode"))
    mode:bind({}, 'A', app_man:toggle("Calendar"))

end

do  -- winmove
    local win_move = require('modules.winmove')
    local mode = f17_mode

    mode:bind({}, '0', win_move.default)
    mode:bind({'shift'}, '0', win_move.move(1/3, 0, 3/2, 1))
    mode:bind({}, '1', win_move.left_bottom)
    mode:bind({}, '2', win_move.bottom)
    mode:bind({}, '3', win_move.right_bottom)
    mode:bind({}, '4', win_move.left)
    mode:bind({'shift'}, '4', win_move.move(0, 0, 3/2, 1))
    mode:bind({}, '5', win_move.full_screen)
    mode:bind({}, '6', win_move.right)
    mode:bind({'shift'}, '6', win_move.move(1/3, 0, 2/3, 1))
    mode:bind({}, '7', win_move.left_top)
    mode:bind({}, '8', win_move.top)
    mode:bind({}, '9', win_move.right_top)
    mode:bind({}, '-', win_move.prev_screen)
    mode:bind({}, '=', win_move.next_screen)
end

do -- move cursor
    local mode = f16_mode
    local cur_move = require('modules.curmove')

    mode:bind({}, '\'', cur_move.right)
    mode:bind({}, ';', cur_move.left)
    mode:bind({}, '[', cur_move.up)
    mode:bind({}, '/', cur_move.down)
    mode:bind({}, 'k', cur_move.home)
    mode:bind({}, ',', cur_move._end)
    mode:bind({}, 'l', cur_move.pageup)
    mode:bind({}, '.', cur_move.pagedown)
end

hs.alert.show('Hammerspoon Reloaded')
