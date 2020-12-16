local Button = {}

function Button.OnPress()
	if not workspace.testLight.SpotLight.Enabled then 
		workspace.testLight.SpotLight.Enabled = true 
	else
		workspace.testLight.SpotLight.Enabled = false
	end
end


return Button