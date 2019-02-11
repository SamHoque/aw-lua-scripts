local showMenu = gui.Checkbox(gui.Reference("VISUALS", "MISC", "Yourself Extra"), "rab_advanced_chams_menu", "Show Advanced Chroma Menu", false)
local mainWindow = gui.Window("rab_advanced_chams", "Advanced Chroma", 200, 200, 682, 700);
local chamsgroup = gui.Groupbox(mainWindow, "Settings", 13, 13, 655, 620);
local masterSwitch = gui.Checkbox(chamsgroup, "rab_advanced_chams_masterswitch", "Master Switch", false);
local menuPressed = 1;
local checkboxVarNames = { "rab_pmodal_masterswitch", "rab_hands_masterswitch", "rab_weapons_masterswitch", "rab_ghost_masterswitch", "rab_glow_masterswitch", "rab_crosshair_masterswitch" };
local comboBoxVarNames = { "rab_select_mod_playermodal", "rab_select_mod_hands", "rab_select_mod_weapons", "rab_select_mod_ghost", "rab_select_mod_glow", "rab_select_mod_crosshair" };
local editboxVarNames = { "rab_pmodal_hex_input", "rab_hands_hex_input", "rab_weapons_hex_input", "rab_ghost_hex_input", "rab_glow_hex_input", "rab_crosshair_hex_input" };
local chromaSpeedVarNames = { "rab_pmodal_chroma_speed", "rab_hands_chroma_speed", "rab_weapons_chroma_speed", "rab_ghost_chroma_speed", "rab_glow_chroma_speed", "rab_crosshair_chroma_speed" };
local alphaVarNames = { "rab_chams_alpha_playermodal", "rab_chams_alpha_hands", "rab_chams_alpha_weapons", "rab_chams_alpha_ghost", "rab_chams_alpha_glow", "rab_chams_alpha_crosshair" };
local enablePulsatingVarNames = { "rab_pmodal_pulsating_masterswitch", "rab_hands_pulsating_masterswitch", "rab_weapons_pulsating_masterswitch", "rab_ghost_pulsating_masterswitch", "rab_glow_pulsating_masterswitch", "rab_crosshair_pulsating_masterswitch" };
local pulsatingSpeedVarNames = { "rab_pmodal_pulsating_speed", "rab_hands_pulsating_speed", "rab_weapons_pulsating_speed", "rab_ghost_pulsating_speed", "rab_glow_pulsating_speed", "rab_crosshair_pulsating_speed" };


local function getMenuItems(checkBoxVarName, comboBoxVarName, editBoxVarName, chromaSpeedSliderVarName, alphaSliderVarName, enablePulsatingVarName, pulsatingSpeedVarName)
    local menuItems = {};
    menuItems[1] = { "checkbox", checkBoxVarName, "Enable", { true } };
    menuItems[2] = { "combobox", comboBoxVarName, "Modification Type", { "Chroma", "Static" } };
    menuItems[3] = { "text", "Hex Value" };
    menuItems[4] = { "editbox", editBoxVarName, "f62222" };
    menuItems[5] = { "slider", chromaSpeedSliderVarName, "Chroma Speed", { 1, 1, 10 } };
    menuItems[6] = { "slider", alphaSliderVarName, "Alpha", { 255, 0, 255 } };
    menuItems[7] = { "checkbox", enablePulsatingVarName, "Enable Pulsating", { false } };
    menuItems[8] = { "slider", pulsatingSpeedVarName, "Pulsating Speed", { 1, 1, 10 } };
    return menuItems;
end

