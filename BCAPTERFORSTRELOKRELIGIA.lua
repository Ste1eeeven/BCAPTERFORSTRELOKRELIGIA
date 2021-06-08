----------------------------------------------
local script_name = "CAPTER ||"
--local main_color = '{464c8d}'
local main_color = '{3c3c3c}'
--local main_color_output = 0x464c8d
local main_color_output = 0x3c3c3c

----------------------------AVTOUPDATE-------------------------------
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local script_vers = 11
local script_vers_text = "11.00"
update_state = false

local update_url = "https://raw.githubusercontent.com/Ste1eeeven/BCAPTERFORSTRELOKRELIGIA/main/BCAPTERVERSION.INI"
local update_path = getWorkingDirectory() .. "/BCAPTERVERSION.INI"

local script_url = " " 
local script_path = thisScript().path
---------------------------------------------------------------------


local notification = 0
local flood_active = false 
local fixOutputDefaultKV = 1
local defaultKV = 0 
local defaultZ = 90 
local flooder2 = 0

local imgui = require 'imgui'
local sampev = require 'lib.samp.events' 
require 'lib.vkeys'  

local villages = {
	"Montgomerty", 
	"Dillimore",
	"Palomino Creek", 
	"Fort Carson", 
	"Blueberry", 
	"Elquebrados", 
	"Las-Barancas", 
	"Angel Payne"}

local territories = {
	'Palomino Creek 1', 
	'Palomino Creek 2', 
	'Palomino Creek 3', 
	'Palomino Creek 4', 
	'Dillimore 1', 
	'Dillimore 2', 
	'Dillimore 3', 
	'Blueberry 1', 
	'Blueberry 2', 
	'Blueberry 3', 
	'Montgomery 1', 
	'Montgomery 2',
	'Montgomery 3',
	'Montgomery 4',
	'Fort Carson 1',
	'Fort Carson 2',
	'Fort Carson 3',
	'Fort Carson 4',
	'Fort Carson 5',
	'Fort Carson 6',
	'El Quebrados 1',
	'El Quebrados 2',
	'El Quebrados 3',
	'El Quebrados 4',
	'Las Barrancas 1',
	'Las Barrancas 2',
	'Angel Payne 1',
	'Angel Payne 2'}

local main_window_state = imgui.ImBool(false)
local second_window_state = imgui.ImBool(false)

local selected_item = imgui.ImInt(0)
local cdelay = imgui.ImInt(90)
local csqrt = imgui.ImInt(1)

----------------------------------------------

local encoding = require 'encoding' 
encoding.default = 'CP1251'
u8 = encoding.UTF8

----------------------------------------------

function sampev.onServerMessage(color, text)
	
	----------------------------------------------
	
	if(string.find(text, "Не флуди!")) then
		if flood_active == true then
			return false
		end
	end
	if (string.find(text, "Добро пожаловать на Evolve Role Play")) or (string.find(text, "Для восстановления доступа перейдите в окно ошибочного ввода")) then
		notification_check()
		--sampAddChatMessage("TRUE", -1)
	end
	----------------------------------------------
end

----------------------------------------------

function SetStyle()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4

	style.WindowRounding = 2
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
	style.ChildWindowRounding = 4.0
	style.FrameRounding = 3
	style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
	style.ScrollbarSize = 13.0
	style.ScrollbarRounding = 0
	style.GrabMinSize = 8.0
	style.GrabRounding = 1.0
	style.WindowPadding = imgui.ImVec2(4.0, 4.0)
	style.FramePadding = imgui.ImVec2(3.5, 3.5)
	style.ButtonTextAlign = imgui.ImVec2(0.0, 0.5)
	

	colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 1.00)
	colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
	colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
	colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
	colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
	colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
	colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
	colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
	colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
	colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.Separator]              = colors[clr.Border]
	colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
	colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
	colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
	colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
	colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
	colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
	colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
	colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.ComboBg]                = colors[clr.PopupBg]
	colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
	colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
	colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
	colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
	colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
	colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

SetStyle()

----------------------------------------------

function imgui.TextColoredRGB(text, render_text)
    local max_float = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end

            local length = imgui.CalcTextSize(w)
            if render_text == 2 then
                imgui.NewLine()
                imgui.SameLine(max_float / 2 - ( length.x / 2 ))
            elseif render_text == 3 then
                imgui.NewLine()
                imgui.SameLine(max_float - length.x - 5 )
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], text[i])
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(w) end


        end
    end

    render_text(text)
end


----------------------------------------------

