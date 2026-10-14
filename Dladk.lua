-- ============================================================
-- APOLONIUM HUB v2.0
-- ============================================================
local P = game:GetService("Players")
local R = game:GetService("RunService")
local T = game:GetService("TweenService")
local U = game:GetService("UserInputService")
local W = game:GetService("Workspace")
local L = game:GetService("Lighting")
local SS = game:GetService("SoundService")
local HS = game:GetService("HttpService")
local SG = game:GetService("StarterGui")

local LP = P.LocalPlayer
local pg = LP:WaitForChild("PlayerGui")

if pg:FindFirstChild("ApoloniumMenu") then pg.ApoloniumMenu:Destroy() end
if pg:FindFirstChild("ApoloniumSelect") then pg.ApoloniumSelect:Destroy() end

local function pc(f) pcall(f) end

-- ============ ЦВЕТА ============
local ACCENT = Color3.fromRGB(180, 90, 255)
local ACCENT_DARK = Color3.fromRGB(110, 40, 180)
local ACCENT_LIGHT = Color3.fromRGB(220, 160, 255)
local BG = Color3.fromRGB(14, 10, 22)
local BG_ITEM = Color3.fromRGB(24, 18, 38)
local BG_ITEM_HOVER = Color3.fromRGB(40, 26, 62)
local BG_ITEM_ACTIVE = Color3.fromRGB(60, 30, 100)
local TEXT_MAIN = Color3.fromRGB(230, 220, 245)
local TEXT_DIM = Color3.fromRGB(160, 140, 200)
local BORDER = Color3.fromRGB(70, 45, 110)

-- ============================================================
-- ЭКРАН ВЫБОРА ВЕРСИИ
-- ============================================================
local vsg = Instance.new("ScreenGui", pg)
vsg.Name = "ApoloniumSelect"
vsg.ResetOnSpawn = false
vsg.IgnoreGuiInset = true
vsg.DisplayOrder = 1000

local VM = Instance.new("Frame", vsg)
VM.Size = UDim2.new(0, 300, 0, 240)
VM.Position = UDim2.new(0.5, -150, 0.5, -120)
VM.BackgroundColor3 = BG
VM.BorderSizePixel = 0
VM.Active = true
Instance.new("UICorner", VM).CornerRadius = UDim.new(0, 14)

local VMS = Instance.new("UIStroke", VM)
VMS.Color = ACCENT
VMS.Thickness = 2
VMS.Transparency = 0.1

-- градиентная полоска
local vTop = Instance.new("Frame", VM)
vTop.Size = UDim2.new(1, 0, 0, 3)
vTop.BackgroundColor3 = ACCENT
vTop.BorderSizePixel = 0
local vTopG = Instance.new("UIGradient", vTop)
vTopG.Color = ColorSequence.new(ACCENT, ACCENT_LIGHT, ACCENT)

-- буква A
local VE = Instance.new("TextLabel", VM)
VE.Size = UDim2.new(0, 44, 0, 44)
VE.Position = UDim2.new(0, 14, 0, 10)
VE.BackgroundTransparency = 1
VE.Text = "A"
VE.TextColor3 = ACCENT_LIGHT
VE.Font = Enum.Font.GothamBlack
VE.TextSize = 34
VE.TextXAlignment = Enum.TextXAlignment.Left
local vEG = Instance.new("UIGradient", VE)
vEG.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, ACCENT_LIGHT),
	ColorSequenceKeypoint.new(0.5, ACCENT),
	ColorSequenceKeypoint.new(1, ACCENT_DARK),
})
vEG.Rotation = 45

local VName = Instance.new("TextLabel", VM)
VName.Size = UDim2.new(0, 200, 0, 44)
VName.Position = UDim2.new(0, 60, 0, 10)
VName.BackgroundTransparency = 1
VName.Text = "APOLONIUM HUB"
VName.TextColor3 = TEXT_MAIN
VName.Font = Enum.Font.GothamBlack
VName.TextSize = 15
VName.TextXAlignment = Enum.TextXAlignment.Left

local VSub = Instance.new("TextLabel", VM)
VSub.Size = UDim2.new(0, 200, 0, 12)
VSub.Position = UDim2.new(0, 61, 0, 42)
VSub.BackgroundTransparency = 1
VSub.Text = "v2.0 • SELECT VERSION"
VSub.TextColor3 = ACCENT
VSub.Font = Enum.Font.GothamBold
VSub.TextSize = 8
VSub.TextXAlignment = Enum.TextXAlignment.Left

local VHint = Instance.new("TextLabel", VM)
VHint.Size = UDim2.new(1, -30, 0, 20)
VHint.Position = UDim2.new(0, 15, 0, 70)
VHint.BackgroundTransparency = 1
VHint.Text = "Выберите версию:"
VHint.TextColor3 = TEXT_DIM
VHint.Font = Enum.Font.Gotham
VHint.TextSize = 11
VHint.TextXAlignment = Enum.TextXAlignment.Left

-- кнопки версий
local function makeVersionBtn(text, y, isInt)
	local b = Instance.new("TextButton", VM)
	b.Size = UDim2.new(1, -30, 0, 46)
	b.Position = UDim2.new(0, 15, 0, y)
	b.BackgroundColor3 = isInt and Color3.fromRGB(30, 20, 50) or Color3.fromRGB(20, 25, 45)
	b.TextColor3 = isInt and ACCENT_LIGHT or Color3.fromRGB(120, 200, 255)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 12
	b.Text = text
	b.BorderSizePixel = 0
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
	local st = Instance.new("UIStroke", b)
	st.Color = isInt and ACCENT or Color3.fromRGB(100, 180, 255)
	st.Thickness = 1.5

	local desc = Instance.new("TextLabel", b)
	desc.Size = UDim2.new(1, -10, 0, 12)
	desc.Position = UDim2.new(0, 10, 1, -14)
	desc.BackgroundTransparency = 1
	desc.Text = isInt and "Полный набор функций" or "Базовый набор функций"
	desc.TextColor3 = TEXT_DIM
	desc.Font = Enum.Font.Gotham
	desc.TextSize = 8
	desc.TextXAlignment = Enum.TextXAlignment.Left

	b.MouseEnter:Connect(function()
		T:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = isInt and Color3.fromRGB(55, 30, 90) or Color3.fromRGB(35, 45, 75)}):Play()
	end)
	b.MouseLeave:Connect(function()
		T:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = isInt and Color3.fromRGB(30, 20, 50) or Color3.fromRGB(20, 25, 45)}):Play()
	end)
	return b
end

local VExtBtn = makeVersionBtn("EXTERNAL", 100, false)
local VIntBtn = makeVersionBtn("INTERNAL", 152, true)

