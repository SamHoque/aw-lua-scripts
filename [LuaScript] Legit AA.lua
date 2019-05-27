--[=====[
     Legit Anti-Aim Made by Rab(SamzSakerz#4758)
             __        __
            |__)  /\  |__)
            |  \ /~~\ |__)
       __   __   ___      ___  ___
      /  ` |__) |__   /\   |  |__
      \__, |  \ |___ /~~\  |  |___
               ___  __           ___     ___
|  | |__|  /\   |  /__`    |\ | |__  \_/  |
|/\| |  | /~~\  |  .__/    | \| |___ / \  |

--]=====]

local direction = true;
local iconFont = draw.CreateFont('Marlett', 45, 700);
local antiAimRef = gui.Reference('LEGIT', 'Extra');
gui.Text(antiAimRef, "                      Legit Anti Aim");
local right = gui.Keybox(antiAimRef, 'lbot_legitaa_right', 'Right Key', 0);
local left = gui.Keybox(antiAimRef, 'lbot_legitaa_left', 'Left Key', 0);

local function isButtonDown(key)
    return key > 0 and input.IsButtonDown(key);
end

local func = function()
    local lp = entities.GetLocalPlayer();
    if (lp == nil or not lp:IsAlive()) then
        return
    end

    -- Update Values
    local lbot_key = gui.GetValue('lbot_key')
    gui.SetValue('rbot_active', not ((lbot_key > 0 and input.IsButtonPressed(lbot_key)) or isButtonDown(lbot_key)));

    if isButtonDown(left:GetValue()) then
        direction = true;
    end
    if isButtonDown(right:GetValue()) then
        direction = false;
    end

    -- Update Desync
    local w, h = draw.GetScreenSize();
    local desyncValue = direction and 2 or 3;
    gui.SetValue('rbot_antiaim_stand_desync', desyncValue);
    gui.SetValue('rbot_antiaim_move_desync', desyncValue);
    draw.SetFont(iconFont);
    draw.Color(249, 0, 0, 255);
    draw.Text(w / 2 + (direction and -100 or 60), h / 2, direction and '4' or '3');
    draw.TextShadow(w / 2 + (direction and -100 or 60), h / 2, direction and '4' or '3');

    -- Update Values
    for _, v in ipairs({
        { 'at_targets', 0 },
        { 'autodir', 0 },
        { 'move_pitch_real', 0 },
        { 'move_real_add', -180 },
        { 'stand_pitch_real', 0 },
        { 'stand_real', 1 },
        { 'stand_velocity', 250 },
        { 'stand_real_add', -180 },
    }) do
        gui.SetValue('rbot_antiaim_' .. v[1], v[2]);
    end
end

callbacks.Register('Draw', func);