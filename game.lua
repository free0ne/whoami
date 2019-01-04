
local composer = require( "composer" )
local toast = require('plugin.toast')

local scene = composer.newScene()

local firstback = true
local justShacken = false
local counter = 0
local lastOne = 1
local newOne = 1

local guys = {}
local guys2 = {}
local celebrities = false
local cinema = false
local cartoon = false

local onepart = 0
local twoparts = 0
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function backTimer( event )
    firstback = true
end

-- Called when a key event has been received
local function onKeyEvent( event )
  -- If the "back" key was pressed on Android, prevent it from backing out of the app
  if (event.phase == "down" and event.keyName == "back" ) then
    if ( system.getInfo("platform") == "android" ) then
      if firstback == true then
        firstback = false
        timer.performWithDelay( 1500, backTimer )
        toast.show('Нажмите ещё раз, чтобы вернуться в меню')
        return true
      else
        Runtime:removeEventListener( "key", onKeyEvent )
        Runtime:removeEventListener( "accelerometer", shakeListener )
        composer.gotoScene( "menu" )
        return true
      end

      return true
    end
  end
  -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
  -- This lets the operating system execute its default handling of the key
  return false
end

-- create()
function scene:create( event )
  display.setStatusBar( display.HiddenStatusBar )
  math.randomseed( os.time() )

  celebrities = composer.getVariable( "cat1" )
  cinema = composer.getVariable( "cat2" )
  cartoon = composer.getVariable( "cat3" )

  if celebrities == true then
    local celebritiesDB = require("celebrities")
    onepart = onepart + #celebritiesDB
    for i=1, #celebritiesDB do
      table.insert( guys, celebritiesDB[i] )
    end
  end
  if cinema == true then
    local cinemaDB = require("cinema")
    twoparts = twoparts + #cinemaDB
    for i=1, #cinemaDB do
      table.insert( guys2, cinemaDB[i] )
    end
  end
  if cartoon == true then
    local cartoonDB = require("cartoons")
    twoparts = twoparts + #cartoonDB
    for i=1, #cartoonDB do
      table.insert( guys2, cartoonDB[i] )
    end
  end

  -- Add the key event listener
  Runtime:addEventListener( "key", onKeyEvent )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
  local gamebgcolor = {225/255, 226/255, 225/255}
  local gametextcolor = {55/255, 0/255, 179/255}
  local subgametextcolor = {98/255, 0/255, 237/255}
  local font = "geometos.ttf"

  display.setDefault( "background", unpack( gamebgcolor ) )
  local gameText = display.newText( sceneGroup, "встряхни телефон,\nчтобы начать игру", display.contentWidth/2, display.contentCenterY, font, 64 )
  gameText:setFillColor( unpack(gametextcolor) )
  gameText.rotation = 90

  local subGameText = display.newText( sceneGroup, "", display.contentWidth/5, display.contentCenterY, font, 44 )
  subGameText:setFillColor( unpack(subgametextcolor) )
  subGameText.rotation = 90

  local function backShake( event )
      justShacken = false
  end

  local function shakeListener( event )
      if event.isShake then
          if justShacken == false then
            justShacken = true
            timer.performWithDelay( 550, backShake )
            counter = counter + 1
            newOne = math.random(onepart + twoparts)
            if lastOne == newOne then
              newOne = math.random(onepart + twoparts)
              --print ("hoba")
            end
            lastOne = newOne
            if (lastOne <= onepart) then
              gameText.text = guys[lastOne]
              subGameText.text = ""
            else
              gameText.text = guys2[lastOne-onepart][1]
              subGameText.text = guys2[lastOne-onepart][2]
            end

            system.vibrate()
          end
      end

      return true
  end
  Runtime:addEventListener( "accelerometer", shakeListener )

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

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
    Runtime:removeEventListener( "key", onKeyEvent )
    Runtime:removeEventListener( "accelerometer", shakeListener )
    composer.removeScene( "game" )
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
