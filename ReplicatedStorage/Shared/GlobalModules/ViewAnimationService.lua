local module = {}

--[[ The name of this file is self-explanatory, it changes the animations of the viewmodels to the ones the
player has choosen.

This was written in order to make stuff more modular.

]]


function module:ViewModelAnimation(ViewModel,Anim,Id)
	assert(typeof(Id) == "number" , "Animation Id argument must be a number")
	
	if Anim == nil then 
		Anim = Instance.new("Animation")
	end
	
	Anim.AnimationId = "rbxassetid://"..Id
	Anim = ViewModel.Humanoid:LoadAnimation(Anim)
	Anim:Play()
end

function module:PlayAnimation(Model,Id)
	assert(typeof(Id) == "number" , "Animation Id argument must be a number")
end





return module
