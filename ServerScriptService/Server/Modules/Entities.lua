local module = {}

local Shared = game.ReplicatedStorage.Shared
	
local EntityClasses = Shared.GlobalModules.Entities
local GetWorkspaceDescendants = workspace:GetDescendants()

function module:InitlizeEntities()
	for _,entityclass in pairs(EntityClasses:GetDescendants()) do
		--// Require the entity classes
		entityclass = require(entityclass)
		
		for _,entity in pairs(GetWorkspaceDescendants) do
			if not entity:IsA("Model") then
				local FindEntityBillboard = entity:FindFirstChild("EntityGui") --// Find the EntityGui
				
				if FindEntityBillboard then
					FindEntityBillboard.Enabled = false --// Disable it 
				end
				
				if EntityClasses:FindFirstChild(entity.Name) and entity.Name:find(entityclass.Name) then
					print(EntityClasses[entity.Name].Name..entity.Name)
					entity.Anchored = true --// Set it to anchored
					entity.CanCollide = false --// Set the part's collisions to nil
					 
					
					entityclass:Create(entity) --// Force the module to create something for that part.
					if FindEntityBillboard then --// If it finds the EntityGui 
						FindEntityBillboard.Enabled = false  --// Make it invisible 
						FindEntityBillboard = nil --// Set it's variable to nil
					end
					
					for _,value in pairs(entity:GetChildren())  do --// Updater
						if value:IsA("NumberValue") or value:IsA("ObjectValue") or value:IsA("BoolValue") or value:IsA("CFrameValue") or value:IsA("StringValue") then  --// Oh god
							value.Changed:Connect(function() --// Listen to changes in the values
								entityclass:Update(value,entity) --// Force the module to update the part 
							end)
						end
					end
				end
			end
		end
	end
end


return module
