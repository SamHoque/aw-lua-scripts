callbacks.Register('FireGameEvent', function(e)
    local en = e:GetName();
    if (en ~= "player_death") then return; end
    local i = entities.GetLocalPlayer():GetIndex();
    local k = entities.GetPlayerResources():GetPropInt("m_iKills", i);
    local d = entities.GetPlayerResources():GetPropInt("m_iDeaths", i);
    if (k < d) then client.Command('rs', true) end;
end);