-- ============================================================
-- ГЛАВНОЕ МЕНЮ
-- ============================================================
local function buildMenu(version)
	vsg:Destroy()
	local isInt = (version == "internal")
	local isExt = (version == "external")

	-- ============ GUI ============
	local sg = Instance.new("ScreenGui", pg)
	sg.Name = "ApoloniumMenu"
	sg.ResetOnSpawn = false
	sg.IgnoreGuiInset = true
	sg.DisplayOrder = 999
	sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local M = Instance.new("Frame", sg)
	M.Size = UDim2.new(0, 560, 0, 380)
	M.Position = UDim2.new(0.5, -280, 0.5, -190)
	M.BackgroundColor3 = BG
	M.BorderSizePixel = 0
	M.Active = true
	M.ClipsDescendants = true
	Instance.new("UICorner", M).CornerRadius = UDim.new(0, 14)

	local mainStroke = Instance.new("UIStroke", M)
	mainStroke.Color = ACCENT
	mainStroke.Thickness = 2
	mainStroke.Transparency = 0.15

	local topBar = Instance.new("Frame", M)
	topBar.Size = UDim2.new(1, 0, 0, 3)
	topBar.BackgroundColor3 = ACCENT
	topBar.BorderSizePixel = 0
	local topGrad = Instance.new("UIGradient", topBar)
	topGrad.Color = ColorSequence.new(ACCENT, ACCENT_LIGHT, ACCENT)

	-- ============ HEADER ============
	local header = Instance.new("Frame", M)
	header.Size = UDim2.new(1, 0, 0, 42)
	header.BackgroundColor3 = Color3.fromRGB(18, 12, 30)
	header.BorderSizePixel = 0

	local letterA = Instance.new("TextLabel", header)
	letterA.Size = UDim2.new(0, 40, 1, 0)
	letterA.Position = UDim2.new(0, 12, 0, 0)
	letterA.BackgroundTransparency = 1
	letterA.Text = "A"
	letterA.Font = Enum.Font.GothamBlack
	letterA.TextSize = 30
	letterA.TextColor3 = ACCENT_LIGHT
	letterA.TextXAlignment = Enum.TextXAlignment.Left
	local aGrad = Instance.new("UIGradient", letterA)
	aGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, ACCENT_LIGHT),
		ColorSequenceKeypoint.new(0.5, ACCENT),
		ColorSequenceKeypoint.new(1, ACCENT_DARK),
	})
	aGrad.Rotation = 45
	local aGlow = Instance.new("UIStroke", letterA)
	aGlow.Color = ACCENT
	aGlow.Thickness = 1.5
	aGlow.Transparency = 0.4

	local titleText = Instance.new("TextLabel", header)
	titleText.Size = UDim2.new(0, 250, 1, 0)
	titleText.Position = UDim2.new(0, 52, 0, 0)
	titleText.BackgroundTransparency = 1
	titleText.Text = "POLONIUM"
	titleText.Font = Enum.Font.GothamBlack
	titleText.TextSize = 16
	titleText.TextColor3 = TEXT_MAIN
	titleText.TextXAlignment = Enum.TextXAlignment.Left

	-- НАЗВАНИЕ ВЕРСИИ ПОД НАЗВАНИЕМ
	local subtitle = Instance.new("TextLabel", header)
	subtitle.Size = UDim2.new(0, 250, 0, 12)
	subtitle.Position = UDim2.new(0, 53, 0, 25)
	subtitle.BackgroundTransparency = 1
	subtitle.Text = isInt and "INTERNAL • v2.0" or "EXTERNAL • v2.0"
	subtitle.TextColor3 = isInt and ACCENT_LIGHT or Color3.fromRGB(120, 200, 255)
	subtitle.Font = Enum.Font.GothamBold
	subtitle.TextSize = 8
	subtitle.TextXAlignment = Enum.TextXAlignment.Left

	-- пульсация A
	task.spawn(function()
		while M.Parent do
			T:Create(letterA, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextColor3 = ACCENT}):Play()
			aGlow.Transparency = 0.7
			task.wait(1.2)
			T:Create(letterA, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextColor3 = ACCENT_LIGHT}):Play()
			aGlow.Transparency = 0.2
			task.wait(1.2)
		end
	end)

	local minBtn = Instance.new("TextButton", header)
	minBtn.Size = UDim2.new(0, 26, 0, 26)
	minBtn.Position = UDim2.new(1, -60, 0, 8)
	minBtn.BackgroundColor3 = Color3.fromRGB(30, 22, 50)
	minBtn.Text = "−"
	minBtn.TextColor3 = ACCENT_LIGHT
	minBtn.Font = Enum.Font.GothamBold
	minBtn.TextSize = 16
	minBtn.BorderSizePixel = 0
	minBtn.AutoButtonColor = false
	minBtn.ZIndex = 10
	Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

	local closeBtn = Instance.new("TextButton", header)
	closeBtn.Size = UDim2.new(0, 26, 0, 26)
	closeBtn.Position = UDim2.new(1, -30, 0, 8)
	closeBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 40)
	closeBtn.Text = "✕"
	closeBtn.TextColor3 = Color3.fromRGB(255, 130, 160)
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.TextSize = 13
	closeBtn.BorderSizePixel = 0
	closeBtn.AutoButtonColor = false
	closeBtn.ZIndex = 10
	Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

	minBtn.MouseEnter:Connect(function()T:Create(minBtn, TweenInfo.new(0.15), {BackgroundColor3 = ACCENT_DARK}):Play()end)
	minBtn.MouseLeave:Connect(function()T:Create(minBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 22, 50)}):Play()end)
	closeBtn.MouseEnter:Connect(function()T:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(120, 30, 60)}):Play()end)
	closeBtn.MouseLeave:Connect(function()T:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 20, 40)}):Play()end)

	-- ============ ПЕРЕТАСКИВАНИЕ ============
	local dragging, dragStart, startPos = false, nil, nil
	header.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true dragStart = i.Position startPos = M.Position
		end
	end)
	U.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local d = i.Position - dragStart
			M.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
	U.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end
	end)

	-- ============ BODY ============
	local body = Instance.new("Frame", M)
	body.Size = UDim2.new(1, 0, 1, -42)
	body.Position = UDim2.new(0, 0, 0, 42)
	body.BackgroundTransparency = 1

	local tabBar = Instance.new("ScrollingFrame", body)
	tabBar.Size = UDim2.new(0, 130, 1, -10)
	tabBar.Position = UDim2.new(0, 6, 0, 5)
	tabBar.BackgroundColor3 = Color3.fromRGB(18, 12, 30)
	tabBar.BorderSizePixel = 0
	tabBar.ScrollBarThickness = 2
	tabBar.ScrollBarImageColor3 = ACCENT
	tabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
	tabBar.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0, 10)
	local tabList = Instance.new("UIListLayout", tabBar)
	tabList.Padding = UDim.new(0, 3)
	tabList.SortOrder = Enum.SortOrder.LayoutOrder
	local tabPad = Instance.new("UIPadding", tabBar)
	tabPad.PaddingTop = UDim.new(0, 6)
	tabPad.PaddingBottom = UDim.new(0, 6)

	local divider = Instance.new("Frame", body)
	divider.Size = UDim2.new(0, 1, 1, -20)
	divider.Position = UDim2.new(0, 142, 0, 10)
	divider.BackgroundColor3 = BORDER
	divider.BorderSizePixel = 0
	divider.BackgroundTransparency = 0.3

	local contentHolder = Instance.new("Frame", body)
	contentHolder.Size = UDim2.new(1, -152, 1, -10)
	contentHolder.Position = UDim2.new(0, 148, 0, 5)
	contentHolder.BackgroundTransparency = 1
	contentHolder.ClipsDescendants = true

	-- ============ ФАБРИКИ ============
	local tabContents = {}
	local tabButtons = {}

	local function makeTab(name, order, icon)
		local btn = Instance.new("TextButton", tabBar)
		btn.Size = UDim2.new(1, -12, 0, 26)
		btn.Position = UDim2.new(0, 6, 0, 0)
		btn.BackgroundColor3 = BG_ITEM
		btn.TextColor3 = TEXT_DIM
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 10
		btn.Text = (icon and (icon .. "  ") or "") .. name
		btn.TextXAlignment = Enum.TextXAlignment.Left
		btn.BorderSizePixel = 0
		btn.AutoButtonColor = false
		btn.LayoutOrder = order
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
		local st = Instance.new("UIStroke", btn)
		st.Color = BORDER st.Thickness = 1 st.Transparency = 0.6
		local pad = Instance.new("UIPadding", btn)
		pad.PaddingLeft = UDim.new(0, 8)

		local content = Instance.new("ScrollingFrame", contentHolder)
		content.Size = UDim2.new(1, 0, 1, 0)
		content.Position = UDim2.new(0, 0, 0, 0)
		content.BackgroundTransparency = 1
		content.BorderSizePixel = 0
		content.ScrollBarThickness = 3
		content.ScrollBarImageColor3 = ACCENT
		content.CanvasSize = UDim2.new(0, 0, 0, 0)
		content.AutomaticCanvasSize = Enum.AutomaticSize.Y
		content.Visible = false
		local cpad = Instance.new("UIPadding", content)
		cpad.PaddingBottom = UDim.new(0, 40)
		local ll = Instance.new("UIListLayout", content)
		ll.Padding = UDim.new(0, 4)
		ll.SortOrder = Enum.SortOrder.LayoutOrder

		table.insert(tabButtons, btn)
		table.insert(tabContents, content)

		btn.MouseEnter:Connect(function()
			if not content.Visible then T:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = BG_ITEM_HOVER}):Play() end
		end)
		btn.MouseLeave:Connect(function()
			if not content.Visible then T:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = BG_ITEM}):Play() end
		end)
		btn.MouseButton1Click:Connect(function()
			for i = 1, #tabContents do
				local isThis = (i == order)
				tabContents[i].Visible = isThis
				if isThis then
					tabButtons[i].BackgroundColor3 = BG_ITEM_ACTIVE
					tabButtons[i].TextColor3 = ACCENT_LIGHT
				else
					tabButtons[i].BackgroundColor3 = BG_ITEM
					tabButtons[i].TextColor3 = TEXT_DIM
				end
			end
		end)
		return content
	end

	local function mkSec(txt, ord, parent)
		local l = Instance.new("TextLabel", parent)
		l.Size = UDim2.new(1, 0, 0, 20)
		l.BackgroundTransparency = 1
		l.Text = "▬  " .. txt
		l.TextColor3 = ACCENT_LIGHT
		l.Font = Enum.Font.GothamBold
		l.TextSize = 10
		l.TextXAlignment = Enum.TextXAlignment.Left
		l.LayoutOrder = ord
		return l
	end

	local function mkToggle(txt, ord, on, off, parent)
		local b = Instance.new("TextButton", parent)
		b.Size = UDim2.new(1, 0, 0, 26)
		b.BackgroundColor3 = BG_ITEM
		b.TextColor3 = TEXT_MAIN
		b.Font = Enum.Font.Gotham
		b.TextSize = 10
		b.Text = "○  " .. txt
		b.TextXAlignment = Enum.TextXAlignment.Left
		b.BorderSizePixel = 0
		b.AutoButtonColor = false
		b.LayoutOrder = ord
		Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
		local pad = Instance.new("UIPadding", b)
		pad.PaddingLeft = UDim.new(0, 8)
		local st = Instance.new("UIStroke", b)
		st.Color = BORDER st.Thickness = 1 st.Transparency = 0.6

		local s = false
		local function render()
			if s then
				b.BackgroundColor3 = BG_ITEM_ACTIVE
				b.TextColor3 = ACCENT_LIGHT
				st.Color = ACCENT st.Transparency = 0
				b.Text = "●  " .. txt
			else
				b.BackgroundColor3 = BG_ITEM
				b.TextColor3 = TEXT_MAIN
				st.Color = BORDER st.Transparency = 0.6
				b.Text = "○  " .. txt
			end
		end
		b.MouseEnter:Connect(function()
			if not s then T:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = BG_ITEM_HOVER}):Play() end
		end)
		b.MouseLeave:Connect(function()
			if not s then T:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = BG_ITEM}):Play() end
		end)
		b.MouseButton1Click:Connect(function()
			s = not s
			pc(function() if s then on() else off() end end)
			render()
		end)
	end

	local function mkBtn(txt, ord, act, parent)
		local b = Instance.new("TextButton", parent)
		b.Size = UDim2.new(1, 0, 0, 26)
		b.BackgroundColor3 = BG_ITEM
		b.TextColor3 = TEXT_MAIN
		b.Font = Enum.Font.Gotham
		b.TextSize = 10
		b.Text = "◈  " .. txt
		b.TextXAlignment = Enum.TextXAlignment.Left
		b.BorderSizePixel = 0
		b.AutoButtonColor = false
		b.LayoutOrder = ord
		Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
		local pad = Instance.new("UIPadding", b)
		pad.PaddingLeft = UDim.new(0, 8)
		local st = Instance.new("UIStroke", b)
		st.Color = BORDER st.Thickness = 1 st.Transparency = 0.6
		b.MouseEnter:Connect(function()T:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = BG_ITEM_HOVER}):Play()end)
		b.MouseLeave:Connect(function()T:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = BG_ITEM}):Play()end)
		b.MouseButton1Click:Connect(function()
			T:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = ACCENT_DARK}):Play()
			task.wait(0.1)
			T:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = BG_ITEM}):Play()
			pc(act)
		end)
	end

	local function mkSlider(txt, ord, min, max, default, onChange, parent)
		local c = Instance.new("Frame", parent)
		c.Size = UDim2.new(1, 0, 0, 34)
		c.BackgroundColor3 = BG_ITEM
		c.BorderSizePixel = 0
		c.LayoutOrder = ord
		Instance.new("UICorner", c).CornerRadius = UDim.new(0, 7)
		local st = Instance.new("UIStroke", c)
		st.Color = BORDER st.Thickness = 1 st.Transparency = 0.6

		local label = Instance.new("TextLabel", c)
		label.Size = UDim2.new(1, -20, 0, 16)
		label.Position = UDim2.new(0, 10, 0, 2)
		label.BackgroundTransparency = 1
		label.Text = txt .. ":  " .. tostring(default)
		label.TextColor3 = TEXT_MAIN
		label.Font = Enum.Font.Gotham
		label.TextSize = 10
		label.TextXAlignment = Enum.TextXAlignment.Left

		local barBg = Instance.new("Frame", c)
		barBg.Size = UDim2.new(1, -20, 0, 6)
		barBg.Position = UDim2.new(0, 10, 0, 22)
		barBg.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
		barBg.BorderSizePixel = 0
		Instance.new("UICorner", barBg).CornerRadius = UDim.new(0, 3)

		local fill = Instance.new("Frame", barBg)
		fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
		fill.BackgroundColor3 = ACCENT
		fill.BorderSizePixel = 0
		Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 3)
		local fg = Instance.new("UIGradient", fill)
		fg.Color = ColorSequence.new(ACCENT_DARK, ACCENT_LIGHT)

		local dragging2 = false
		local function setFromX(x)
			local rel = math.clamp((x - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
			local val = min + (max - min) * rel
			fill.Size = UDim2.new(rel, 0, 1, 0)
			label.Text = txt .. ":  " .. string.format("%.0f", val)
			pc(function() onChange(val) end)
		end
		barBg.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				dragging2 = true
				setFromX(i.Position.X)
			end
		end)
		U.InputChanged:Connect(function(i)
			if dragging2 and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
				setFromX(i.Position.X)
			end
		end)
		U.InputEnded:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				dragging2 = false
			end
		end)
	end

	local function mkInput(txt, ord, default, onEnter, parent)
		local c = Instance.new("Frame", parent)
		c.Size = UDim2.new(1, 0, 0, 26)
		c.BackgroundColor3 = BG_ITEM
		c.BorderSizePixel = 0
		c.LayoutOrder = ord
		Instance.new("UICorner", c).CornerRadius = UDim.new(0, 7)
		local st = Instance.new("UIStroke", c)
		st.Color = BORDER st.Thickness = 1 st.Transparency = 0.6

		local box = Instance.new("TextBox", c)
		box.Size = UDim2.new(1, -16, 1, 0)
		box.Position = UDim2.new(0, 8, 0, 0)
		box.BackgroundTransparency = 1
		box.Text = default or ""
		box.PlaceholderText = txt
		box.TextColor3 = TEXT_MAIN
		box.PlaceholderColor3 = TEXT_DIM
		box.Font = Enum.Font.Gotham
		box.TextSize = 10
		box.TextXAlignment = Enum.TextXAlignment.Left
		box.ClearTextOnFocus = false
		box.FocusLost:Connect(function(enter)
			if enter then pc(function() onEnter(box.Text) end) end
		end)
	end

	-- ============================================================
	-- ФУНКЦИОНАЛ
	-- ============================================================

	-- === ДВИЖЕНИЕ ===
	local speedConn, speedVal = nil, 16
	local function setSpeed(v) speedVal = v end
	local function watchSpeed()
		if speedConn then return end
		speedConn = R.Heartbeat:Connect(function()
			local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
			if h then h.WalkSpeed = speedVal end
		end)
	end
	local function stopSpeed() if speedConn then speedConn:Disconnect() speedConn = nil end end

	local jumpConn, jumpVal = nil, 50
	local function setJump(v) jumpVal = v end
	local function watchJump()
		if jumpConn then return end
		jumpConn = R.Heartbeat:Connect(function()
			local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
			if h then h.UseJumpPower = true h.JumpPower = jumpVal end
		end)
	end
	local function stopJump() if jumpConn then jumpConn:Disconnect() jumpConn = nil end end

	local infJumpConn
	local function infJumpOn()
		if infJumpConn then return end
		infJumpConn = U.JumpRequest:Connect(function()
			local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
			if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
		end)
	end
	local function infJumpOff() if infJumpConn then infJumpConn:Disconnect() infJumpConn = nil end end

	local flyA, flyBV, flyBG
	local function flyOn()
		if flyA then return end
		flyA = true
		local r = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
		if not r then flyA = false return end
		flyBV = Instance.new("BodyVelocity", r)
		flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		flyBV.Velocity = Vector3.zero
		flyBG = Instance.new("BodyGyro", r)
		flyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
		flyBG.P = 1000 flyBG.D = 50
	end
	local function flyOff()
		flyA = false
		if flyBV then flyBV:Destroy() flyBV = nil end
		if flyBG then flyBG:Destroy() flyBG = nil end
	end
	R.RenderStepped:Connect(function()
		if not flyA or not flyBV or not flyBG then return end
		local cm = W.CurrentCamera
		if not cm then return end
		local d = Vector3.zero
		if U:IsKeyDown(Enum.KeyCode.W) then d = d + cm.CFrame.LookVector end
		if U:IsKeyDown(Enum.KeyCode.S) then d = d - cm.CFrame.LookVector end
		if U:IsKeyDown(Enum.KeyCode.A) then d = d - cm.CFrame.RightVector end
		if U:IsKeyDown(Enum.KeyCode.D) then d = d + cm.CFrame.RightVector end
		if U:IsKeyDown(Enum.KeyCode.Space) then d = d + Vector3.new(0, 1, 0) end
		if U:IsKeyDown(Enum.KeyCode.LeftControl) then d = d - Vector3.new(0, 1, 0) end
		flyBV.Velocity = d.Magnitude > 0 and d.Unit * 120 or Vector3.zero
		flyBG.CFrame = cm.CFrame
	end)

	-- BANHOP
	local bhA, bhC
	local function bhOn()
		if bhA then return end
		bhA = true
		bhC = R.Heartbeat:Connect(function()
			local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
			if h and h.FloorMaterial ~= Enum.Material.Air then
				h:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)
	end
	local function bhOff() bhA = false if bhC then bhC:Disconnect() bhC = nil end end

	-- NOCLIP
	local ncA, ncC
	local function ncOn()
		if ncA then return end ncA = true
		ncC = R.Stepped:Connect(function()
			local c = LP.Character
			if c then for _, o in ipairs(c:GetDescendants()) do
            if o:IsA("BasePart") then o.CanCollide = false end
		end end
	end)
