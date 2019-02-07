local chromatab = gui.Window("rab_chroma", "Chroma Lines", 200, 200, 250, 360);
local linegroup = gui.Groupbox(chromatab, "Settings", 13, 13, 230, 300);
local enable = gui.Checkbox(linegroup, "rab_enable_line", "Enable", 0);
local line_mode = gui.Combobox(linegroup, "rab_line_mode", "Color", "Chroma", "Custom Hex");
local line_thickness = gui.Slider(linegroup, "rab_line_thickness", "Thickness", 5, 1, 50);
gui.Text(linegroup, "Hex value");
local hexInput = gui.Editbox(linegroup, "rab_hex_input", "f62222");
local line_alpha = gui.Slider(linegroup, "rab_line_alpha", "Line Alpha", 255, 0, 255);
local line_chroma_speed = gui.Slider(linegroup, "rab_line_chroma_speed", "Chroma Speed", 1, 1, 10);
local menuPressed = 1;

function drawLine()
    if input.IsButtonPressed(gui.GetValue("msc_menutoggle")) then
        menuPressed = menuPressed == 0 and 1 or 0
    end
    chromatab:SetActive(menuPressed);

    local screenSize = draw.GetScreenSize();
    local whichMode = line_mode:GetValue();
    local isRainbow = whichMode == 0;
    local thickness = line_thickness:GetValue();
    local alpha = line_alpha:GetValue();
    if enable:GetValue() then
        if (isRainbow) then
            local rgb = getFadeRGB(line_chroma_speed:GetValue())
            draw.Color(rgb[1], rgb[2], rgb[3], alpha);
            draw.FilledRect(0, 0, screenSize, thickness);
        elseif (not isRainbow) then
            local rgb = updateHexInputRGB();
            draw.Color(math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]), alpha);
            draw.FilledRect(0, 0, screenSize, thickness);
        end
    end
end

function getFadeRGB(speed)
    local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
    local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
    local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
    return { r, g, b };
end


function updateHexInputRGB()
    local hex = hexInput:GetValue();
    hex = hex:gsub("#", "");
    local validHex = validHexColor(hex);
    local rgb = {};
    if (validHex == not nil) then
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
    end
end

function validHexColor(color)
    return nil ~= (color:find("^%x%x%x%x%x%x$") or color:find("^%x%x%x$"));
end

callbacks.Register('Draw', 'chroma_rab_draw', drawLine);