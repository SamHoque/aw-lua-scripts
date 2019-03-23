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
local a=draw.CreateFont('Marlett',45,700)local b=true;local c=gui.Reference('RAGE','Main','Anti-aim main')local d=gui.Checkbox(c,'rab_legitaa_enable','Legit AA',false)local e=gui.Keybox(c,'rbot_legitaa_right','Right Key',0)local f=gui.Keybox(c,'rbot_legitaa_left','Left Key',0)local function g(h)if h~=0 then return input.IsButtonDown(h)end end;local function i()if g(f:GetValue())then b=true end;if g(e:GetValue())then b=false end end;local function j()local k,l=draw.GetScreenSize()local m=b and 2 or 3;gui.SetValue('rbot_antiaim_stand_desync',m)gui.SetValue('rbot_antiaim_move_desync',m)draw.SetFont(a)draw.Color(249,0,0,255)draw.Text(k/2+(b and 60 or-100),l/2,b and'4'or'3')draw.TextShadow(k/2+(b and 60 or-100),l/2,b and'4'or'3')end;local function n()local o={{'at_targets',0},{'autodir',0},{'move_pitch_real',0},{'move_real_add',-180},{'stand_pitch_real',0},{'stand_real',1},{'stand_velocity',250},{'stand_real_add',-180}}for p,q in ipairs(o)do gui.SetValue('rbot_antiaim_'..q[1],q[2])end end;callbacks.Register('Draw',function()if d:GetValue()then i()j()n()end end)