end
local function ncOff() ncA = false if ncC then ncC:Disconnect() ncC = nil end end

-- === ПЕРСОНАЖ ===
-- Бесконечное здоровье
local hpConn
local function infHpOn()
	if hpConn then return end
	hpConn = R.Heartbeat:Connect(function()
		local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
		if h then h.MaxHealth = math.huge h.Health = math.huge end
	end)
end
local function infHpOff()
	if hpConn then hpConn:Disconnect() hpConn = nil end
	local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
	if h then h.MaxHealth = 100 h.Health = 100 end
end

-- Fullbright / ночное зрение
local fbA = false
local fbOld = {}
local function fbOn()
	if fbA then return end
	fbA = true
	fbOld.Ambient = L.Ambient
	fbOld.OutdoorAmbient = L.OutdoorAmbient
	fbOld.Brightness = L.Brightness
	fbOld.FogEnd = L.FogEnd
	fbOld.FogStart = L.FogStart
	L.Ambient = Color3.fromRGB(200, 200, 200)
	L.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
	L.Brightness = 3
	L.FogEnd = 1e6
	L.FogStart = 1e6
end
local function fbOff()
	fbA = false
	L.Ambient = fbOld.Ambient or L.Ambient
	L.OutdoorAmbient = fbOld.OutdoorAmbient or L.OutdoorAmbient
	L.Brightness = fbOld.Brightness or 2
	L.FogEnd = fbOld.FogEnd or 500
	L.FogStart = fbOld.FogStart or 0
