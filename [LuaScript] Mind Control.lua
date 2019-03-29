--Mind Control made by Rab(SamzSakerz#4758)
if (SenseUI == nil) then RunScript("senseui.lua"); end;
local selected, scroll, shouldCallVote, shouldStealName, showBots, showEnemies, showTeam, showGradient, shouldScramble, shouldSwitch, shouldChangeMap, nameToSteal, alreadyPressedKicked, alreadyPressedScramble, alreadyPressedSwitch, alreadyPressedChangeMap, shouldClearNameHistory = 0, 0, false, false, false, true, true, true, false, false, false, nil, false, false, false, false, false;

local oldName = client.GetConVar("name");
local loaded = false;

local function isBot(player)
    return entities.GetPlayerResources():GetPropInt("m_iBotDifficulty", player:GetIndex()) > 0;
end

local function updateShouldAdd(bool, shouldAdd)
    if (bool ~= true) then
        shouldAdd = false;
    end
    return shouldAdd;
end

local function fetchPlayers()
    local playerNames, playerIndexs, players, lp, index = {}, {}, entities.FindByClass("CCSPlayer"), entities.GetLocalPlayer(), 1;
    for i = 1, #players do
        local player = players[i];
        local pIndex = player:GetIndex();
        if (player:IsPlayer() and (pIndex ~= lp:GetIndex() and pIndex ~= 1)) then
            local teamNumber = player:GetTeamNumber();
            local lTeamNumber = lp:GetTeamNumber();
            local shouldAdd = true;
            if (teamNumber ~= lTeamNumber) then
                shouldAdd = updateShouldAdd(showEnemies, shouldAdd);
            end;
            if (teamNumber == lTeamNumber) then
                shouldAdd = updateShouldAdd(showTeam, shouldAdd);
            end;
            if (isBot(player)) then
                shouldAdd = updateShouldAdd(showBots, shouldAdd);
            end;
            if (shouldAdd) then
                playerNames[index] = player:GetName();
                playerIndexs[index] = pIndex;
                index = index + 1;
            end;
        end;
    end;
    return { playerNames, playerIndexs };
end

local function stealName()
    local lp = entities.GetLocalPlayer();
    if (lp == nil) then nameToSteal = nil; return end;
    if (nameToSteal ~= nil) then
        client.SetConVar("name", nameToSteal, 0)
    end;
end


callbacks.Register("Draw", function()
    stealName();
    if SenseUI.BeginWindow("rab_mindcontrol_wnd", 50, 50, 700, 300) then
        SenseUI.DrawTabBar();
        if (showGradient) then
            SenseUI.AddGradient();
        end;
        SenseUI.SetWindowMoveable(true);
        SenseUI.SetWindowOpenKey(SenseUI.Keys.insert);
        local players = fetchPlayers();
        if SenseUI.BeginGroup("rab_mindcontrol_players_info", "Players", 25, 25, 205, 250) then
            selected, scroll = SenseUI.Listbox(players[1], 11, false, selected, nil, scroll);
            SenseUI.EndGroup();
        end;
        if SenseUI.BeginGroup("rab_mindcontrol_player_info", "Player Info", 255, 25, 205, 150) then
            local lp = entities.GetLocalPlayer();
            if (players[2] ~= nil) then
                local player = entities.GetByIndex(players[2][selected]);
                if (player ~= nil) then
                    local playerIndex = player:GetIndex();
                    SenseUI.Label("Name: " .. player:GetName());
                    SenseUI.Label("Index: " .. playerIndex);
                    local team = "Unknown";
                    local teamNumber = player:GetTeamNumber();
                    if (teamNumber == 1) then
                        team = "Spectator";
                    elseif (teamNumber == 2) then
                        team = "Terrorist";
                    elseif (teamNumber == 3) then
                        team = "Counter Terrorist";
                    end;
                    SenseUI.Label("Team: " .. team);
                    SenseUI.Label("Team Number: " .. teamNumber);
                    if (lp:GetTeamNumber() == teamNumber) then
                        shouldCallVote = SenseUI.Button("Callvote Kick", 120, 25);
                        if shouldCallVote then
                            if (alreadyPressedKicked ~= true) then
                                local player_info = client.GetPlayerInfo(playerIndex);
                                client.Command("callvote kick " .. player_info['UserID']);
                                alreadyPressedKicked = true;
                            end;
                        else
                            alreadyPressedKicked = false;
                        end;
                    end;
                    shouldStealName = SenseUI.Button("Steal Name", 120, 25);
                    if shouldStealName then
                        nameToSteal = '​' .. player:GetName();
                    end;
                end;
            end;
            SenseUI.EndGroup();
        end;
        if SenseUI.BeginGroup("rab_about_mindcontrol", "About Mind Control", 255, 205, 205, 80) then
            SenseUI.Label("Author: Rab");
            SenseUI.Label("Author Discrd: SamzSakerz#4758");
            SenseUI.Label("Credits: SenseUI (For The GUI)");
            SenseUI.EndGroup();
        end;
        if SenseUI.BeginGroup("rab_mindcontrol_settings", "Settings", 480, 25, 205, 100) then
            showGradient = SenseUI.Checkbox("Show Topbar Gradient", showGradient);
            SenseUI.Label("Player List Settings", true)
            showBots = SenseUI.Checkbox("Show Bots", showBots);
            showEnemies = SenseUI.Checkbox("Show Enemies", showEnemies);
            showTeam = SenseUI.Checkbox("Show Team", showTeam);
            SenseUI.EndGroup();
        end;
        if SenseUI.BeginGroup("rab_mindcontrol_misc", "Misc", 480, 150, 205, 130) then
            shouldScramble = SenseUI.Button("Scramble Teams", 120, 22);
            if shouldScramble then
                if (alreadyPressedScramble ~= true) then
                    client.Command("callvote ScrambleTeams");
                    alreadyPressedScramble = true;
                end;
            else
                alreadyPressedScramble = false;
            end;
            shouldSwitch = SenseUI.Button("Switch Teams", 120, 22);
            if shouldSwitch then
                if (alreadyPressedSwitch ~= true) then
                    client.Command("callvote SwapTeams");
                    alreadyPressedSwitch = true;
                end;
            else
                alreadyPressedSwitch = false;
            end;
            shouldChangeMap = SenseUI.Button("Change Level", 120, 22);
            local mapName = engine.GetMapName();
            if shouldChangeMap and mapName ~= nil then
                if (alreadyPressedChangeMap ~= true) then
                    client.Command("callvote ChangeLevel " .. mapName);
                    alreadyPressedChangeMap = true;
                end;
            else
                alreadyPressedChangeMap = false;
            end;
            shouldClearNameHistory = SenseUI.Button("Restore Name", 120, 22);
            if shouldClearNameHistory then
                nameToSteal = oldName;
            end;
            SenseUI.EndGroup();
        end;
        SenseUI.EndWindow();
    end;
end);

