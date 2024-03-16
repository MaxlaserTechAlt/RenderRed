function getgitHubRequest(url)
	return game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/"..url, true)
end
function updateFile(file)
	delfile("RenderRed/"..file)
	writefile("RenderRed/"..file, getgitHubRequest(file))
end
local isfile = isfile or function(path)
	local suc,res = pcall(function() return readfile(path) end)
end
if not isfolder("RenderRed") then
	makefolder("RenderRed")
end
local RendersStore = loadstring(getgitHubRequest("Core/System.lua", true))()
shared.RenderStore = RendersStore
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
task.spawn(function()
	shared.MainScriptLoaded = true
	if not isfile("RenderRed/Installer.lua") then
		loadstring(getgitHubRequest("Installer.lua"))()
		writefile("RenderRed/Installer.lua", getgitHubRequest("Installer.lua"))
	else
		loadfile("RenderRed/Installer.lua")()
		repeat task.wait(0.3) until shared.InstallerLoaded
		if not shared.upd1 then
			updateFile("Installer.lua")
			GuiLibrary:Notify({
				Title = "Render Red",
				Content = "Update Has Been Detected, Please ReExecute The Installer",
				Duration = 7
			})
		end
	end
end)