end

-- Убрать тени
local sdA, sdD = false, {}
local function sdOn()
	if sdA then return end
	sdA = true
	pc(function() L.GlobalShadows = false end)
	for _, o in ipairs(W:GetDescendants()) do
		if o:IsA("BasePart") and o.CastShadow then
			sdD[o] = true
			o.CastShadow = false
		end
	end
end
local function sdOff()
	sdA = false
	pc(function() L.GlobalShadows = true end)
	for o in pairs(sdD) do if o.Parent then o.CastShadow = true end end
	sdD = {}
end

-- Невидимость тела
local nsA, nsC
local function nsOn()
	if nsA then return end
	nsA = true
	nsC = R.Stepped:Connect(function()
		local c = LP.Character
		if c then for _, o in ipairs(c:GetDescendants()) do
			if o:IsA("BasePart") and o.Name ~= "HumanoidRootPart" then
				o.LocalTransparencyModifier = 1
				o.Transparency = 1
			end
		end end
	end)
end
local function nsOff()
	nsA = false
	if nsC then nsC:Disconnect() nsC = nil end
	local c = LP.Character
	if c then for _, o in ipairs(c:GetDescendants()) do
		if o:IsA("BasePart") then o.LocalTransparencyModifier = 0 o.Transparency = 0 end
	end end
