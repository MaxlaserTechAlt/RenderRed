local function vapeGithubRequest(scriptname, scripturl)
	if not isfile("vape/"..scriptname) then
		local suc, res = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/"..readfile("vape/commithash.txt").."/"..scripturl, true) end)
		if not suc or res == "404: Not Found" then return nil end
		if scripturl:find(".lua") then res = "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..res end
		writefile("vape/"..scriptname, res)
	end
	return readfile("vape/"..scriptname)
end

shared.CustomSaveVape = 6872274481
if isfile("vape/games/6872274481.lua") then
	loadstring(readfile("vape/games/6872274481.lua"))()
else
	local publicrepo = vapeGithubRequest("games/6872274481.lua", "CustomModules/6872274481.lua")
	if publicrepo then
		loadstring(publicrepo)()
	end
end
