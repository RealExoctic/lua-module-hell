local module = {}

module.Name = "ambient_generic"
module.SimpleName = "Ambient Generic"

function module:Create(location)
	assert(location ~= nil,"Location argument shouldn't be nil")
	local Sound = location:FindFirstChildOfClass("Sound")
	
	if not Sound then
		Sound = Instance.new("Sound",location)
		
		for _,property in pairs(location:GetChildren()) do
			if string.find(property.ClassName,"Value") then 
				Sound[property.Name] = property.Value
			end
		end
	end
end

function module:Update(property,location)
	local Sound = location:FindFirstChildOfClass("Sound")
	
	if Sound then 
		Sound[property.Name] = property.Value
	end
end

return module
