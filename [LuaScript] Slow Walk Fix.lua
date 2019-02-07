autostop_keys = {
    "rbot_autosniper_autostop",
    "rbot_sniper_autostop",
    "rbot_scout_autostop",
    "rbot_revolver_autostop",
    "rbot_pistol_autostop",
    "rbot_smg_autostop",
    "rbot_rifle_autostop",
    "rbot_shotgun_autostop",
    "rbot_lmg_autostop",
    "rbot_shared_autostop"
}
local menuPressed = 1;
autostop_user_saved_values = {}
for i = 1, #autostop_keys do
    autostop_user_saved_values[i] = gui.GetValue(autostop_keys[i]);
end

local mam = gui.Reference("MISC", "AUTOMATION", "Movement");
local showMenu = gui.Checkbox(mam, "rab_slowwalkfix_show", "Show SlowWalk Fix Menu", false);
local mainWindow = gui.Window("rab_slowwalkfix", "SlowWalk Fix", 200, 200, 220, 460);
local settings = gui.Groupbox(mainWindow, "Settings", 13, 13, 190, 385);
local enabled = gui.Checkbox(settings, "rab_slowwalkfix_enable", "Enable SlowWalk Fix", false);

local bgtypeVarNames = { "rab_slowwalkfix_primarybg_type", "rab_slowwalkfix_secondarybg_type" };
local bgHexVarNames = { "rab_slowwalkfix_primarybg_hex", "rab_slowwalkfix_secondarybg_hex" };
local bgChromaSpeedVarNames = { "rab_slowwalkfix_primarybg_chroma_speed", "rab_slowwalkfix_secondarybg_chroma_speed" };

function addBgColorOption(bgTypeVarname, wat, bgHexVarName, bgChromaSpeedVarName, def)
    gui.Combobox(settings, bgTypeVarname, wat .. " Background Type", "Static", "Chroma");
    gui.Text(settings, "Hex Value");
    gui.Editbox(settings, bgHexVarName, def)
    gui.Slider(settings, bgChromaSpeedVarName, "Chroma Speed", 1, 1, 10)
end

addBgColorOption(bgtypeVarNames[1], "Primary", bgHexVarNames[1], bgChromaSpeedVarNames[1], "100000")
addBgColorOption(bgtypeVarNames[2], "Secondary", bgHexVarNames[2], bgChromaSpeedVarNames[2], "96b901")
gui.Text(settings, "Text Color Hex Value");
gui.Editbox(settings, "rab_slowalk_textcolor", "ffffff")
gui.Text(mainWindow, "SlowWalk Fix - Made by Rab")

callbacks.Register("Draw", function()
    if input.IsButtonPressed(gui.GetValue("msc_menutoggle")) then
        menuPressed = menuPressed == 0 and 1 or 0;
    end
    if (showMenu:GetValue()) then
        mainWindow:SetActive(menuPressed);
    else
        mainWindow:SetActive(0);
    end
    local slowWalkBind = gui.GetValue("msc_slowwalk");
    if (slowWalkBind == nil or slowWalkBind == 0) then return end
    local lPlayer = entities.GetLocalPlayer();
    if (lPlayer == nil) then return end
    local slowWalkEnabled = input.IsButtonDown(slowWalkBind);
    for i = 1, #autostop_keys do
        if slowWalkEnabled and lPlayer:IsAlive() and enabled:GetValue() then
            local text = "SlowWalk Fix Enabled"
            local textWidth, textHeight = draw.GetTextSize(text);
            local top = 590
            drawColor(bgtypeVarNames[2], bgHexVarNames[2], bgChromaSpeedVarNames[2], {150, 185, 1})
            draw.FilledRect(0, top, textWidth + 30, top + textHeight + 20);
            drawColor(bgtypeVarNames[1], bgHexVarNames[1], bgChromaSpeedVarNames[1], {16, 0, 0})
            draw.FilledRect(0, top, textWidth + 20, top + textHeight + 20);
            local rgb = getHexInput("rab_slowalk_textcolor")
            draw.Color(rgb[1], rgb[2], rgb[3], 255);
            draw.Text(10, top + 10, text);
            gui.SetValue(autostop_keys[i], 0);
        else
            gui.SetValue(autostop_keys[i], autostop_user_saved_values[i])
        end
    end
end)

function drawColor(selection, hexInput, chromaSpeed, default)
    local rgb;
    if (gui.GetValue(selection) == 0) then
        rgb = getHexInput(hexInput, default);
    else
        rgb = getFadeRGB(gui.GetValue(chromaSpeed));
    end
    draw.Color(rgb[1], rgb[2], rgb[3], 255)
end

function getFadeRGB(speed)
    local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
    local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
    local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
    return {r, g, b};
end

function getHexInput(hexInput, default)
    local hex = gui.GetValue(hexInput);
    hex = hex:gsub("#", "");
    local validHex = validHexColor(hex);
    if (validHex == nil) then validHex = "f62222" end;
    local rgb = {};
    if hex:len() == 3 then
        rgb[1] = (tonumber("0x" .. hex:sub(1, 1) .. hex:sub(1, 1)));
        rgb[2] = (tonumber("0x" .. hex:sub(2, 2) .. hex:sub(2, 2)));
        rgb[3] = (tonumber("0x" .. hex:sub(3, 3) .. hex:sub(3, 3)));
        return rgb;
    elseif (hex:len() == 6) then
        rgb[1] = (tonumber("0x" .. hex:sub(1, 2)));
        rgb[2] = (tonumber("0x" .. hex:sub(3, 4)));
        rgb[3] = (tonumber("0x" .. hex:sub(5, 6)));
        return rgb;
    end;
    return default
end

function validHexColor(color)
    return nil ~= (color:find("^%x%x%x%x%x%x$") or color:find("^%x%x%x$"));
end