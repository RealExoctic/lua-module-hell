local PhysicsService = game:GetService("PhysicsService")

pcall(function()
	PhysicsService:CreateCollisionGroup("ViewModel")
	PhysicsService:CollisionGroupSetCollidable("ViewModel", "Default", false)
end)