function imgui.OnDrawFrame()
  if not main_window_state.v and not second_window_state.v then
	imgui.Process = false
  end
  
  
  if main_window_state.v then
    ----------------------------------------------
	imgui.SetNextWindowSize(imgui.ImVec2(520, 350), imgui.Cond.FirstUseEver)
	imgui.SetNextWindowPos(imgui.ImVec2(x / 2, y / 2), imgui.Cond.Always, imgui.ImVec2(0.5,0.5))
	
	----------------------------------------------
	
	imgui.Begin(u8'Байкерский каптер для Evolve-RP.', main_window_state)
    
	----------------------------------------------
	
	imgui.SetCursorPos(imgui.ImVec2(160, 30))
    
	imgui.TextColoredRGB(u8"{FF0000}Информация о командах cкрипта:")
	
	imgui.TextColoredRGB(u8"{FF0000}'/bflood' {FFFFFF}- запустить флудер на квадрат, указанный в окне.")
	imgui.TextColoredRGB(u8"{FF0000}'/bdelay [значение]'{FFFFFF} - установить задержку командой(аналог изменения задержки")
	imgui.TextColoredRGB(u8"в окне). Рекомендуемое значение - {FF0000}90{FFFFFF} мс.  Клавиша {FF0000}6{FFFFFF} отключает флудер.")
	imgui.Separator()
	
	imgui.SetCursorPos(imgui.ImVec2(85, 105))
	imgui.TextColoredRGB(u8"{FF0000}Изменить значения задержки и установленного квадрата:")
	
	imgui.TextColoredRGB(u8'{FFFFFF}Выбранный квадрат: {FF0000}'..fixOutputDefaultKV.. " {FFFFFF}[{FF0000}".. territories[fixOutputDefaultKV].."{FFFFFF}]")

	imgui.SetCursorPos(imgui.ImVec2(250, 123))
	imgui.PushItemWidth(120) 
	if imgui.InputInt(u8"##csqrt", csqrt) then
		local ckv = tonumber(csqrt.v)
		change_kv(ckv)
	end
	imgui.PopItemWidth()

	imgui.TextColoredRGB(u8"Установленная задержка: {FF0000}"..defaultZ..u8' {FFFFFF}мс.')

	imgui.SetCursorPos(imgui.ImVec2(250, 150))
	imgui.PushItemWidth(120) 
	if imgui.InputInt(u8"##cdelay", cdelay) then
		defaultZ = tonumber(cdelay.v)
	end
	imgui.PopItemWidth()

	imgui.SetCursorPos(imgui.ImVec2(3, 175))
	imgui.TextColoredRGB(u8"{FF0000}Примечание: {FFFFFF}рекомендуемая задержка не менее {FF0000}90{FFFFFF} мс. При меньшей задержке")
	imgui.Text(u8"кикает сервер за флуд функциями.")
	
	imgui.Separator()
	imgui.SetCursorPos(imgui.ImVec2(165, 215))
	imgui.TextColoredRGB(u8"{FF0000}Установить метку на деревню:")
	imgui.PushItemWidth(510) 
	
	if imgui.Combo(u8'', selected_item, villages, #villages) then
		if selected_item.v == 0 then
			set_point(0)
		elseif selected_item.v == 1 then
			set_point(1)
		elseif selected_item.v == 2 then
			set_point(2)
		elseif selected_item.v == 3 then
			set_point(3)
		elseif selected_item.v == 4 then
			set_point(4)
		elseif selected_item.v == 5 then
			set_point(5)
		elseif selected_item.v == 6 then
			set_point(6)
		elseif selected_item.v == 7 then
			set_point(7)
		end
	end
	imgui.PopItemWidth()
	imgui.Separator()
	
	imgui.SetCursorPos(imgui.ImVec2(215, 260))
	imgui.TextColoredRGB(u8"{FF0000}Таймер капта:")
	imgui.TextColoredRGB(u8"Soon...")
	if imgui.Button(u8"Отключить скрипт") then
		script_off()
	end
	imgui.SetCursorPos(imgui.ImVec2(290, 330))
	imgui.TextColoredRGB(u8"by " .. main_color ..  "Steven Parks " .. "{FFFFFF} for " .. main_color .. "shoter of religion")
	
	----------------------------------------------
	
	imgui.End()
  
	----------------------------------------------
  end
end

----------------------------------------------

function script_off()
	lua_thread.create(function()
	main_window_state.v = false
	imgui.Process = false
	wait(2000)
	thisScript():unload()
	end)
end

function main()
    
	repeat wait(0) until isSampAvailable()
	while not isSampAvailable() do wait(0) end
	
	
	x, y = getScreenResolution()
	
	wait(2000)
	if notification == 0 then
		notification_check()
	end
	wait(2000)
	if notification == 1 then
		sampAddChatMessage(main_color .. script_name .. " {FFFFFF}Скрипт загружен. Информация:" ..main_color.." /captinfo", main_color_output)
		
		sampRegisterChatCommand("bflood", flooder_state)
		sampRegisterChatCommand("captinfo", frame)
		sampRegisterChatCommand("bdelay", set_Z)
		sampRegisterChatCommand("updatecheck", updateeee_check)
	
	elseif notification == 0 then
		script_off()
	end
	
	--------------------------------AVTOUPDATE------------------------------------
	downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage(main_color .. script_name .. " {FFFFFF}Имеется активное обновление скрипта. Версия: ".. main_color .. updateIni.info.vers_text, main_color_output)
                update_state = true
            end
            os.remove(update_path)
        end
    end)
	------------------------------------------------------------------------------
	while true do
		wait(0)
		------------------------------AVTOUPDATE----------------------------------	
		if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage(main_color .. script_name .. "{FFFFFF}Скрипт обновлён. Ожидайте.", main_color_output)
                    thisScript():reload()
                end
            end)
            break
        end
		--------------------------------------------------------------------------

		if flood_active then
			fast_capt(defaultKV)
			wait(defaultZ)
		end
		
		if isKeyDown(0x36) and flood_active then
			flood_active = false
			sampAddChatMessage(main_color .. script_name .. "{FFFFFF} Флудер был отключён нажатием клавиши.", main_color_output)
			wait(150)
			sampCloseCurrentDialogWithButton(0)
		end
	
	
	end
