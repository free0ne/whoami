local composer = require( "composer" )

local scene = composer.newScene()
local widget = require( "widget" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
    local window = display.newRect( sceneGroup, display.contentCenterX,  display.contentCenterY,
    display.contentWidth, display.contentHeight )
    window:setFillColor(0.15, 0.8)
    window:addEventListener( "tap", function() composer.hideOverlay( "fade", 400 ) end)

    display.newRoundedRect( sceneGroup, display.contentCenterX, 480, 460, 670, 10 ):setFillColor(0.95)
    local options =
    {
        text = [[Дополнительная информация

Угадай, кто? - версия 1.0.3

- Исправлен баг

1.0.2

- Расширена база данных
- Отдельные режимы для персонажей и их источников

Обо всех недочётах и пожеланиях сообщайте, пожалуйста, разработчику через комментарии.

Приятной игры!]],
        x = display.contentWidth/2,
        y = 380,
        width = 420,
        --font = font,
        fontSize = 22,
        align = "left"  -- Alignment parameter
    }

    local helpText = display.newText( options )
    helpText:setFillColor( 0 )
    sceneGroup:insert(helpText)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
        --composer.removeScene( "help" )
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
