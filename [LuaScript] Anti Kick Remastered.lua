--[=====[

    Anti Kick Vote Made by Rab(SamzSakerz#4758)
             __        __
            |__)  /\  |__)
            |  \ /~~\ |__)
       __   __   ___      ___  ___
      /  ` |__) |__   /\   |  |__
      \__, |  \ |___ /~~\  |  |___
               ___  __           ___     ___
|  | |__|  /\   |  /__`    |\ | |__  \_/  |
|/\| |  | /~~\  |  .__/    | \| |___ / \  |

--]=====]

-- Register all the events we will be listening to
local eventsToListen = { "game_start", "vote_cast", "vote_changed", "vote_ended", "vote_failed", "vote_passed" };
for i = 1, #eventsToListen do
    client.AllowListener(eventsToListen[i]);
end

-- Create the window for adding options for anti kick.
local aimwareMenu = gui.Reference("MENU");
local windowW, windowH = 200, 275;
local mainWindow = gui.Window("rab_anti_kick_menu", "Anti Kick", 200, 200, windowW, windowH);
local settingsGroup = gui.Groupbox(mainWindow, "Settings", 13, 13, windowW - 25, windowH - 55);

-- Add options to the window
local enable = gui.Checkbox(settingsGroup, "rab_anti_kick_enabled", "Enable Anti Kick", false);
local joinSpec = gui.Checkbox(settingsGroup, "rab_anti_kick_join_spec", "Join Spectators", false);
local switchTeam = gui.Checkbox(settingsGroup, "rab_anti_kick_switch_team", "Switch Team", false);

local voteThreshold = gui.Slider(settingsGroup, "rab_anti_kick_threshold", "Scramble threshold %", 80, 1, 100);

-- Add info bar options to window
local drawInfo = gui.Checkbox(settingsGroup, "rab_anti_kick_info_bar", "Info Bar", false);
local theme = gui.Combobox(settingsGroup, "rab_anti_kick_info_bar_theme", "Info Bar Theme", "Light", "Dark", "Amoled")

-- Add option to enable/disable window via aw menu
local showMenu = gui.Checkbox(gui.Reference("MISC", "AUTOMATION", "Other"), "rab_anti_kick_show", "Show Anti Kick Menu", false);

-- Needed Variables for the vote feature to work.
local self_voted = false;
local vote_yes_count = 1;
local self_being_kicked = false;
local potentialVotes = 0;
local vote_cool_down = 0;
local last_call_vote = 1;
local last_team_in = 1;

-- Needed Vars for info bar
local mouseX, mouseY, x, y, dx, dy, w, h = 0, 0, 25, 660, 0, 0, 160, 60;
local shouldDrag = false;
local primary_color = { { 255, 255, 255 }, { 33, 33, 33 }, { 0, 0, 0 } };
local secondary_color = { { 238, 238, 238 }, { 44, 44, 44 }, { 0, 0, 0 } }
local text_color = { { 0, 0, 0 }, { 255, 255, 255 }, { 255, 255, 255 } }
local RabFonts = { Verdana17400 = draw.CreateFont("Verdana", 17, 400), Verdana13400 = draw.CreateFont("Verdana", 13, 400) }

