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

local bedwars = {}
local isfile = isfile or function(path) local suc,res = pcall(function() return readfile(path) end) end
local httprequest = (http and http.request or http_request or fluxus and fluxus.request or request or function() end)
local createNotification = function() end
local getgitHubRequest = function() end
local CreateToggle = function() end
local runFunction = function(func) func() end
local newdialog = function() end

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


bedwars = {
    ["6872274481.lua"] = getgitHubRequest("Modules/6872274481.lua"),
    ["NormalRender"] = game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Render/source/packages/6872274481.lua"),
    ["RenderRedUniversal"] = getgitHubRequest("Universal.lua"),
    ["Universal"] = game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Render/source/packages/Universal.lua"),
    ["githubRepo"] = "https://api.github.com/repos/MaxlaserTechAlt/RenderRed/contents/Profiles"
}

local response = request({
    Url = bedwars.githubRepo,
    Method = "GET",
    Headers = {
        ["User-Agent"] = "Roblox",
    }
})

NewDialog = function(func)
    win:Dialog({
        Title = "Render",
        Content = "Do you Want To Process This?",
        Buttons = {
            {
                Title = "Confirm",
                Callback = func()
            },
            {
                Title = "Cancel",
                Callback = function()
                    createNotification("Render", "Cancelled the dialog.", 5)
                end
            }
        }
    })
end



local Profiles = {Enabled = true}
local Modules = {Enabled = false}
runFunction(function()
    Tabs.Main:AddButton({
        Title = "Install",
        Description = "Installs the config.",
        Callback = function()
            NewDialog(function()
                task.spawn(function()
                    if Profiles.Enabled then
                        delfolder("vape/Profiles")
                        makefolder("vape/Profiles")
                        local files = game:GetService("HttpService"):JSONDecode(response.Body)
                        for _, file in ipairs(files) do
                            local verycontent = httprequest({
                                Url = file.download_url,
                                Method = "GET",
                                Headers = {
                                    ["User-Agent"] = "Roblox",
                                }
                            })
                            local profile = verycontent.Body
                            writefile("vape/Profiles/".. file.name, profile)
                        end
                    end

                    if Modules.Enabled then
                        appendfile("vape/CustomModules/6872274481.lua", bedwars["6872274481.lua"])
                        createNotification("Render", "CustomModules Installed")
                    end
                end)
                createNotification("Render", "Might Take A Bit To Install Render Red!")
            end)
        end
    })
end)

runFunction(function()
    local InstallProfile = Tabs.Main:AddToggle("Install Profile", {
        Title = "Install Profile", 
        Default = true 
    })
    InstallProfile:OnChanged(function(callback)
        Profiles.Enabled = Callback
    end)
end)

runFunction(function()
    local InstallModules = Tabs.Main:AddToggle("Install Modules", {
        Title = "Install Modules", 
        Default = true 
    })
    InstallModules:OnChanged(function(callback)
        Modules.Enabled = Callback
    end)
end)


task.spawn(function()
    shared.upd1 = true
    shared.InstallerLoaded = true
end)