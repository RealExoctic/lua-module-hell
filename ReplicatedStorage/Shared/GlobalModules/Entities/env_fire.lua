local module = {}

module.Name = "env_fire"
module.SimpleName = "Fire"

function module:Create(location)
	assert(location ~= nil,"Location argument shouldn't be nil")
	local Fire = location:FindFirstChildOfClass("Fire")
	
	
	if not Fire then 
		Fire = Instance.new("Fire",location)
			
		for _,property in pairs(location:GetChildren()) do
			if string.find(property.ClassName,"Value") then 
				Fire[property.Name] = property.Value
			end
		end
	end
end

function module:Update(property,location)
	local Fire = location:FindFirstChildOfClass("Fire")
	
	if Fire then 
		Fire[property.Name] = property.Value
	end
end

return module
