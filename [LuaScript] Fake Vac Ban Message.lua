local gui_reference = gui.Reference("MISC", "General", "Main");
gui.Text(gui_reference, "Fake Vac Name");
local nameChanger = gui.Editbox(gui_reference, "rab_vac_fake_name", "");
local WAIT_FOR_NAMESTEALER = 2;
local old_name = "";
local is_waiting = false;
local wait = 0;
callbacks.Register("Draw", function()
    if nameChanger:GetValue() ~= old_name then
        gui.SetValue("msc_namestealer_enable", 1);
        gui.SetValue("msc_namestealer_interval", 5);
        old_name = nameChanger:GetValue();
        wait = WAIT_FOR_NAMESTEALER;
        is_waiting = true;
    end
    if is_waiting == true and wait > 0 then
        wait = wait - globals.FrameTime()
    elseif is_waiting == true then
        is_waiting = false
        wait = 0
        local new_name_entered = nameChanger:GetValue();
        local new_name = " \x01\x0B";
        if (new_name_entered ~= nil and new_name_entered ~= "") then
            new_name = string.char(32, 1, 11);
            old_name = nameChanger:GetValue();
            new_name = new_name .. string.char(15) .. nameChanger:GetValue() .. ' has been permanently banned from official CS:GO servers.';
            while (#new_name < 400) do
                new_name = new_name .. '\nᅠ';
            end
        end
        new_name = new_name .. "\x01";
        client.SetConVar("name", new_name, false)
        gui.SetValue("msc_namestealer_enable", 0)
        gui.SetValue("msc_namestealer_interval", 0)
    end
end)