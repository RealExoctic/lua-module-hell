local Shared = game:GetService("ReplicatedStorage").Shared
local ContextActionService = game:GetService("ContextActionService")

for _,v in pairs(Shared.GlobalModules.Input:GetDescendants()) do
	if v:IsA("ModuleScript") and not v.Disabled.Value then
		print(v.Name)
		local Clone = require(v:Clone())
		
		ContextActionService:BindAction(v.Name,Clone.Input,Clone.MobileButtonEnabled,Clone.Key)
	end
	if v:IsA("ModuleScript") then 
		v.Disabled.Changed:Connect(function()
			if not v.Disabled.Value then
				local Clone = require(v)
				
				ContextActionService:BindAction(v.Name,Clone.Input,Clone.MobileButtonEnabled,Clone.Key)
			end
		end)
	end
end