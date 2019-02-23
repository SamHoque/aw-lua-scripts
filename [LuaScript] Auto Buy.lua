local ref = gui.Reference("MISC", "AUTOMATION", "Other");
local showMenu = gui.Checkbox(ref, "rab_autobuy_showmenu", "Show Auto Buy Menu", false);
local menuPressed = 1;
local primaryWeapons = {
    { "SCAR 20 | G3SG1", "scar20" };
    { "SG 008", "ssg08" };
    { "AWP", "awp" };
    { "G3 SG1 | AUG", "sg556" };
    { "AK 47 | M4A1", "ak47" };
};
local secondaryWeapons = {
    { "Dual Elites", "elite" };
    { "Desert Eagle | R8 Revolver", "deagle" };
    { "Five Seven | Tec 9", "tec9" };
    { "P250", "p250" };
};
local armors = {
    { "None", nil, nil };
    { "Kevlar Vest", "vest", nil };
    { "Kevlar Vest + Helmet", "vest", "vesthelm" };
};
local granades = {
    { "Off", nil, nil };
    { "Grenade", "hegrenade", nil };
    { "Flashbang", "flashbang", nil };
    { "Smoke Grenade", "smokegrenade", nil };
    { "Decoy Grenade", "decoy", nil };
    { "Molotov | Incindiary Grenade", "molotov", "incgrenade" };
};
local mainWindow = gui.Window("rab_autobuy", "Auto Buy", 200, 200, 250, 530);
local autoBuyGroup = gui.Groupbox(mainWindow, "Settings", 15, 15, 220, 456);
local enabled = gui.Checkbox(autoBuyGroup, "rab_autobuy_masterswitch", "Enabled Auto Buy", false);
local printLogs = gui.Checkbox(autoBuyGroup, "rab_autobuy_printlogs", "Print Logs To Aimware Console", false);
local primaryWeaponSelection = gui.Combobox(autoBuyGroup, "rab_autobuy_primary_weapon", "Primary Weapon", primaryWeapons[1][1], primaryWeapons[2][1], primaryWeapons[3][1], primaryWeapons[4][1], primaryWeapons[5][1]);
local secondaryWeaponSelection = gui.Combobox(autoBuyGroup, "rab_autobuy_secondary_weapon", "Secondary Weapon", secondaryWeapons[1][1], secondaryWeapons[2][1], secondaryWeapons[3][1], secondaryWeapons[4][1]);
local armorSelection = gui.Combobox(autoBuyGroup, "rab_autobuy_armor", "Armor", armors[1][1], armors[2][1], armors[3][1]);
local granadeSlot1 = gui.Combobox(autoBuyGroup, "rab_autobuy_grenade_slot_1", "Grenade Slot #1", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1]);
local granadeSlot2 = gui.Combobox(autoBuyGroup, "rab_autobuy_grenade_slot_2", "Grenade Slot #2", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1]);
local granadeSlot3 = gui.Combobox(autoBuyGroup, "rab_autobuy_grenade_slot_3", "Grenade Slot #3", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1]);
local granadeSlot4 = gui.Combobox(autoBuyGroup, "rab_autobuy_grenade_slot_4", "Grenade Slot #4", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1]);
local taser = gui.Checkbox(autoBuyGroup, "rab_autobuy_taser", "Buy Taser", false);
local defuseKit = gui.Checkbox(autoBuyGroup, "rab_autobuy_defusekit", "Buy Defuse Kit", false);
gui.Text(mainWindow, "Auto Buy - Made By Rab(SamzSakerz#4758)");

local function buy(wat)
    if (wat == nil) then return end;
    if (printLogs) then
        print('Bought x1 ' .. wat);
    end;
    client.Command('buy "' .. wat .. '";', true);
end


local function buyTable(table)
    for i, j in pairs(table) do
        buy(j);
    end;
end

local function buyWeapon(selection, table)
    local selection = selection:GetValue();
    local weaponToBuy = table[selection + 1][2];
    buy(weaponToBuy);
end

local function buyGrenades(selections)
    for k, selection in pairs(selections) do
        local selection = selection:GetValue();
        local grenadeTable = granades[selection + 1];
        buyTable({ grenadeTable[2], grenadeTable[3] });
    end
end

callbacks.Register('FireGameEvent', function(e)
    if (enabled:GetValue() ~= true) then return end;
    local localPlayer = entities.GetLocalPlayer();
    local en = e:GetName();
    if (localPlayer == nil or en ~= "player_spawn") then return end;
    local userIndex = client.GetPlayerIndexByUserID(e:GetInt('userid'));
    local localPlayerIndex = localPlayer:GetIndex();
    if (userIndex ~= localPlayerIndex) then return end;
    buyWeapon(primaryWeaponSelection, primaryWeapons);
    buyWeapon(secondaryWeaponSelection, secondaryWeapons);
    local armorSelected = armorSelection:GetValue();
    local armorTable = armors[armorSelected + 1];
    buyTable({ armorTable[2], armorTable[3] });
    if (defuseKit:GetValue()) then
        buy('defuser');
    end
    if (taser:GetValue()) then
        buy('taser');
    end
    buyGrenades({ granadeSlot1, granadeSlot2, granadeSlot3, granadeSlot4 });
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
end);

client.AllowListener("player_spawn");