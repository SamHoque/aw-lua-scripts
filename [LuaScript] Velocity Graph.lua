--[=====[
    Velocity Graph Made by Rab(SamzSakerz#4758)
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

-- Create UI
local windowW, windowH = 250, 400;
local mainWindow = gui.Window("rab_velocity_graph_menu", "Velocity Graph", 200, 200, windowW, windowH);
local settingsGroup = gui.Groupbox(mainWindow, "Settings", 13, 13, windowW - 25, windowH - 55);
local enable = gui.Checkbox(settingsGroup, "rab_velocity_graph_enabled", "Enable", true);
-- Speed Indicator Settings
local uiSpeed = gui.Checkbox(settingsGroup, "rab_velocity_graph_speed_indicator", "Enable Speed Indicator", true);

-- Graph Settings
local menuPressed = 1;
local uiGraph = gui.Checkbox(settingsGroup, "rab_velocity_graph_graph_ui", "Enable Graph UI", true);
local uiGraphJumps = gui.Checkbox(settingsGroup, "rab_velocity_graph_ui_jumps", "Enable Graph UI Jumps", true);
local uiGraphWidth = gui.Slider(settingsGroup, "rab_velocity_graph__ui_width", "Speed graph width", 250, 1, 700);
local uiGraphMaxY = gui.Slider(settingsGroup, "rab_velocity_graph_ui_maxy", "Speed graph max speed", 400, 1, 5000);
local uiGraphCompression = gui.Slider(settingsGroup, "rab_velocity_graph_ui_compress", "Speed graph compression", 3, 1, 15);
local uiGraphFreq = gui.Slider(settingsGroup, "rab_velocity_graph_ui_freq", "Speed graph delay", 0, 0, 150);
local uiGraphSpread = gui.Slider(settingsGroup, "rab_velocity_graph_ui_spread", "Speed graph spread", 1, 1, 50);
local uiGraphColorType = gui.Combobox(settingsGroup, "rab_velocity_graph_ui_colortype", "Spread Graph Color Type", "Static", "Gradient Chroma", "Static Chroma");
local uiGraphColorRed = gui.Slider(settingsGroup, "rab_velocity_graph_ui_red", "Red", 255, 0, 255);
local uiGraphColorGreen = gui.Slider(settingsGroup, "rab_velocity_graph_ui_green", "Green", 255, 0, 255);
local uiGraphColorBlue = gui.Slider(settingsGroup, "rab_velocity_graph_ui_blue", "Blue", 255, 0, 255);
local uiGraphStaticChromaSpeed = gui.Slider(settingsGroup, "rab_velocity_graph_ui_static_chroma_speed", "Static Chroma Speed", 1, 1, 10);
local uiGraphAlpha = gui.Slider(settingsGroup, "rab_velocity_graph_ui_alpha", "Speed graph alpha", 255, 0, 255);


-- Super Spoopy Stuff
local superSpoopyIndeed = 0;

-- Define needed vars
local graphJump, graphLand, playerIsJumping, jumpPos, landPos, speed = false, false, false, {}, {}, 0;
local lastDelay, lastGraph, prevTick, lastVelocity = 0, 0, 0, 0;
local graphHistory = {};
local main_font = draw.CreateFont("Arial", 16);
local font_small = draw.CreateFont("Arial", 12);

local function round(number, decimals)
    local power = 10 ^ decimals
    return math.floor(number * power) / power
end

-- Gets prop float
local function getPropFloat(lp, wat)
    return lp:GetPropFloat("localdata", wat)
end

local function colour(dist)
    if dist >= 235 then
        return { 255, 137, 34 }
    elseif dist >= 230 then
        return { 255, 33, 33 }
    elseif dist >= 227 then
        return { 57, 204, 96 }
    elseif dist >= 225 then
        return { 91, 225, 255 }
    else
        return { 170, 170, 170 }
    end
end
function HUEtoRGB(h)
    local z = math.floor(h / 60)
    local hi = z % 6;
    local f = h / 60 - z;

    local r = hi == 0 and 1
            or hi == 1 and (1 - f)
            or hi == 2 and 0
            or hi == 3 and 0
            or hi == 4 and 1 - (1 - f)
            or hi == 5 and 1
            or 0;

    local g = hi == 0 and 1 - (1 - f)
            or hi == 1 and 1
            or hi == 2 and 1
            or hi == 3 and 1 - f
            or hi == 4 and 0
            or hi == 5 and 0
            or 0;

    local b = hi == 0 and 0
            or hi == 1 and 0
            or hi == 2 and 1 - (1 - f)
            or hi == 3 and 1
            or hi == 4 and 1
            or hi == 5 and 1 - f
            or 0;

    return r * 255, g * 255, b * 255;
end
local function getFadeRGB(rgbSpeed)
    local r = math.floor(math.sin(globals.RealTime() * rgbSpeed) * 127 + 128)
    local g = math.floor(math.sin(globals.RealTime() * rgbSpeed + 2) * 127 + 128)
    local b = math.floor(math.sin(globals.RealTime() * rgbSpeed + 4) * 127 + 128)
    return r, g, b;
end
local function drawGraph(velocity, x, y, tickCount)
    local alpha, width, compress, spread = uiGraphAlpha:GetValue(), uiGraphWidth:GetValue(), uiGraphCompression:GetValue(), uiGraphSpread:GetValue();
    x = x - (width / 2)
    if ((lastGraph + uiGraphFreq:GetValue()) < tickCount) then
        local temp = {  };
        temp.velocity = math.min(velocity, uiGraphMaxY:GetValue());
        if (graphJump) then
            graphJump, temp.jump, temp.speed, temp.jumpPos = false, true, speed, jumpPos;
        end
        if (graphLand) then
            graphLand, temp.landed, temp.landPos = false, true, landPos
        end
        table.insert(graphHistory, temp)
        lastGraph = tickCount
    end
    local over = #graphHistory - (width / spread);
    if (over > 0) then
        table.remove(graphHistory, 1)
    end
    for i = 2, #graphHistory, 1 do
        local curVelocity, prevVelocity = graphHistory[i].velocity, graphHistory[i - 1].velocity;
        local curX, prevX = x + (i * spread), x + ((i - 1) * spread);
        local curY, prevY = y - (curVelocity / compress), y - (prevVelocity / compress);
        if (uiGraphJumps:GetValue()) then
            if graphHistory[i].jump then
                local index
                for q = i + 1, #graphHistory, 1 do
                    if (graphHistory[q].jump or graphHistory[q].landed) then
                        index = q
                        break
                    end
                end
                if (index) then
                    if graphHistory[index].landPos and graphHistory[index].landPos[1] then
                        local jSpeed = graphHistory[i].speed
                        local lSpeed = graphHistory[index].velocity
                        local speedGain = lSpeed - jSpeed
                        if speedGain > -100 then
                            local jPos = graphHistory[i].jumpPos
                            local lPos = graphHistory[index].landPos
                            local dist = math.sqrt((math.abs(lPos[1] - jPos[1]) ^ 2.0) + (math.abs(lPos[2] - jPos[2]) ^ 2.0)) + 32
                            if dist > 150 then
                                local jumpX = curX - 1
                                local jumpY = curY
                                local landX = x + (index * spread)
                                local landY = y - (graphHistory[index].velocity / compress)
                                local topY = landY - 13
                                if topY > jumpY or topY > jumpY - 13 then
                                    topY = jumpY - 13
                                end
                                local text = speedGain > 0 and "+" or ""
                                text = text .. speedGain;
                                local middleX = (jumpX + landX) / 2
                                draw.SetFont(font_small);
                                draw.Color(255, 255, 255, alpha)
                                draw.Text(middleX, topY - 13, text)
                                local ljColour = colour(dist)
                                draw.SetFont(font_small);
                                draw.Color(ljColour[1], ljColour[2], ljColour[3], alpha)
                                draw.Text(middleX, topY, "(" .. round(dist, 0) .. ")")
                            end
                        end
                    end
                end
            end
        end
        local colorType = uiGraphColorType:GetValue();
        local r, g, b = uiGraphColorRed:GetValue(), uiGraphColorGreen:GetValue(), uiGraphColorBlue:GetValue();
        if (colorType == 1) then
            r, g, b = HUEtoRGB((i) - superSpoopyIndeed);
        elseif (colorType == 2) then
            r, g, b = getFadeRGB(uiGraphStaticChromaSpeed:GetValue());
        end
        draw.Color(r, g, b, alpha)
        draw.Line(prevX, prevY, curX, curY)
    end
    superSpoopyIndeed = superSpoopyIndeed + 1;
    if (superSpoopyIndeed == 360) then
        superSpoopyIndeed = 0;
    end
end

callbacks.Register('FireGameEvent', function(e)
    local en = e:GetName();
    if (en == "game_start" or en == "round_start") then
        graphJump, graphLand, playerIsJumping, jumpPos, landPos, speed = false, false, false, {}, {}, 0;
        lastDelay, lastGraph, prevTick, lastVelocity = 0, 0, 0, 0;
        graphHistory = {};
    end
end)

callbacks.Register("Draw", function()
    -- Set the visibility of our settings window.
    if input.IsButtonPressed(gui.GetValue("msc_menutoggle")) then
        menuPressed = menuPressed == 0 and 1 or 0;
    end
    mainWindow:SetActive(menuPressed);
    if (enable:GetValue() ~= true) then
        return
    end
    local lp = entities.GetLocalPlayer(); -- Get our local entity and check if its `nil`, If it's nil lets abort from here
    if (lp == nil or lp:IsAlive() ~= true) then
        graphJump, graphLand, playerIsJumping, jumpPos, landPos, speed = false, false, false, {}, {}, 0;
        lastDelay, lastGraph, prevTick, lastVelocity = 0, 0, 0, 0;
        graphHistory = {};
        return
    end
    -- entity isn't nil lets start our code from here
    local flags = lp:GetProp('m_fFlags');
    local playerIsInGround = (flags & 1) ~= 0 -- bitwise and (m & n)
    local moveType = lp:GetPropInt('movetype');
    if (moveType == 9) then
        playerIsJumping = false;
    end
    local x, y, z = lp:GetAbsOrigin();
    local vX, vY = getPropFloat(lp, 'm_vecVelocity[0]'), getPropFloat(lp, 'm_vecVelocity[1]');
    if (playerIsInGround ~= true and playerIsJumping ~= true) then
        graphJump, playerIsJumping, jumpPos, speed = true, true, { x, y, z }, math.floor(math.min(9999, math.sqrt(vX ^ 2 + vY ^ 2)) + 0.2);
    end
    if (playerIsInGround and playerIsJumping) then
        playerIsJumping, graphLand, landPos = false, true, { x, y, z };
    end
    if (lastDelay == 0 or lastDelay + 4 < globals.RealTime()) then
        speed = 0;
        lastDelay = globals.RealTime();
    end
    local velocity = math.floor(math.min(10000, math.sqrt(vX * vX + vY * vY) + 0.5))
    local screenX, screenY = draw.GetScreenSize();
    local bottomX, bottomY = screenX / 2, screenY / 1.2;
    if (uiSpeed:GetValue()) then
        local r, g, b = 255, 255, 255
        if lastVelocity < velocity then
            r, g, b = 30, 255, 109
        end
        if lastVelocity == velocity then
            r, g, b = 255, 199, 89
        end
        if lastVelocity > velocity then
            r, g, b = 255, 119, 119
        end
        local text = velocity;
        if speed ~= 0 then
            text = text .. " (" .. speed .. ")"
        end
        draw.SetFont(main_font)
        draw.Color(r, g, b, 255)
        local tW, _ = draw.GetTextSize(text);
        draw.Text(bottomX - tW / 2, bottomY, text)
    end
    local tickCount = globals.TickCount();
    if (uiGraph:GetValue()) then
        drawGraph(velocity, bottomX, bottomY - (bottomY * 0.03), tickCount)
    end
    if (prevTick + 5) < tickCount then
        lastVelocity, prevTick = velocity, tickCount;
    end
end)