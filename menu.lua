
local composer = require( "composer" )
local widget = require( "widget" )
local toast = require('plugin.toast')
local scene = composer.newScene()

local firstback = true

local bgcolor = {225/255, 226/255, 225/255}
local labeltextcolor = {1, 1, 1}
local labelrectcolor = {55/255, 0/255, 179/255}
local textcolor = {0, 0, 0}
local subTextcolor = {0.2, 0.2, 0.2}
local onColorButton = {2/255, 218/255, 197/255}
local offColorButton = {1, 1, 1, 1}
local startGameRectColor = {98/255, 0/255, 237/255}

local font = "geometos.ttf"
local rects = {}
local texts = {}
local subTexts = {}
local menuGroups = {}
local sum = 0

local titlesOnly = false
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

local function chooseCategory( event )
    event.target.state = not event.target.state
    if event.target.number == 6 then titlesOnly = false
    elseif event.target.number == 7 then titlesOnly = false
    elseif event.target.number == 8 then titlesOnly = false
    elseif event.target.number == 9 then titlesOnly = true
    elseif event.target.number == 10 then titlesOnly = false
    elseif event.target.number == 11 then titlesOnly = true
    elseif event.target.number == 12 then titlesOnly = false
    elseif event.target.number == 13 then titlesOnly = true end

    names = {6, 7, 8, 10, 12}
    titles = {9, 11, 13}
    if titlesOnly == true then
        for _, myName in ipairs(names) do
            rects[myName].state = false
            rects[myName]:setFillColor( unpack(offColorButton) )
            texts[myName]:setFillColor( unpack(textcolor) )
            subTexts[myName]:setFillColor( unpack(subTextcolor) )
        end
    else
        for _, myTitle in ipairs(titles) do
            rects[myTitle].state = false
            rects[myTitle]:setFillColor( unpack(offColorButton) )
            texts[myTitle]:setFillColor( unpack(textcolor) )
            subTexts[myTitle]:setFillColor( unpack(subTextcolor) )
        end
    end


    if (event.target.state == true) then
        event.target:setFillColor( unpack(onColorButton) )
        texts[event.target.number]:setFillColor( unpack(labeltextcolor) )
        subTexts[event.target.number]:setFillColor( unpack(labeltextcolor) )
    else
        event.target:setFillColor( unpack(offColorButton) )
        texts[event.target.number]:setFillColor( unpack(textcolor) )
        subTexts[event.target.number]:setFillColor( unpack(subTextcolor) )
    end

    if rects[6].state == false and rects[7].state == false then
        rects[1].state = false
        rects[1]:setFillColor( unpack(offColorButton) )
        texts[1]:setFillColor( unpack(textcolor) )
        subTexts[1]:setFillColor( unpack(subTextcolor) )
    else
        rects[1]:setFillColor( unpack(onColorButton) )
        texts[1]:setFillColor( unpack(labeltextcolor) )
        subTexts[1]:setFillColor( unpack(labeltextcolor) )
    end


    if rects[8].state == false and rects[9].state == false then
        rects[2].state = false
        rects[2]:setFillColor( unpack(offColorButton) )
        texts[2]:setFillColor( unpack(textcolor) )
        subTexts[2]:setFillColor( unpack(subTextcolor) )
    else
        rects[2]:setFillColor( unpack(onColorButton) )
        texts[2]:setFillColor( unpack(labeltextcolor) )
        subTexts[2]:setFillColor( unpack(labeltextcolor) )
    end

    if rects[10].state == false and rects[11].state == false then
        rects[3].state = false
        rects[3]:setFillColor( unpack(offColorButton) )
        texts[3]:setFillColor( unpack(textcolor) )
        subTexts[3]:setFillColor( unpack(subTextcolor) )
    else
        rects[3]:setFillColor( unpack(onColorButton) )
        texts[3]:setFillColor( unpack(labeltextcolor) )
        subTexts[3]:setFillColor( unpack(labeltextcolor) )
    end

    if rects[12].state == false and rects[13].state == false then
        rects[4].state = false
        rects[4]:setFillColor( unpack(offColorButton) )
        texts[4]:setFillColor( unpack(textcolor) )
        subTexts[4]:setFillColor( unpack(subTextcolor) )
    else
        rects[4]:setFillColor( unpack(onColorButton) )
        texts[4]:setFillColor( unpack(labeltextcolor) )
        subTexts[4]:setFillColor( unpack(labeltextcolor) )
    end
    --print(titlesOnly)
    --print(event.target.state)

