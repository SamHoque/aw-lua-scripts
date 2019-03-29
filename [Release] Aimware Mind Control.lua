local menuPressed, showBots, showEnemies, showTeam, selected, scroll, nameToSteal = 1, false, true, true, 0, 0, nil;

--gui code
mgui={}local c={}local d={}local e={{}}local f={}f.outline=function(h,i,j,k,l)draw.Color(l[1],l[2],l[3],l[4])draw.OutlinedRect(h,i,h+j,i+k)end;f.rect=function(h,i,j,k,l)draw.Color(l[1],l[2],l[3],l[4])draw.FilledRect(h,i,h+j,i+k)end;f.rect2=function(h,i,j,k)draw.FilledRect(h,i,h+j,i+k)end;f.gradient=function(h,i,j,k,m,n,o)f.rect(h,i,j,k,m)local r,g,b=n[1],n[2],n[3]if o then for p=1,k do local a=p/k*255;f.rect(h,i+p,j,1,{r,g,b,a})end else for p=1,j do local a=p/j*255;f.rect(h+p,i,1,k,{r,g,b,a})end end end;f.text=function(h,i,q,l,s)if s~=nil then draw.SetFont(s)end;draw.Color(l[1],l[2],l[3],l[4])draw.Text(h,i,q)end;mgui.checkbox=function(t,u,v,w,x,y,z)local A=false;if c[y][1]==null then c[y]={x}else A=c[y][1]end;local B=t+d[z][1]local C=u+d[z][2]if mgui.mouse_mov(B,C,16,v)and e[1][7]~=true then mgui.color_aw("gui_controls3")else mgui.color_aw("gui_groupbox_background")end;drawing.block(B,C,21,v)if mgui.mouse_mov(B,C,16,v)and e[1][7]~=true then if A then mgui.color_aw("gui_checkbox_on_hover")else mgui.color_aw("gui_checkbox_off_hover")end;if input.IsButtonPressed(1)then mgui.color_aw("gui_checkbox_on_hover")if c[y][1]==false then c[y][1]=true else c[y][1]=false end end else if A then mgui.color_aw("gui_checkbox_on")else mgui.color_aw("gui_checkbox_off")end end;drawing.block_round(B+4,C+5,12,12)if A then mgui.color_aw("gui_controls2")else mgui.color_aw("gui_controls3")end;if mgui.mouse_mov(B,C,16,v)and e[1][7]~=true then mgui.color_aw("gui_controls2")end;drawing.encircle_round(B+4,C+5,12,12)local D=B+17;local E=C-1;mgui.color_aw("gui_text2")draw.Text(D+4,E+5,w)return A end;mgui.button=function(t,u,F,v,w,y,z)local B,C;if c[y][1]then else c[y]={false}end;if z==0 then B=t;C=u else B=t+d[z][1]C=u+d[z][2]end;local G=false;if mgui.mouse_mov(B,C,F,v)and e[1][7]~=true then mgui.color_aw("gui_button_hover")if input.IsButtonDown(1)then mgui.color_aw("gui_button_clicked")end;if input.IsButtonPressed(1)then G=true end else mgui.color_aw("gui_button_idle")end;drawing.block_round(B,C,F,v)local H,I=draw.GetTextSize(w)local D=B+v/2-H/2;local E=C+F/2-I/2;mgui.color_aw("gui_text1")draw.Text(D,E,w)return G end;local function J(a,b,K,L,M,N)if a>=K and a<=M and b>=L and b<=N then return true else return false end end;local function O(P,Q,R)if P<Q then return Q end;if P>R then return R end;return P end;mgui.listbox=function(h,i,S,T,U,V,z)h=h+d[z][1]i=i+d[z][2]if(#S-T)*20>=T*20 then while(#S-T)*20>=T*20 do T=T+1 end end;local k=T*20;local r,g,b,a=gui.GetValue("clr_gui_listbox_outline")f.outline(h,i,155,k+2,{r,g,b,a})r,g,b,a=gui.GetValue("clr_gui_listbox_background")f.rect(h+1,i+1,153,k,{r,g,b,a})local W=0;local X=0;local Y=false;for p=1,#S do local r,g,b,a=181,181,181,255;local Z=i+p*20-19-V*20;local _=true;if Z>i+k then _=false;W=W+1;Y=true elseif Z<i then _=false;X=X+1;Y=true end;if _ then local a0,a1=input.GetMousePos()if J(a0,a1,h+1,Z,h+149,Z+20)then if input.IsButtonPressed(1)then U=p end end;if U==p then r,g,b,a=gui.GetValue("clr_gui_listbox_select")f.rect(h+1,Z+3,153,15,{r,g,b,a})end;r,g,b,a=gui.GetValue("clr_gui_text2")f.text(h+10,Z+3,S[p],{r,g,b,a},nil)end end;if Y then f.rect(h+149,i+1,5,k,{32,32,32,255})local a2=38;local a3=i+V+V*20+1;local a4=k-(#S-T)*20-V;local a0,a1=input.GetMousePos()if J(a0,a1,h+149,a3,h+154,a3+a4)then a2=46;if input.IsButtonDown(1)then a2=23 end end;if J(a0,a1,h+149,i,h+154,i+k)and input.IsButtonDown(1)then local a5=O(a1-i,0,k)local a6=a5/k+a5/k/2;V=O(math.floor((#S-T)*a6),0,#S-T)end;f.outline(h+149,a3,5,a4,{a2,a2,a2,255})f.rect(h+150,a3+1,3,a4-1,{a2+8,a2+8,a2+8,255})if W~=0 then f.rect(h+150-9,i+k-18+11,5,1,{181,181,181,255})f.rect(h+150-8,i+k-18+12,3,1,{181,181,181,255})f.rect(h+150-7,i+k-18+13,1,1,{181,181,181,255})end;if X~=0 then f.rect(h+150-7,i-5+11,1,1,{181,181,181,255})f.rect(h+150-8,i-5+12,3,1,{181,181,181,255})f.rect(h+150-9,i-5+13,5,1,{181,181,181,255})end end;return U,V end;mgui.panel=function(t,u,F,v,w,y,z)mgui.color_aw("gui_groupbox_background")local B=t+d[z][1]local C=u+d[z][2]drawing.block(B,C,F,v)mgui.color_aw("gui_groupbox_outline")drawing.shadow(B,C,F,v)if w then local H,I=draw.GetTextSize(w)mgui.color_aw("gui_text2")draw.Text(B+14,C-5,w)end end;mgui.label=function(t,u,w,y,z)mgui.color_aw("gui_text2")local B=t+d[z][1]local C=u+d[z][2]draw.Text(B,C,w)end;mgui.menu=function(t,u,F,v,w,y)local a7,a8;if d[y][1]then a7=d[y][1]a8=d[y][2]else a7=t;a8=u;d[y]={t,u,false,v}end;mgui.color_aw("gui_window_background")drawing.block(a7,a8,F,v)mgui.color_aw("gui_window_header")drawing.block(a7,a8-25,25,v)mgui.color_aw("gui_window_header_tab2")drawing.block(a7,a8,4,v)mgui.color_aw("gui_window_footer")drawing.block(a7,a8+F,20,v)mgui.color_aw("gui_text1")draw.TextShadow(a7+8,a8-18,w)mgui.color_aw("gui_window_footer_text")draw.TextShadow(a7+8,a8+F+4,"Mind Control - Made by Rab")drawing.shadow(a7,a8-25,F+45,v)end;mgui.item=function(t,u,F,v,a9,y)e[1]={t,u,F,v,a9,y,true}end;local aa,ab=0,0;mgui.menu_mouse=function(y)local a7=d[y][1]local a8=d[y][2]if input.IsButtonDown(1)then local m_x,m_y=input.GetMousePos()if d[y][3]then d[y][1]=m_x-ab;d[y][2]=m_y-aa+25 end;if m_x>=a7 and m_x<=a7+d[y][4]and m_y>=a8-25 and m_y<=a8 and d[y][3]==false then d[y][3]=true;ab=m_x-a7;aa=m_y-a8+25 end else d[y][3]=false end end;mgui.mouse_mov=function(t,u,F,v)m_x,m_y=input.GetMousePos()if m_x>=t and m_x<=t+v and m_y>=u and m_y<=u+F then return true end end;mgui.color_aw=function(ac)r,g,b,a=gui.GetValue("clr_"..ac)draw.Color(r,g,b,a)end;mgui.max_component=function(ad,ae)if c[1]==null then for p=1,ae do table.insert(c,{})end;for p=1,ad do table.insert(d,{})end end end;drawing={}drawing.block=function(t,u,F,v)draw.FilledRect(t,u,t+v,u+F)end;drawing.block_round=function(t,u,F,v)draw.RoundedRectFill(t,u,t+v,u+F)end;drawing.encircle=function(t,u,F,v)draw.OutlinedRect(t,u,t+v,u+F)end;drawing.encircle_round=function(t,u,F,v)draw.RoundedRect(t,u,t+v,u+F)end;drawing.shadow=function(t,u,F,v)alpha=100;left_s=t;top_s=u;height_s=F;width_s=v;for p=1,1 do alpha=alpha-20;left_s=left_s-1;top_s=top_s-1;height_s=height_s+2;width_s=width_s+2;draw.Color(10,10,10,alpha)drawing.encircle(left_s,top_s,height_s,width_s)end;alpha=20;for p=1,10 do alpha=alpha-2;if alpha<0 then break end;left_s=left_s-1;top_s=top_s-1;height_s=height_s+2;width_s=width_s+2;draw.Color(10,10,10,alpha)drawing.encircle(left_s,top_s,height_s,width_s)end end

local function fetchPlayers()
    local playerNames, playerIndexs, players, lp, index = {}, {}, entities.FindByClass("CCSPlayer"), entities.GetLocalPlayer(), 1;
    for i = 1, #players do
        local player = players[i];
        local pIndex = player:GetIndex();
        if (player:IsPlayer() and (pIndex ~= lp:GetIndex() and pIndex ~= 1)) then
            local ping = entities.GetPlayerResources():GetPropInt("m_iPing", pIndex);
            local teamNumber = player:GetTeamNumber();
            local lTeamNumber = lp:GetTeamNumber();
            local shouldAdd = true;
            if (ping < 0) then
                if (showBots ~= true) then
                    shouldAdd = false;
                end
            end;
            if (teamNumber ~= lTeamNumber) then
                if (showEnemies ~= true) then
                    shouldAdd = false;
                end
            end;
            if (teamNumber == lTeamNumber) then
                if (showTeam ~= true) then
                    shouldAdd = false;
                end
            end;
            if (shouldAdd) then
                playerNames[index] = player:GetName();
                playerIndexs[index] = pIndex;
                index = index + 1;
            end;
        end;
    end;
    return { playerNames, playerIndexs };
end

local function stealName()
    if (nameToSteal ~= nil) then
        client.SetConVar("name", '​' .. nameToSteal, 0)
    end;
end

callbacks.Register("Draw", function()
    stealName();
    if input.IsButtonPressed(gui.GetValue("msc_menutoggle")) then
        menuPressed = menuPressed == 0 and 1 or 0;
    end
    if (menuPressed == 0) then return end;

    mgui.max_component(10, 100)

    mgui.menu(25, 25, 300, 630, "Mind Control", 1)

    mgui.panel(25, 25, 245, 175, "Players", 2, 1)
    local players = fetchPlayers();
    selected, scroll = mgui.listbox(35, 35, players[1], 11, selected, scroll, 1)
    mgui.panel(225, 25, 150, 175, "Player Info", 3, 1)
    local lp = entities.GetLocalPlayer();
    if (players[2] ~= nil) then
        local player = entities.GetByIndex(players[2][selected]);
        if (player ~= nil) then
            local playerIndex = player:GetIndex();
            mgui.label(235, 35, "Name: " .. player:GetName(), 31, 1);
            mgui.label(235, 45, "Index: " .. playerIndex, 32, 1);
            local team = "Unknown";
            local teamNumber = player:GetTeamNumber();
            if (teamNumber == 1) then
                team = "Spectator";
            elseif (teamNumber == 2) then
                team = "Terrorist";
            elseif (teamNumber == 3) then
                team = "Counter Terrorist";
            end;
            mgui.label(235, 55, "Team: " .. team, 4, 1);
            mgui.label(235, 65, "Team Number: " .. teamNumber, 33, 1);
            local callVoteButtonPad = 0;
            if (lp:GetTeamNumber() == teamNumber) then
                callVoteButtonPad = 25;
                if mgui.button(235, 80, 22, 130, "Callvote Kick", 34, 1) then
                    local player_info = client.GetPlayerInfo(playerIndex);
                    client.Command("callvote kick " .. player_info['UserID']);
                end
            end;
            if mgui.button(235, callVoteButtonPad + 80, 22, 130, "Steal Name", 35, 1) then
                nameToSteal = player:GetName();
            end
        end;
    end;
    mgui.panel(225, 190, 80, 185, "About Mind Control", 4, 1)
    mgui.label(235, 210, "Author: Rab", 41, 1);
    mgui.label(235, 225, "Author Discrd: SamzSakerz#4758", 42, 1);
    mgui.label(235, 240, "Credits: QBER (For GUI API)", 43, 1);


    mgui.panel(420, 25, 100, 185, "Settings", 5, 1)
    showBots = mgui.checkbox(430, 40, 85, "Show Bots", showBots, 51, 1);
    showEnemies = mgui.checkbox(430, 60, 85, "Show Enemies", showEnemies, 52, 1);
    showTeam = mgui.checkbox(430, 80, 85, "Show Team", showTeam, 53, 1);

    mgui.panel(420, 150, 125, 175, "Misc", 6, 1)
    if mgui.button(430, 170, 22, 130, "Scramble Teams", 61, 1) then
        client.Command("callvote ScrambleTeams");
    end
    if mgui.button(430, 195, 22, 130, "Switch Teams", 62, 1) then
        client.Command("callvote SwapTeams");
    end
    local mapName = engine.GetMapName();
    if mgui.button(430, 220, 22, 130, "Change Level", 63, 1) then
        if (mapName ~= nil) then
            client.Command("callvote ChangeLevel " .. mapName);
        end
    end
    if mgui.button(430, 245, 22, 130, "Clear Name History", 64, 1) then
        client.Command("callvote ScrambleTeams");
    end
    mgui.menu_mouse(1);
end);