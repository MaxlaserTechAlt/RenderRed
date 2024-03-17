local System = {}
local lplr = game.Players.LocalPlayer
if not isfile("FirstTime.json") then
    writefile("FirstTime.json", "nil")
end
System.Check(str)
    return loadstring(readfile(str)())
end
System.CreateKey(key)
    writefile("key-".. key)
    if not isfolder("vape/Render") then
        lplr:Kick("Failed To Create key. Please Go To @.gg/render or Render Red Server!")
    else
        writefile("vape/Render/key-"..key)
    end
end
System.ReadFile(name)
    if System.Check("FirstTime.json") == "nil" then
        writefile(name.. ".rr", "true")
        delfile("FirstTime.json")
        writefile("FirstTime.json", "false")
    end
    if not isfile(name..".rr") then
        lplr:Kick("Something When Wrong...")
    end
end
return System