end

local function goToGame( event )
    for i = 6,13 do
        if (rects[i].state == true) then
            sum = sum + 1
            composer.setVariable( "cat"..i, true )
        else
            composer.setVariable( "cat"..i, false )
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
    display.setStatusBar( display.HiddenStatusBar )
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    display.setDefault( "background", unpack( bgcolor ) )

    local labelRect = display.newRect( sceneGroup, display.contentCenterX, 65, display.contentWidth, 130 )
    labelRect:setFillColor( unpack (labelrectcolor) )
    local label = display.newText( sceneGroup, "GUESS WHO", display.contentCenterX, 65, font, 48 )
    label:setFillColor( unpack(labeltextcolor) )
    local bgRect = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth-100, 600 )
    bgRect:setFillColor( 1, 1 ,1 )

    for i = 1,5 do
        menuGroups[i] = display.newGroup()
        menuGroups[i].x = display.contentCenterX
        menuGroups[i].y = 120 + i*120

        rects[i] = display.newRect( menuGroups[i], 0, 0, display.contentWidth-100, 120 )
        rects[i]:setFillColor( unpack(offColorButton) )
        rects[i].state = false
        rects[i].number = i

        if (i == 1) then
            texts[i] = display.newText( menuGroups[i], "звёзды эфира", 0, -37, font, 26 )
            subTexts[i] = display.newText( menuGroups[i], "220+", 185, -37, font, 20 )
        elseif (i == 2) then
            texts[i] = display.newText( menuGroups[i], "кино и сериалы", 0, -37, font, 26 )
            subTexts[i] = display.newText( menuGroups[i], "160+", 185, -37, font, 20 )
        elseif (i == 3) then
            texts[i] = display.newText( menuGroups[i], "мультфильмы", 0, -37, font, 26 )
            subTexts[i] = display.newText( menuGroups[i], "370+", 185, -37, font, 20 )
        elseif (i == 4) then
            texts[i] = display.newText( menuGroups[i], "литература", 0, -37, font, 26 )
            subTexts[i] = display.newText( menuGroups[i], "100+", 185, -37, font, 20 )
        elseif (i == 5) then
            texts[i] = display.newText( menuGroups[i], "в разработке", 0, 0, font, 26 )
            subTexts[i] = display.newText( menuGroups[i], "(знаменитости)", 0, 32, font, 20 )
            rects[i]:removeEventListener( "tap", chooseCategory )
            rects[i]:setFillColor( 0.8 )
        end

        texts[i]:setFillColor( unpack(textcolor) )
        subTexts[i]:setFillColor( unpack(subTextcolor) )
        sceneGroup:insert(menuGroups[i])
    end

    rects[6] = display.newRect( menuGroups[1], -110, 20, display.contentWidth/2-50, 80 )
    rects[6]:setFillColor( unpack(offColorButton) )
    rects[6].state = false
    rects[6].number = 6
    rects[6]:addEventListener( "tap", chooseCategory )
    texts[6] = display.newText( menuGroups[1], "русские", -107, 24, font, 26 )
    texts[6]:setFillColor( unpack(textcolor) )
    subTexts[6] = display.newText( menuGroups[1], "", 0, 32, font, 20 )
    rects[7] = display.newRect( menuGroups[1], 110, 20, display.contentWidth/2-50, 80 )
    rects[7]:setFillColor( unpack(offColorButton) )
    rects[7].state = false
    rects[7].number = 7
    rects[7]:addEventListener( "tap", chooseCategory )
    texts[7] = display.newText( menuGroups[1], "зарубежные", 107, 24, font, 26 )
    texts[7]:setFillColor( unpack(textcolor) )
    subTexts[7] = display.newText( menuGroups[1], "", 0, 32, font, 20 )

    rects[8] = display.newRect( menuGroups[2], -110, 20, display.contentWidth/2-50, 80 )
    rects[8]:setFillColor( unpack(offColorButton) )
    rects[8].state = false
    rects[8].number = 8
    rects[8]:addEventListener( "tap", chooseCategory )
    texts[8] = display.newText( menuGroups[2], "персонажи", -107, 24, font, 26 )
    texts[8]:setFillColor( unpack(textcolor) )
    subTexts[8] = display.newText( menuGroups[2], "", 0, 32, font, 20 )
    rects[9] = display.newRect( menuGroups[2], 110, 20, display.contentWidth/2-50, 80 )
    rects[9]:setFillColor( unpack(offColorButton) )
    rects[9].state = false
    rects[9].number = 9
    rects[9]:addEventListener( "tap", chooseCategory )
    texts[9] = display.newText( menuGroups[2], "ленты", 107, 24, font, 26 )
    texts[9]:setFillColor( unpack(textcolor) )
    subTexts[9] = display.newText( menuGroups[2], "", 0, 32, font, 20 )

    rects[10] = display.newRect( menuGroups[3], -110, 20, display.contentWidth/2-50, 80 )
    rects[10]:setFillColor( unpack(offColorButton) )
    rects[10].state = false
    rects[10].number = 10
    rects[10]:addEventListener( "tap", chooseCategory )
    texts[10] = display.newText( menuGroups[3], "персонажи", -107, 24, font, 26 )
    texts[10]:setFillColor( unpack(textcolor) )
    subTexts[10] = display.newText( menuGroups[3], "", 0, 32, font, 20 )
    rects[11] = display.newRect( menuGroups[3], 110, 20, display.contentWidth/2-50, 80 )
    rects[11]:setFillColor( unpack(offColorButton) )
    rects[11].state = false
    rects[11].number = 11
    rects[11]:addEventListener( "tap", chooseCategory )
    texts[11] = display.newText( menuGroups[3], "ленты", 107, 24, font, 26 )
    texts[11]:setFillColor( unpack(textcolor) )
    subTexts[11] = display.newText( menuGroups[3], "", 0, 32, font, 20 )

    rects[12] = display.newRect( menuGroups[4], -110, 20, display.contentWidth/2-50, 80 )
    rects[12]:setFillColor( unpack(offColorButton) )
    rects[12].state = false
    rects[12].number = 12
    rects[12]:addEventListener( "tap", chooseCategory )
    texts[12] = display.newText( menuGroups[4], "герои", -107, 24, font, 26 )
    texts[12]:setFillColor( unpack(textcolor) )
    subTexts[12] = display.newText( menuGroups[4], "", 0, 32, font, 20 )
    rects[13] = display.newRect( menuGroups[4], 110, 20, display.contentWidth/2-50, 80 )
    rects[13]:setFillColor( unpack(offColorButton) )
    rects[13].state = false
    rects[13].number = 13
    rects[13]:addEventListener( "tap", chooseCategory )
    texts[13] = display.newText( menuGroups[4], "книги", 107, 24, font, 26 )
    texts[13]:setFillColor( unpack(textcolor) )
    subTexts[13] = display.newText( menuGroups[4], "", 0, 32, font, 20 )



    local help = widget.newButton(
        {
            shape = "circle",
            radius = 33,
            label = "?",
            font = "lucky.otf",
            fontSize = 60,
            fillColor = { default={ 255/255, 255/255, 255/255 }, over={ 255/255, 255/255, 255/255 } },
            labelColor = { default={98/255, 0/255, 237/255}, over={98/255, 0/255, 237/255} },
            onPress = function(event)
                composer.showOverlay( "help" , {
                    isModal = true,
                    effect = "fade",
                    time = 400,
                } )
            end
        }
    )
    help.x = 500
    help.y = 65
    help:scale(0.7, 0.7)
    sceneGroup:insert(help)

    local startGameRect = display.newRect( sceneGroup, display.contentCenterX, display.contentHeight - 65, display.contentWidth, 130 )
    startGameRect:setFillColor( unpack (startGameRectColor) )
    startGameRect:addEventListener( "tap", goToGame )
    local startGameLabel = display.newText( sceneGroup, "начать", display.contentCenterX, display.contentHeight - 65, font, 40 )
    startGameLabel:setFillColor( unpack(labeltextcolor) )

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
