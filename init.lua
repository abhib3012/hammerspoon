local hyper = { "cmd", "alt", "ctrl", "shift" }
    hs.hotkey.bind(hyper, "0", function()  
        hs.reload()
end)
hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

hs.window.animationDuration = 0
hs.hotkey.bind(hyper, "left", function()  
    local win = hs.window.focusedWindow();  
    if not win then return end
    
win:moveToUnit(hs.layout.left50)
end)

hs.hotkey.bind(hyper, "up", function()  
    local win = hs.window.focusedWindow();  
    if not win then return end
    
win:moveToUnit(hs.layout.maximized)
end)

hs.hotkey.bind(hyper, "down", function()  
    local win = hs.window.focusedWindow();  
    if not win then return end
    
win:moveToScreen(win:screen():next())
end)

hs.hotkey.bind(hyper, "right", function()  
    local win = hs.window.focusedWindow();  
    if not win then return end
    
win:moveToUnit(hs.layout.right50)
end)

local applicationHotkeys = {  
    i = 'Google Chrome Beta',
    t = 'Terminal',
    s = 'Safari',
    v = 'Visual Studio Code',
    z = "zoom.us",
    h = "Horo"
}

for key, app in pairs(applicationHotkeys) do  
    hs.hotkey.bind(hyper, key, function()    
        hs.application.launchOrFocus(app)  
    end)
end

hs.loadSpoon("Zoom")
spoon.Zoom:start()

-- This lets you click on the menu bar item to toggle the mute state
zoomStatusMenuBarItem = hs.menubar.new(nil)
zoomStatusMenuBarItem:setClickCallback(function()
    spoon.Zoom:toggleMute()
end)

updateZoomStatus = function(event)
  hs.printf("updateZoomStatus(%s)", event)
  if (event == "from-running-to-meeting") then
    zoomStatusMenuBarItem:returnToMenuBar()
  elseif (event == "muted") then
    zoomStatusMenuBarItem:setTitle("🔴")
  elseif (event == "unmuted") then
    zoomStatusMenuBarItem:setTitle("🟢")
  elseif (event == "from-meeting-to-running") or (event == "from-running-to-closed") then
    zoomStatusMenuBarItem:removeFromMenuBar()
  end
end

hs.loadSpoon("Zoom")
spoon.Zoom:setStatusCallback(updateZoomStatus)
spoon.Zoom:start()

-- Next up:
-- https://github.com/adamyonk/PushToTalk.spoon/blob/master/init.lua
hs.hotkey.bind(hyper, 'm', function()
  spoon.Zoom:mute()
end)

hs.hotkey.bind(hyper, 'u', function()
    spoon.Zoom:unmute()
  end)
