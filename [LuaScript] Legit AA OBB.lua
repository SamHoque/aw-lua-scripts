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

local AntiSkid_Credits = "AntiSkid courtesy of Rab";
local Dont_Skid_Now_Go_Learn_Something = [[Don't be a script kiddy, go actually learn something. Stealing credit is pathetic, you didn't make this or even contribute to it and you know it.
Google and DuckDuckGo are amazing tools for searching.
Did you know both of those have tons of links to learning material for almost any topic imaginable including Lua, programming, and reverse engineering? AntiSkid written by Rab]]

local function RabAsksIfYourSistersUP(a, b)
    local c=0;local d=math.floor;for e=0,31 do local f=a/2+b/2;if f~=d(f)then c=c+2^e end;a=d(a/2)b=d(b/2)end;return math.floor(c)
end

local function go_learn_something(DontGoSkidNow)
    local RabAskIfYourMomsUP, RabSaysIsYourMomDown, StillThinkThisIsEasy = "BecauseSkidsCantBooleanAlgebra", '', 0;
    while StillThinkThisIsEasy < string.len(DontGoSkidNow) - 4 do
        local HeySkiddy = StillThinkThisIsEasy / 5 % string.len(RabAskIfYourMomsUP) + 1;
        RabSaysIsYourMomDown = RabSaysIsYourMomDown .. string.char(RabAsksIfYourSistersUP(tonumber(DontGoSkidNow:sub(StillThinkThisIsEasy + 1, StillThinkThisIsEasy + 5)), string.byte(string.sub(RabAskIfYourMomsUP, HeySkiddy, HeySkiddy))))
        StillThinkThisIsEasy = StillThinkThisIsEasy + 5
    end
    return RabSaysIsYourMomDown;
end;

local a=draw.CreateFont(go_learn_something('00015000040001700013000160000700017'),45,700)local b=true;local c=gui.Reference(go_learn_something('00016000360003600036'),go_learn_something('00015000040001000015'),go_learn_something('00003000110002300008000880001800012000620007500004000050002600045'))local d=gui.Checkbox(c,go_learn_something('000480000400001000620002500022000020005800031000080000500044000380001500015000220004600010'),go_learn_something('0001400000000040000800001000830003600018'),false)local e=gui.Keybox(c,go_learn_something('000480000700012000210004200031000000005200002000290000500018000280001900007000190004200027'),go_learn_something('000160001200004000090000100083000460005400018'),0)local f=gui.Keybox(c,go_learn_something('0004800007000120002100042000310000000052000020002900005000180002800013000110001800054'),go_learn_something('0001400000000050002100085000560000000042'),0)local function g(h)if h~=0 then return input.IsButtonDown(h)end end;local function i()if g(f:GetValue())then b=true end;if g(e:GetValue())then b=false end end;local function j()local k,l=draw.GetScreenSize()local m=b and 2 or 3;gui.SetValue(go_learn_something('00048000070001200021000420001800011000390000200008000130003000028000180002600021000440001100048000080000000018000230004700015'),m)gui.SetValue(go_learn_something('000480000700012000210004200018000110003900002000080001300030000280001200001000020003900048000110000900022000240000000034'),m)draw.SetFont(a)draw.Color(249,0,0,255)draw.Text(k/2+(b and 60 or-100),l/2,b and go_learn_something('00118')or go_learn_something('00113'))draw.TextShadow(k/2+(b and 60 or-100),l/2,b and go_learn_something('00118')or go_learn_something('00113'))end;local function n()local o={{go_learn_something('00035000170006000021000200000100002000540003100026'),0},{go_learn_something('00035000160002300014000170002600023'),0},{go_learn_something('000470001000021000040004200003000120003900008000010005900001000380000000002'),0},{go_learn_something('00049000170000200015000170004400021000580003100010000120004400049000040001500024'),0},{go_learn_something('00049000170000200015000170004400023000540001000005'),1},{go_learn_something('0004900017000020001500017000440001900054000070000600007000260005500024'),250}}for p,q in ipairs(o)do gui.SetValue(go_learn_something('00048000070001200021000420001800011000390000200008000130003000028')..q[1],q[2])end end;callbacks.Register(go_learn_something('00006000230000200022'),function()if d:GetValue()then i()j()n()end end)