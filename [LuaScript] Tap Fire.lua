--[=====[
    Tap Fire Made by Rab(SamzSakerz#4758)
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

local ref = gui.Reference('LEGIT', 'Triggerbot');
local tapfireKey, lastShot, tapFireDelay = gui.Keybox(ref, 'rab_tapfire_key', 'TapFire Key', 0), 0,
gui.Slider(ref, 'rab_tapfire_delay', 'TapFire Delay', 40, 1, 100);

callbacks.Register('CreateMove', function(UserCmd)
    local key = tapfireKey:GetValue();
    if (key > 0 and input.IsButtonDown(key) and lastShot < globals.RealTime()) then
        UserCmd:SetButtons(UserCmd:GetButtons() | (1 << 0));
        local delay = tapFireDelay:GetValue();
        lastShot = globals.RealTime() + delay / 100;
    end
end);