local System = {}
local lplr = game.Players.LocalPlayer
writefile("FirstTime", "nil")
System.Check(str)
    return readfile(str)
end
System.CreateKey(key)
    writefile("key-".. key)
    if not isfolder("vape/Render") then
        lplr:Kick("Failed To Create key")
    else
        writefile("vape/Render/key-"..key)
    end
end
System.ReadFile(name)
    if System.Check("FirstTime") == nil then
        delfile("FirstTime.json")
        writefile("FirstTime.json", "false")
    end
end
return System
