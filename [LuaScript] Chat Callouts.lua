local SetVis = gui.Reference('MISC', "AUTOMATION", "Other");
local enabled = gui.Checkbox(SetVis, "rab_chat_callouts_enabled", "Chat Callouts", false);
local callouts = {};
local last_msg = globals.TickCount();

callbacks.Register("DrawESP", function(e)
    local en, lp = e:GetEntity(), entities.GetLocalPlayer();
    if (enabled:GetValue() ~= true or en:GetTeamNumber() == lp:GetTeamNumber() or en:IsAlive() ~= true or en:IsPlayer() ~= true) then return end;
    local enName = en:GetName();
    local enLoc = en:GetPropString('m_szLastPlaceName');
    local shouldAdd = true;
    for index, callout in pairs(callouts) do
        local eName = callout[1];
        local eLoc = callout[2];
        if (eName == enName) then
            if (eLoc ~= enLoc) then
                callouts[index] = { enName, enLoc, true }
            end
            shouldAdd = false;
        end
    end
    if (shouldAdd) then table.insert(callouts, { enName, enLoc, true }); end;
end);

callbacks.Register("Draw", function()
    if (enabled:GetValue() ~= true or #callouts <= 0) then return end;
    for index, callout in pairs(callouts) do
        local eName = callout[1];
        local eLoc = callout[2];
        local isActive = callout[3];
        if (isActive and (globals.TickCount() - last_msg > 250)) then
            client.ChatSay(eName .. " Was last spotted In " .. addSpace(eLoc));
            callouts[index] = { eName, eLoc, fade_multiplier }
            last_msg = globals.TickCount();
        end
    end
end)

callbacks.Register("FireGameEvent", function(e)
    local en = e:GetName()
    if (enabled:GetValue() ~= true or #callouts <= 0) then return end;
    if (en == "game_start" or en == "round_start" or en == "round_end") then callouts = {} end
end)

function addSpace(str)
    local sb = {}
    for each in str:gmatch("[A-Z][^A-Z]*") do table.insert(sb, each .. " ") end
    return table.concat(sb)
end