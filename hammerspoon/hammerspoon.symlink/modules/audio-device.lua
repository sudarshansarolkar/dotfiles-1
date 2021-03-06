-- Define audio device names for headphone/speaker switching
local usbAudioSearch = "VIA Technologies" -- USB sound card

-- Toggle between speaker and headphone sound devices (useful if you have multiple USB soundcards that are always connected)
function setDefaultAudio()
  local current = hs.audiodevice.defaultOutputDevice()
  local usbAudio = findOutputByPartialUID(usbAudioSearch)

  if usbAudio and current:name() ~= usbAudio:name() then
    usbAudio:setDefaultOutputDevice()
  end

  hs.notify.new({
    title='Hammerspoon',
    informativeText='Default output device:' .. hs.audiodevice.defaultOutputDevice():name()
  }):send()
end

function findOutputByPartialUID(uid)
  for _, device in pairs(hs.audiodevice.allOutputDevices()) do
    if device:uid():match(uid) then
      return device
    end
  end
end

hs.usb.watcher.new(setDefaultAudio):start()
setDefaultAudio()
