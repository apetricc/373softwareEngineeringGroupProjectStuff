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



local magicword = "CACTUS"

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

--******************************************************************************
--load hangman images into an array that can be displayed on wrong guesses
--******************************************************************************
hangman = {}
hangman[1] = display.newImageRect( "post.png", 200, 200)
hangman[2] = display.newImageRect( "head.png", 200, 200)
hangman[3] = display.newImageRect( "body.png", 200, 200)
hangman[4] = display.newImageRect( "leftArm.png", 200, 200)
hangman[5] = display.newImageRect( "rightArm.png", 200, 200)
hangman[6] = display.newImageRect( "leftLeg.png", 200, 200)
hangman[7] = display.newImageRect( "rightLeg.png", 200, 200)



for i = 1, table.getn(hangman), 1 do
		hangman[i].x = display.contentCenterX - 75
		hangman[i].y = display.contentCenterY - 50
		hangman[i].alpha = 0
end




alphabet = {}
alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
"Q","R","S","T","U","V","W","X","Y","Z"}

--******************************************************************************
--CREATE MAGICWORD DISPLAY GRID
--change alpha to 1 when letters selected from alphabet 
--******************************************************************************
magicCopy = {}
printOut = {}
local magicX = 50
local result


for i = 1, string.len(magicword), 1 do
	magicCopy[i] = string.sub(magicword, i, i)
	--magicCopy[i] = display.newText(string.sub(magicWord,i,i+1), 100, 250, native.systemFontBold, 35 )
	printOut[i] = display.newText(magicword:sub(i,i), magicX, 255, native.systemFontBold, 35 )
	magicX = magicX + 35
	printOut[i].alpha = .15
end

--******************************************************************************
--CREATE ALPHABET GRID for touch interaction with copy, 
--then compare original array to magic word 
--******************************************************************************
local initialX = endX - 155
local startLetters = initialX
local yCoord = startY
newLetter = {}
local hangCount = 1
--for loop to set alphabet letters on screen with event listeners
for i = 1, 26, 1 do
		 if (i % 7 == 0 ) then 
			 	yCoord = yCoord + 40 
			 	startLetters = initialX
		 end

		newLetter[i] = display.newText(alphabet[i], startLetters, yCoord, native.systemFontBold, 25 )
		newLetter[i]:setFillColor( 1, 1, 1 )
		newLetter[i].alpha = .25
		local index
		
		local outputX = 100
		local function letterListener( event )

				if ( event.phase == "began" ) then				    
				        
				        newLetter[i].alpha = 1
				        newLetter[i]:setFillColor(1,0,0)
				        --print (new)
					    if (string.find(magicword,alphabet[i])~=nil) then 
					        print("This letter was pressed in the event: "..alphabet[i])
					        for j = 1, string.len(magicword),1 do
					        	if (alphabet[i]==string.sub(magicword,j,j)) then
					        		print ("Match on letter: " ..alphabet[i])
					        		printOut[j].alpha = 1
					        	end --if letter matches index j of magicword
					        end--for j, length of magicword 
					    
					    else 
					    -- 	  local platform = display.newImageRect( "platform.png", 300, 50)
									-- platform.x = display.contentCenterX
									-- platform.y = display.contentHeight-25
					    	-- hangedman = display.newImageRect( "rightLeg.png", 200, 200)
					    	-- hangedman.x = display.contentCenterX - 50
					    	-- hangedman.y = display.contentCenterY - 50
					    	hangman[hangCount].alpha = 1
					    	hangCount = hangCount + 1
					    	print ("Hang count is: "..hangCount)
					    	if (hangCount > 7) then
					    		local gameOver = display.newText("GAME OVER!", display.contentCenterX, 
					    			display.contentCenterY, native.systemFontBold, 55)
					    		gameOver:setFillColor(1,0,0)
					    	end
					    end--end if matches a letter in magicword
			    end--if event began

			    return true
		end

		newLetter[i]:addEventListener( "touch", letterListener )
		startLetters = startLetters + 25
				
end

