
local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

-- Seed the random number generator
math.randomseed( os.time() )

-- Configure image sheet
local options =
{
    frames =
    {
        {   -- 1) asteroid 1
            x = 0,
            y = 0,
            width = 102,
            height = 85
        },
        {   -- 2) asteroid 2
            x = 0,
            y = 85,
            width = 90,
            height = 83
        },
        {   -- 3) asteroid 3
            x = 0,
            y = 168,
            width = 100,
            height = 97
        },
        {   -- 4) ship
            x = 0,
            y = 265,
            width = 98,
            height = 79
        },
        {   -- 5) laser
            x = 98,
            y = 265,
            width = 14,
            height = 40
        },
    }
}
local objectSheet = graphics.newImageSheet( "gameObjects.png", options )

-- Initialize variables
local lives = 2
local score = 0
local died = false

local asteroidsTable = {}

local ship
local gameLoopTimer
local livesText
local scoreText
local resetMessage
local gameOver
-- Set up display groups
local backGroup = display.newGroup()  -- Display group for the background image
local mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
local uiGroup = display.newGroup()    -- Display group for UI objects like the score

-- Load the background
local background = display.newImageRect( backGroup, "background.png", 800, 1400 )
background.x = display.contentCenterX
background.y = display.contentCenterY

ship = display.newImageRect( mainGroup, objectSheet, 4, 98, 79 )
ship.x = display.contentCenterX
ship.y = display.contentHeight - 100
physics.addBody( ship, { radius=30, isSensor=true } )
ship.myName = "ship"

-- Display lives and score
livesText = display.newText( uiGroup, "Lives: "..lives, 200, 80, native.systemFont, 36 )
scoreText = display.newText( uiGroup, "Score: "..score, 400, 80, native.systemFont, 36 )

-- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )


local function updateText()
	livesText.text = "Lives: "..lives
	scoreText.text = "Score: "..score
end


local function createAsteroid()

	local newAsteroid = display.newImageRect( mainGroup, objectSheet, 1, 102, 85 )
	table.insert( asteroidsTable, newAsteroid )
	physics.addBody( newAsteroid, "dynamic", { radius=40, bounce=0.8 } )
	newAsteroid.myName = "asteroid"

	local whereFrom = math.random( 3 )

	if ( whereFrom == 1 ) then
		-- From the left
		newAsteroid.x = -60
		newAsteroid.y = math.random( 500 )
		newAsteroid:setLinearVelocity( math.random( 40,120 ), math.random( 20,60 ) )
	elseif ( whereFrom == 2 ) then
		-- From the top
		newAsteroid.x = math.random( display.contentWidth )
		newAsteroid.y = -60
		newAsteroid:setLinearVelocity( math.random( -40,40 ), math.random( 40,120 ) )
	elseif ( whereFrom == 3 ) then
		-- From the right
		newAsteroid.x = display.contentWidth + 60
		newAsteroid.y = math.random( 500 )
		newAsteroid:setLinearVelocity( math.random( -120,-40 ), math.random( 20,60 ) )
	end

	newAsteroid:applyTorque( math.random( -6,6 ) )
end


local function fireLaser()

	local newLaser = display.newImageRect( mainGroup, objectSheet, 5, 14, 40 )
	physics.addBody( newLaser, "dynamic", { isSensor=true } )
	newLaser.isBullet = true
	newLaser.myName = "laser"

	newLaser.x = ship.x
	newLaser.y = ship.y
	newLaser:toBack()

	transition.to( newLaser, { y=-40, time=1000,
		onComplete = function() display.remove( newLaser ) end
	} )
end

ship:addEventListener( "tap", fireLaser )


--touch events have phases: began, moved, and ended/cancelled
local function dragShip( event )

	local ship = event.target
	local phase = event.phase

	if ( "began" == phase ) then
		-- Set touch focus on the ship
		display.currentStage:setFocus( ship )
		-- Store initial offset position
		ship.touchOffsetX = event.x - ship.x
    ship.touchOffsetY = event.y - ship.y

	elseif ( "moved" == phase ) then
		-- Move the ship to the new touch position
		ship.x = event.x - ship.touchOffsetX
    ship.y = event.y - ship.touchOffsetY

	elseif ( "ended" == phase or "cancelled" == phase ) then
		-- Release touch focus on the ship
		display.currentStage:setFocus( nil )
	end

	return true  -- Prevents touch propagation to underlying objects
end

ship:addEventListener( "touch", dragShip )


