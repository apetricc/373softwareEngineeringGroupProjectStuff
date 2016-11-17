-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

-- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )

--initialize physics
local physics = require( "physics")
physics.start()
physics.setGravity( 0, 0 )
--seed the random number generator
math.randomseed( os.time() )


--configure image sheet
local sheetOptions =
{
  frames =
  {
    {
      --1) asteroid 1
      x = 0,
      y = 0,
      width = 102,
      height = 85
    },
    { -- 2) asteroid 2
      x = 0,
      y = 85,
      width = 90,
      height = 83
    },
    { -- 3) asteroid 3
      x = 0,
      y = 168,
      width = 100,
      height = 97
    },
    {-- 4) ship
      x = 0,
      y = 265,
      width = 98,
      height = 79
    },
    {-- 5) laser
      x = 98,
      y = 265,
      width = 14,
      height = 40
    },
  }
}

local objectSheet = graphics.newImageSheet( "gameObjects.png", sheetOptions)

local lives = 3
local score = 0
local died = false

local asteroidsTable = {}

local ship
local gameLoopTimer
local livesText
local scoreText

--display groups are layered in the order they are declared,
--background, main, then UI
local backGroup = display.newGroup()  --background
local mainGroup = display.newGroup() -- ship, asteroids, lasers, etc
local uiGroup = display.newGroup()  --display group for UI objects like the score

--load the background
local background = display.newImageRect( backGroup, "background.png", 800, 1400 )
background.x = display.contentCenterX
background.y = display.contentCenterY

ship = display.newImageRect( mainGroup, objectSheet, 4, 98, 79 )
--where ship is displayed:
ship.x = display.contentCenterX
ship.y = display.contentHeight - 100
physics.addBody( ship, { radius = 30, isSensor = true } )
ship.myName = "ship"

--display lives and score
livesText = display.newText( uiGroup, "Lives: " .. lives, 200, 80, native.systemFont, 36 )
scoreText = display.newText( uiGroup, "Score: " .. score, 400, 80, native.systemFont, 36 )

-- function to update lives and score text
local function updateText()
  livesText.text = "Lives: " .. lives
  scoreText.text = "Score: " .. score
end

-- game logic:
--create a new object that is an asteroid
local function createAsteroid()
  local newAsteroid = display.newImageRect( mainGroup, objectSheet, 1, 102, 85 )
end

--insert asteroid into asteroidsTable with table.insert
table.insert( asteroidsTable, newAsteroid )

--now that it's added to the table and image loaded, we add it to the physics engine
physics.addBody( newAsteroid, "dynamic", { radius=40, bounce=.8 } )

--[[
Finally, let's assign the asteroid a myName property of "asteroid".
Later on, when detecting collisions, it will simplify our lives to know
that this object is an asteroid:
--]]
newAsteroid.myName = "asteroid"

--set point of origin for asteroid with the math.random() command, either 1, 2, or 3
local whereFrom = math.random( 3 )

--if 1 place the asteroid slightly off to the left
if (whereFrom == 1) then
  --from the left
  newAsteroid.x = -60
  newAsteroid.y = math.random( 500 )

elseif ( whereFrom == 2 ) then
  --from the top
  newAsteroid.x = math.random( display.contentWidth )
  newAsteroid.y = -60
  newAsteroid:setLinearVelocity( math.random( -40,40 ), math.random( 40,120 ) )

elseif ( whereFrom == 3 ) then
  --from the right
  newAsteroid.x = display.contentWidth + 60
  newAsteroid.y = math.random( 500 )
  newAsteroid:setLinearVelocity( math.random( -120,-40 ), math.random( 20,60 ) )

end

--tell asteroid where to move to
newAsteroid:setLinearVelocity( math.random( 40, 120 ), math.random(20, 60 ) )
newAsteroid:applyTorque( math.random( -6,6 ) )

--create new laser object
local function fireLaser()
  local newLaser = display.newImageRect( mainGroup, objectSheet, 5, 14, 40 )
  physics.addBody( newLaser, "dynamic", { isSensor=true } )
  newLaser.isBullet = true
  transition.to( newLaser, { y=-40, time=500,
    onComplete = function() display.remove( newLaser ) end
    } )
end
ship:addEventListener( "tap", fireLaser )
newLaser.myName = "laser"

newLaser.x = ship.x
newLaser.y = ship.y
newLaser:toBack()

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
    for i = #asteroidsTable, 1, -1 do
        local thisAsteroid = asteroidsTable[i]

        if ( thisAsteroid.x < -100 or
             thisAsteroid.x > display.contentWidth + 100 or
             thisAsteroid.y < -100 or
             thisAsteroid.y > display.contentHeight + 100 )
        then
            display.remove( thisAsteroid )
            table.remove( asteroidsTable, i )
        end
    end
end
