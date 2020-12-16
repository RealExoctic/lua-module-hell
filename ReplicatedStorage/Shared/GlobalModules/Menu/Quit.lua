local Button = {}

local Players = game.Players
local Player = Players.LocalPlayer

local Window = require(script.Parent.Window)

function Button.Press()
	local function Button1CallBack()
		Player:Kick("\n What did you expect from the Quit button? \n Roblox does not allow us to close a user's window yet, \n and probably never will allow us to do that. \n You can press the leave button below this message, \n or quit the app in whichever way you prefer to. \n \n ~ Rexon Studios")
	end
	Window.OpenWindow("Quit","Do you wish to stop playing now?","Quit game","Cancel",Button1CallBack)
end

return Button