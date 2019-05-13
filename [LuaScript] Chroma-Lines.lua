local window = gui.Window('rab_chroma_lines', 'Chroma Lines', 200, 200, 255, 260);
local frame = gui.Groupbox(window, 'Settings', 13, 13, 230, 200);

local UI = {
    show = 1;
    enable = gui.Checkbox(frame, 'rab_enable_chroma_line', 'Enable', 0);
    mode = gui.Combobox(frame, 'rab_chroma_lines_mode', 'Color Mode', 'Static Color', 'Chroma');
    color = gui.ColorEntry('rab_chroma_lines_color', 'Chroma Line Color', 246, 32, 32, 255);
    thickness = gui.Slider(frame, 'rab_chroma_lines_thickness', 'Thickness', 5, 1, 50);
    speed = gui.Slider(frame, 'rab_chroma_lines_speed', 'Chroma Speed', 1, 1, 10);
}

local function getFadeRGB(speed)
    local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
    local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
    local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
    return r, g, b;
end

callbacks.Register('Draw', function()
    if input.IsButtonPressed(gui.GetValue('msc_menutoggle')) then
        UI.show = UI.show == 0 and 1 or 0
    end
    window:SetActive(UI.show);
    if (UI.enable:GetValue() ~= true) then
        return
    end

    local r, g, b, a = UI.color:GetValue();
    if (UI.mode:GetValue() == 1) then
        r, g, b = getFadeRGB(UI.speed:GetValue());
    end
    draw.Color(r, g, b, a);
    draw.FilledRect(0, 0, draw.GetScreenSize(), UI.thickness:GetValue());
end);