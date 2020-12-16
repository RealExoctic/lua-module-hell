local Module = {}
local TweenService = game:GetService("TweenService")

local Lighting = game.Lighting

function Module.OnTouch()
    TweenService:Create(Lighting,TweenInfo.new(1),{Ambient = Color3.fromRGB(0,0,0)}):Play()
    TweenService:Create(Lighting,TweenInfo.new(1),{ClockTime = 0}):Play()
    TweenService:Create(Lighting,TweenInfo.new(1),{OutdoorAmbient = Color3.fromRGB(0,0,0)}):Play()
end




return Module 