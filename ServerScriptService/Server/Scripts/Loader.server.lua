local ModulesToLoad = {
	"LoadCharacter",
	"Stats"
}

for _,module in pairs(script.Parent.Parent.Modules:GetDescendants()) do
	if module:IsA("ModuleScript") and table.find(ModulesToLoad,module.Name) then 
		require(module)
	end
end