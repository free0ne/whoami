
local composer = require( "composer" )
local toast = require('plugin.toast')

local scene = composer.newScene()

local firstback = true
local justShacken = false
local counter = 0
local lastOne = 1
local newOne = 1

local tempDB = {}
local totalDB = {}
local serviceDB = {}

local titlesOnly
local celebritiesRU = false
local celebritiesIN = false
local cinema = false
local cinemaHeroes = false
local cartoons = false
local cartoonHeroes = false
local books = false
local bookHeroes = false

local subGameText
local gameText
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function backShake( event )
    justShacken = false
end

local function backTimer( event )
    firstback = true
end

local function shakeListener( event )
    if event.isShake then
        if justShacken == false then
            justShacken = true
            timer.performWithDelay( 550, backShake )
            counter = counter + 1
            newOne = math.random(#totalDB)
            if lastOne == newOne then
                newOne = math.random(#totalDB)
                --print ("hoba")
            end
            lastOne = newOne
            gameText.text = totalDB[lastOne][1]
            subGameText.text = totalDB[lastOne][2]
            --gameText.text = "привет привет привет привет привет привет"
            --subGameText.text = "привет привет привет привет привет привет"
            system.vibrate()
        end
    end
    return true
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

    titlesOnly = composer.getVariable( "titlesOnly" )
    celebritiesRU = composer.getVariable( "cat1" )
    celebritiesIN = composer.getVariable( "cat2" )
    cinemaHeroes = composer.getVariable( "cat3" )
    cartoonHeroes = composer.getVariable( "cat4" )
    bookHeroes = composer.getVariable( "cat5" )
    cinema = composer.getVariable( "cat6" )
    cartoons = composer.getVariable( "cat7" )
    books = composer.getVariable( "cat8" )


    if titlesOnly == false then
        if celebritiesRU == true then
            print("люди ру")
            tempDB = require("celebritiesRU")
            for i=1, #tempDB do
                table.insert( totalDB, {tempDB[i], ""} )
                table.insert( serviceDB, tempDB[i])
            end
        end
        if celebritiesIN == true then
            print("люди ен")
            tempDB = require("celebritiesIN")
            for i=1, #tempDB do
                if table.indexOf( serviceDB, tempDB[i] ) == nil then
                    table.insert( totalDB, {tempDB[i], ""} )
                    table.insert( serviceDB, tempDB[i])
                else print "powtor" end
            end
        end
        if cinemaHeroes == true then
            print("киногерои")
            tempDB = require("cinemaHeroes")
            for i=1, #tempDB do
                if table.indexOf( serviceDB, tempDB[i][1]..tempDB[i][2] ) == nil then
                    table.insert( totalDB, {tempDB[i][1], tempDB[i][2]} )
                    table.insert( serviceDB, tempDB[i][1]..tempDB[i][2])
                else
                    --print "powtor"
                end
            end
        end
        if cartoonHeroes == true then
            print("мультгерои")
            tempDB = require("cartoonHeroes")
            for i=1, #tempDB do
                if table.indexOf( serviceDB, tempDB[i][1]..tempDB[i][2] ) == nil then
                    table.insert( totalDB, {tempDB[i][1], tempDB[i][2]} )
                    table.insert( serviceDB, tempDB[i][1]..tempDB[i][2])
                else
                    --print "powtor"
                end
            end
        end
        if bookHeroes == true then
            print("книжные герои")
            tempDB = require("bookHeroes")
            for i=1, #tempDB do
                if table.indexOf( serviceDB, tempDB[i][1]..tempDB[i][2] ) == nil then
                    table.insert( totalDB, {tempDB[i][1], tempDB[i][2]} )
                    table.insert( serviceDB, tempDB[i][1]..tempDB[i][2])
                else
                    --print "powtor"
                end
            end
        end
    else --(titlesOnly == true)
        if cinema == true then
            print("кино")
            tempDB = require("cinema")
            for i=1, #tempDB do
                table.insert( totalDB, {tempDB[i], ""})
                table.insert( serviceDB, tempDB[i])
            end
        end
        if cartoons == true then
            print("мульты")
            tempDB = require("cartoons")
            for i=1, #tempDB do
                if table.indexOf( serviceDB, tempDB[i] ) == nil then
                    table.insert( totalDB, {tempDB[i], ""} )
                    table.insert( serviceDB, tempDB[i])
                else print "powtor" end
            end
        end
        if books == true then
            print("книги")
            tempDB = require("books")
            for i=1, #tempDB do
                if table.indexOf( serviceDB, tempDB[i] ) == nil then
                    table.insert( totalDB, {tempDB[i], ""} )
                    table.insert( serviceDB, tempDB[i])
                else print "powtor" end
            end
        end

    end

    print(#totalDB)

      -- Add the key event listener
    Runtime:addEventListener( "key", onKeyEvent )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
    local gamebgcolor = {244/255, 244/255, 244/255}
    local gametextcolor = {55/255, 0/255, 179/255}
    local subgametextcolor = {98/255, 0/255, 237/255}
    local font = "karton.ttf"

    display.setDefault( "background", unpack( gamebgcolor ) )

    local options =
    {
        text = "встряхни телефон,\nчтобы начать игру",
        x = display.contentWidth/2,
        y = display.contentCenterY,
        width = 920,
        font = font,
        fontSize = 64,
        align = "center"  -- Alignment parameter
    }

    gameText = display.newText( options )
    gameText:setFillColor( unpack(gametextcolor) )
    gameText.rotation = 90
    sceneGroup:insert(gameText)

    local subOptions =
    {
        text = "",
        x = display.contentWidth/5,
        y = display.contentCenterY,
        width = 920,
        font = font,
        fontSize = 44,
        align = "center"  -- Alignment parameter
    }

    subGameText = display.newText( subOptions )
    subGameText:setFillColor( unpack(subgametextcolor) )
    subGameText.rotation = 90
    sceneGroup:insert(subGameText)

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
