local pngData = http.Get("https://rab.wtf/csgo/aimware/victory_royale.png");
local imgRGBA, imgWidth, imgHeight = common.DecodePNG(pngData);
local texture = draw.CreateTexture(imgRGBA, imgWidth, imgHeight)
local alpha, delay = -1, -1;

callbacks.Register('FireGameEvent', function(e)
    local en = e:GetName();
    if (en ~= "round_end") then return end;
    local winner, localPlayer = e:GetInt("winner"), entities.GetLocalPlayer();
    local winner2 = entities.GetByUserID(winner);
    if (localPlayer ~= nil and (localPlayer:GetTeamNumber() == winner or (winner2 ~= nil and localPlayer:GetIndex() == winner2:GetIndex()))) then
        alpha, delay = 0, globals.RealTime() + 4;
        client.Command("playvol *victory_royale.mp3 1", true);
    end
end)

callbacks.Register("Draw", function()
    if (alpha == -1 and delay == -1) then return end;
    if (alpha == 0 and delay == -1) then alpha = -1 return end;
    if (alpha < 255 and delay ~= -1) then
        alpha = alpha + 1;
    end;
    if delay == -1 then
        alpha = alpha - 1
    end;
    if (globals.RealTime() > delay) then
        delay = -1;
    end;
    local w, h = draw.GetScreenSize();
    local x = (w - imgWidth) / 2;
    local y = (h - imgHeight) / 8;
    draw.Color(255, 255, 255, alpha);
    draw.SetTexture(texture);
    draw.FilledRect(x, y, x + imgWidth, y + imgHeight);
end);

client.AllowListener('round_end');