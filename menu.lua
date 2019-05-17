
local composer = require( "composer" )
local widget = require( "widget" )
local toast = require('plugin.toast')
local scene = composer.newScene()

local firstback = true

--local bgcolor = {225/255, 226/255, 225/255}
local bgcolor = {255/255, 255/255, 255/255}
local labeltextcolor = {1, 1, 1}
--local labelrectcolor = {55/255, 0/255, 179/255}
local labelrectcolor = {88/255, 2/255, 109/255}
local textcolor = {0, 0, 0}
local subTextcolor = {0.2, 0.2, 0.2}
local onColorButton = {2/255, 218/255, 197/255}
local offColorButton = {1, 1, 1, 1}
local redColor = {135/255, 0, 71/255}
local blueColor = {55/255, 5/255, 113/255}
local startGameRectColor = {98/255, 0/255, 237/255}

--local font = "geometos.ttf"
local font = "karton.ttf"
local rects = {}
local texts = {}
local subTexts = {}
local menuGroups = {}
local sum = 0

local titlesOnly = false

local manImg
local filmImg
local manRects = {}
local manTexts = {}
local filmRects = {}
local filmTexts = {}
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

local function openSettings( event )
        composer.showOverlay( "help" , {
            isModal = true,
            effect = "fade",
            time = 400,
        } )
end

local function chooseMan( event )
    manImg.alpha = 1
    filmImg.alpha = 0.3
    for i = 1,6 do
        manTexts[i].isVisible = true
    end
    for i = 1,3 do
        filmRects[i].state = false
        filmRects[i].isVisible = false
        filmTexts[i].isVisible = false
    end
    titlesOnly = false
end

local function chooseFilm( event )
    filmImg.alpha = 1
    manImg.alpha = 0.3
    for i = 1,6 do
        manRects[i].state = false
        manRects[i].isVisible = false
        manTexts[i].isVisible = false
    end
    for i = 1,3 do
        filmTexts[i].isVisible = true
    end
    titlesOnly = true
end

local function choosePunkt( event )
    local type = event.target.type
    local i = event.target.id
    if type == "man" then
        if (manRects[i].state) then
            manRects[i].state = false
            manRects[i].isVisible = false
        else
            manRects[i].state = true
            manRects[i].isVisible = true
        end
    else
        if (filmRects[i].state) then
            filmRects[i].state = false
            filmRects[i].isVisible = false
        else
            filmRects[i].state = true
            filmRects[i].isVisible = true
        end
    end
end

local function goToGame( event )
    for i = 1,6 do
        if (manRects[i].state == true) then
            sum = sum + 1
            composer.setVariable( "cat"..i, true )
        else
            composer.setVariable( "cat"..i, false )
        end
    end
    for i = 1,3 do
        if (filmRects[i].state == true) then
            sum = sum + 1
            composer.setVariable( "cat"..6+i, true )
        else
            composer.setVariable( "cat"..6+i, false )
        end
    end
    if (sum == 0) then
        --print("sum = 0")
        toast.show('Сначала нужно выбрать категории!')
    else
        --print("sum = "..sum)
        composer.setVariable( "titlesOnly", titlesOnly )
        Runtime:removeEventListener( "key", onKeyEvent )
        composer.gotoScene( "game" )
    end
    sum = 0
end

-- Called when a key event has been received
local function onKeyEvent( event )
  -- If the "back" key was pressed on Android, prevent it from backing out of the app
  if (event.phase == "down" and event.keyName == "back" ) then
    if ( system.getInfo("platform") == "android" ) then
      if firstback == true then
        firstback = false
        timer.performWithDelay( 1500, backTimer )
        toast.show('Нажмите ещё раз, чтобы выйти')
        return true
      else
        os.exit()
        return true
      end

      return true
    end
  end
  -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
  -- This lets the operating system execute its default handling of the key
  return false
