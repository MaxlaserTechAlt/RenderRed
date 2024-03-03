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
    local la = {Enabled = false}
    local katframe = {Players = {}}
    local range = {Value = 14}
    local laAngle = {Value = 150}
    local Nearest = {Enabled = true}
    local norender = {}
    local laremote = bedwars.ClientHandler:Get(bedwars.AttackRemote).instance
    local SwingMiss = replicatedStorageService["rbxts_include"]["node_modules"]["@rbxts"]["net"]["out"]["_NetManaged"]["SwordSwingMiss"]
    local InRange = false

    local function getAttackData()
        if GuiLibrary.ObjectsThatCanBeSaved['Lobby CheckToggle'].Api.Enabled then
            if bedwarsStore.matchState == 0 then return false end
        end

        local sword = bedwarsStore.localHand or getSword()
        if not sword or not sword.tool then return false end

        local swordmeta = bedwars.ItemTable[sword.tool.Name]
        return sword, swordmeta
    end

    local function Distance(a, b)
        return (a.RootPart.Position - entityLibrary.character.HumanoidRootPart.Position).Magnitude < (b.RootPart.Position - entityLibrary.character.HumanoidRootPart.Position).Magnitude
    end

    local plrs = AllNearPosition(range.Value, 10)
    if #plrs > 0 then
        InRange = true
    elseif #plrs == 0 then
        InRange = false
    end

    local function ka()
        local oldcall
        oldcall = hookmetamethod(game, "__namecall", function(self, ...)
            if not la.Enabled then
                return oldcall(self, ...)
            end

            if getnamecallmethod() == 'FireServer' and self == SwingMiss and InRange then
                local plrs = AllNearPosition(range.Value, 10)
                if #plrs > 0 then
                    if Nearest.Enabled then
                        table.sort(plrs, Distance)
                    end
                    local sword, swordmeta = getAttackData()
                    if sword then
                        for i, plr in next, plrs do
                            local root = plr.RootPart
                            if not root then
                                continue
                            end
                            vapeTargetInfo.Targets.la = {
                                Humanoid = {
                                    Health = (plr.Character:GetAttribute('Health') or plr.Humanoid.Health) + getShieldAttribute(plr.Character),
                                    MaxHealth = plr.Character:GetAttribute('MaxHealth') or plr.Humanoid.MaxHealth
                                },
                                Player = plr.Player
                            }
                            local localfacing = entityLibrary.character.HumanoidRootPart.CFrame.lookVector
                            local vec = (root.Position - entityLibrary.character.HumanoidRootPart.Position).unit
                            local angle = math.acos(localfacing:Dot(vec))
                            if angle >= math.rad(laAngle.Value) / 2 then
                                continue
                            end
                            local selfrootpos = entityLibrary.character.HumanoidRootPart.Position
                            local selfpos = selfrootpos + (range.Value > 14 and (selfrootpos - root.Position).magnitude > 14.4 and (CFrame.lookAt(selfrootpos, root.Position).lookVector * ((selfrootpos - root.Position).magnitude - 14)) or Vector3.zero)
                            bedwars.SwordController.lastAttack = workspace:GetServerTimeNow()
                            bedwarsStore.attackReach = math.floor((selfrootpos - root.Position).magnitude * 100) / 100
                            bedwarsStore.attackReachUpdate = tick() + 1
                            laremote:FireServer({
                                weapon = sword.tool,
                                chargedAttack = {
                                    chargeRatio = swordmeta.sword.chargedAttack and bedwarsStore.queueType ~= 'bridge_duel' and not swordmeta.sword.chargedAttack.disableOnGrounded and 0.999 or 0
                                },
                                entityInstance = plr.Character,
                                validate = {
                                    raycast = {
                                        cameraPosition = attackValue(root.Position),
                                        cursorDirection = attackValue(CFrame.new(selfpos, root.Position).lookVector)
                                    },
                                    targetPosition = attackValue(root.Position),
                                    selfPosition = attackValue(selfpos)
                                }
                            })
                        end
                    end
                end
            end
            return oldcall(self, ...)
        end)
    end

    local la = GuiLibrary.ObjectsThatCanBeSaved.LegitWindow.Api.CreateOptionsButton({
        Name = 'Legit Aura',
        HoverText = 'Thanks to blxnked for the hookmetamethod',
        Function = function(callback)
            if callback then
                ka()
            end
        end
    })
    range = la.CreateSlider({
        Name = "Range",
        Min = 10,
        Max = 18,
        Function = function() end,
        Default = 14
    })
    laAngle = la.CreateSlider({
        Name = "Angle",
        Min = 0,
        Max = 230,
        Function = function() end,
        Default = 180
    })
    katframe = la.CreateTargetWindow({})
    Nearest = la.CreateToggle({
        Name = "Attack Nearest",
        Function = function() end,
        Default = true
    })
    norender = la.CreateToggle({
        Name = 'Ignore render',
        Function = function() if la.Enabled then la.ToggleButton(false) la.ToggleButton(false) end end,
        HoverText = 'ignores render users under your rank.\n(they can\'t attack you back :omegalol:)'
    })
    norender.Object.Visible = false
    task.spawn(function() repeat task.wait() until RenderFunctions.WhitelistLoaded
        norender.Object.Visible = RenderFunctions:GetPlayerType(3, plr.Player) > 1.5
    end)
end)

runFunction(function()
	local KnockBack = {}
	local KnockBackHorizontal = {Value = 53}
	local KnockBackVertical = {Value = 43}
	local applyKnockback
	KnockBack = GuiLibrary.ObjectsThatCanBeSaved.LegitWindow.Api.CreateOptionsButton({
		Name = 'KnockBack',
		Function = function(calling)
			if calling then
				applyKnockback = bedwars.KnockbackUtil.applyKnockback
				bedwars.KnockbackUtil.applyKnockback = function(root, mass, dir, knockback, ...)
					knockback = knockback or {}
					if KnockBackHorizontal.Value == 0 and KnockBackVertical.Value == 0 then return end
					knockback.horizontal = (knockback.horizontal or 1) * (KnockBackHorizontal.Value / 100)
					knockback.vertical = (knockback.vertical or 1) * (KnockBackVertical.Value / 100)
					return applyKnockback(root, mass, dir, knockback, ...)
				end
			else
				bedwars.KnockbackUtil.applyKnockback = applyKnockback
			end
		end,
		HoverText = 'Reduces You Knockback'
	})
end)
print("Render Red Finished Loading")
