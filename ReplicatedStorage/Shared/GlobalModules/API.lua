local module = {}

local SoundService = game:GetService("SoundService")
local MarketPlaceService = game:GetService("MarketplaceService")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local CurrentCamera = workspace.CurrentCamera


module.TweenService = game:GetService("TweenService")
module.UserInputSService = game:GetService("UserInputService")

local CurrentlyPlayingAudios = {}
local SoundVolumes = {}

function module:lookAt(target, eye)
	local forwardVector = (target - eye).Unit
	local upVector = Vector3.new(0, 1, 0)
	-- Remember the right-hand rule
	local rightVector = forwardVector:Cross(upVector)
	local upVector2 = rightVector:Cross(forwardVector)
	
	return CFrame.fromMatrix(eye, rightVector, upVector2)
end

function module:CriticalError(message)
	assert(typeof(message) == "string", "Message argument must be a string!")
	
	warn("[!! CRITICAL FRAMEWORK ERROR !!] ".. message)
end

function module:AnchorPlayers(bool)
	for _,v in pairs(Players:GetPlayers()) do
		print(bool)
		v.Character.HumanoidRootPart.Anchored = bool
	end
end

function module:SendToMenu()
	local Player = Players.LocalPlayer --// CLIENT ONLY!
	local UI = Player:WaitForChild("PlayerGui"):WaitForChild("Main") --// client stuff, since sometimes even localscripts require the api loll
	
	
	Player.PlayerScripts.Client.Values.WeaponsDisabled.Value = true
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	CurrentCamera.FieldOfView = 25
	CurrentCamera.CFrame = workspace.World.Menu:WaitForChild("Camera").CFrame
	UI.HUD.Visible = false
	Player.PlayerScripts.Client.Values.HEV.Equipped.Value = false
	UI.Menu.Visible = true 
end

function module:DisableMouseIcon(bool)
    module.UserInputSService.MouseIconEnabled = bool 
end

function module:TeleportAllPlayersToPart(part)
	assert(part:IsA("Part") or part:IsA("UnionOperation") or part:IsA("MeshPart"), "Part argument must be either a Part, UnionOperation or a MeshPart")
	for _,player in pairs(Players:GetPlayers()) do
		local Character = player.Character or player.CharacterAdded:Wait()
		Character.HumanoidRootPart.CFrame = part.CFrame
	end
end

function module:CheckForTriggers(map)
	for _,v in pairs(map:GetDescendants()) do
		if v:IsA("Part") then
			for _,v in pairs(v:GetChildren()) do
				if v:IsA("Texture") and v.Texture == "rbxgameasset://Images/aaatrigger" then
					v:Destroy()
				end
			end
		end
	end
end

function module:DisplayMessage(text,time)
	local Player = Players.LocalPlayer --// CLIENT ONLY!
	local UI = Player:WaitForChild("PlayerGui"):WaitForChild("Main") --// client stuff, since sometimes even localscripts require the api loll
	
	
	assert(typeof(text) == "string", "The text argument must be a string")
	
	UI.Message.String.Text = text
	TweenService:Create(UI.Message,TweenInfo.new(.5),{BackgroundTransparency = 0}):Play()
	TweenService:Create(UI.Message.String,TweenInfo.new(.5),{TextStrokeTransparency = 0.5}):Play()
	TweenService:Create(UI.Message.String,TweenInfo.new(.5),{TextTransparency = 0}):Play()
	
	wait(time)
	UI.Message.String.Text = text
	TweenService:Create(UI.Message,TweenInfo.new(.5),{BackgroundTransparency = 1}):Play()
	TweenService:Create(UI.Message.String,TweenInfo.new(.5),{TextStrokeTransparency = 1}):Play()
	TweenService:Create(UI.Message.String,TweenInfo.new(.5),{TextTransparency = 1}):Play()
end

function module:TeleportPlayerToPlace(player,placeId)
	assert(player:IsA("Player"),"Player argument must be a player!")
	assert(typeof(placeId) == "number", "placeId argument must be a number!")
	print("All checks have passed, attempting teleport to ".. placeId)
	
	TeleportService:Teleport(placeId,player)
	
	TeleportService.TeleportInitFailed:Connect(function(player,result,message)
		module:CriticalError("Failed to teleport ".. player.Name .."! The error message is: ".. message)
	end)
end



function module:CheckForSpawn(map)
	for _,v in pairs(map:GetDescendants()) do
		if v.Name == "Info_Player_start" and v:IsA("Model") then
			module:TeleportAllPlayersToPart(v.LogicPart)
			v:Destroy()
		end
	end
end

function module:PauseEveryAudio(location)
	for _,v in pairs(location:GetDescendants()) do 
		if v ~= nil and v:IsA("Sound") and v.IsPlaying then
			table.insert(SoundVolumes,v.Name..v.Volume)
			v.Volume = 0
			v:Pause()
			v.Playing = false 
		end
	end
