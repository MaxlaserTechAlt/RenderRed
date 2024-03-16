local System = {}
local lplr = game.Players.LocalPlayer
System.CreateKey(key)
    writefile("key-".. key)
    if not isfolder("vape/Render") then
        lplr:Kick("Failed To Create key. Please Go To @.gg/render")
    else
        writefile("vape/Render/key-"..key)
    end
end
return System
