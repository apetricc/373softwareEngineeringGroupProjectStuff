-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local startX = 20
local endX = 300
local startY = 20
local endY = 475
-- width = 320,
-- height = 480,
local magicword = "cat"

alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
"Q","R","S","T","U","V","W","X","Y","Z"}


if ((string.find(string.lower(magicword),string.lower(alphabet[1]))~=nil)) then 
	print("This letter was pressed in the event: "..alphabet[1])
end

alphabet2 = {}
for i = 1, table.getn(alphabet), 1 do
	alphabet2[i] = alphabet[i]
end
wordArray = {}
for i = 1, string.len(magicword), 1 do
	wordArray[i] = magicword:sub(i,i)
end
print ("The magic word is this long: "..(table.getn(wordArray)))

-- for i = 1, table.getn(alphabet), 1 do
-- 	print ("Alphabet " .. i .. " is: "..alphabet[i])
-- end
local wordText = display.newText(magicword, display.contentCenterX,350, native.systemFontBold,55)
wordText.alpha = .25
local initialX = endX - 155
local startLetters = initialX
local yCoord = startY
alphaText = {}
--for loop to set alphabet letters on screen with event listeners
for i = 1, 26, 1 do
		 if (i % 7 == 0 ) then 
			 	yCoord = yCoord + 40 
			 	startLetters = initialX
		 end

		alphaText[i] = display.newText(alphabet[i], startLetters, yCoord, native.systemFontBold, 25 )
		alphaText[i]:setFillColor( 1, 1, 1 )
		alphaText[i].alpha = .25
		local index
		local function letterListener( event )

				if ( event.phase == "began" ) then				    
				        -- if (string.find(magicword,alphabet[i])) then
				        -- 	displayText.alpha = 1
				        -- end
				        alphaText[i].alpha = 1
				        alphaText[i]:setFillColor(1,0,0)
				        --print (new)
				        -- ((string.find(string.lower(magicword),string.lower(alphabet[1]))~=nil))
					    if ((string.find(string.lower(magicword),string.lower(alphabet[i]))~=nil)) then 
					        print("This letter was pressed in the event: "..alphabet[i])
					        if (alphaText[i].alpha > .25 and ((string.find(string.lower(magicword),string.lower(alphabet[1]))~=nil))) then
								index = string.find(wordArray[1],alphabet[i]) 
								print (tostring(alphabet[i]) .." was tapped.")
								-- string.sub(index, index).alpha = 1
								print("Index of the tapped letter: "..string.sub(magicword,i, i))
								--wordText[1].alpha = 0
							end--end if

					    end
			    end

			    return true
		end

		alphaText[i]:addEventListener( "touch", letterListener )
		startLetters = startLetters + 25
				
end

local function fillLetter()

end