end

-- Сброс персонажа
local function respawn()
	local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
	if h then h.Health = 0 end
end

-- Телепорт вверх
local function tpUp()
	local r = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
	if r then r.CFrame = r.CFrame + Vector3.new(0, 50, 0) end
end

-- === ВИЗУАЛ ESP ===
local espA, espD, espC = false, {}, {}
local function applyEsp(pl)
	if pl == LP then return end
	local function onChar(char)
		if not espA or not char then return end
		local hl = char:FindFirstChild("ApoESP")
		if not hl then
			hl = Instance.new("Highlight", char)
			hl.Name = "ApoESP"
			hl.FillColor = ACCENT
			hl.OutlineColor = ACCENT_LIGHT
			hl.OutlineTransparency = 0.3
			hl.FillTransparency = 0.6
			hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		end
		espD[pl] = hl
	end
	if pl.Character then onChar(pl.Character) end
	table.insert(espC, pl.CharacterAdded:Connect(function(c) task.wait(0.5) if espA then onChar(c) end end))
end
local function espOn()
	if espA then return end
	espA = true
	for _, pl in ipairs(P:GetPlayers()) do applyEsp(pl) end
	table.insert(espC, P.PlayerAdded:Connect(applyEsp))
end
local function espOff()
	espA = false
	for _, hl in pairs(espD) do if hl and hl.Parent then hl:Destroy() end end
	espD = {}
	for _, cn in ipairs(espC) do cn:Disconnect() end
	espC = {}
end

-- Свой Highlight
local glH
local function glowOn()
	if glH then return end
	local c = LP.Character
	if not c then return end
	glH = Instance.new("Highlight", c)
	glH.FillColor = ACCENT
	glH.OutlineColor = ACCENT_LIGHT
	glH.OutlineTransparency = 0.2
	glH.FillTransparency = 0.6
	glH.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end
local function glowOff()
	if glH then glH:Destroy() glH = nil end
end

-- Невидимая цель (для aimbot-подобных скриптов)
local tracersA, tracerFolder, tracerC
local function tracersOn()
	if tracersA then return end
	tracersA = true
	tracerFolder = Instance.new("Folder", W)
	tracerFolder.Name = "ApoTracers"
	tracerC = R.RenderStepped:Connect(function()
		for _, t in ipairs(tracerFolder:GetChildren()) do
			if t:IsA("Line") or t:IsA("Beam") then
				pc(function() t:Destroy() end)
			end
		end
		local cam = W.CurrentCamera
		local myChar = LP.Character
		local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
		if not (cam and myRoot) then return end
		for _, pl in ipairs(P:GetPlayers()) do
			if pl ~= LP and pl.Character then
				local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					local a = Instance.new("Attachment", hrp)
					local b = Instance.new("Attachment", myRoot)
					b.Position = Vector3.new(0, -2, 0)
					local beam = Instance.new("Beam", tracerFolder)
					beam.Attachment0 = a
					beam.Attachment1 = b
					beam.Width0 = 0.05
					beam.Width1 = 0.05
					beam.FaceCamera = true
					beam.Color = ColorSequence.new(ACCENT)
					beam.Transparency = NumberSequence.new(0.3)
					beam.LightEmission = 1
				end
			end
		end
	end)
end
local function tracersOff()
	tracersA = false
	if tracerC then tracerC:Disconnect() tracerC = nil end
	if tracerFolder then tracerFolder:Destroy() tracerFolder = nil end
end

-- Fullbright в интерфейсе
local function setFullbright(v)
	pc(function()
		L.Brightness = v
		L.Ambient = Color3.fromRGB(v * 80, v * 80, v * 80)
		L.OutdoorAmbient = Color3.fromRGB(v * 80, v * 80, v * 80)
	end)
end

-- === КАМЕРА ===
local camFOV = W.CurrentCamera and W.CurrentCamera.FieldOfView or 70
local function setFOV(v)
	camFOV = v
	pc(function() W.CurrentCamera.FieldOfView = v end)
end
local function resetFOV() setFOV(70) end

-- Free cam (WASD камера)
local freeA, freeC, freePos
local function freeOn()
	if freeA then return end
	freeA = true
	local cam = W.CurrentCamera
	freePos = cam and cam.CFrame or CFrame.new()
	freeC = R.RenderStepped:Connect(function()
		if not freeA then return end
		local c = W.CurrentCamera
		if not c then return end
		if c.CameraType ~= Enum.CameraType.Scriptable then
			c.CameraType = Enum.CameraType.Scriptable
		end
		local d = Vector3.zero
		if U:IsKeyDown(Enum.KeyCode.W) then d = d + freePos.LookVector end
		if U:IsKeyDown(Enum.KeyCode.S) then d = d - freePos.LookVector end
		if U:IsKeyDown(Enum.KeyCode.A) then d = d - freePos.RightVector end
		if U:IsKeyDown(Enum.KeyCode.D) then d = d + freePos.RightVector end
		if U:IsKeyDown(Enum.KeyCode.Space) then d = d + Vector3.new(0, 1, 0) end
		if U:IsKeyDown(Enum.KeyCode.LeftControl) then d = d - Vector3.new(0, 1, 0) end
		freePos = freePos + d * 2
		c.CFrame = freePos
	end)
end
local function freeOff()
	freeA = false
	if freeC then freeC:Disconnect() freeC = nil end
	local c = W.CurrentCamera
	if c then c.CameraType = Enum.CameraType.Custom end
end

-- Камера от первого лица
local function setFirstPerson(v)
	LP.CameraMode = v and Enum.CameraMode.LockFirstPerson or Enum.CameraMode.Classic
end

-- === ЗВУК ===
local function muteGame(v)
	SS.AmbientReverb = v and Enum.ReverbType.NoReverb or Enum.ReverbType.NoReverb
	pc(function() L.Ambient = L.Ambient end)
	for _, s in ipairs(game:GetService("SoundService"):GetChildren()) do
		if s:IsA("Sound") then s.Volume = v and 0 or 1 end
	end
end
local function setMasterVolume(v)
	pc(function() game:GetService("SoundService"):SetAttribute("MasterVolume", v) end)
	pc(function() SS.Volume = v end)
end

-- === ОСВЕЩЕНИЕ ===
local clockConn
local function setTime(h)
	pc(function()
		L.ClockTime = h
		L.GeographicLatitude = 0
	end)
end
local function watchTime(h)
	if clockConn then clockConn:Disconnect() end
	clockConn = R.Heartbeat:Connect(function()
		pc(function() L.ClockTime = h end)
	end)
end
local function stopTime()
	if clockConn then clockConn:Disconnect() clockConn = nil end
end