local function addMenuToGui(menus)
    for i = 1, #menus do
        local menu = menus[i];
        local menuWindow = menu[1];
        local menuName = menu[2];
        local menuPaddingLeft = menu[3];
        local menuPaddingTop = menu[4];
        local menuWidth = menu[5];
        local menuHeight = menu[6];
        local menuItems = menu[7];
        local menuGroup = gui.Groupbox(menuWindow, menuName, menuPaddingLeft, menuPaddingTop, menuWidth, menuHeight);
        for i2 = 1, #menuItems do
            local menuItem = menuItems[i2];
            local menuItemType = menuItem[1];
            local menuItemVarName = menuItem[2];
            local menuItemName;
            if (#menuItem >= 3) then menuItemName = menuItem[3] end;
            local menuItemValues;
            if (#menuItem >= 4) then menuItemValues = menuItem[4] end;
            if (menuItemType == "combobox") then
                gui.Combobox(menuGroup, menuItemVarName, menuItemName, menuItemValues[1], menuItemValues[2]);
            elseif (menuItemType == "slider") then
                gui.Slider(menuGroup, menuItemVarName, menuItemName, menuItemValues[1], menuItemValues[2], menuItemValues[3]);
            elseif (menuItemType == "checkbox") then
                gui.Checkbox(menuGroup, menuItemVarName, menuItemName, menuItemValues[1]);
            elseif (menuItemType == "editbox") then
                gui.Editbox(menuGroup, menuItemVarName, menuItemName);
            elseif (menuItemType == "text") then
                gui.Text(menuGroup, menuItemVarName);
            end;
        end
    end
end

local function getMenuItemsForID(id)
    return getMenuItems(checkboxVarNames[id], comboBoxVarNames[id], editboxVarNames[id], chromaSpeedVarNames[id], alphaVarNames[id], enablePulsatingVarNames[id], pulsatingSpeedVarNames[id])
end

local pModalMenu = { chamsgroup, "Player Model", 0, 30, 200, 265, getMenuItemsForID(1) };

local handsMenu = { chamsgroup, "Hands", 0, 310, 200, 265, getMenuItemsForID(2) };

local weaponMenu = { chamsgroup, "Weapons", 210, 30, 200, 265, getMenuItemsForID(3) };

local ghostMenu = { chamsgroup, "Ghost", 210, 310, 200, 265, getMenuItemsForID(4) };

local glowMenu = { chamsgroup, "Glow", 420, 30, 200, 265, getMenuItemsForID(5) };

local crosshairMenu = { chamsgroup, "Crosshair", 420, 310, 200, 265, getMenuItemsForID(6) };

addMenuToGui({ pModalMenu, handsMenu, weaponMenu, ghostMenu, glowMenu, crosshairMenu })

gui.Text(mainWindow, "Advanced Chroma - Made by Rab");

local function getChamsVar(i)
    if (i == 1) then
        return { { "clr_chams_ct_vis", "v" }, { "clr_chams_t_vis", "v" } };
    elseif (i == 2) then
        return { { "clr_chams_hands_primary", "v" }, { "clr_chams_hands_primary", "v" } };
    elseif (i == 3) then
        return { { "clr_chams_weapon_primary", "v" }, { "clr_chams_weapon_secondary", "v" } };
    elseif (i == 4) then
        return { { "clr_chams_ghost_client", "v" }, { "clr_chams_ghost_server", "v" }, { "clr_chams_historyticks", "v" } };
    elseif (i == 5) then
        return { { "vis_glowalpha", "sf" }, { "clr_esp_box_ct_vis", "v" }, { "clr_esp_box_t_vis", "v" }, { "clr_esp_box_ct_invis", "v" }, { "clr_esp_box_t_invis", "v" } };
    elseif (i == 6) then
        return { { "clr_esp_crosshair", "v" }, { "clr_esp_crosshair_recoil", "v" }, { "clr_misc_hitmarker", "v" } };
    end;
end

local function getPulsateAlpha(speed)
    return math.floor(math.abs(math.sin(globals.CurTime() * speed) * 255));
end

local function getFadeRGB(speed)
    local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
    local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
    local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
    return { r, g, b };
end

local function validHexColor(color)
    return nil ~= (color:find("^%x%x%x%x%x%x$") or color:find("^%x%x%x$"));
end

local function getHexInput(hexInput)
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
    return { 255, 0, 0 }
end

local function setChromaValue(keys, alpha, speed)
    for i = 1, #keys do
        local rgb = getFadeRGB(gui.GetValue(speed));
        local key = keys[i];
        local var = key[1];
        local wat = key[2];
        if (wat == "v") then
            gui.SetValue(var, rgb[1], rgb[2], rgb[3], math.floor(alpha));
        elseif (wat == "sf") then
            gui.SetValue(var, alpha / 255);
        end
    end
end

local function setGuiValues(keys, rgb, alpha)
    for i = 1, #keys do
        local key = keys[i];
        local var = key[1];
        local wat = key[2];
        if (wat == "v") then
            gui.SetValue(var, rgb[1], rgb[2], rgb[3], math.floor(alpha));
        elseif (wat == "sf") then
            gui.SetValue(var, alpha / 255);
        end
    end
end

local function drawChams(enabled, selection, chamsVars, alpha, hexInput, pulsating, pulsatingSpeed, chromaSpeed)
    if (gui.GetValue(enabled)) then
        local shouldPulsate = gui.GetValue(pulsating);
        local alphaValue = gui.GetValue(alpha);
        if (shouldPulsate) then
            alphaValue = getPulsateAlpha(gui.GetValue(pulsatingSpeed));
        end
        if (gui.GetValue(selection) == 0) then
            setChromaValue(chamsVars, alphaValue, chromaSpeed);
        else
            setGuiValues(chamsVars, getHexInput(hexInput), alphaValue);
        end
    end
end

callbacks.Register('Draw', function()
    if input.IsButtonPressed(gui.GetValue("msc_menutoggle")) then
        menuPressed = menuPressed == 0 and 1 or 0;
    end
    if (showMenu:GetValue()) then
        mainWindow:SetActive(menuPressed);
    else
        mainWindow:SetActive(0);
    end
    if (not masterSwitch:GetValue()) then return end
    for i = 1, #checkboxVarNames do
        drawChams(checkboxVarNames[i], comboBoxVarNames[i], getChamsVar(i), alphaVarNames[i], editboxVarNames[i], enablePulsatingVarNames[i], pulsatingSpeedVarNames[i], chromaSpeedVarNames[i])
    end
end);