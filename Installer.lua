local client = "Vape V4"
local version = " V2"
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local lplr = game.Players.LocalPlayer
local httpService = game:GetService("HttpService")
local httprequest = (http and http.request or http_request or fluxus and fluxus.request or request or function() end)
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/Checker.lua", true))()
end)

local isfile = isfile or function(file)
    local success, filecontents = pcall(function() return readfile(file) end)
    return success and type(filecontents) == "string"
end 

local newmodule = function(name,file)
    writefile("vape/CustomModules/"..name,file)
    task.wait(0.4)
end
local delmodule = function(name)
    delfile("vape/CustomModules/"..name)
end

local newfolder = function(name)
    makefolder("vape/"..name)
end
local newprofile = function(name,file)
    writefile("vape/Profiles/".. name, file)
end
local writefiles = function(name, file)
    if not isfile(name) then
        writefile(name, file)
    end
end
local Window = Fluent:CreateWindow({
    Title = "Installer" .. version,
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Object = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local cancelnotification = function()
    Fluent:Notify({
        Title = "Cancel",
        Content = "The action was cancelled.",
        Duration = 5
    })
end

local notify = function(name,text)
    Fluent:Notify({
        Title = name,
        Content = text,
        Duration = 5
    })
end

local info = function(text, duration)
    Fluent:Notify({
        Title = "Info",
        Content = text,
        Duration = duration
    })
end

local failnotification = function()
    Fluent:Notify({
        Title = "Module",
        Content = "The operation failed.",
        Duration = 5 
    })
end

local ResetProfiles = function()
    if not isfolder("vape/Profiles") then
        makefolder("vape/Profiles")
    else
        delfolder("vape/Profiles")
        task.wait(0.05)
        makefolder("vape/Profiles")
    end
end

local uninstall = function()
    task.spawn(function()
        local v = shared.GuiLibrary
        if v then
            v.SelfDestruct()
        end
    end)
    ResetProfiles()
    if isfile("vape/CustomModules/6872274481.lua") then delmodule("6872274481.lua") end
    notify("Render","Sucessfully Uninstall Config!")
end

local bedwars = {
    ["6872274481.lua"] = game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/Modules/6872274481.lua"),
    ["NormalRender"] = game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Render/source/packages/6872274481.lua"),
    ["RenderRedUniversal"] = game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/Universal.lua"),
    ["Universal"] = game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Render/source/packages/Universal.lua"),
    ["githubRepo"] = "https://api.github.com/repos/MaxlaserTechAlt/RenderRed/contents/Profiles"
}

local InstallProfile = true
local InstallOnce = false
local MakeModule = true
local response = request({
    Url = bedwars.githubRepo,
    Method = "GET",
    Headers = {
        ["User-Agent"] = "Roblox"
    }
})

Object.Main:AddButton({
    Title = "Install",
    Description = "Installs the config.",
    Callback = function()
        local files = HttpService:JSONDecode(response.Body)
        Window:Dialog({
            Title = "Install",
            Content = "Are you sure you want to proceed?",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        if isfolder("vape/Profiles") then
                            if InstallProfile then
                                ResetProfiles()
                                for _, file in ipairs(files) do
                                    if file.type == "file" then
                                        local fileContentResponse = request({
                                            Url = file.download_url,
                                            Method = "GET",
                                            Headers = {
                                                ["User-Agent"] = "Roblox"
                                            }
                                        })
                                        local fileContent = fileContentResponse.Body
                                        newprofile(file.name, fileContent)
                                    end
                                end
                                info("Install Profiles Sucess!", 5)
                            end
                        else
                            failnotification("Profile Folder Not Found", 5)
                        end
                        if isfile("vape/CustomModules/6872274481.lua") then
                            if MakeModule then
                                delmodule("6872274481.lua")
                                delfile("vape/Universal.lua")
                                writefile("vape/Universal.lua", bedwars.Universal)
                                appendfile("vape/Universal.lua", "\n".. bedwars.RenderRedUniversal)
                                newmodule("6872274481.lua", bedwars.NormalRender)
                                appendfile("vape/CustomModules/6872274481.lua", "\n".. bedwars["6872274481.lua"])
                                info("Install Module Sucess!", 5)
                            end
                        end

                        task.wait(1.5)
                        do
                            Window:Dialog({
                                Title = "Installer",
                                Content = "What do you want to load!",
                                Buttons = {
                                    {
                                        Title = "Render",
                                        Callback = function()
                                            loadfile([[vape/NewMainScript.lua]])()
                                        end
                                    },
                                    {
                                        Title = "Cancel",
                                        Callback = function()
                                            cancelnotification()
                                        end
                                    }
                                }
                            })
                        end
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        cancelnotification()
                    end
                }
            }
        })
    end
})

Object.Main:AddButton({
    Title = "Uninstall",
    Description = "Uninstalls the config.",
    Callback = function()
        Window:Dialog({
            Title = "Uninstall",
            Content = "Are you sure you want to proceed?",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        uninstall()
                        notify("Uninstall", "Finished!")
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        cancelnotification()
                    end
                }
            }
        })
    end
})
local InstallProfiles = Object.Main:AddToggle("Profiles",{
    Title = "Install Profiles",
    Default = true
})
InstallProfiles:OnChanged(function(calling)
    InstallProfile = calling
end)
local MakeModules = Object.Main:AddToggle("MakeModules",{
    Title = "Install CustomModules",
    Default = true
})
MakeModules:OnChanged(function(calling)
    MakeModule = calling
end)
Object.Main:AddButton({
    Title = "Execute Render",
    Description = "Executing Render Config.",
    Callback = function()
        Window:Dialog({
            Title = "Render",
            Content = "Do you want to Execute Render",
            Buttons = {
                {
                    Title = "Yes",
                    Callback = function()
                        loadfile("vape/NewMainScript.lua")()
                    end
                },
                {
                    Title = "No",
                    Callback = function()
                        cancelnotification()
                    end
                }
            }
        })
    end
})
Object.Main:AddButton({
    Title = "UnInject",
    Description = "UnInject Vape V4.",
    Callback = function()
        Window:Dialog({
            Title = "Render",
            Content = "Do you sure u want to Uninject Render?",
            Buttons = {
                {
                    Title = "Yes",
                    Callback = function()
                        local v = shared.GuiLibrary v then v.SelfDestruct() end
                        notify("Render", "Render Has Been UnInjected!")
                    end
                },
                {
                    Title = "No",
                    Callback = function()
                         cancelnotification()
                    end
                }
            }
        })
    end
})