-- Ambient color
local function setAmbientColor(r, g, b)
	pc(function()
		L.Ambient = Color3.fromRGB(r, g, b)
		L.OutdoorAmbient = Color3.fromRGB(r, g, b)
	end)
end

-- === МИР ===
local function clearParticles()
	for _, o in ipairs(W:GetDescendants()) do
		pc(function()
			if o:IsA("ParticleEmitter") then o.Enabled = false end
			if o:IsA("Trail") then o.Enabled = false end
			if o:IsA("Beam") then o.Enabled = false end
			if o:IsA("Smoke") then o.Enabled = false end
			if o:IsA("Fire") then o.Enabled = false end
			if o:IsA("Sparkles") then o.Enabled = false end
		end)
	end
end
local function restoreParticles()
	for _, o in ipairs(W:GetDescendants()) do
		pc(function()
			if o:IsA("ParticleEmitter") then o.Enabled = true end
			if o:IsA("Trail") then o.Enabled = true end
			if o:IsA("Beam") then o.Enabled = true end
			if o:IsA("Smoke") then o.Enabled = true end
			if o:IsA("Fire") then o.Enabled = true end
			if o:IsA("Sparkles") then o.Enabled = true end
		end)
	end
end

-- Убрать текстуры
local function noTextures()
	for _, o in ipairs(W:GetDescendants()) do
		pc(function()
			if o:IsA("BasePart") then o.Material = Enum.Material.SmoothPlastic end
			if o:IsA("Decal") or o:IsA("Texture") then o.Transparency = 1 end
		end)
	end
end

-- === MM2 ===
local function getRole(pl)
	if not pl or not pl.Character then return "Innocent" end
	local bp = pl:FindFirstChild("Backpack")
	if bp and (bp:FindFirstChild("Knife") or bp:FindFirstChild("Knife2")) then return "Murderer" end
	if pl.Character:FindFirstChild("Knife") or pl.Character:FindFirstChild("Knife2") then return "Murderer" end
	if bp and (bp:FindFirstChild("Gun") or bp:FindFirstChild("Revolver")) then return "Sheriff" end
	if pl.Character:FindFirstChild("Gun") or pl.Character:FindFirstChild("Revolver") then return "Sheriff" end
	return "Innocent"
end
local function getMurderer()
	for _, pl in ipairs(P:GetPlayers()) do
		if pl ~= LP and getRole(pl) == "Murderer" then return pl end
	end
	return nil
end
local function getSheriff()
	for _, pl in ipairs(P:GetPlayers()) do
		if pl ~= LP and getRole(pl) == "Sheriff" then return pl end
	end
	return nil
end

-- MM2 ESP с ролями
local mm2EspA, mm2EspD, mm2EspC = false, {}, {}
local function mm2Apply(pl)
	if pl == LP then return end
	local function onChar(char)
		if not mm2EspA or not char then return end
		local hl = char:FindFirstChild("ApoMM2ESP")
		if not hl then
			hl = Instance.new("Highlight", char)
			hl.Name = "ApoMM2ESP"
			hl.OutlineTransparency = 0.2
			hl.FillTransparency = 0.5
			hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		end
		mm2EspD[pl] = hl
	end
	if pl.Character then onChar(pl.Character) end
	table.insert(mm2EspC, pl.CharacterAdded:Connect(function(c) task.wait(0.5) if mm2EspA then onChar(c) end end))
end
local function mm2EspOn()
	if mm2EspA then return end
	mm2EspA = true
	for _, pl in ipairs(P:GetPlayers()) do mm2Apply(pl) end
	table.insert(mm2EspC, P.PlayerAdded:Connect(mm2Apply))
	table.insert(mm2EspC, R.Heartbeat:Connect(function()
		if not mm2EspA then return end
		for pl, hl in pairs(mm2EspD) do
			if hl and hl.Parent and pl.Character then
				local role = getRole(pl)
				if role == "Murderer" then
					hl.FillColor = Color3.fromRGB(255, 0, 0)
					hl.OutlineColor = Color3.fromRGB(255, 100, 100)
				elseif role == "Sheriff" then
					hl.FillColor = Color3.fromRGB(0, 100, 255)
					hl.OutlineColor = Color3.fromRGB(100, 180, 255)
				else
					hl.FillColor = Color3.fromRGB(0, 255, 0)
					hl.OutlineColor = Color3.fromRGB(150, 255, 150)
				end
			end
		end
	end))
end
local function mm2EspOff()
	mm2EspA = false
	for _, hl in pairs(mm2EspD) do if hl and hl.Parent then hl:Destroy() end end
	mm2EspD = {}
	for _, cn in ipairs(mm2EspC) do cn:Disconnect() end
	mm2EspC = {}
end

-- MM2 Auto TP к убийце
local function tpToMurderer()
	local m = getMurderer()
	local mr = m and m.Character and m.Character:FindFirstChild("HumanoidRootPart")
	local myR = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
	if mr and myR then myR.CFrame = CFrame.new(mr.Position + Vector3.new(0, 0, 3)) end
end

-- MM2 Auto TP к шерифу
local function tpToSheriff()
	local s = getSheriff()
	local sr = s and s.Character and s.Character:FindFirstChild("HumanoidRootPart")
	local myR = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
	if sr and myR then myR.CFrame = CFrame.new(sr.Position + Vector3.new(0, 0, 3)) end
end

-- MM2 Auto TP к оружию
local atA, atC = false, nil
local function tpToGunOn()
	if atA then return end
	atA = true
	atC = R.Heartbeat:Connect(function()
		local c = LP.Character
		local r = c and c:FindFirstChild("HumanoidRootPart")
		if not r then return end
		for _, o in ipairs(W:GetDescendants()) do
			if o:IsA("Tool") then
				local n = o.Name:lower()
				if n == "gun" or n == "revolver" then
					local hd = o:FindFirstChild("Handle")
					local par = o.Parent
					if hd and par and not par:IsA("Backpack") and not par:FindFirstChildOfClass("Humanoid") then
						r.CFrame = CFrame.new(hd.Position + Vector3.new(0, 3, 0))
						break
					end
				end
			end
		end
	end)
end
local function tpToGunOff() atA = false if atC then atC:Disconnect() atC = nil end end

-- MM2 Aimbot на убийцу
local aimA, aimC, aimSpeed = false, nil, 0.25
local function aimOn()
	if aimA then return end
	aimA = true
	aimC = R.RenderStepped:Connect(function()
		local cam = W.CurrentCamera
		local m = getMurderer()
		if not cam or not m or not m.Character then return end
		local h = m.Character:FindFirstChild("Head")
		if not h then return end
		local myC = LP.Character
		local myH = myC and myC:FindFirstChild("Head")
		if not myH then return end
		local p = RaycastParams.new()
		p.FilterType = Enum.RaycastFilterType.Exclude
		p.FilterDescendantsInstances = {myC, m.Character}
		local res = W:Raycast(myH.Position, h.Position - myH.Position, p)
		if res then return end
		cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, h.Position), aimSpeed)
	end)
end
local function aimOff() aimA = false if aimC then aimC:Disconnect() aimC = nil end end

-- MM2 Anti-Aim (вращение)
local aaA, aaC, aaSpeed = false, nil, 50
local function aaOn()
	if aaA then return end
	aaA = true
	aaC = R.Heartbeat:Connect(function()
		local r = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
		if r then r.CFrame = r.CFrame * CFrame.Angles(0, math.rad(aaSpeed), 0) end
	end)
