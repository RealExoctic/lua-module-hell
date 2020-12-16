local module = {}

local SoundService = game:GetService("SoundService")
local MarketPlaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

module.TweenService = game:GetService("TweenService")
module.UserInputSService = game:GetService("UserInputService")

local CurrentlyPlayingAudios = {}

local SoundVolumes = {}

function module:AnchorPlayers(bool)
	for _,v in pairs(Players:GetPlayers()) do
		print(bool)
		v.Character.HumanoidRootPart.Anchored = bool
	end
end

function module:DisableMouseIcon(bool)
    module.UserInputSService.MouseIconEnabled = bool 
end

function module:TeleportAllPlayersToPart(part)
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
		end
	end
end

function module:ResumeEveryAudio(location)
	for _,v in pairs(location:GetDescendants()) do 
		if v ~= nil and v:IsA("Sound") and not v.Parent.Name == "HumanoidRootPart" and v.IsPaused then
			if table.find(SoundVolumes..v.Name) then 
				v.Volume = 1
			end
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

	local result = CheckId(id)
	
	if SoundService:FindFirstChild(result.Name) then 
		SoundService[result.Name]:Play()
		return "brrr"
	end

	local Sound = Instance.new("Sound")
	if (loop) then Sound.Looped = true end
	if (typeof(volume) == "number") then Sound.Volume = volume end

	Sound.Name = result.Name
	table.insert(CurrentlyPlayingAudios,result.Name)

	if parent ~= nil then
		Sound.Parent = parent

		if result ~= nil then
			Sound.SoundId = "rbxassetid://"..result.AssetId
			Sound:Play()
		end
	elseif parent == nil then
		Sound.Parent = game.SoundService

		if result ~= nil then
			Sound.SoundId = "rbxassetid://"..result.AssetId
			print("Awesome")
			Sound:Play()
		end
	end

	Sound.Ended:Connect(function()
		Sound:Destroy()
		Sound = nil
	end)
end

function module:Explode(Radius,Pressure,Part)
	local Explosion = Instance.new("Explosion")

	Explosion.BlastRadius = Radius
	Explosion.BlastPressure = Pressure
	Explosion.ExplosionType = Enum.ExplosionType.NoCraters


	if Part == nil then
		warn("Cannot create explosion on nothing.")
	end

	if Part ~= nil then
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
end

function module:StopAudio(AudioName)
	for _,v in pairs(game:GetDescendants()) do
        if v ~= nil and v:IsA("Sound") and v.Name == AudioName then
            v:Stop()
        end
    end
end


	


return module
