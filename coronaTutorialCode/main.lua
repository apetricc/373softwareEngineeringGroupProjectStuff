local physics = require("physics")
physics.start()

local sky = display.newImage("bkg_clouds.png")
sky.x = 160; sky.y = 195

local ground = display.newImage("ground.png")
ground.x = .1; ground.y = 445

physics.addBody(ground, "static", {friction=.5, bounce=.3})

--drop crate off to the side, goes right by the ground!
local crate = display.newImage("crate.png")
crate.x = 240
crate.y = -50
crate.rotation = 1

physics.addBody(crate, {density=1.0, friction=.9, bounce=.89})