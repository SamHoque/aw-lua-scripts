--[=====[
    Rainbow Spread Crosshair Made by Rab(SamzSakerz#4758)
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

local function a(b,c)local d=math.floor(math.sin((globals.RealTime()+b)*c)*127+128)local e=math.floor(math.sin((globals.RealTime()+b)*c+2)*127+128)local f=math.floor(math.sin((globals.RealTime()+b)*c+4)*127+128)return d,e,f end;local function g(h,i,j)local k,l;for m=0,360,10 do local n,o=h+j*math.cos(math.rad(m)),i+j*math.sin(math.rad(m))local p,q=n,o;if p~=nil and k~=nil then local d,e,f=a(m,10)draw.Color(d,e,f,255)draw.Line(p,q,k,l)end;k,l=p,q end end;callbacks.Register("Draw",function()local r,s=draw.GetScreenSize()local t=entities.GetLocalPlayer()if t==nil then return end;local u=t:GetPropEntity("m_hActiveWeapon")if u==nil then return end;local v=u:GetWeaponInaccuracy()*1000;g(r/2,s/2,v)end)