local function gameLoop()

	-- Create new asteroid
	createAsteroid()

	-- Remove asteroids which have drifted off screen
  --counting down from the number asteroids in the table which is constantly
  --changing, that's what the # sign does--> it gives us that new length of the
  --asteroids table
  --[[
  this tells lua to use the index i, start at #asteroidsTable, stop at 1, and
  count by -1 (decrement)
  --]]
	for i = #asteroidsTable, 1, -1 do
		local thisAsteroid = asteroidsTable[i]

    if ( thisAsteroid.x < -100 or
       thisAsteroid.x > display.contentWidth + 100 or
       thisAsteroid.y < -100 or
       thisAsteroid.y > display.contentHeight + 100 )
    then
--[[if ( thisAsteroid.x < -100 or
   thisAsteroid.x > display.contentWidth + 100 or
   thisAsteroid.y < -100 or
   thisAsteroid.y > display.contentHeight + 100 )
then
]]

			display.remove( thisAsteroid )
			table.remove( asteroidsTable, i )
		end--end of if statement block
	end--end of for loop block
end --end of gameLoop()
--1 second delay, call gameLoop(), infinite times (0, or -1)
gameLoopTimer = timer.performWithDelay( 1000, gameLoop, 0 )


local function restoreShip()
--setting to false makes ship temporarily invincible


  --cancel any velocity the ship had from being hit by a moving asteroid, otherwise
  --it might have bounced off screen or something like that
	ship:setLinearVelocity( 0, 0 )
  --reposition ship to the center of the bottom of the screen
	ship.x = display.contentCenterX
	ship.y = display.contentHeight - 100

	-- Fade in the ship, restoring to active phsyics with a callback on completion
	transition.to( ship, { alpha=1, time=4000,
		onComplete = function()
			ship.isBodyActive = true
			died = false
		end  --end callback function 'onComplete'
	} )

end  --end restoreShip()


local function resetShip()

    ship = display.newImageRect( mainGroup, objectSheet, 4, 98, 79 )
    ship.x = display.contentCenterX
    ship.y = display.contentHeight - 100
    physics.addBody( ship, { radius=30, isSensor=true } )
    ship.isBodyActive = true
    ship.myName = "ship"
  	restoreShip()
    score = 0
    scoreText.text = "Score: " .. score
    ship:addEventListener( "tap", fireLaser )
    ship:addEventListener( "touch", dragShip )

end




local function myTouchListener( event )

  if ( event.phase == "began" ) then
          resetMessage:removeSelf()
          print "event triggered, game reset."
          --display.Hide(textObject2)
          --stuff = nil
          --[[local textObject2 = display.newText("you touched the text!",
          display.contentCenterX, display.contentCenterY+55,
           native.systemFontBold, 15 )
           ]]
           lives = 3
           livesText.text = "Lives: "..lives
           resetShip()

           timer.performWithDelay(1000, restoreShip )
           --timer.performWithDelay( 1000, restoreShip )
           --textObject2 = nil

  end
  return true
end










--collisions have phases just like touch events:
--began, & ended
local function onCollision( event )

	if ( event.phase == "began" ) then

		local obj1 = event.object1
		local obj2 = event.object2

		if ( ( obj1.myName == "laser" and obj2.myName == "asteroid" ) or
			 ( obj1.myName == "asteroid" and obj2.myName == "laser" ) )
		then
			-- Remove both the laser and asteroid
			display.remove( obj1 )
            display.remove( obj2 )

			for i = #asteroidsTable, 1, -1 do
				if ( asteroidsTable[i] == obj1 or asteroidsTable[i] == obj2 ) then
					table.remove( asteroidsTable, i )
					break
				end
			end

			-- Increase score
			score = score + 100
			scoreText.text = "Score: " .. score

		elseif ( ( obj1.myName == "ship" and obj2.myName == "asteroid" ) or
				 ( obj1.myName == "asteroid" and obj2.myName == "ship" ) )
		then
			if ( died == false ) then
				died = true

				-- Update lives
				lives = lives - 1
				livesText.text = "Lives: " .. lives

				if ( lives == 0 ) then
					display.remove( ship )
          --timer.pause( gameLoopTimer );
          resetMessage = display.newText( uiGroup, "Reset? ",
           display.contentCenterX, display.contentCenterY, native.systemFont, 55 )
           resetMessage:addEventListener( "touch", myTouchListener )
          --resetCycle()

          --timer.pause( gameLoopTimer )
				else
					ship.alpha = 0
					timer.performWithDelay( 1000, restoreShip )
				end
			end
		end
	end
end

Runtime:addEventListener( "collision", onCollision )