end

function updateeee_check()
	sampAddChatMessage("TRUE", -1)
end
----------------------------------------------

function frame()
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v
end

----------------------------------------------

function fast_capt(capt_arg)
	lua_thread.create(function()
	sampSendChat("/capture")
	sampSendDialogResponse(32700, 1, defaultKV)
	end)
end

----------------------------------------------


function flooder_state(arg)
	flood_active = true
	if flood_active then
		sampAddChatMessage(main_color .. script_name .. "{FFFFFF} Флудер активирован. Каптится квадрат: ".. fixOutputDefaultKV .. ".", main_color_output)
	else
		sampAddChatMessage(main_color .. script_name .. "{FFFFFF} Флудер был отключён командой.", main_color_output)
	end
end

----------------------------------------------

function set_kv(kvarg)
	defaultKV = tonumber(kvarg - 1)
	fixOutputDefaultKV = defaultKV + 1
end

----------------------------------------------

function set_Z(zarg)
	if #zarg == 0 then
		sampAddChatMessage(main_color .. script_name .. " {FFFFFF}Укажите значение задержки в тысячах.", main_color_output)
	else
		defaultZ = zarg
		sampAddChatMessage(main_color .. script_name .. "{FFFFFF} Установлена задержка: "..defaultZ .. ".", main_color_output)
	end
end
----------------------------------------------

function set_point(village)
	if village == 2 then --"Palomino Creek" 
		placeWaypoint(2380, 55, 0)
	elseif village == 4 then --'Blueberry' 
		placeWaypoint(170, -150, 0)
	elseif village == 3 then -- 'Fort Carson' 
		placeWaypoint(-120, 1110, 0)
	elseif village == 1 then -- 'Dillimore' 
		placeWaypoint(700, -550, 0)
	elseif village == 7 then --'Angel Payne' 
		placeWaypoint(-2150, -2400, 0)
	elseif village == 5  then --'Elquebrados' 
		placeWaypoint(-1480, 2600, 0)
	elseif village == 6 then --'Las-Barancas' 
		placeWaypoint(-850, 1500, 0)
	elseif village == 0 then -- 'Montgomerty' 
		placeWaypoint(1320, 250, 0)
	end
end

----------------------------------------------

function notification_check()
	lua_thread.create(function()
	
	repeat wait(0) until sampIsLocalPlayerSpawned()
	
		_, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nick_name = sampGetPlayerNickname(myid)
	
	if not sampGetCurrentServerName():find("Evolve") then 
		thisScript():unload() 
		return 
    end

	if nick_name == '' then
		notification = 1
	else
	
		sampSendChat('/fpanel')
		wait(100)
		
		local did = sampGetCurrentDialogId()
		if did == 16000 then
			dtext = sampGetDialogText()
			--if dtext:find('стрелок религия') then
			if dtext:find('стрелок религия') then
				notification = 1
			elseif dtext:find('жатецкий гусь') then
				sampAddChatMessage(main_color .. script_name .. "{FFFFFF} Жатецка гусь, пошел нахуй))", main_color_output)
				wait(100)
				script_off()
			else 
				sampAddChatMessage(main_color ..  script_name .. "{FFFFFF} error (-_-)", main_color_output)
				wait(100)
				script_off()
			end
		end
		wait(100)
		sampCloseCurrentDialogWithButton(0)
		wait(100)
		sampCloseCurrentDialogWithButton(0)
	end	
	end)
end

function change_kv(chkv)
	if chkv < 1 then
		sampAddChatMessage(main_color .. script_name.. " {FFFFFF}Достигнут предел. Выберите значение не менее 1.", main_color_output)
		csqrt = imgui.ImInt(1)
	elseif chkv > 28 then
		sampAddChatMessage(main_color .. script_name .. "{FFFFFF} Достигнут предел. Выберите значение не более 28.", main_color_output)
		csqrt = imgui.ImInt(28)
	else
		fixOutputDefaultKV = chkv
		defaultKV = tonumber(fixOutputDefaultKV - 1)
	end
end