end
-- Add the key event listener
Runtime:addEventListener( "key", onKeyEvent )
-- create()
function scene:create( event )
    if display.contentHeight/display.contentWidth > 2 then display.setStatusBar( display.DefaultStatusBar )
    else display.setStatusBar( display.HiddenStatusBar ) end
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    display.setDefault( "background", unpack( bgcolor ) )

    local labelRect = display.newRect( sceneGroup, display.contentCenterX, display.contentHeight*0.057291, display.contentWidth, display.contentHeight*0.078125*2 )
    labelRect:setFillColor( unpack (labelrectcolor) )
    local label = display.newText( sceneGroup, "УГАДАЙ, КТО?", display.contentCenterX, display.contentHeight*0.0677, font, 72 )
    label:setFillColor( unpack(labeltextcolor) )

    manImg = display.newImage( sceneGroup, "man.png", display.contentCenterX - 90, display.contentHeight*0.27 )
    manImg:scale(0.18, 0.18)
    manImg:addEventListener( "tap", chooseMan )

    filmImg = display.newImage( sceneGroup, "film.png", display.contentCenterX + 90, display.contentHeight*0.27 )
    filmImg:scale(0.18, 0.18)
    filmImg.alpha = 0.3
    filmImg:addEventListener( "tap", chooseFilm )

    for i = 1,6 do
        manRects[i] = display.newRoundedRect( sceneGroup, display.contentCenterX, display.contentHeight/3.1 + i*display.contentHeight/12, 390, 60, 14 )
        manRects[i].strokeWidth = 2
        manRects[i]:setFillColor( 1 )
        manRects[i]:setStrokeColor( unpack(redColor) )
        manRects[i].state = false
        manRects[i].isVisible = false
        if (i == 1) then
            manTexts[i] = display.newText( sceneGroup, "исторические личности", display.contentCenterX, display.contentHeight/3.1 + i*display.contentHeight/12, font, 40 )
        elseif (i == 2) then
            manTexts[i] = display.newText( sceneGroup, "русские звёзды", display.contentCenterX, display.contentHeight/3.1 + i*display.contentHeight/12, font, 40 )
        elseif (i == 3) then
            manTexts[i] = display.newText( sceneGroup, "зарубежные звёзды", display.contentCenterX, display.contentHeight/3.1 + i*display.contentHeight/12, font, 40 )
        elseif (i == 4) then
            manTexts[i] = display.newText( sceneGroup, "киногерои", display.contentCenterX, display.contentHeight/3.1 + i*display.contentHeight/12, font, 40 )
        elseif (i == 5) then
            manTexts[i] = display.newText( sceneGroup, "мультгерои", display.contentCenterX, display.contentHeight/3.1 + i*display.contentHeight/12, font, 40 )
        elseif (i == 6) then
            manTexts[i] = display.newText( sceneGroup, "книжные персонажи", display.contentCenterX, display.contentHeight/3.1 + i*display.contentHeight/12, font, 40 )
        end
        manTexts[i]:setFillColor( unpack(redColor) )
        manTexts[i].type = "man"
        manTexts[i].id = i
        manTexts[i]:addEventListener("tap", choosePunkt)
    end

    for i = 1,3 do
        filmRects[i] = display.newRoundedRect( sceneGroup, display.contentCenterX, display.contentHeight/12*(5 + i), 350, 60, 14 )
        filmRects[i].strokeWidth = 2
        filmRects[i]:setFillColor( 1 )
        filmRects[i]:setStrokeColor( unpack(blueColor) )
        filmRects[i].state = false
        filmRects[i].isVisible = false
        if (i == 1) then
            filmTexts[i] = display.newText( sceneGroup, "кино и сериалы", display.contentCenterX, display.contentHeight/12*(5 + i), font, 40 )
        elseif (i == 2) then
            filmTexts[i] = display.newText( sceneGroup, "мультфильмы", display.contentCenterX, display.contentHeight/12*(5 + i), font, 40 )
        elseif (i == 3) then
            filmTexts[i] = display.newText( sceneGroup, "книги", display.contentCenterX, display.contentHeight/12*(5 + i), font, 40 )
        end
        filmTexts[i]:setFillColor( unpack(blueColor) )
        filmTexts[i].type = "film"
        filmTexts[i].id = i
        filmTexts[i].isVisible = false
        filmTexts[i]:addEventListener("tap", choosePunkt)
    end


    local startGameRect = display.newRect( sceneGroup, display.contentWidth*0.7, display.contentHeight - 65, display.contentWidth*0.6, 130 )
    startGameRect:setFillColor( unpack (bgcolor) )
    startGameRect:addEventListener( "tap", goToGame )
    local startGameLabel = display.newText( sceneGroup, "начать", display.contentWidth*0.7, display.contentHeight - 65, font, 78 )
    startGameLabel:setFillColor( unpack(labelrectcolor) )

    local helpImg = display.newImage( sceneGroup, "setting.png", 60, display.contentHeight - 65 )
    helpImg:setFillColor(unpack(labelrectcolor))
    helpImg:scale(0.7, 0.7)
    helpImg:addEventListener( "tap", openSettings )

    --abc = {{"1", ""}, {"2", "20"}}
    --x = indexOf(abc, {"1", ""})
    --if x == nil then
    --    print("NIL")
    --else print(x) end
  --[[local o = system.orientation
  local orient = display.newText( sceneGroup, o, display.contentCenterX, 200, native.systemFont, 46 )
  orient:setFillColor( unpack(textcolor) )

  local function onOrientationChange(e)
    orient.text = e.type
  end
  Runtime:addEventListener("orientation", onOrientationChange)   ]]--

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
    composer.removeScene( "menu" )
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
