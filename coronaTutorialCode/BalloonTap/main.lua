-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--add background
local background = display.newImageRect("background.png", 360, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

--add number to display num taps
local tapCount = 0
local tapText = display.newText( tapCount, display.contentCenterX, 20, native.systemFont, 40 )
tapText:setFillColor( 0,0,0, .5)


--add platform for balloon to bounce off of
local platform = display.newImageRect( "platform.png", 300, 50)
platform.x = display.contentCenterX
platform.y = display.contentHeight-25

local balloon = display.newImageRect( "balloon.png", 112, 112)
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.apha = .8

local physics = require( "physics")
physics.start()

physics.addBody( platform, "static")
physics.addBody( balloon, "dynamic", { radius=50, bounce=.3})

--first function!
local function pushBalloon()
  balloon:applyLinearImpulse( 0, -.75, balloon.x, balloon.y)
  tapCount= tapCount + 1
  tapText.text = tapCount
end

--event listener
balloon:addEventListener( "tap", pushBalloon)