-- Register callback for our DispatchUserMessage event.
callbacks.Register("DispatchUserMessage", function(um)
    local id = um:GetID();
    -- if(id > 40 and id < 50) then print(id) end;
    if (id == 46 and enable:GetValue()) then
        local lp = entities.GetLocalPlayer();
        -- Entity Index of the person who started the vote
        local vote_starter_entid = um:GetInt(2);
        if (lp == nil) then
            return
        end ;
        local localPlayerIndex = lp:GetIndex();
        --  print("vote started by id: " .. vote_starter_entid .. " our id is: ".. localPlayerIndex)
        if (vote_starter_entid == localPlayerIndex) then
            --   print("we just called a vote")
            -- We are calling the vote so lets reset some cache
            self_voted, self_being_kicked, vote_yes_count, potentialVotes = true, false, 0, 0;
        else
            local personGettingKickedName = um:GetString(5);
            local voteType = um:GetInt(3);
            local localPlayerName = lp:GetName();
            -- Check if the vote is a callvote kick and if the person getting kicked is our name, or empty
            if (voteType == 0 and (personGettingKickedName == localPlayerName or personGettingKickedName == '')) then
                self_being_kicked = true;
                self_voted = false;
            end
        end
    elseif id == 48 then
        -- Check if the vote kick on us has failed and reset cache
        if (self_being_kicked) then
            self_being_kicked, vote_yes_count, potentialVotes = false, 0, 0;
        end
    elseif id == 47 then
        -- Check if we have swapped/scrambled/changed level if so lets reset the vote_cool_down value and reset cache.
        -- print('vote passed')
        -- print("self_voted: ", tostring(self_voted))
        if (self_voted) then
            --   print('vote passed 2')
            self_voted, self_being_kicked, vote_yes_count, potentialVotes, vote_cool_down = false, false, 0, 0, 0;
        end
    end
end);

-- Register callback for our FireGameEvent event.
callbacks.Register("FireGameEvent", function(e)
    local en = e:GetName();
    if (en == "game_start") then
        -- a new game has started lets reset our vote cache
        self_voted, self_being_kicked, vote_yes_count, potentialVotes, vote_cool_down = false, false, 0, 0, 0;
    elseif (en == "vote_changed") then
        -- Check if we didn't start the vote and we are being kicked at the same time and then store potential votes needed for us to get kicked
        if (self_voted ~= true and self_being_kicked) then
            potentialVotes = e:GetInt("potentialVotes");
        end
    elseif (en == "vote_cast") then
        local lp = entities.GetLocalPlayer();
        local localPlayerIndex = lp:GetIndex();
        -- Vote option the person casted
        local voteOption = e:GetInt("vote_option");

        -- Entity id of the person who casted the vote
        local vote_starter_entid = e:GetInt("entityid");
        if (self_voted ~= true and self_being_kicked) then
            -- Checks if we have voted yes, we can't vote yes on our own kick vote so lets make self_being_kicked false and reset cache
            if (vote_starter_entid == localPlayerIndex and vote_option == 0) then
                self_being_kicked, vote_yes_count, potentialVotes = false, 0, 0;
                -- Someone else voted yes on the vote and we have verified we are the one being kicked so lets add +1 to vote_yes_count
            elseif (vote_starter_entid ~= localPlayerIndex and voteOption == 0) then
                vote_yes_count = vote_yes_count + 1;
            end
        end
    end
end);

