--Made by Rab(SamzSakerz#4758)
local mouseX, mouseY, x, y, dx, dy, w, h, menuPressed = 0, 0, 25, 660, 0, 0, 300, 50, 1;
local shouldDrag = false;
local font_main = draw.CreateFont("Trench", 22, 22);
local font_spec = draw.CreateFont("Arial", 20, 20);
local topbarSize = 25;
local ref = gui.Reference('MISC', "GENERAL", "Extra");
local showMenu = gui.Checkbox(ref, "rab_material_spec_list", "Show Material Spectators Menu", false);

--GUI Starts here
local mainWindow = gui.Window("rab_material_spec_list", "Material Spectators", 50, 50, 165, 180);
local settings = gui.Groupbox(mainWindow, "Settings", 13, 13, 140, 120);
local masterSwitch = gui.Checkbox(settings, "rab_material_spec_masterswitch", "Master Switch", false);
local theme = gui.Combobox(settings, "rab_material_spec_theme", "Theme", "Light", "Dark", "Amoled");
local hideBots = gui.Checkbox(settings, "rab_material_spec_hide_bots", "Hide Bots", false);
local primary_color = { { 255, 255, 255 }, { 33, 33, 33 }, { 0, 0, 0 } };
local secondary_color = { { 238, 238, 238 }, { 44, 44, 44 }, { 0, 0, 0 } }
local text_color = { { 0, 0, 0 }, { 255, 255, 255 }, { 255, 255, 255 } }

--This gets a player array of all the specatators that is specating our local player thanks to Cheeseot
local function getSpectators()
    local spectators = {};
    local lp = entities.GetLocalPlayer();
    if lp ~= nil then
        local players = entities.FindByClass("CCSPlayer");
        local specI = 1;
        for i = 1, #players do
            local player = players[i];
            if player ~= lp and player:GetHealth() <= 0 then
                local name = player:GetName();
                if player:GetPropEntity("m_hObserverTarget") ~= nil then
                    local playerindex = player:GetIndex();
                    local ping = entities.GetPlayerResources():GetPropInt("m_iPing", playerindex);
                    local shouldAdd = true;
                    if(ping == 0) then
                        if (hideBots:GetValue()) then
                            shouldAdd = false;
                        end
                    end
                        if name ~= "GOTV" and playerindex ~= 1 then
                            local target = player:GetPropEntity("m_hObserverTarget");
                            if target:IsPlayer() then
                                local targetindex = target:GetIndex();
                                local myindex = client.GetLocalPlayerIndex();
                                if lp:IsAlive() then
                                    if targetindex == myindex and shouldAdd then
                                        spectators[specI] = player;
                                        specI = specI + 1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return spectators;
end

--Adding this makes the top-bar draggable thanks to Ruppet.
local function dragFeature()
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
end

local function getFadeRGB(speed)
    local r = math.floor(math.sin((globals.RealTime()) * speed) * 127 + 128)
    local g = math.floor(math.sin((globals.RealTime()) * speed + 2) * 127 + 128)
    local b = math.floor(math.sin((globals.RealTime()) * speed + 4) * 127 + 128)
    return { r, g, b };
end

--This draws the nice looking material window designed and developed by Rab
local function drawWindow(spectators)
    local h = h + (spectators * 17);
    local currentTheme = theme:GetValue() + 1;
    local rgb = primary_color[currentTheme];
    draw.Color(rgb[1], rgb[2], rgb[3], 255)
    draw.FilledRect(x, y, x + w, y + h);
    rgb = text_color[currentTheme];
    draw.Color(rgb[1], rgb[2], rgb[3], 255);
    draw.SetFont(font_main);
    draw.Text(x + 10, y + topbarSize / 8, "Spectators")
    rgb = getFadeRGB(1);
    draw.Color(rgb[1], rgb[2], rgb[3], 255)
    draw.FilledRect(x, y + topbarSize, x + w, y + h);
    rgb = secondary_color[currentTheme];
    draw.Color(rgb[1], rgb[2], rgb[3], 255)
    draw.FilledRect(x, y + topbarSize + 5, x + w, y + h);
end

local function drawSpectators(spectators)
    for index, player in pairs(spectators) do
        draw.SetFont(font_spec);
        local currentTheme = theme:GetValue() + 1;
        local rgb = text_color[currentTheme];
        draw.Color(rgb[1], rgb[2], rgb[3], 255);
        draw.Text(x + 15, (y + topbarSize - 5) + (index * 17), player:GetName())
    end;
end

local function handleGUI()
    if input.IsButtonPressed(gui.GetValue("msc_menutoggle")) then
        menuPressed = menuPressed == 0 and 1 or 0;
    end
    if (showMenu:GetValue()) then
        mainWindow:SetActive(menuPressed);
    else
        mainWindow:SetActive(0);
    end
end

callbacks.Register("Draw", function()
    handleGUI();
    if (masterSwitch:GetValue() ~= true) then return end;
    dragFeature();
    local spectators = getSpectators();
    drawWindow(#spectators);
    drawSpectators(spectators);
end)