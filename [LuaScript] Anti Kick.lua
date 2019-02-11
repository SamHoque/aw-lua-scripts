local cool_down_delay, last_team_in, last_cv, vote_count, potentialVotes, menuPressed, is_me = -1, -1, 1, 1, 0, 1, false;
local showMenu = gui.Checkbox(gui.Reference("MISC", "AUTOMATION", "Other"), "rab_anti_kick_show", "Show Anti Kick Menu", false);
local mainWindow = gui.Window("rab_anti_kick", "Anti Kick", 200, 200, 165, 180);
local settingsGroup = gui.Groupbox(mainWindow, "Settings", 13, 13, 140, 120);
local enable = gui.Checkbox(settingsGroup, "rab_anti_kick_enabled", "Enable Anti Kick", false);
local join_spec = gui.Checkbox(settingsGroup, "rab_anti_kick_join_spec", "Join Spectator", false);
local threshold = gui.Slider(settingsGroup, "rab_anti_kick_threshold", "Scramble threshold %", 80, 1, 100);

client.AllowListener("game_start");
client.AllowListener("vote_cast");
client.AllowListener("vote_changed");
client.AllowListener("vote_failed");
client.AllowListener("vote_passed");
client.AllowListener("vote_ended");

local function checkAndCallVote()
    if (is_me ~= true or potentialVotes == 0) then return end;
    local lp = entities.GetLocalPlayer();
    if ((((vote_count - 1) / (potentialVotes / 2)) * 100) >= threshold:GetValue()) then
        potentialVotes, vote_count = 0, 1;
        if (last_cv == 1) then
            client.Command("callvote ChangeLevel " .. engine.GetMapName());
            last_cv = 2;
        elseif (last_cv == 2) then
            client.Command("callvote SwapTeams");
            last_cv = 3;
        elseif (last_cv == 3) then
            client.Command("callvote ScrambleTeams");
            last_cv = 1;
        end
        if (join_spec:GetValue() ~= true) then return end;
        cool_down_delay, last_team_in = globals.RealTime() + 140, lp:GetTeamNumber();
        client.Command("jointeam  1");
    end
end

callbacks.Register("DispatchUserMessage", function(um)
    if (um:GetID() ~= 46 or enable:GetValue() ~= true) then return end;
    vote_count, potentialVotes = 1, 0;
    local lp = entities.GetLocalPlayer();
    if (um:GetInt(3) == 0 and um:GetString(5) == lp:GetName()) then
        is_me = true;
        checkAndCallVote();
    end;
end);

callbacks.Register("Draw", function()
    if input.IsButtonPressed(gui.GetValue("msc_menutoggle")) then
        menuPressed = menuPressed == 0 and 1 or 0;
    end
    if (showMenu:GetValue()) then
        mainWindow:SetActive(menuPressed);
    else
        mainWindow:SetActive(0);
    end
    if (cool_down_delay == -1 or last_team_in == -1 or enable:GetValue() ~= true or join_spec:GetValue() ~= true) then return end;
    if (cool_down_delay < globals.RealTime()) then
        client.Command("jointeam  0 " .. last_team_in);
        cool_down_delay, last_team_in, vote_count, potentialVotes, is_me = -1, -1, 1, 0, false;
    end
end)

callbacks.Register("FireGameEvent", function(e)
    local en = e:GetName();
    if (enable:GetValue() ~= true) then return end;
    if (en == "game_start") then
        cool_down_delay, last_team_in, last_cv, vote_count, potentialVotes, is_me = -1, -1, 1, 1, 0, false;
    elseif (en == "vote_changed") then
        potentialVotes = e:GetInt("potentialVotes");
        checkAndCallVote();
    elseif (en == "vote_cast") then
        if (client.GetLocalPlayerIndex() ~= e:GetInt("entityid") and e:GetInt("vote_option") == 0) then
            vote_count = vote_count + 1;
            checkAndCallVote();
        end
    elseif (en == "vote_failed" or en == "vote_passed" or en == "vote_ended") then
        vote_count, potentialVotes,is_me = 1, 0, false;
    end
end)