-- Register callback for our Draw event.
callbacks.Register("Draw", function()
    -- Set the visibility of our settings window.
    mainWindow:SetActive(showMenu:GetValue() and aimwareMenu:IsActive());

    -- Check if we have anti vote enabled, if not lets return.
    if (enable:GetValue() ~= true) then
        return
    end
    local lp = entities.GetLocalPlayer();
    if (lp ~= nil) then
        -- Check if we called the vote and we are being kicked also check if potentialVotes isn't 0
        if (self_voted ~= true and self_being_kicked and potentialVotes ~= 0) then
            -- For debugging
            -- print('self_voted: ', tostring(self_voted), ' ', 'self_being_kicked: ', tostring(self_being_kicked), ' ', 'vote_yes_count: ', vote_yes_count, 'potentialVotes: ', potentialVotes, 'vote_cool_down: ', vote_cool_down  )

            local thresholdReached = ((vote_yes_count / (potentialVotes / 2)) * 100) >= voteThreshold:GetValue();

            -- We have reached our threshold limit lets active anti kick
            if (thresholdReached) then
                -- Reset some cache since we wont be getting kicked anymore
                self_voted, self_being_kicked, vote_yes_count, potentialVotes = false, false, 0, 0;

                -- Lets call a vote to override us being kicked
                local vote_to_call = last_call_vote == 1 and 'SwapTeams' or last_call_vote == 2 and 'ScrambleTeams' or 'ChangeLevel ' .. engine.GetMapName();

                -- Lets change the last_call_vote so we pick a different call_vote next time.
                last_call_vote = last_call_vote == 1 and 2 or last_call_vote == 2 and 3 or last_call_vote == 3 and 1;

                -- Finally lets execute the call-vote command
                client.Command('callvote ' .. vote_to_call)

                -- Lets set the vote_cool_down since we have just started a vote. Vote cool downs are 120 seconds, to be safe lets set it at 140.
                vote_cool_down = globals.RealTime() + 140;

                -- Check if we have join spectators enabled if not lets just return from here
                if (joinSpec:GetValue() ~= true) then
                    return
                end

                -- Lets cache the num of the last team we were in before joining specs
                local teamNum = lp:GetTeamNumber();
                last_team_in = switchTeam:GetValue() and (teamNum == 2 and 3 or 2) or teamNum
                client.Command("jointeam  1");
            end
            -- check if we are in spectators and vote_cool_down has ended
        elseif (lp:GetTeamNumber() == 1 and vote_cool_down ~= 0 and vote_cool_down < globals.RealTime()) then
            vote_cool_down, last_team_in = 0, 1;
            client.Command("jointeam  0 " .. last_team_in);
            -- check if we aren't in specs and vote_cool_down hasn't ended
        elseif (lp:GetTeamNumber() ~= 1 and vote_cool_down ~= 0) then
            --TODO: Implement something
        end
    else
        self_voted, self_being_kicked, vote_yes_count, potentialVotes, vote_cool_down = false, false, 0, 0, 0;
    end
    local remainingTime = math.ceil((vote_cool_down - globals.RealTime()) * 100) / 100;
    if (remainingTime < 0 and vote_cool_down ~= 0) then
        vote_cool_down, last_team_in = 0, 1;
    end
    if (drawInfo:GetValue()) then
        if input.IsButtonDown(1) then
            mouseX, mouseY = input.GetMousePos();
            if shouldDrag then
                x = mouseX - dx;
                y = mouseY - dy;
            end
            if mouseX >= x and mouseX <= x + w and mouseY >= y and mouseY <= y + 40 then
                shouldDrag = true;
                dx = mouseX - x;
                dy = mouseY - y;
            end
        else
            shouldDrag = false;
        end
        local currentTheme = theme:GetValue() + 1;
        local rgb = primary_color[currentTheme];
        local topbarSize = 25;
        draw.Color(rgb[1], rgb[2], rgb[3], 255)
        draw.FilledRect(x, y, x + w, y + h);
        rgb = text_color[currentTheme];
        draw.Color(rgb[1], rgb[2], rgb[3], 255);
        draw.SetFont(RabFonts.Verdana17400);
        draw.Text(x + 10, y + topbarSize / 8, "Anti Kick Info")
        local r = math.floor(math.sin((globals.RealTime()) * 2) * 127 + 128)
        local g = math.floor(math.sin((globals.RealTime()) * 2 + 2) * 127 + 128)
        local b = math.floor(math.sin((globals.RealTime()) * 2 + 4) * 127 + 128)
        rgb = { r, g, b };
        draw.Color(rgb[1], rgb[2], rgb[3], 255)
        draw.FilledRect(x, y + topbarSize, x + w, y + h);
        rgb = secondary_color[currentTheme];
        draw.Color(rgb[1], rgb[2], rgb[3], 255)
        draw.FilledRect(x, y + topbarSize + 5, x + w, y + h);
        rgb = text_color[currentTheme];
        draw.Color(rgb[1], rgb[2], rgb[3], 255);
        draw.SetFont(RabFonts.Verdana13400);
        if (vote_cool_down == 0) then
            remainingTime = "N/A"
        end
        draw.Text(x + 5, (y + topbarSize) + 5, "Remaining Time: " .. remainingTime)
        draw.Text(x + 5, (y + topbarSize) + 20, "Team to join back in: " .. (last_team_in == 2 and "T" or last_team_in == 3 and "CT" or "N/A"))
    end
end)