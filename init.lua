hs.hotkey.bind({'option', 'cmd'}, 'r', hs.reload)


function vimesc()
  local inputEnglish = "com.apple.keylayout.ABC"
  local input_source = hs.keycodes.currentSourceID()

  if not (input_source == inputEnglish) then
    hs.eventtap.keyStroke({}, 'right')
    hs.keycodes.currentSourceID(inputEnglish)
  end
  hs.eventtap.keyStroke({'control'}, 'c')   
end

hs.hotkey.bind({}, 'escape', vimesc)

hs.alert.show('Hammerspoon Reloaded')
