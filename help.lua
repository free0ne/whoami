local composer = require( "composer" )

local scene = composer.newScene()
local widget = require( "widget" )


local updatesImg
local dankeImg
local updatesTitle
local updatesText
local dankeText
local commentImg
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function chooseUpdates( event )
    updatesImg.alpha = 1
    dankeImg.alpha = 0.3
	updatesTitle.isVisible = true
	updatesText.isVisible = true
	dankeText.isVisible = false
	commentImg.isVisible = false
end

local function chooseDanke( event )
    dankeImg.alpha = 1
    updatesImg.alpha = 0.3
	updatesTitle.isVisible = false
	updatesText.isVisible = false
	dankeText.isVisible = true
	commentImg.isVisible = true
end
-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
    local window = display.newRect( sceneGroup, display.contentCenterX,  display.contentCenterY,
    display.contentWidth, display.contentHeight+100 )
    --window:setFillColor(0.15, 0.8)
	window:setFillColor(1)
	local font = "karton.ttf"

	updatesImg = display.newImage( sceneGroup, "update.png", display.contentWidth*0.3, display.contentHeight*0.1 )
	updatesImg:setFillColor(88/255, 2/255, 109/255)
    updatesImg:addEventListener( "tap", chooseUpdates )

	dankeImg = display.newImage( sceneGroup, "emoticon.png", display.contentWidth*0.7, display.contentHeight*0.1 )
	dankeImg:setFillColor(88/255, 2/255, 109/255)
    dankeImg.alpha = 0.3
    dankeImg:addEventListener( "tap", chooseDanke )

	updatesTitle = display.newText( sceneGroup, "Changelog", display.contentCenterX, display.contentHeight*0.19, font, 36 )
	updatesTitle:setFillColor( 0, 0, 0 )

	local footageText = display.newText( sceneGroup, "Обо всех недочётах и пожеланиях\nсообщайте, пожалуйста,\nразработчику через комментарии.\n\nПриятной игры!", display.contentWidth*0.57, display.contentHeight - 100, native.systemFont, 22 )
	footageText:setFillColor( 0, 0, 0 )

    --display.newRoundedRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth*0.87,  display.contentHeight*0.7, 10 ):setFillColor(0.95)
    local options =
    {
        text = [[Угадай, кто? - версия 1.0.4

- Переработан дизайн
- Приложение оптимизировано
для вытянутых телефонов
- Явно разделены категории
- Готовится к выходу новая категория

1.0.3

- Исправлен баг

1.0.2

- Расширена база данных
- Отдельные режимы для персонажей и их источников]],
        x = display.contentWidth/2,
        y = display.contentHeight*0.46,
        width = 420,
        --font = font,
        fontSize = 22,
        align = "left"  -- Alignment parameter
    }

    updatesText = display.newText( options )
    updatesText:setFillColor( 0 )
    sceneGroup:insert(updatesText)


	dankeText = display.newText( sceneGroup, "Вы можете поддержать\nразработчика,\nоставив отзыв на странице\nприложения в Google Play.", display.contentWidth*0.5, display.contentHeight*0.39, font, 32 )
	dankeText:setFillColor( 0.2 )
	dankeText.isVisible = false

	commentImg = display.newImage( sceneGroup, "comment.png", display.contentWidth*0.5, display.contentHeight*0.54 )
	commentImg:setFillColor(88/255, 2/255, 109/255)
	--commentImg:scale(0.85, 0.85)
	commentImg.isVisible = false


	local footageText = display.newText( sceneGroup, "Обо всех недочётах и пожеланиях\nсообщайте, пожалуйста,\nразработчику через комментарии.\n\nПриятной игры!", display.contentWidth*0.57, display.contentHeight - 100, native.systemFont, 22 )
	footageText:setFillColor( 0.2 )

	local backImg = display.newImage( sceneGroup, "cancel.png", 60, display.contentHeight - 65 )
	backImg:setFillColor(88/255, 2/255, 109/255)
	backImg:scale(0.85, 0.85)
    backImg:addEventListener( "tap", function() composer.hideOverlay( "fade", 400 ) end)

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
		--composer.removeScene( "help" )
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
