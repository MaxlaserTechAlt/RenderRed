runFunction(function()
    local Transform = {Enabled = false}
    local Block = {Value = "lucky_block"}
	Transform = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
        Name = 'Transform Into A block',
        Function = function(callback)
            if callback then
                task.spawn(function()
					replicatedStorageService["rbxts_include"]["node_modules"]["@rbxts"].net.out._NetManaged.MimicBlock:FireServer({
						["data"] = {
							["blockType"] = Block.Value or "bedrock",
						}
					})
                end)
				Transform.ToggleButton(false)
            end
        end,
        HoverText = 'Crashing All People in the game'
    })
	Block = Transform.CreateDropdown({
		Name = 'Block',
		Function = function() end,
		List = {"bedrock", "lucky_block", "cosmic_lucky_block", "brick", "birch_log", "copper_block", "diamond_block", "emerald_block", "food_lucky_block"}
	})
end)

runFunction(function()
    local EarDestroyer = {}
    local Type = {Value = "Dao"}
	EarDestroyer = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
        Name = 'EarDestroyer',
        Function = function(callback)
            if callback then
                task.spawn(function()
                    repeat 
                        task.wait()

                    until (not EarDestroyer.Enabled)
                end)
            end
        end,
        HoverText = 'Crashing All People in the game'
    })
--	Type = Transform.CreateDropdown({
	--	Name = 'RemoteType',
	--	Function = function() end,
	--	List = {"Dao", "Soons"}
--	})
end)