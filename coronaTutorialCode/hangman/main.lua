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



local magicword = "MAGICWORD"

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
--print ("The index where the letter is at: " .. string.find(magicword,"c"))

if (string.find(magicword,"c")~=nil) then
	print ("the letter was in the magicword")
end

-- local a;local b;local c;local d;local e;local f;local g;local h;local i;local j;
-- local k;local l;local m;local n;local o;local p;local q;local r;local s;local t;
-- local u;local v;local w;local x;local y;local z

alphabet = {}
alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
"Q","R","S","T","U","V","W","X","Y","Z"}

alphabet3 = {}
alphabet3[1] = "!"
print (alphabet3[1])
print (alphabet[1])

local newTextObject = display.newText(alphabet[1], 100, 200, native.systeFont, 55 )
-- alphabet = {[1]="A",[2]="B",[3]="C",[4]="D",[5]="E",[6]="F",[7]="G",[8]="H",
-- [9]="I",[10]="J",[11]="K",[12]="L",[13]="M",[14]="N",[15]="O",[16]="P",[17]="Q",
-- [18]="R",[19]="S",[20]="T",[21]="U",[22]="V",[23]="W",[24]="X",[25]="Y",[26]="Z"}


-- alphabet[1] = "A"
-- alphabet[2]= "B"
-- alphabet[3]="C"
-- alphabet[4]="D"
-- alphabet[5]="E"
-- alphabet[6]="F"
-- alphabet[7]="G"
-- alphabet[8]="H"
-- alphabet[9]="I";alphabet[10]="J";alphabet[11]="K";alphabet[12]="L";
-- alphabet[13]="M";alphabet[14]="N";alphabet[15]="O";alphabet[16]="P"
-- alphabet[17]="Q";alphabet[18]="R";alphabet[19]="S";alphabet[20]="T";
-- alphabet[21]="U";alphabet[22]="V";alphabet[23]="W";alphabet[24]="X";
-- alphabet[25]="Y";alphabet[26]="Z";




-- local initialX = endX - 155
-- local startLetters = initialX
-- local yCoord = startY
-- newLetter = {}
-- --for loop to set alphabet letters on screen with event listeners
-- for i = 1, 26, 1 do
-- 		 if (i % 7 == 0 ) then 
-- 			 	yCoord = yCoord + 40 
-- 			 	startLetters = initialX
-- 		 end

-- 		alphabet[i] = display.newText(alphabet[i], startLetters, yCoord, native.systemFontBold, 25 )
-- 		alphabet[i]:setFillColor( 1, 1, 1 )
-- 		alphabet[i].alpha = .25

-- 		local function letterListener( event )

-- 				if ( event.phase == "began" ) then				    
-- 				        -- if (string.find(magicword,alphabet[i])) then
-- 				        -- 	displayText.alpha = 1
-- 				        -- end
-- 				        alphabet[i].alpha = 1
-- 				        alphabet[i]:setFillColor(1,0,0)
				        
-- 			    end

-- 			    return true
-- 		end

-- 		alphabet[i]:addEventListener( "touch", letterListener )
-- 		startLetters = startLetters + 25
				
-- end



--create alphabet grid for touch interaction with copy, then compare original array to magic word 
local initialX = endX - 155
local startLetters = initialX
local yCoord = startY
newLetter = {}
--for loop to set alphabet letters on screen with event listeners
for i = 1, 26, 1 do
		 if (i % 7 == 0 ) then 
			 	yCoord = yCoord + 40 
			 	startLetters = initialX
		 end

		newLetter[i] = display.newText(alphabet[i], startLetters, yCoord, native.systemFontBold, 25 )
		newLetter[i]:setFillColor( 1, 1, 1 )
		newLetter[i].alpha = .25

		local function letterListener( event )

				if ( event.phase == "began" ) then				    
				        -- if (string.find(magicword,alphabet[i])) then
				        -- 	displayText.alpha = 1
				        -- end
				        newLetter[i].alpha = 1
				        newLetter[i]:setFillColor(1,0,0)
					    if (string.find(magicword,alphabet[i])~=nil) then 
					        print("This letter was pressed in the event: "..alphabet[i])
					    end
			    end

			    return true
		end

		newLetter[i]:addEventListener( "touch", letterListener )
		startLetters = startLetters + 25
				
end









--display text for magicword
local displayText = display.newText(magicword, 100,
	255, native.systemFontBold, 55 )

displayText.alpha = .025

local function wordListener( event )
	if ( event.phase == "began" ) then
			displayText.alpha = 1
			displayText:setFillColor(1,0,0)
			--for loop to determine tapped status after magic word activated
			local var
			for i = 1, 26, 1 do 
				--alphabet[i]:removeEventListener("touch",letterListener)
				

				if (alphabet[i].alpha > .25) then
				--	print (tostring(alphabet[i]) .." was tapped.")
					displayText.alpha = 1
				end--end if
			end --end for
	end--end if phase
	return true
end--end function
displayText:addEventListener("touch", wordListener )



-- for key,value in myTable do --pseudocode
--     value = "foobar"
-- end
-- This "pseudocode" makes no sense. You cannot modify a table by modifying the 
-- contents of a local variable; Lua doesn't work that way. You cannot get a 
-- reference to a table entry; you can only get a value from the table.

-- If you want to modify the contents of a table, you have to actually modify 
-- the table. For example:

-- for key,value in pairs(myTable) do --actualcode
--     myTable[key] = "foobar"
-- end

--print alphabet3.a
--alphabet2 = {[1] = "A",[2]="B",[3]="C"}
--for key, letter in pairs(alphabet2) do print (key, letter)end
-- ,"D","E","F","G","H","I","J","K","L","M","N","O","P",
-- "Q","R","S","T","U","V","W","X","Y","Z"}
