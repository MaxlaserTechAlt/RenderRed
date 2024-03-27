--[[
    thanks blank for installer source (i definitely have his permission!)
]]

local createNotification = function(title,text,duration)
    game:GetService('StarterGui'):SetCore('SendNotification', ({
        Title = title,
        Text = text,
        Icon = 'rbxassetid://16498204245',
        Duration = duration or 5
    })) 
end
if not isfolder("vape/Render") then
    return createNotification("Installer", "Failed To Install Render Red. Please Install Render")
end

for i,v in next, ({"GuiLibrary.lua", "MainScript.lua", "NewMainScript.lua"}) do
    delfile("vape/".. v)
end

for i,v in next, ({"CustomModules", "Libraries", "Profiles"}) do
    delfolder("vape/".. v)
end

for i,v in next, ({'gui.lua', 'main.lua', 'newmain.lua'}) do 
    local res = game:HttpGet('https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/'..v)
    if res ~= '404: Not Found' then 
        writefile("vape/".. v, res)
    end
end

for i,v in next, ({'libraries', 'games', 'config'})
    makefolder("vape/".. v)
end

repeat task.wait() until isfolder("config")

for i,v in next, ({'6872274481.lua', '6872265039.lua'}) do 
    local res = game:HttpGet('https://raw.githubusercontent.com/MaxlaserTechAlt/RenderRed/source/games/'..v)
    if res ~= '404: Not Found' then 
        writefile('vape/games/'..v, res) 
    end
end

local profiles = {}
local fetected
local res = game:HttpGet('https://api.github.com/repos/MaxlaserTechAlt/RenderRed/contents/config/')
if res ~= '404: Not Found' then 
    for i,v in next, game:GetService("HttpService"):JSONDecode(res) do 
        if type(v) == 'table' and v.name then 
            table.insert(profiles, v.name) 
        end
    end
    fetected = true
end

repeat task.wait() until fetected
local finished = false
for i,v in next, profiles do
    local res = game:HttpGet('https://api.github.com/repos/MaxlaserTechAlt/RenderRed/contents/config/')
    if res ~= '404: Not Found' then 
        writefile('vape/config/'..v, res) 
    end
    finished = true
end
repeat task.wait() until finished
createNotification("Render Red", "Finished Installing", 5)
if shared.ExecuteOnFinished then
    getgenv().RenderDeveloper = true
    loadfile("vape/newmain.lua")()
end
