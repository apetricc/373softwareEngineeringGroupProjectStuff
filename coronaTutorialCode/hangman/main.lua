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



local a;local b;local c;local d;local e;local f;local g;local h;local i;local j;
local k;local l;local m;local n;local o;local p;local q;local r;local s;local t;
local u;local v;local w;local x;local y;local z

--local alphabet = ({ 1="A", 2="orange", 3="yellow" })
--for k,v in pairs(alphabet) do print(k,v) end
-- local alphabet = {
--   1 = {"a"},
--   2 = {"b"},
--   3 = {"c"}
-- }
local idle, running, jumping, hiding, shooting = 0, 1, 2, 4, 8
--local a, b, c = 1, 2, 3
--{a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}
alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
for i = 1, 10 do
	print (tostring(alphabet[i]))
end


--[[
alphabet[1] = display.newText(alphabet[1], endX-120, startY, native.systemFontBold, 20 )
		alphabet[1]:setFillColor( 1, 1, 1 )
		alphabet[1].alpha = .25

		local function myTouchListener( event )

		  if ( event.phase == "began" ) then
		          alphabet[1]:removeSelf()
		          alphabet[1] = display.newText(alphabet[1], endX-120, startY, native.systemFontBold, 20 )
		          alphabet[1]:setFillColor(1,0,0)
		          print "event triggered, stuff happened."
		           stuff = "you touched the text!"
		           local textObject2 = display.newText(stuff, display.contentCenterX,
		           display.contentCenterY + 100, native.systemFontBold, 25 )


		           --textObject2 = nil

		  end
		  return true
		end

		alphabet[1]:addEventListener( "touch", myTouchListener )



]]


--[[
int rows = 3;
          int cols = 6;
          printGrid(rows, cols);
     }
 
     public static void printGrid(int rows, int cols)
     {
          for ( int i = 1; i <= (rows * cols); i++ )
          {
               for ( int j = 1; j <= rows; j++)
               {
                      System.out.print(j);
                }
           }
      }
]]


local startLetters = endX - 120
local yCoord = startY

for i = 1, 26, 1 do
 				 if (i % 7 == 0 ) then 
				 	yCoord = yCoord + 20 
				 	startLetters = endX - 120
				 end
				alphabet[i] = display.newText(alphabet[i], startLetters, yCoord, native.systemFontBold, 20 )
				alphabet[i]:setFillColor( 1, 1, 1 )
				alphabet[i].alpha = .25

				local function myTouchListener( event )

				  if ( event.phase == "began" ) then
				         -- alphabet[i]:removeSelf()
				          --alphabet[i] = display.newText(alphabet[i], startLetters, yCoord, native.systemFontBold, 20 )
				          alphabet[i].alpha = 1
				          alphabet[i]:setFillColor(1,0,0)
				  end
				  return true
				end

				alphabet[i]:addEventListener( "touch", myTouchListener )
				startLetters = startLetters + 20
				
end

--[[
b = display.newText("B", endX-100, startY, native.systemFontBold, 20 )
b:setFillColor( 1, 1, 1 )
b.alpha = .25

local function myTouchListener( event )

  if ( event.phase == "began" ) then
          b:removeSelf()
          b = display.newText("B", endX-100,startY, native.systemFontBold, 20 )
          b:setFillColor(1,0,0)
  end
  return true
end
b:addEventListener( "touch", myTouchListener )


c = display.newText("C", endX-80, startY, native.systemFontBold, 20 )
c:setFillColor( 1, 1, 1 )
c.alpha = .25

local function myTouchListener( event )

  if ( event.phase == "began" ) then
          c:removeSelf()
          c = display.newText("C", endX-80,startY, native.systemFontBold, 20 )
          c:setFillColor(1,0,0)
  end
  return true
end
c:addEventListener( "touch", myTouchListener )

d = display.newText("D", endX-60, startY, native.systemFontBold, 20 )
d:setFillColor( 1, 1, 1 )
d.alpha = .25

local function myTouchListener( event )

  if ( event.phase == "began" ) then
          d:removeSelf()
          d = display.newText("D", endX-60,startY, native.systemFontBold, 20 )
          d:setFillColor(1,0,0)
  end
  return true
end
d:addEventListener( "touch", myTouchListener )

e = display.newText("E", endX-40, startY, native.systemFontBold, 20 )
e:setFillColor( 1, 1, 1 )
e.alpha = .25

local function myTouchListener( event )

  if ( event.phase == "began" ) then
          e:removeSelf()
          e = display.newText("E", endX-40,startY, native.systemFontBold, 20 )
          e:setFillColor(1,0,0)
  end
  return true
end
e:addEventListener( "touch", myTouchListener )
]]
