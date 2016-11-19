--this is my file
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

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

local backGroup
local mainGroup
local uiGroup

local resetMessage
local gameOver

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------


local function updateText()
	livesText.text = "Lives: "..lives
	scoreText.text = "Score: "..score
end

--pretty much the main logic of the game here:
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

--fireLaser(), but we can't add the event listener yet
--since we haven't created the ship yet!
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

--dragShip(), and again, we don't put the eventListener yet
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

local function gameLoop()

	-- Create new asteroid
	createAsteroid()

	for i = #asteroidsTable, 1, -1 do
		local thisAsteroid = asteroidsTable[i]

    if ( thisAsteroid.x < -100 or
       thisAsteroid.x > display.contentWidth + 100 or
       thisAsteroid.y < -100 or
       thisAsteroid.y > display.contentHeight + 100 )
    then
			display.remove( thisAsteroid )
			table.remove( asteroidsTable, i )
		end--end of if statement block
	end--end of for loop block
end --end of gameLoop()
--1 second delay, call gameLoop(), infinite times (0, or -1)



local function restoreShip()
--setting to false makes ship temporarily invincible
  ship.isBodyActive = false
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
           lives = 3
           livesText.text = "Lives: "..lives
           resetShip()

           timer.performWithDelay(1000, restoreShip )
  end
  return true
end

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





-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	phsyics.pause() --temporarily pause the physics engine

	backGroup = display.newGroup()
	sceneGroup:insert( backGroup )

	mainGroup = display.newGroup()
	sceneGroup:insert( uiGroup )

	uiGroupj = display.newGroup()
	sceneGroup:insert( uiGroup )

-- Load the background
	local background = display.newImageRect( backGroup, "background.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	ship = display.newImageRect( mainGroup, objectSheet, 4, 98, 79 )
	ship.x = display.contentCenterX
	ship.y = display.contentHeight - 100
	physics.addBody( ship, { radius=30, isSensor=true } )
	ship.myName = "ship"

	--display lives and score
	livesText = display.newText( uiGroup, "Lives: "..lives, 200, 80, native.systemFont, 36 )
	scoreText = display.newText( uiGroup, "Score: "..score, 400, 80, native.systemFont, 36 )

  ship:addEventListener( "tap", fireLaser )
	ship:addEventListener( "touch", dragShip )
end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
			phsyics.start()
			Runtime:addEventListener( "collision", onCollision )
			gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
