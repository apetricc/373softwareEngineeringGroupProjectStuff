-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
print ("Hello terminal window!")

--[[
block comment
block comment
block comment
]]--

-- display.newText(string, x, y, font, size)
local textStuff = display.newText("Hey now!", 160, 240, "Comic Sans MS", 32)
--set color like this:
-- [object]:setFillColor( r, g, b )
local otherText = display.newText("Wut?", 200, 40, "Arial", 22)
otherText:setFillColor(1, .04, .01)

--make a function to create random values for r, g, b
function screenTap()
	local r = math.random( 0, 100)
	local g = math.random( 0, 100)
	local b = math.random( 0, 100)
	otherText:setFillColor(r/100, g/100, b/100)
end

-- add an event listener
display.currentStage:addEventListener("tap", screenTap)


