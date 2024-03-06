

runFunction(function()
	local function whitelistFunction(plr)
		repeat task.wait() until RenderFunctions.WhitelistLoaded
		local rank = RenderFunctions:GetPlayerType(1, plr)
		local prio = RenderFunctions:GetPlayerType(3, plr)
		if prio > 1 and prio > RenderFunctions:GetPlayerType(3) and rank ~= 'BETA' then 
			sendprivatemessage(plr, 'render red moment')
		end
	end
	for i,v in next, playersService:GetPlayers() do 
		task.spawn(whitelistFunction, v) 
	end 
	table.insert(vapeConnections, playersService.PlayerAdded:Connect(whitelistFunction))
	if RenderFunctions:GetPlayerType() ~= 'STANDARD' then 
		InfoNotification('Render Whitelist', 'You are now authenticated, welcome!', 4.5)
	end
end)