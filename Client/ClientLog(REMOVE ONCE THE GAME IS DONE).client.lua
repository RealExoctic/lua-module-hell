for _,v in pairs(script.Parent:GetDescendants()) do 
    if v:IsA("LocalScript") or v:IsA("ModuleScript")  and v.Name ~= script.Name then
        print("Client >> ".. v.Name)
    end
    if v:IsA("BoolValue") then 
        v.Changed:Connect(function(newValue)
            print(not newValue) 
            print(v.Name.. " value's has changed! Old Value: ", not newValue, " New value:", newValue)
        end)
    end  
end 