end

function module:ResumeEveryAudio(location)
	for _,v in pairs(location:GetDescendants()) do 
		if v ~= nil and v:IsA("Sound") and not v.Parent.Name == "HumanoidRootPart" and not v.Playing then
			if table.find(SoundVolumes..v.Name) then 
				v.Volume = 1
				v:Resume()
			end
			v.Playing = true
			v:Resume()
		end
	end
end


function CheckId(id)
	local productInfo = MarketPlaceService:GetProductInfo(id)

	if productInfo.AssetTypeId == 3 then
		return productInfo
	elseif productInfo.AssetType ~= 3 then
		warn("ERROR: Given id is not an audio id, using placeholder id. Asset type: ".. productInfo.AssetTypeId)
		productInfo.AssetId = 5048077804
		return productInfo
	end

end

function module:TweenModel(model, CF,info)
	local CFrameValue = Instance.new("CFrameValue")
	CFrameValue.Value = model:GetPrimaryPartCFrame()

	CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
		model:SetPrimaryPartCFrame(CFrameValue.Value)
	end)

	local tween = module.TweenService:Create(CFrameValue, info, {Value = CF})
	tween:Play()

	return tween
end

function module:PlayAudio(id,loop,volume,parent)
	warn(":PlayAudio() has been deprecated and will be removed soon, use :PlaySound() instead")
	module:PlaySound(id,loop,volume,parent)
end

function module:PlayMusic(id,loop)
	assert(typeof(id) == "number","Audio Id argument must be a number")
	
	if not SoundService:FindFirstChild("Music") then
		local Sound = Instance.new("Sound",SoundService)
		
		Sound.SoundId = id 
		Sound.Looped = loop 
		Sound.Name = "Music"
	end
	
	SoundService.Music:Stop()
	SoundService.Music.SoundId = "rbxassetid://"..id
	SoundService.Music.Looped = loop 
	
	SoundService.Music:Play()
end



function module:PlaySound(id,loop,volume,parent)
	assert(typeof(id) == "number","Audio Id argument must be a number")
	assert(typeof(volume) == "number", "Volume argument must be a number")
	
	local result = CheckId(id)
	
	if SoundService:FindFirstChild(result.Name) then
		CollectionService:AddTag(SoundService[result.Name],"Sound")
		SoundService[result.Name]:Play()
	end

	local Sound = Instance.new("Sound")
	Sound.Looped = loop
	Sound.Volume = volume

	Sound.Name = result.Name
	table.insert(CurrentlyPlayingAudios,result.Name)

	if parent ~= nil then
		Sound.Parent = parent

		if result ~= nil then
			Sound.SoundId = "rbxassetid://"..result.AssetId
			CollectionService:AddTag(Sound,"Sound")
			Sound:Play()
		end
	elseif parent == nil then
		Sound.Parent = game.SoundService
		
		if result ~= nil then
			Sound.SoundId = "rbxassetid://"..result.AssetId
			CollectionService:AddTag(Sound,"Sound")
			Sound:Play()
		end
	end

	Sound.Ended:Connect(function()
		Sound:Destroy()
		CollectionService:RemoveTag(Sound,"Sound")
		Sound = nil
	end)
end

function module:Explode(Radius,Pressure,Part)
	assert(Part:IsA("Part") or Part:IsA("UnionOperation") or Part:IsA("MeshPart"),"Part argument must be a Part,UnionOperation or MeshPart")
	local Explosion = Instance.new("Explosion")

	Explosion.BlastRadius = Radius
	Explosion.BlastPressure = Pressure
	Explosion.ExplosionType = Enum.ExplosionType.NoCraters

	if Part:IsA("Model") then
		for _,v in pairs(Part:GetDescendants()) do
			if v:IsA("Model") then
				for _,v in pairs(v:GetDescendants()) do
					if v:IsA("Part") then
						v.Anchored = false
						Explosion.Parent = v
						Explosion.Position = v.Position
					end
				end
			elseif v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
				v.Anchored = false
				Explosion.Parent = v
				Explosion.Position = v.Position
			end
		end
	else
		Part.Anchored = false
		Explosion.Parent = Part
		Explosion.Position = Part.Position
	end
end

function module:StopSounds()
	local Sounds = CollectionService:GetTagged("Sound")
	
	for _,sound in pairs(Sounds) do
		if not sound.Paused then 
			print("Pausing..")
			sound:Pause()
		end
	end
end

function module:ResumeSounds()
	local Sounds = CollectionService:GetTagged("Sound")
	
	for _,sound in pairs(Sounds) do
		if sound.Paused then
			print("Resuming..")
			sound:Resume()
		end
	end
end

	


return module
