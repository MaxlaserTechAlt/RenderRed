
local client = "Vape V4"
local version = 'V1.0'
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local lplr = game.Players.LocalPlayer
local httpService = game:GetService('HttpService')
local executor = (identifyexecutor or getexecutorname or function() return 'your executor' end)()
local httprequest = (http and http.request or http_request or fluxus and fluxus.request or request or function() end)
local setclipboard = setclipboard or function(data) writefile('clipboard.txt', data) end
local rbxanalytics = game:GetService("RbxAnalyticsService")
local hwid = rbxanalytics:GetClientId()

local isfile = isfile or function(file)
    local success, filecontents = pcall(function() return readfile(file) end)
    return success and type(filecontents) == 'string'
end 

local function runFunction(func) func() end

local newfolder = function(name)
    makefolder("vape/"..name)
end
local newprofile = function(name,file)
    writefile('vape/Profiles/'.. name, file)
end

local Window = Fluent:CreateWindow({
    Title = "Render Red " .. version,
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

local failnotification = function()
    Fluent:Notify({
        Title = "Module",
        Content = "The operation failed.",
        Duration = 5
    })
end

local ResetProfiles = function()
    if not isfolder('vape/Profiles') then
        makefolder('vape/Profiles')
    else
        delfolder('vape/Profiles')
        task.wait(0.05)
        makefolder('vape/Profiles')
    end
end

local testUninstaller = function()
    lplr:Kick("Reinstalling "..client)
end

local uninstall = function()
    repeat task.wait() until uninstalled == true
    ResetProfiles()
    print("Finished!")
    notify("Uninstaller", "Finished uninstalling.")
    local uninstalled = true
end

runFunction(function()
    local lobbyfile1 = game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/Profiles/6872265039.vapeprofile.txt")
    local lobbyfile2 = game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/Profiles/6872265039.vapeprofiles.txt")
    local lobbyfile3 = game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/Profiles/6872265039GUIPositions.vapeprofile.txt")
    local lobbyfile4 = game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/Profiles/6872265039GUIPositions.vapeprofile.txt")
    local lobbyfile5 = game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/Profiles/Render_White6872265039.vapeprofile.txt")
    local setting1 = game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/Profiles/6872274481.vapeprofile.txt")
    local setting2 = game:HttpGet("https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/main/Profiles/6872274481.vapeprofiles.txt")
    Object.Main:AddButton({
        Title = "Install",
        Description = "Installs the config.",
        Callback = function()
            Window:Dialog({
                Title = "Install",
                Content = "Are you sure you want to proceed?",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            ResetProfiles()
                            if isfolder("vape/Profiles") then
                                notify("Render", "Reset Profiles Sucess")
                            end
                                newprofile('6872265039.vapeprofile.txt', lobbyfile1)
                                newprofile('6872265039.vapeprofiles.txt', lobbyfile2)
                                newprofile('6872265039GUIPositions.vapeprofile.txt', lobbyfile3)
                                newprofile('6872265039Render_WhiteGUIPositions.vapeprofile.txt', lobbyfile4)
                                newprofile('Render_White6872265039.vapeprofile.txt', lobbyfile5)
                                newprofile("6872274481.vapeprofile.txt", setting1)
                            
                            notify("Install", "Finished Installing!")
                            
                            task.wait(1.5)
                            
                            do
                                Window:Dialog({
                                    Title = "Installer",
                                    Content = "What do you want to load!",
                                    Buttons = {
                                        {
                                            Title = "Paid Render", --//must be whitelisted
                                            Callback = function()
                                                getgenv().renderwl = true 
                                                loadfile('vape/NewMainScript.lua')()
                                            end
                                        },
                                        {
                                            Title = "Normal Render",
                                            Callback = function()
                                                loadfile("vape/NewMainScript.lua")()
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
                            notify('Uninstall', 'Finished!')
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
    InterfaceManager:SetLibrary(Fluent)
    InterfaceManager:BuildInterfaceSection(Object.Settings)
end)
