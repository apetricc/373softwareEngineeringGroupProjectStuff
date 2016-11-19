local composer = require( "composer" )

-- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- Seed the random number generator
math.randomseed( os.time() )

-- this will eventually go to the menu scene.
composer.gotoScene( "menu" )