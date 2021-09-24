-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
require("view1")
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--배경 그림--
	local backgroundUp = display.newImageRect("image/green_background.png", 720, 500)
	backgroundUp.x, backgroundUp.y = display.contentWidth*0.5, display.contentHeight*0.8
	local backgroundDown = display.newImageRect("image/blue_background.png", 720, 810)
	backgroundDown.x, backgroundDown.y = display.contentWidth*0.5, display.contentHeight*0.28
	
	--시간 기록 받아서 출력--
	local timeRecord = composer.getVariable("time")
	local showTimeRecord = display.newText("시간 기록: " .. timeRecord, display.contentCenterX*1.02, display.contentCenterY*0.7)
	showTimeRecord:setFillColor(0, 0, 0)
	showTimeRecord.size = 50

	--End 글자--
	local ending = display.newText("End", display.contentCenterX, display.contentCenterY)
	ending.size = 150
	ending:setTextColor(0, 0, 0)

	--다시 시작--
	local replay = display.newText("↺replay", display.contentCenterX*1.3, display.contentCenterY*1.2)
	replay.size = 40
	replay:setTextColor(0, 0, 0)

	local function reload(event)
		if(event.phase == "began") then
			sceneGroup:insert(backgroundUp)
			sceneGroup:insert(backgroundDown)
			sceneGroup:insert(showTimeRecord)
			sceneGroup:insert(ending)
			sceneGroup:insert(replay)
			composer.removeScene("view2")
			composer.removeScene("view1")
			composer.gotoScene("view1")
		end
	end
	replay:addEventListener("touch", reload)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
