--[=====[
    Name Changer Made by Rab(SamzSakerz#4758)
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
mgui={}local c={}local d={}local e={{}}local f={}local h=draw.CreateFont("Verdana",12,400)f.outline=function(i,j,k,l,m)draw.Color(m[1],m[2],m[3],m[4])draw.OutlinedRect(i,j,i+k,j+l)end;f.rect=function(i,j,k,l,m)draw.Color(m[1],m[2],m[3],m[4])draw.FilledRect(i,j,i+k,j+l)end;f.rect2=function(i,j,k,l)draw.FilledRect(i,j,i+k,j+l)end;f.gradient=function(i,j,k,l,n,o,p)f.rect(i,j,k,l,n)local r,g,b=o[1],o[2],o[3]if p then for q=1,l do local a=q/l*255;f.rect(i,j+q,k,1,{r,g,b,a})end else for q=1,k do local a=q/k*255;f.rect(i+q,j,1,l,{r,g,b,a})end end end;f.text=function(i,j,s,m,t)if t~=nil then draw.SetFont(t)else draw.SetFont(h)end;draw.Color(m[1],m[2],m[3],m[4])draw.Text(i,j,s)end;mgui.checkbox=function(u,v,width,w,x,mgui_id,y)local z=x;local n_left=u+d[y][1]local n_top=v+d[y][2]if mgui.mouse_mov(n_left,n_top,16,width)and e[1][7]~=true then mgui.color_aw("gui_controls3")else mgui.color_aw("gui_groupbox_background")end;drawing.block(n_left,n_top,21,width)if mgui.mouse_mov(n_left,n_top,16,width)and e[1][7]~=true then if z then mgui.color_aw("gui_checkbox_on_hover")else mgui.color_aw("gui_checkbox_off_hover")end;if input.IsButtonPressed(1)then mgui.color_aw("gui_checkbox_on_hover")if z==false then z=true else z=false end end else if z then mgui.color_aw("gui_checkbox_on")else mgui.color_aw("gui_checkbox_off")end end;drawing.block_round(n_left+4,n_top+5,12,12)if z then mgui.color_aw("gui_controls2")else mgui.color_aw("gui_controls3")end;if mgui.mouse_mov(n_left,n_top,16,width)and e[1][7]~=true then mgui.color_aw("gui_controls2")end;drawing.encircle_round(n_left+4,n_top+5,12,12)local n_button_left=n_left+17;local n_button_top=n_top-1;mgui.color_aw("gui_text2")draw.SetFont(h)draw.Text(n_button_left+4,n_button_top+5,w)return z end;mgui.button=function(u,v,height,width,w,mgui_id,y)local n_left,n_top;if c[mgui_id][1]then else c[mgui_id]={false}end;if y==0 then n_left=u;n_top=v else n_left=u+d[y][1]n_top=v+d[y][2]end;local A=false;if mgui.mouse_mov(n_left,n_top,height,width)and e[1][7]~=true then mgui.color_aw("gui_button_hover")if input.IsButtonDown(1)then mgui.color_aw("gui_button_clicked")end;if input.IsButtonPressed(1)then A=true end else mgui.color_aw("gui_button_idle")end;drawing.block_round(n_left,n_top,height,width)local c_w,c_h=draw.GetTextSize(w)local n_button_left=n_left+width/2-c_w/2;local n_button_top=n_top+height/2-c_h/2;mgui.color_aw("gui_text1")draw.SetFont(h)draw.Text(n_button_left,n_button_top,w)return A end;local function B(a,b,C,D,E,F)if a>=C and a<=E and b>=D and b<=F then return true else return false end end;local function G(H,I,J)if H<I then return I end;if H>J then return J end;return H end;mgui.listbox=function(i,j,K,L,M,N,y)i=i+d[y][1]j=j+d[y][2]if(#K-L)*20>=L*20 then while(#K-L)*20>=L*20 do L=L+1 end end;local l=L*20;local r,g,b,a=gui.GetValue("clr_gui_listbox_outline")f.outline(i,j,155,l+2,{r,g,b,a})r,g,b,a=gui.GetValue("clr_gui_listbox_background")f.rect(i+1,j+1,153,l,{r,g,b,a})local O=0;local P=0;local Q=false;for q=1,#K do local r,g,b,a=181,181,181,255;local R=j+q*20-19-N*20;local S=true;if R>j+l then S=false;O=O+1;Q=true elseif R<j then S=false;P=P+1;Q=true end;if S then local T,U=input.GetMousePos()if B(T,U,i+1,R,i+149,R+20)then if input.IsButtonPressed(1)then M=q end end;if M==q then r,g,b,a=gui.GetValue("clr_gui_listbox_select")f.rect(i+1,R+3,153,15,{r,g,b,a})end;r,g,b,a=gui.GetValue("clr_gui_text2")f.text(i+10,R+3,K[q],{r,g,b,a},nil)end end;if Q then f.rect(i+149,j+1,5,l,{32,32,32,255})local V=38;local W=j+N+N*20+1;local X=l-(#K-L)*20-N;local T,U=input.GetMousePos()if B(T,U,i+149,W,i+154,W+X)then V=46;if input.IsButtonDown(1)then V=23 end end;if B(T,U,i+149,j,i+154,j+l)and input.IsButtonDown(1)then local Y=G(U-j,0,l)local Z=Y/l+Y/l/2;N=G(math.floor((#K-L)*Z),0,#K-L)end;f.outline(i+149,W,5,X,{V,V,V,255})f.rect(i+150,W+1,3,X-1,{V+8,V+8,V+8,255})if O~=0 then f.rect(i+150-9,j+l-18+11,5,1,{181,181,181,255})f.rect(i+150-8,j+l-18+12,3,1,{181,181,181,255})f.rect(i+150-7,j+l-18+13,1,1,{181,181,181,255})end;if P~=0 then f.rect(i+150-7,j-5+11,1,1,{181,181,181,255})f.rect(i+150-8,j-5+12,3,1,{181,181,181,255})f.rect(i+150-9,j-5+13,5,1,{181,181,181,255})end end;return M,N end;mgui.panel=function(u,v,height,width,w,mgui_id,y)mgui.color_aw("gui_groupbox_background")local n_left=u+d[y][1]local n_top=v+d[y][2]drawing.block(n_left,n_top,height,width)mgui.color_aw("gui_groupbox_outline")drawing.shadow(n_left,n_top,height,width)if w then local c_w,c_h=draw.GetTextSize(w)mgui.color_aw("gui_text2")draw.SetFont(h)draw.Text(n_left+14,n_top-5,w)end end;mgui.label=function(u,v,w,mgui_id,y)mgui.color_aw("gui_text2")local n_left=u+d[y][1]local n_top=v+d[y][2]draw.SetFont(h)draw.Text(n_left,n_top,w)end;mgui.multiColorLabel=function(u,v,_,y)local a0=0;local n_left=u+d[y][1]local n_top=v+d[y][2]for q=1,#_ do local a1=_[q]local r,g,b,a2=a1[1],a1[2],a1[3],a1[4]draw.SetFont(h)draw.Color(r,g,b,255)draw.Text(n_left+a0,n_top,a2)local k,a3=draw.GetTextSize(a2)a0=a0+k end end;mgui.menu=function(u,v,height,width,w,mgui_id)local a4,a5;if d[mgui_id][1]then a4=d[mgui_id][1]a5=d[mgui_id][2]else a4=u;a5=v;d[mgui_id]={u,v,false,width}end;mgui.color_aw("gui_window_background")drawing.block(a4,a5,height,width)mgui.color_aw("gui_window_header")drawing.block(a4,a5-25,25,width)mgui.color_aw("gui_window_header_tab2")drawing.block(a4,a5,4,width)mgui.color_aw("gui_window_footer")drawing.block(a4,a5+height,20,width)mgui.color_aw("gui_text1")draw.SetFont(h)draw.TextShadow(a4+8,a5-18,w)mgui.color_aw("gui_window_footer_text")draw.SetFont(h)draw.TextShadow(a4+8,a5+height+4,"Name Changer - Made by Rab")drawing.shadow(a4,a5-25,height+45,width)end;mgui.item=function(u,v,height,width,item_text,mgui_id)e[1]={u,v,height,width,item_text,mgui_id,true}end;local a6,a7=0,0;mgui.menu_mouse=function(mgui_id)local a4=d[mgui_id][1]local a5=d[mgui_id][2]if input.IsButtonDown(1)then local m_x,m_y=input.GetMousePos()if d[mgui_id][3]then d[mgui_id][1]=m_x-a7;d[mgui_id][2]=m_y-a6+25 end;if m_x>=a4 and m_x<=a4+d[mgui_id][4]and m_y>=a5-25 and m_y<=a5 and d[mgui_id][3]==false then d[mgui_id][3]=true;a7=m_x-a4;a6=m_y-a5+25 end else d[mgui_id][3]=false end end;mgui.item_show=function()if e[1][7]then n_left=e[1][1]n_top=e[1][2]height=e[1][3]width=e[1][4]item_text=e[1][5]mgui_id=e[1][6]s_top=n_top+20;s_height=#item_text*15;mgui.color_aw("gui_combobox_drop1")drawing.block(n_left,s_top,s_height,width)drawing.shadow(n_left,s_top,s_height,width)for q=1,#item_text do if mgui.mouse_mov(n_left,s_top+15*q-14,14,width)then if input.IsButtonDown(1)then c[mgui_id][1]=q;c[mgui_id][2]=false;e[1][7]=false end;mgui.color_aw("gui_combobox_drop3")drawing.block(n_left,s_top+15*q-15,15,width)end;mgui.color_aw("gui_text2")draw.Text(n_left+8,s_top+15*q+1-15,item_text[q])end;if mgui.mouse_mov(n_left,n_top,height,width)then else if input.IsButtonDown(1)then if c[mgui_id][2]==true then c[mgui_id][2]=false;e[1][7]=false end end end end end;mgui.mouse_mov=function(u,v,height,width)m_x,m_y=input.GetMousePos()if m_x>=u and m_x<=u+width and m_y>=v and m_y<=v+height then return true end end;mgui.color_aw=function(a8)r,g,b,a=gui.GetValue("clr_"..a8)draw.Color(r,g,b,a)end;mgui.max_component=function(a9,aa)if c[1]==null then for q=1,aa do table.insert(c,{})end;for q=1,a9 do table.insert(d,{})end end end;drawing={}drawing.block=function(u,v,height,width)draw.FilledRect(u,v,u+width,v+height)end;drawing.block_round=function(u,v,height,width)draw.RoundedRectFill(u,v,u+width,v+height)end;drawing.encircle=function(u,v,height,width)draw.OutlinedRect(u,v,u+width,v+height)end;drawing.encircle_round=function(u,v,height,width)draw.RoundedRect(u,v,u+width,v+height)end;drawing.shadow=function(u,v,height,width)alpha=100;left_s=u;top_s=v;height_s=height;width_s=width;for q=1,1 do alpha=alpha-20;left_s=left_s-1;top_s=top_s-1;height_s=height_s+2;width_s=width_s+2;draw.Color(10,10,10,alpha)drawing.encircle(left_s,top_s,height_s,width_s)end;alpha=20;for q=1,10 do alpha=alpha-2;if alpha<0 then break end;left_s=left_s-1;top_s=top_s-1;height_s=height_s+2;width_s=width_s+2;draw.Color(10,10,10,alpha)drawing.encircle(left_s,top_s,height_s,width_s)end end;mgui.edit=function(u,v,width,w,s,mgui_id,y)if c[mgui_id][1]==null then c[mgui_id]={"",false}e_text=s;c[mgui_id][1]=s else e_text=c[mgui_id][1]end;height=18;n_left=u+d[y][1]n_top=v+d[y][2]if mgui.mouse_mov(n_left,n_top,40,width)and e[1][7]~=true then mgui.color_aw("gui_controls3")else mgui.color_aw("gui_groupbox_background")end;drawing.block(n_left,n_top,18,width)mgui.color_aw("gui_controls1")drawing.block_round(n_left+5,n_top+20,height,width-10)if mgui.mouse_mov(n_left+5,n_top+20,height,width-10)and e[1][7]~=true then mgui.color_aw("gui_controls2")if input.IsButtonDown(1)then mgui.color_aw("gui_controls2")if c[mgui_id][2]==false then c[mgui_id][2]=true end end else if input.IsButtonDown(1)then if c[mgui_id][2]==true then c[mgui_id][2]=false end end;mgui.color_aw("gui_controls3")end;if c[mgui_id][2]==true then mgui.color_aw("gui_controls1")s_text=e_text.."_"else s_text=e_text end;if c[mgui_id][2]==true then if input.IsButtonPressed(8)then e_text=string.sub(e_text,1,string.len(e_text)-1)c[mgui_id][1]=e_text end;in_text=mgui.input_to_text()c_w,c_h=draw.GetTextSize(e_text)if in_text~=""and c_w<width-20 then e_text=e_text..in_text;c[mgui_id][1]=e_text end end;if c[mgui_id][2]==true then mgui.color_aw("gui_controls2")end;drawing.encircle_round(n_left+5,n_top+20,height,width-10)c_w,c_h=draw.GetTextSize(e_text)n_button_left=n_left+8;n_button_top=n_top+height/2-c_h/2;mgui.color_aw("gui_text2")draw.SetFont(h)draw.Text(n_button_left,n_button_top+20,s_text)draw.Text(n_left+6,n_top+3,w)return e_text end;mgui.input_to_text=function()local ab={[96]="~",[49]="!",[50]="@",[51]="#",[52]="$",[53]="%",[54]="^",[55]="&",[56]="*",[57]="(",[48]=")",[57]="(",[48]=")",[45]="_",[61]="+",[91]="{",[93]="}",[92]="|",[59]=" =",[39]="\"",[44]="<",[46]=">",[47]="?"}local ac={[189]="-",[187]="=",[186]=";",[219]="[",[221]="]",[222]="'",[220]="\\",[191]="/",[188]=",",[190]="."}local ad={[189]="_",[187]="+",[186]=";",[219]="{",[221]="}",[222]='"',[220]="|",[191]="?",[188]="<",[190]=">"}local A=""for q=48,90 do if input.IsButtonPressed(q)then if not input.IsButtonDown(16)and q>=65 and q<=90 then A=string.char(q+32)elseif input.IsButtonDown(16)and ab[q]then A=ab[q]else A=string.char(q)end end end;for q=187,222 do if input.IsButtonPressed(q)then if not input.IsButtonDown(16)and ac[q]~=nil then A=ac[q]elseif input.IsButtonDown(16)and ad[q]~=nil then A=ad[q]else A=string.char(q)end end end;if input.IsButtonPressed(32)then A=" "end;return A end;mgui.itembox=function(u,v,width,s,item_text,ae,mgui_id,y)if c[mgui_id][1]==null then c[mgui_id]={ae,false}else ae=c[mgui_id][1]act_item=c[mgui_id][2]end;height=18;n_left=u+d[y][1]n_top=v+d[y][2]if mgui.mouse_mov(n_left,n_top,45,width)and e[1][7]~=true then mgui.color_aw("gui_controls3")else mgui.color_aw("gui_groupbox_background")end;drawing.block(n_left,n_top,45,width)mgui.color_aw("gui_text2")draw.SetFont(h)draw.Text(n_left+7,n_top+3,s)n_top=n_top+20;n_left=n_left+5;n_width=width-10;mgui.color_aw("gui_controls1")drawing.block_round(n_left,n_top,height,n_width)if mgui.mouse_mov(n_left,n_top,height,width)and e[1][7]~=true then mgui.color_aw("gui_controls2")if input.IsButtonPressed(1)then if c[mgui_id][2]==false then c[mgui_id][2]=true end end else if c[mgui_id][2]==true then mgui.color_aw("gui_controls2")else mgui.color_aw("gui_controls3")end end;drawing.encircle_round(n_left,n_top,height,n_width)mgui.color_aw("gui_text2")draw.SetFont(h)draw.Text(n_left+8,n_top+2,item_text[ae])if c[mgui_id][2]==true then mgui.item(n_left,n_top,height,n_width,item_text,mgui_id)end;return c[mgui_id][1],item_text[c[mgui_id][1]]end

local fishes = {
    ">))'>",
    "ᅠᅠ>))'>",
    "ᅠᅠᅠᅠᅠ  >))'>",
    "ᅠᅠᅠᅠ ᅠ ᅠ ᅠ >))'>",
    " ᅠᅠᅠᅠ ᅠ  <'((<",
    " ᅠᅠᅠᅠ<'((<",
    " ᅠᅠ<'((<",
    "<'((<",
}

local hitler = { '卐', '卍' }
local stars = { '☆', '★' }

local silentName, wait, enabled = false, 0, false;
local currentName = '';
local menuPressed = 1;
local nameTypes = { "Static", "Anim 1", "Anim 2", "Vote Troll", "Hitler", "Stars", "Fishes" };
local namePreset = {};
local type_index, type_text = 1, 0;
local preset_index, preset_text = 1, 0;
local editName = '';
local currentInt = 0;
local lastChange = 0;
local currentAnimInt = 1;

local function changeGuiValues(i, i2)
    gui.SetValue("msc_namestealer_enable", i);
    gui.SetValue("msc_namestealer_interval", i2);
end

local function makeVoteTrollName()
    local tempName = '';
    for _ = 1, 46 do
        tempName = tempName .. "\n";
    end
    tempName = tempName .. editName;
    for _ = 1, 46 do
        tempName = tempName .. "\n";
    end
    currentName = tempName;
end

local function doCustomAnimFromTable(table)
    if ((globals.RealTime()) > lastChange) then
        if (currentAnimInt > #table) then
            currentAnimInt = 1
        end
        currentName = table[currentAnimInt];
        currentAnimInt = currentAnimInt + 1;
        lastChange = globals.RealTime() + 0.4;
    end
end

local function makeNameChangerSilent()
    if (enabled ~= true) then
        return
    end
    if (silentName ~= true) then
        changeGuiValues(1, 5);
        if (wait == 0) then
            wait = 2;
        end
        if (wait > 0) then
            wait = wait - globals.FrameTime();
            return
        end
        silentName = true;
        changeGuiValues(0, 0)
    else
        client.SetConVar("name", currentName, false);
    end
end

local function makeFormingName(wat)
    local nameLen = string.len(editName);
    if (lastChange == 0) then
        lastChange = globals.RealTime() + 0.4
    end
    if ((globals.RealTime()) < lastChange) then
        return
    end
    local fNameLen = nameLen;
    if (wat == 3) then
        fNameLen = fNameLen * 2;
    end
    if (currentInt > fNameLen) then
        currentInt = 0
    end
    currentInt = currentInt + 1;
    lastChange = globals.RealTime() + 0.4;
    -- wat 2 and 3 is buggy atm will implement it later
    if (wat == 1) then
        currentName = editName:sub(currentInt);
    elseif (wat == 2) then
        currentName = editName:sub(-currentInt);
    elseif (wat == 3) then
        if #currentName <= currentInt then
            currentName = string.sub(currentName, currentInt);
        else
            currentName = string.sub(currentName, 1, currentInt - (currentInt * 2 - #currentName + 1));
        end
    end
    currentName = currentName .. ' '
end

callbacks.Register("Draw", function()
    local lp = entities.GetLocalPlayer();
    if (lp ~= nil) then
        makeNameChangerSilent();
    else
        silentName, wait = false, 0;
    end
    if (type_index == 1) then
        currentName = editName;
    elseif (type_index == 2) then
         makeFormingName(1);
    elseif (type_index == 3) then
       makeFormingName(2);
    elseif (type_index == 4) then
        makeVoteTrollName();
    elseif (type_index == 5) then
        doCustomAnimFromTable(hitler)
    elseif (type_index == 6) then
        doCustomAnimFromTable(stars)
    elseif (type_index == 7) then
        doCustomAnimFromTable(fishes)
    end
    if (type_index == 1 or type_index == 2 or type_index == 3) then
        namePreset = { 'Custom', 'Time' }
    elseif (type_index == 4) then
        namePreset = { 'Custom' };
    else
        namePreset = {};
    end
    if input.IsButtonPressed(gui.GetValue("msc_menutoggle")) then
        menuPressed = menuPressed == 0 and 1 or 0;
    end
    if (menuPressed ~= 0) then
        mgui.max_component(10, 100)
        mgui.menu(25, 25, 160, 300, "Name Changer", 1);
        mgui.panel(15, 15, 130, 270, "", 2, 1);
        enabled = mgui.checkbox(25, 25, 90, "Enable", enabled, 1, 1);
        local previewPadding = 20;
        type_index, type_text = mgui.itembox(25, previewPadding + 30, 70, "Name Type", nameTypes, 1, 3, 1);
        if (#namePreset > 0) then
            preset_index, preset_text = mgui.itembox(100, previewPadding + 30, 70, "Name Preset", namePreset, 1, 4, 1);
        end
        if (preset_text == 'Custom') then
            editName = mgui.edit(25, previewPadding + 75, 250, "Custom Text", "", 5, 1);
        elseif (preset_text == 'Time') then
            editName = '[' .. os.date("%X") .. ']';
        else
            editName = 'BlAME RAB';
        end
        mgui.label(100, 30, "Name: " .. currentName, 7, 1);
        mgui.menu_mouse(1);
        mgui.item_show();
    end
end);