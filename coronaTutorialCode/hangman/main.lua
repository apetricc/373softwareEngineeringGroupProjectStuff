-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

display.setStatusBar( display.HiddenStatusBar )
local startX = -35
local endX = 515
local startY = 10
local endY = 310
local aStartX = 0
local aStartY = 20
local width = 480; local height = 320;



local magicword = "magicword"

-- local length = strlen(magicword)
-- print ("The length of the magicword is: " .. length)

-- string methods:

-- string.find (str, substr, [init, [end]])
-- string.len(s)
-- string.sub(s,i,[j])
-- string.lower(s)
-- string.upper(s)
-- string.gsub(mainString,findString,replaceString)
-- string.reverse(arg)
-- string.format(...)
-- --Basic string formatting
-- print(string.format("Basic formatting %s %s",string1,string2))




-- ascii(s,[i])     ??
-- format(formatstring,e1,e2,...)

local theLength = string.len(magicword)

print("The length of the magic word is: " ..theLength)
print ("The index where the letter is at: " .. string.find(magicword,"c"))

-- local a;local b;local c;local d;local e;local f;local g;local h;local i;local j;
-- local k;local l;local m;local n;local o;local p;local q;local r;local s;local t;
-- local u;local v;local w;local x;local y;local z


alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
"Q","R","S","T","U","V","W","X","Y","Z"}

local initialX = endX - 155
local startLetters = initialX
local yCoord = startY

for i = 1, 26, 1 do
 				 if (i % 7 == 0 ) then 
				 	yCoord = yCoord + 40 
				 	startLetters = initialX
				 end
				alphabet[i] = display.newText(alphabet[i], startLetters, yCoord, native.systemFontBold, 25 )
				alphabet[i]:setFillColor( 1, 1, 1 )
				alphabet[i].alpha = .25

				local function letterListener( event )

				  if ( event.phase == "began" ) then				    
				          alphabet[i].alpha = 1
				          alphabet[i]:setFillColor(1,0,0)
				  end
				  return true
				end

				alphabet[i]:addEventListener( "touch", letterListener )
				startLetters = startLetters + 25
				
end

local displayText = display.newText(magicword, 100,
	255, native.systemFontBold, 55 )

displayText.alpha = .025

local function wordListener( event )
	if ( event.phase == "began" ) then
		displayText.alpha = 1
		displayText:setFillColor(1,0,0)
	end
	return true
end
displayText:addEventListener("touch", wordListener )	


