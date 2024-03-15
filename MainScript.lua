function getgitHubRequest(url)
	return game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/"..url, true)
end
local isfile = isfile or function(path)
	local suc,res = pcall(function() return readfile(path) end)
end
if not isfolder("RenderRed") then
	makefolder("RenderRed")
end
local GuiLibrary = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
shared.Fluent = GuiLibrary

local win = GuiLibrary:CreateWindow({
    Title = "Render Red Installer",
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.RightControl
})
shared.Window = win

local Tabs = {
	Main = win:AddTab({ 
		Title = "Main", 
		Icon = "" 
	}),
    Settings = win:AddTab({ 
		Title = "Settings", 
		Icon = "settings" 
	})
}
shared.Tab = Tabs

--[[local RenderStore = {
	["Service"] = {
		["PlayerService"] = game:GetService("Players"),
		["replicatedStorageService"] = game:GetService("ReplicatedStorage"),
		["TweenService"] = game:GetService("TweenService"),
		["InputService"] = game:GetService("UserInputService"),
	},
	["Game"] = {
		["PlaceId"] = game.PlaceId,
		["JobId"] = game.JobId,
		["GameId"] = game.GameId,
	},
	["InGame"] = {
		["LocalPlayer"] = game:GetService("Players").LocalPlayer,
		["Character"] = game:GetService("Players").LocalPlayer.Character,
		["Health"] = game:GetService("Players").LocalPlayer.Character.Humanoid.Health,
		["RootPart"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
	},
}
shared.RenderRedStore = RenderStore]]

task.spawn(function()
	shared.MainScriptLoaded = true
	if not isfile("RenderRed/Installer.lua") then
		loadstring(getgitHubRequest("Installer.lua"))()
		writefile("RenderRed/Installer.lua", getgitHubRequest("Installer.lua"))
	else
		loadfile("RenderRed/Installer.lua")()
	end
end)