local svgData = http.Get("https://rab.wtf/csgo/aimware/lol_kill_img.svg");
local imgRGBA, imgWidth, imgHeight = common.RasterizeSVG(svgData);
local texture = draw.CreateTexture(imgRGBA, imgWidth, imgHeight);
local font = draw.CreateFont("BeaufortforLOL-Bold", 100, 100);
local kill_messages = { "DOUBLE KILL", "TRIPLE KILL", "QUADRA KILL", "PENTA KILL" };
local kill_table = {};
local kills, last_kill = 0, 0;

local function getKillMessageForKill(kill)
    local killmessage = kill_messages[kill];
    if (killmessage == nil) then killmessage = "" end;
    return killmessage .. '!';
end

local function playSoundForKill(kill)
    local killmessage = kill_messages[kill];
    if (killmessage == nil) then return end;
    local soundFile = string.lower(killmessage);
    soundFile = soundFile:gsub(" ", "_")
    print("soundFile: " .. soundFile);
    client.Command("playvol *rab_lol/" .. soundFile .. ".mp3 1", true);
end

callbacks.Register('FireGameEvent', function(e)
    local en = e:GetName();
    if (en == "round_start" or en == "game_start") then kills = 0; end;
    if (en ~= "player_death") then return end;
    local user = entities.GetByUserID(e:GetInt('userid'));
    local localPlayer = entities.GetLocalPlayer();
    if (user ~= nil) then
        if (localPlayer:GetIndex() == user:GetIndex()) then kills = 0; end;
    end;
    local attacker = entities.GetByUserID(e:GetInt('attacker'));
    if (attacker == nil) then return end;
    if (localPlayer:GetIndex() == attacker:GetIndex()) then
        if (kills > 10) then kills = 0 end;
        kills = kills + 1;
        if ((globals.RealTime()) > last_kill) then
            kills = 0;
        end;
        last_kill = globals.RealTime() + 3;
        kill_table[1] = { kills, globals.RealTime() + 3, false };
    end;
end);

callbacks.Register("Draw", function()
    local w, h = draw.GetScreenSize();
    local x = (w - imgWidth) / 2;
    local y = (h - imgHeight) / 4;
    if (kills == 0 or kills > 5 or #kill_table == 0) then return end;
    local kill = kill_table[1];
    if (globals.RealTime() > kill[2]) then
        table.remove(kill_table, 1);
        return;
    end;
    local text = getKillMessageForKill(kills);
    if (text == "!") then return end;
    if (kill[3] ~= true) then
        playSoundForKill(kills);
        kill_table[1] = { kill[1], kill[2], true };
    end;
    draw.SetTexture(texture);
    draw.FilledRect(x, y, x + imgWidth, y + imgHeight);
    draw.SetFont(font);
    local tw, th = draw.GetTextSize(text);
    draw.Color(196, 166, 116, 255);
    draw.TextShadow(((w - imgWidth)) / 2, ((h - imgHeight) + th) / 3, text)
end);


client.AllowListener('player_death');