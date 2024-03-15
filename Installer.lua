local GuiLibrary = shared.Fluent
local win = shared.Window
local Tabs = shared.Tab
local RenderStore = shared.RenderStore

local TweenService = game:GetService("TweenService")
local plrService = game:GetService("Players")
local InputService = game:GetService("UserInputService")
local lplr = game.Players.LocalPlayer
local replicatedStorageService = game:GetService("ReplicatedStorage")

local placeId = game.PlaceId
local jobId = game.JobId
local gameId = game.GameId

local createNotification = function() end
local getgitHubRequest = function() end
local runFunction = function(func) func() end
local newdialog = function() end
local isfile = isfile or function(path) local suc,res = pcall(function() return readfile(path) end) end

createNotification = function(topic, desc, duration)
    GuiLibrary:Notify({
        Title = topic or "Cancel",
        Content = desc or "The Action Has Been Cancel",
        Duration = duration or 5 
    })
end

getgitHubRequest = function(url)
	return game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/"..url, true)
end

newdialog = function(func)
    Window:Dialog({
        Title = "Do you want to Process This?",
        Content = "it will do what the button name said",
        Buttons = {
            {
                Title = "Confirm",
                Callback = func(),
            },
            {
                Title = "Cancel",
                Callback = function()
                    createNotification("Render", "Dialog Canceled", 5)
                end,
            }
         }
    })
end

Tabs.Main:AddButton({
    Title = "Install",
    Description = "Installs the config.",
    Callback = function()
        newdialog = function()
            print("test")
        end
    end
})