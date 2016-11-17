-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
--[[
local word = display.newText( "Reset?", display.contentCenterX, display.contentCenterY, native.systemFont, 55 )


local function resetCycle()
  gameOver = true
  resetMessage.x = display.contentCenterX
  resetMessage.y = display.contentCenterY

end

local function resetGame()
  if (gameOver) then
    lives, livesText = 3
    restoreShip()
    timer.resume( gameLoopTimer )
  end
end

--resetMessage:addEventListener( "tap", resetGame)



local function myTouchListener( event )

if ( event.phase == "began" ) then
        local textObject = display.newText("you touched the text!",
        display.contentCenterX, display.contentCenterY + 44,
         native.systemFontBold, 25 )
    end
    return true
end


local textObject2 = display.newText("Hey! ",display.contentCenterX,display.contentCenterY, native.systemFontBold, 15 )





local word = display.newText( "Reset?", display.contentCenterX, display.contentCenterY, native.systemFont, 55 )

function word:touch( event )
    if event.phase == "began" then
        print( "You touched reset!" )
        return true
    end
end

word:addEventListener( "touch", word )


--other guys thing:

local stuff = "Hey, touch me!"
local textObject2 = display.newText(stuff, display.contentCenterX,
display.contentCenterY, native.systemFontBold, 25 )

local function myTouchListener( event )

  if ( event.phase == "began" ) then
          stuff:removeSelf()
          stuff = nil
          local textObject = display.newText("you touched the text!",
          display.contentCenterX, display.contentCenterY+55,
           native.systemFontBold, 15 )
  end
  return true
end


textObject2:addEventListener( "touch", myTouchListener )


local textObject2 = display.newText("hello!", display.contentCenterX,
display.contentCenterY, native.systemFontBold, 25 )


local function myTouchListener( event )
  if ( event.phase == "began" ) then
    print( "object touched =", event.target )
    local textObject = display.newText("you touched "..event.target , 320, 480, native.systemFontBold, 15 )
  end
  return true
end
]]
local stuff = "Hey, touch me!"
local textObject2 = display.newText(stuff, display.contentCenterX,
display.contentCenterY, native.systemFontBold, 25 )

local function myTouchListener( event )

  if ( event.phase == "began" ) then
          textObject2:removeSelf()
          print "event triggered, stuff happened."
          --display.Hide(textObject2)
          --stuff = nil
          --[[local textObject2 = display.newText("you touched the text!",
          display.contentCenterX, display.contentCenterY+55,
           native.systemFontBold, 15 )
           ]]
           stuff = "you touched the text!"
           textObject2 = display.newText(stuff, display.contentCenterX,
           display.contentCenterY, native.systemFontBold, 25 )


           --textObject2 = nil

  end
  return true
end


textObject2:addEventListener( "touch", myTouchListener )
