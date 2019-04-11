local ref = gui.Reference("MISC", "AUTOMATION", "Other");
local showMenu = gui.Checkbox(ref, "rab_autobuy_showmenu", "Show Auto Buy Menu", false);
local menuPressed = 1;
local primaryWeapons = {
    {"None", nil};
    { "SCAR 20 | G3SG1", "scar20" };
    { "SSG 008", "ssg08" };
    { "AWP", "awp" };
    { "G3 SG1 | AUG", "sg556" };
    { "AK 47 | M4A1", "ak47" };
};
local secondaryWeapons = {
    {"None", nil};
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
    { "None", nil, nil };
    { "Grenade", "hegrenade", nil };
    { "Flashbang", "flashbang", nil };
    { "Smoke Grenade", "smokegrenade", nil };
    { "Decoy Grenade", "decoy", nil };
    { "Molotov | Incindiary Grenade", "molotov", "incgrenade" };
};
local mainWindow = gui.Window("rab_autobuy", "Auto Buy", 200, 200, 250, 554);
local autoBuyGroup = gui.Groupbox(mainWindow, "Settings", 15, 15, 220, 480);
local enabled = gui.Checkbox(autoBuyGroup, "rab_autobuy_masterswitch", "Enabled Auto Buy", false);
local printLogs = gui.Checkbox(autoBuyGroup, "rab_autobuy_printlogs", "Print Logs To Aimware Console", false);
local concatCommand = gui.Checkbox(autoBuyGroup, "rab_autobuy_concat", "Concact Buy Command", false);
concatCommand:SetValue(true);
local primaryWeaponSelection = gui.Combobox(autoBuyGroup, "rab_autobuy_primary_weapon", "Primary Weapon", primaryWeapons[1][1], primaryWeapons[2][1], primaryWeapons[3][1], primaryWeapons[4][1], primaryWeapons[5][1], primaryWeapons[6][1]);
local secondaryWeaponSelection = gui.Combobox(autoBuyGroup, "rab_autobuy_secondary_weapon", "Secondary Weapon", secondaryWeapons[1][1], secondaryWeapons[2][1], secondaryWeapons[3][1], secondaryWeapons[4][1], secondaryWeapons[5][1]);
local armorSelection = gui.Combobox(autoBuyGroup, "rab_autobuy_armor", "Armor", armors[1][1], armors[2][1], armors[3][1]);
armorSelection:SetValue(2);
local granadeSlot1 = gui.Combobox(autoBuyGroup, "rab_autobuy_grenade_slot_1", "Grenade Slot #1", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1], granades[6][1]);
granadeSlot1:SetValue(1);
local granadeSlot2 = gui.Combobox(autoBuyGroup, "rab_autobuy_grenade_slot_2", "Grenade Slot #2", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1], granades[6][1]);
granadeSlot2:SetValue(3);
local granadeSlot3 = gui.Combobox(autoBuyGroup, "rab_autobuy_grenade_slot_3", "Grenade Slot #3", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1], granades[6][1]);
granadeSlot3:SetValue(5);
local granadeSlot4 = gui.Combobox(autoBuyGroup, "rab_autobuy_grenade_slot_4", "Grenade Slot #4", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1], granades[6][1]);
granadeSlot4:SetValue(2);
local taser = gui.Checkbox(autoBuyGroup, "rab_autobuy_taser", "Buy Taser", false);
local defuseKit = gui.Checkbox(autoBuyGroup, "rab_autobuy_defusekit", "Buy Defuse Kit", false);
gui.Text(mainWindow, "Auto Buy - Made By Rab(SamzSakerz#4758)");

local function getSingleTableItem(selection, table)
    return table[selection:GetValue() + 1][2];
end

local function getMultiTableItems(seletion, table)
    local table = table[seletion:GetValue() + 1];
    return { table[2], table[3] };
end

local function insertToTableNonNull(tableToInsertTo, table1)
    for i = 1, #table1 do
        local item = table1[i];
        if (item ~= nil) then
            table.insert(tableToInsertTo, item);
        end
    end
end

local function inserToTableBool(tableToInserTo, bool, itemToInsert)
    if (bool:GetValue()) then
        table.insert(tableToInserTo, itemToInsert);
    end
end

local function buy(items, concat)
    local buyCommand = '';
    for i = 1, #items do
        local item = items[i];
        if (concat) then
            buyCommand = buyCommand .. 'buy "' .. item .. '"; ';
        else
            if (printLogs:GetValue()) then
                print('Bought x1 ' .. item);
            end;
            client.Command('buy "' .. item .. '";', true);
        end;
    end;
    if (buyCommand ~= '') then
        if (printLogs:GetValue()) then
            print('Bought x' .. #items .. ' items');
        end;
        client.Command(buyCommand);
    end;
end

callbacks.Register('FireGameEvent', function(e)
    local lp, en, ui = entities.GetLocalPlayer(), e:GetName(), client.GetPlayerIndexByUserID(e:GetInt('userid'));
    if (enabled:GetValue() ~= true or lp == nil or en ~= "player_spawn" or ui ~= lp:GetIndex()) then return
    end;
    local stuffToBuy = {};
    table.insert(stuffToBuy, getSingleTableItem(primaryWeaponSelection, primaryWeapons))
    table.insert(stuffToBuy, getSingleTableItem(secondaryWeaponSelection, secondaryWeapons));
    insertToTableNonNull(stuffToBuy, getMultiTableItems(armorSelection, armors));
    inserToTableBool(stuffToBuy, defuseKit, 'defuser');
    insertToTableNonNull(stuffToBuy, getMultiTableItems(granadeSlot1, granades));
    insertToTableNonNull(stuffToBuy, getMultiTableItems(granadeSlot2, granades));
    insertToTableNonNull(stuffToBuy, getMultiTableItems(granadeSlot3, granades));
    insertToTableNonNull(stuffToBuy, getMultiTableItems(granadeSlot4, granades));
    inserToTableBool(stuffToBuy, taser, 'taser');
    buy(stuffToBuy, concatCommand:GetValue());
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