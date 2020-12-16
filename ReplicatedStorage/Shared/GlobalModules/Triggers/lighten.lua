local Module = {}
local TweenService = game:GetService("TweenService")

local Lighting = game.Lighting


function Module.OnTouch()
    TweenService:Create(Lighting,TweenInfo.new(1),{Ambient = Color3.fromRGB(138,138,138)}):Play()
    TweenService:Create(Lighting,TweenInfo.new(1),{ClockTime = 10}):Play()
    TweenService:Create(Lighting,TweenInfo.new(1),{OutdoorAmbient = Color3.fromRGB(128,128,128)}):Play()
end





return Module 