local module = {}

local Players = game.Players
local Player = Players.LocalPlayer

local UI = Player:WaitForChild("PlayerGui").Main

function Button2Callback(Clone)
	Clone:Destroy()
	Clone = nil
end




function module.OpenWindow(title,content,button1,button2,button1CallBack)
	
	if not UI:FindFirstChild(title) then 
		local windowClone = UI.Window:Clone()
		windowClone.Parent = UI
		
		windowClone.Title.Text = title 
		windowClone.Content.Text = content 
		windowClone.Button1.Text = button1 
		windowClone.Button2.Text = button2
		windowClone.Name = title
		
		windowClone.Visible = true
		
		
		windowClone.Button1.MouseButton1Down:Connect(button1CallBack)
		windowClone.Button2.MouseButton1Down:Connect(function()
			Button2Callback(windowClone)
			windowClone:Destroy()
			windowClone = nil
		end)
	end
end


return module
