local Module = {}

function Module:ViewportPointToWorldCoordinates(x, y)
	
	local ray = workspace.CurrentCamera:ViewportPointToRay(x, y)
	local partHit, endPosition = workspace:FindPartOnRay(Ray.new(ray.Origin, ray.Direction*5000))
	
	return partHit, endPosition
	
end

return Module