end
local function aaOff() aaA = false if aaC then aaC:Disconnect() aaC = nil end end

-- MM2 Silent Aim к убийце
local saA, saC = false, nil
local function silentAimOn()
	if saA then return end
	saA = true
	saC = R.RenderStepped:Connect(function()
		local m = getMurderer()
		if not m or not m.Character then return end
		local h = m.Character:FindFirstChild("Head")
		local cam = W.CurrentCamera
		if h and cam then
			cam.CFrame = CFrame.new(cam.CFrame.Position, h.Position)
		end
	end)
end
local function silentAimOff() saA = false if saC then saC:Disconnect() saC = nil end end

-- MM2 Auto Knife Kill (приближение к убийце и активация ножа)
local akA, akC = false, nil
local function autoKillOn()
	if akA then return end
	akA = true
	akC = R.Heartbeat:Connect(function()
		local m = getMurderer()
		if not m or not m.Character then return end
		local mh = m.Character:FindFirstChild("HumanoidRootPart")
		local myR = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
		if mh and myR then
			myR.CFrame = CFrame.new(mh.Position + Vector3.new(0, 0, 3))
			local c = LP.Character
			local knife = c and (c:FindFirstChild("Knife") or c:FindFirstChild("Knife2"))
			if knife then pc(function() knife:Activate() end) end
		end
	end)
end
local function autoKillOff() akA = false if akC then akC:Disconnect() akC = nil end end

-- MM2 Gun Shoot (автоматический выстрел)
local gsA, gsC, lastShot = false, nil, 0
local shotDelay = 0.5
local function gunShootOn()
	if gsA then return end
	gsA = true
	gsC = R.Heartbeat:Connect(function()
		local now = tick()
		if now - lastShot < shotDelay then return end
		local c = LP.Character
		if not c then return end
		local gun = c:FindFirstChild("Gun") or c:FindFirstChild("Revolver")
		if not gun then
			local bp = LP:FindFirstChild("Backpack")
			if bp then gun = bp:FindFirstChild("Gun") or bp:FindFirstChild("Revolver") end
		end
		if gun then
			lastShot = now
			pc(function() gun:Activate() end)
		end
	end)
end
local function gunShootOff() gsA = false if gsC then gsC:Disconnect() gsC = nil end end

