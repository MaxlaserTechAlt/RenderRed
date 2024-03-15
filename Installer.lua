local GuiLibrary = shared.Fluent
local win = shared.Window
local Tabs = shared.Tab
local RenderStore = shared.RenderStore

local TweenService = RenderStore.Service.TweenService
local plrService = RenderStore.Service.PlayerService
local InputService = RenderStore.Service.InputService
local lplr = RenderStore.InGame.LocalPlayer
local replicatedStorage = RenderStore.Service.replicatedStorageService

local placeId = RenderStore.Game.PlaceId
local jobId = RenderStore.Game.JobId
local gameId = RenderStore.Game.GameId

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

Object.Main:AddButton({
    Title = "Install",
    Description = "Installs the config.",
    Callback = function()
        newdialog = function()
            print("test")
        end
    end
})