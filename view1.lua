-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--물리 함수 시작--
	local physics = require "physics"
	physics.start()

	physics.setGravity(0, 1)

	--배경 그림--
	local backgroundUp = display.newImageRect("image/green_background.png", 720, 500)
	backgroundUp.x, backgroundUp.y = display.contentWidth*0.5, display.contentHeight*0.8
	local backgroundDown = display.newImageRect("image/blue_background.png", 720, 810)
	backgroundDown.x, backgroundDown.y = display.contentWidth*0.5, display.contentHeight*0.28

	--플레이어 그림--
	local player = display.newImageRect("image/player.png", 70, 160)
	player.x, player.y = display.contentCenterX, display.contentCenterY*1.8
	physics.addBody(player, "static")

	--똥 그림--
	local poop = { }
	local poopGroup = display.newGroup()

	--떨어지는 똥 생성--
	for i = 0, 1000 do
		poop[i] = display.newImageRect(poopGroup, "image/poop.png", 60, 60)
		poop[i].x, poop[i].y = display.contentCenterX + math.random(-300, 300), 
		display.contentCenterY - 495 - i*250
		physics.addBody(poop[i], "dynamic")
	end

	--플레이어 키보드로 이동--
	local function keyPlayerMove(event)
		if(event.keyName == "right") then
			if(player.x < 646) then
				transition.moveBy(player, {x=30, y=0, time=70})
			else
				transition.moveBy(player, {x=0, y=0, time=70})
			end
		elseif(event.keyName == "left") then
			if(player.x > 29) then
				transition.moveBy(player, {x=-30, y=0, time=70})
			else
				transition.moveBy(player, {x=0, y=0, time=70})
			end
		end
	end
	Runtime:addEventListener("key", keyPlayerMove)	

	--시간 측정--
	time = 0
	local showTime = display.newText("시간: " .. time, display.contentCenterX*0.22, display.contentCenterY*0.1)
	showTime:setFillColor(0)
	showTime.size = 40

	local function timeRecord(event)
		time = time + 1
		showTime.text = "시간: " .. time
	end
	timer.performWithDelay(1000, timeRecord, 0, "record")

	--플레이어와 똥 충돌시 화면 전환--
	local function poopColliPlayer(self, event)
		if(event.phase == "ended") then
			physics.pause()
			Runtime:removeEventListener("key", keyPlayerMove)
			timer.pause("record")
			sceneGroup:insert(backgroundUp)
			sceneGroup:insert(backgroundDown)
			sceneGroup:insert(player)
			sceneGroup:insert(poopGroup)
			sceneGroup:insert(showTime)
			composer.setVariable("time", time)
			composer.gotoScene("view2")
		end
	end
	player.collision = poopColliPlayer
	player:addEventListener("collision")
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