-- === ИНТЕРФЕЙСНЫЕ УТИЛИТЫ ===
local function notify(text)
	local n = Instance.new("TextLabel", sg)
	n.Size = UDim2.new(0, 240, 0, 32)
	n.Position = UDim2.new(1, -260, 0, 50)
	n.BackgroundColor3 = BG_ITEM
	n.Text = text
	n.TextColor3 = ACCENT_LIGHT
	n.Font = Enum.Font.GothamBold
	n.TextSize = 11
	n.BorderSizePixel = 0
	Instance.new("UICorner", n).CornerRadius = UDim.new(0, 8)
	local st = Instance.new("UIStroke", n)
	st.Color = ACCENT
	st.Thickness = 1.5
	n.BackgroundTransparency = 1
	n.TextTransparency = 1
	T:Create(n, TweenInfo.new(0.3), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
	task.delay(2, function()
		T:Create(n, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
		task.wait(0.4)
		if n.Parent then n:Destroy() end
	end)
end

-- ============================================================
-- СПИСОК ВКЛАДОК
-- ============================================================

-- ========== ВКЛАДКА 1: MM2 ==========
local T1 = makeTab("MM2", 1, "🔪")
mkSec("MM2 — ЧИТЫ", 0, T1)
mkToggle("MM2 ESP (роли)", 1, mm2EspOn, mm2EspOff, T1)
mkToggle("Aimbot на Murderer", 2, aimOn, aimOff, T1)
mkToggle("Silent Aim", 3, silentAimOn, silentAimOff, T1)
mkToggle("Anti-Aim (вращение)", 4, aaOn, aaOff, T1)
mkToggle("Auto TP к Murderer", 5, function()
	local c = R.Heartbeat:Connect(tpToMurderer)
	table.insert(mm2EspC, c)
end, function() end, T1)
mkToggle("Auto TP к Sheriff", 6, function()
	local c = R.Heartbeat:Connect(tpToSheriff)
	table.insert(mm2EspC, c)
end, function() end, T1)
mkToggle("Auto TP к пистолету", 7, tpToGunOn, tpToGunOff, T1)
mkToggle("Auto Knife Kill", 8, autoKillOn, autoKillOff, T1)
mkToggle("Auto Gun Shoot", 9, gunShootOn, gunShootOff, T1)
mkSlider("Aim Speed", 10, 0.05, 1, 0.25, function(v) aimSpeed = v end, T1)
mkSlider("Anti-Aim Speed", 11, 10, 200, 50, function(v) aaSpeed = v end, T1)
mkSlider("Shot Delay", 12, 0.1, 2, 0.5, function(v) shotDelay = v end, T1)

-- ========== ВКЛАДКА 2: ДВИЖЕНИЕ ==========
local T2 = makeTab("MOVE", 2, "🏃")
mkSec("ДВИЖЕНИЕ", 0, T2)
mkSlider("WalkSpeed", 1, 16, 300, 16, function(v) setSpeed(v) end, T2)
mkToggle("Speed Hack", 2, function() watchSpeed() end, stopSpeed, T2)
mkSlider("JumpPower", 3, 50, 500, 50, function(v) setJump(v) end, T2)
mkToggle("Jump Hack", 4, function() watchJump() end, stopJump, T2)
mkToggle("Infinite Jump", 5, infJumpOn, infJumpOff, T2)
mkToggle("Fly (WASD)", 6, flyOn, flyOff, T2)
mkToggle("Bunny Hop", 7, bhOn, bhOff, T2)
mkToggle("Noclip", 8, ncOn, ncOff, T2)
mkBtn("Teleport Up", 9, tpUp, T2)
mkBtn("Respawn", 10, respawn, T2)

-- ========== ВКЛАДКА 3: ВИЗУАЛ ==========
local T3 = makeTab("VISUAL", 3, "👁")
mkSec("ВИЗУАЛ", 0, T3)
mkToggle("Player ESP", 1, espOn, espOff, T3)
mkToggle("Self Glow", 2, glowOn, glowOff, T3)
mkToggle("Tracers", 3, tracersOn, tracersOff, T3)
mkToggle("Invisible Body", 4, nsOn, nsOff, T3)
mkToggle("Infinite Health", 5, infHpOn, infHpOff, T3)

-- ========== ВКЛАДКА 4: СВЕТ ==========
local T4 = makeTab("LIGHT", 4, "☀")
mkSec("ОСВЕЩЕНИЕ", 0, T4)
mkToggle("Fullbright", 1, fbOn, fbOff, T4)
mkToggle("No Shadows", 2, sdOn, sdOff, T4)
mkSlider("Brightness", 3, 0, 10, 2, function(v) setFullbright(v) end, T4)
mkSlider("Clock Time", 4, 0, 24, 14, function(v) setTime(v) end, T4)
mkToggle("Lock Time", 5, function()
	-- ставим 12:00
	watchTime(12)
end, stopTime, T4)
mkBtn("Day", 6, function() setTime(12) end, T4)
mkBtn("Night", 7, function() setTime(0) end, T4)
mkBtn("Sunset", 8, function() setTime(18) end, T4)
mkBtn("Morning", 9, function() setTime(6) end, T4)

-- ========== ВКЛАДКА 5: КАМЕРА ==========
local T5 = makeTab("CAMERA", 5, "🎥")
mkSec("КАМЕРА", 0, T5)
mkSlider("Field of View", 1, 30, 140, 70, function(v) setFOV(v) end, T5)
mkBtn("Reset FOV", 2, resetFOV, T5)
mkToggle("Free Cam (WASD)", 3, freeOn, freeOff, T5)
mkToggle("First Person", 4, function() setFirstPerson(true) end, function() setFirstPerson(false) end, T5)

-- ========== ВКЛАДКА 6: МИР ==========
local T6 = makeTab("WORLD", 6, "🌍")
mkSec("МИР", 0, T6)
mkBtn("Убрать частицы", 1, clearParticles, T6)
mkBtn("Вернуть частицы", 2, restoreParticles, T6)
mkBtn("Убрать текстуры", 3, noTextures, T6)

-- ========== ВКЛАДКА 7: ЗВУК ==========
local T7 = makeTab("SOUND", 7, "🔊")
mkSec("ЗВУК", 0, T7)
mkSlider("Master Volume", 1, 0, 10, 5, function(v) setMasterVolume(v / 10) end, T7)
mkBtn("Mute", 2, function() setMasterVolume(0) end, T7)
mkBtn("Unmute", 3, function() setMasterVolume(1) end, T7)

-- ========== ВКЛАДКА 8: ИГРОКИ ==========
local T8 = makeTab("PLAYERS", 8, "👥")
mkSec("ИГРОКИ", 0, T8)
mkBtn("Список игроков (в консоль)", 1, function()
	for _, pl in ipairs(P:GetPlayers()) do
		print(pl.Name, "— роль:", getRole(pl))
	end
	notify("Список выведен в консоль")
end, T8)
mkBtn("Кто убийца?", 2, function()
	local m = getMurderer()
	notify(m and ("Убийца: " .. m.Name) or "Убийца не найден")
end, T8)
mkBtn("Кто шериф?", 3, function()
	local s = getSheriff()
	notify(s and ("Шериф: " .. s.Name) or "Шериф не найден")
end, T8)

-- ========== ВКЛАДКА 9: ПОЛЁТ ==========
local T9 = makeTab("FLY", 9, "✈")
mkSec("ПОЛЁТ", 0, T9)
mkToggle("Fly (WASD)", 1, flyOn, flyOff, T9)
mkBtn("Загрузить FlyGuiV3", 2, function()
	pc(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
	end)
	notify("FlyGuiV3 загружен")
end, T9)

-- ========== ВКЛАДКА 10: BANHOP ==========
local T10 = makeTab("BANHOP", 10, "🐰")
mkSec("BANHOP", 0, T10)
mkToggle("Bunny Hop", 1, bhOn, bhOff, T10)
mkBtn("Прыжок вверх x5", 2, function()
	local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
	if h then
		for _ = 1, 5 do
			h:ChangeState(Enum.HumanoidStateType.Jumping)
			task.wait(0.05)
		end
	end
end, T10)

-- ========== ВКЛАДКА 11: КОНФИГ ==========
local T11 = makeTab("CONFIG", 11, "⚙")
mkSec("КОНФИГ", 0, T11)
mkBtn("Сохранить (заглушка)", 1, function() notify("Сохранено") end, T11)
mkBtn("Загрузить (заглушка)", 2, function() notify("Загружено") end, T11)
mkBtn("Перезапустить меню", 3, function()
	sg:Destroy()
	-- пересоздаём экран выбора
	local vsg2 = Instance.new("ScreenGui", pg)
	vsg2.Name = "ApoloniumSelect2"
	notify("Меню перезапущено (закрой и зайди снова)")
end, T11)

-- ========== ВКЛАДКА 12: О ХАБЕ ==========
local T12 = makeTab("ABOUT", 12, "ℹ")
mkSec("О ХАБЕ", 0, T12)
mkBtn("Версия", 1, function()
	notify(isInt and "APOLONIUM INTERNAL v2.0" or "APOLONIUM EXTERNAL v2.0")
      local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
		if h then
			for _ = 1, 5 do
				h:ChangeState(Enum.HumanoidStateType.Jumping)
				task.wait(0.05)
			end
		end
	end, T10)
	mkToggle("Auto Bunny (зажать Space)", 3, function()
		bhOn()
	end, bhOff, T10)
	mkSlider("Bhop Power", 4, 50, 500, 50, function(v)
		local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
		if h then h.UseJumpPower = true h.JumpPower = v end
	end, T10)

	-- ========== ВКЛАДКА 11: КОНФИГ ==========
	local T11 = makeTab("CONFIG", 11, "⚙")
	mkSec("КОНФИГ", 0, T11)
	mkBtn("Сохранить (заглушка)", 1, function() notify("Сохранено") end, T11)
	mkBtn("Загрузить (заглушка)", 2, function() notify("Загружено") end, T11)
	mkBtn("Перезапустить меню", 3, function()
		sg:Destroy()
		notify("Меню закрыто. Перезапусти скрипт.")
	end, T11)

	-- ========== ВКЛАДКА 12: О ХАБЕ ==========
	local T12 = makeTab("ABOUT", 12, "ℹ")
	mkSec("О ХАБЕ", 0, T12)
	mkBtn("Версия", 1, function()
		notify(isInt and "APOLONIUM INTERNAL v2.0" or "APOLONIUM EXTERNAL v2.0")
	end, T12)
	mkBtn("Информация", 2, function()
		notify("Apolonium Hub • by ты")
	end, T12)

	-- ========== EXTERNAL: СКРЫВАЕМ ЛИШНИЕ ВКЛАДКИ ==========
	if isExt then
		-- В external оставляем: MM2 (частично), MOVE, VISUAL, FLY, BANHOP, ABOUT
		-- Скрываем: LIGHT, CAMERA, WORLD, SOUND, PLAYERS, CONFIG (порядок 4,5,6,7,8,11)
		local hideOrders = {4, 5, 6, 7, 8, 11}
		for _, ord in ipairs(hideOrders) do
			if tabButtons[ord] then tabButtons[ord].Visible = false end
			if tabContents[ord] then tabContents[ord].Visible = false end
		end
		-- Автоматически открываем MM2
		if tabButtons[1] then
			tabButtons[1].BackgroundColor3 = BG_ITEM_ACTIVE
			tabButtons[1].TextColor3 = ACCENT_LIGHT
			tabContents[1].Visible = true
		end
	else
		-- В internal открываем MM2
		if tabButtons[1] then
			tabButtons[1].BackgroundColor3 = BG_ITEM_ACTIVE
			tabButtons[1].TextColor3 = ACCENT_LIGHT
			tabContents[1].Visible = true
		end
	end
end

-- ============================================================
-- ПОДКЛЮЧАЕМ КНОПКИ ВЫБОРА ВЕРСИИ
-- ============================================================
VExtBtn.MouseButton1Click:Connect(function()
	buildMenu("external")
end)
VIntBtn.MouseButton1Click:Connect(function()
	buildMenu("internal")
end)
