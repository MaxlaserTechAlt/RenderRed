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


print("Render Red Finished Loading")
