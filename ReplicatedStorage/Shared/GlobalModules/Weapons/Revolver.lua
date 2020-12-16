local Weapon = {}

local CurrentCamera = workspace.CurrentCamera
local ReplicatedStorage = game.ReplicatedStorage

function Weapon:Hit(Mouse,Weapon)
	ReplicatedStorage.Shared.Events.WeaponRayDamage:FireServer(workspace.CurrentCamera.CFrame.Position,Mouse.Hit.Position,Weapon)
end





return Weapon