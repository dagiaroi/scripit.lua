-- =================================================================
-- PHẦN 1: KHỞI TẠO SCREEN GUI & BIẾN CẤU HÌNH
-- =================================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local OldGui = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("UniversalAllGamesMenu")
if OldGui then OldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalAllGamesMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999999
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

_G.CorrectKey = "TRZ"
_G.OriginalMenuPos = UDim2.new(0.5, -200, 0.5, -150)
_G.OriginalMenuSize = UDim2.new(0, 420, 0, 300)
_G.ScreenGui = ScreenGui
-- =================================================================
-- PHẦN 2: CÁC HÀM HIỆU ỨNG MÀU SẮC (RAINBOW)
-- =================================================================
function _G.ApplyRainbowBorder(UIStroke)
	task.spawn(function()
		local hue = 0
		while UIStroke and UIStroke.Parent do
			hue = (hue + 0.008) % 1
			UIStroke.Color = Color3.fromHSV(hue, 1, 1)
			task.wait(0.03)
		end
	end)
end

function _G.ApplyRainbowText(TextLabel)
	task.spawn(function()
		local hue = 0
		while TextLabel and TextLabel.Parent do
			hue = (hue + 0.01) % 1
			TextLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
			task.wait(0.03)
		end
	end)
end
-- =================================================================
-- PHẦN 3: INTRO SCREEN & CAPTCHA GIAO DIỆN XÁC MINH
-- =================================================================
local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundTransparency = 1
IntroFrame.Parent = ScreenGui

local IntroLabel = Instance.new("TextLabel")
IntroLabel.Size = UDim2.new(1, 0, 0, 80)
IntroLabel.Position = UDim2.new(0, 0, 0.5, -40)
IntroLabel.BackgroundTransparency = 1
IntroLabel.Text = ""
IntroLabel.Font = Enum.Font.SourceSansBold
IntroLabel.TextSize = 28
IntroLabel.TextTransparency = 1
IntroLabel.TextStrokeTransparency = 1
IntroLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
IntroLabel.Parent = IntroFrame

local CaptchaFrame = Instance.new("Frame")
CaptchaFrame.Size = UDim2.new(0, 260, 0, 160)
CaptchaFrame.Position = UDim2.new(0.5, -130, 0.5, -80)
CaptchaFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CaptchaFrame.Active = true
CaptchaFrame.Draggable = true
CaptchaFrame.Visible = false
CaptchaFrame.Parent = ScreenGui
Instance.new("UICorner", CaptchaFrame).CornerRadius = UDim.new(0, 12)

local CaptchaTitle = Instance.new("TextLabel")
CaptchaTitle.Size = UDim2.new(1, -20, 0, 40)
CaptchaTitle.Position = UDim2.new(0, 10, 0, 15)
CaptchaTitle.BackgroundTransparency = 1
CaptchaTitle.Text = "Kiểm tra xem bạn phải con người không"
CaptchaTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
CaptchaTitle.TextWrapped = true
CaptchaTitle.Font = Enum.Font.SourceSansBold
CaptchaTitle.TextSize = 15
CaptchaTitle.Parent = CaptchaFrame

local CheckBox = Instance.new("TextButton")
CheckBox.Size = UDim2.new(0, 35, 0, 35)
CheckBox.Position = UDim2.new(0, 20, 0, 80)
CheckBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
CheckBox.Text = ""
CheckBox.Parent = CaptchaFrame
Instance.new("UICorner", CheckBox).CornerRadius = UDim.new(0, 8)

local CheckLabel = Instance.new("TextLabel")
CheckLabel.Size = UDim2.new(0, 160, 0, 35)
CheckLabel.Position = UDim2.new(0, 65, 0, 80)
CheckLabel.BackgroundTransparency = 1
CheckLabel.Text = "Tôi không phải robot"
CheckLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
CheckLabel.TextXAlignment = Enum.TextXAlignment.Left
CheckLabel.Font = Enum.Font.SourceSans
CheckLabel.TextSize = 14
CheckLabel.Parent = CaptchaFrame

local Spinner = Instance.new("ImageLabel")
Spinner.Size = UDim2.new(0, 25, 0, 25)
Spinner.Position = UDim2.new(0.5, -12, 0.5, -12)
Spinner.BackgroundTransparency = 1
Spinner.Image = "rbxassetid://6031280882"
Spinner.ImageColor3 = Color3.fromRGB(0, 170, 255)
Spinner.Visible = false
Spinner.Parent = CheckBox
-- =================================================================
-- PHẦN 4: KEY INPUT SCREEN & LOADING BAR
-- =================================================================
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 250, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyFrame.Visible = false
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, -20, 0, 40)
KeyTitle.Position = UDim2.new(0, 10, 0, 10)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "Nhập key vào di ccbm"
KeyTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
KeyTitle.Font = Enum.Font.SourceSansBold
KeyTitle.TextSize = 16
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0, 190, 0, 35)
KeyInput.Position = UDim2.new(0.5, -95, 0, 60)
KeyInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderText = "Nhập Key..."
KeyInput.Text = ""
KeyInput.Font = Enum.Font.SourceSans
KeyInput.TextSize = 14
KeyInput.Parent = KeyFrame
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 8)

local SubmitKeyBtn = Instance.new("TextButton")
SubmitKeyBtn.Size = UDim2.new(0, 190, 0, 35)
SubmitKeyBtn.Position = UDim2.new(0.5, -95, 0, 110)
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
SubmitKeyBtn.Text = "XÁC NHẬN"
SubmitKeyBtn.TextColor3 = Color3.fromRGB(15, 15, 15)
SubmitKeyBtn.Font = Enum.Font.SourceSansBold
SubmitKeyBtn.TextSize = 15
SubmitKeyBtn.Parent = KeyFrame
Instance.new("UICorner", SubmitKeyBtn).CornerRadius = UDim.new(0, 8)

local LoadFrame = Instance.new("Frame")
LoadFrame.Size = UDim2.new(0, 280, 0, 140)
LoadFrame.Position = UDim2.new(0.5, -140, 0.5, -70)
LoadFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LoadFrame.Visible = false
LoadFrame.Parent = ScreenGui
Instance.new("UICorner", LoadFrame).CornerRadius = UDim.new(0, 12)

local LoadStroke = Instance.new("UIStroke", LoadFrame)
LoadStroke.Thickness = 3
_G.ApplyRainbowBorder(LoadStroke)

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1, 0, 0, 30)
LoadTitle.Position = UDim2.new(0, 0, 0, 10)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "Loading..."
LoadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadTitle.Font = Enum.Font.SourceSansBold
LoadTitle.TextSize = 18
LoadTitle.Parent = LoadFrame

local RedStarSpinner = Instance.new("ImageLabel")
RedStarSpinner.Size = UDim2.new(0, 30, 0, 30)
RedStarSpinner.Position = UDim2.new(0.5, -15, 0, 42)
RedStarSpinner.BackgroundTransparency = 1
RedStarSpinner.Image = "rbxassetid://6031268524"
RedStarSpinner.ImageColor3 = Color3.fromRGB(255, 30, 30)
RedStarSpinner.Parent = LoadFrame

local BarBG = Instance.new("Frame")
BarBG.Size = UDim2.new(0.85, 0, 0, 16)
BarBG.Position = UDim2.new(0.075, 0, 0, 85)
BarBG.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
BarBG.Parent = LoadFrame
Instance.new("UICorner", BarBG).CornerRadius = UDim.new(0, 6)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 230, 120)
BarFill.Parent = BarBG
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(0, 6)
-- =================================================================
-- PHẦN 5: XỬ LÝ SỰ KIỆN INTRO, CAPTCHA & XÁC THỰC KEY
-- =================================================================
task.spawn(function()
	IntroLabel.Text = "Script by: Baconcute"
	IntroLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(IntroLabel, tweenInfo, {TextTransparency = 0, TextStrokeTransparency = 0}):Play()
	task.wait(1.8)
	local fadeOut1 = TweenService:Create(IntroLabel, tweenInfo, {TextTransparency = 1, TextStrokeTransparency = 1})
	fadeOut1:Play()
	fadeOut1.Completed:Wait()
	
	IntroLabel.Text = "thank you for using the script :D"
	_G.ApplyRainbowText(IntroLabel)
	TweenService:Create(IntroLabel, tweenInfo, {TextTransparency = 0, TextStrokeTransparency = 0}):Play()
	task.wait(2)
	local fadeOut2 = TweenService:Create(IntroLabel, tweenInfo, {TextTransparency = 1, TextStrokeTransparency = 1})
	fadeOut2:Play()
	fadeOut2.Completed:Wait()
	
	IntroFrame:Destroy()
	CaptchaFrame.Visible = true
end)

CheckBox.MouseButton1Click:Connect(function()
	CheckBox.Text = ""
	Spinner.Visible = true
	task.spawn(function()
		local rot = 0
		while Spinner.Visible do
			rot = rot + 15
			Spinner.Rotation = rot
			task.wait(0.02)
		end
	end)
	task.wait(1.5)
	Spinner.Visible = false
	CheckBox.Text = "✓"
	CheckBox.TextColor3 = Color3.fromRGB(0, 230, 100)
	CheckBox.TextSize = 22
	task.wait(0.5)
	CaptchaFrame.Visible = false
	KeyFrame.Visible = true
end)

local function VerifyAndProceedKey()
	if KeyInput.Text == _G.CorrectKey then
		KeyFrame.Visible = false
		LoadFrame.Visible = true
		BarFill.Size = UDim2.new(0, 0, 1, 0)
		
		local isStarRotating = true
		task.spawn(function()
			local starRot = 0
			while isStarRotating and LoadFrame.Visible do
				starRot = (starRot + 10) % 360
				RedStarSpinner.Rotation = starRot
				task.wait(0.02)
			end
		end)

		local Tween = TweenService:Create(BarFill, TweenInfo.new(2, Enum.EasingStyle.Linear), {
			Size = UDim2.new(1, 0, 1, 0)
		})
		Tween:Play()
		Tween.Completed:Connect(function()
			isStarRotating = false
			LoadFrame.Visible = false
			if _G.CircleToggleBtn then _G.CircleToggleBtn.Visible = true end
			if _G.SelectTab then _G.SelectTab("main") end
			if _G.OpenMenuWithAnimation then _G.OpenMenuWithAnimation() end
		end)
	end
end

KeyInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then VerifyAndProceedKey() end
end)

SubmitKeyBtn.MouseButton1Click:Connect(function()
	VerifyAndProceedKey()
end)
-- =================================================================
-- PHẦN 6: GIAO DIỆN KHUNG CHÍNH (MAIN MENU) & NÚT MỞ/ĐÓNG
-- =================================================================
local CircleToggleBtn = Instance.new("TextButton")
CircleToggleBtn.Size = UDim2.new(0, 60, 0, 60)
CircleToggleBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
CircleToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CircleToggleBtn.Text = "AIM"
CircleToggleBtn.TextSize = 16
CircleToggleBtn.Font = Enum.Font.SourceSansBold
CircleToggleBtn.Visible = false
CircleToggleBtn.Active = true
CircleToggleBtn.Draggable = true
CircleToggleBtn.Parent = ScreenGui
Instance.new("UICorner", CircleToggleBtn).CornerRadius = UDim.new(0, 8)

local CircleStroke = Instance.new("UIStroke", CircleToggleBtn)
CircleStroke.Thickness = 3
CircleStroke.Color = Color3.fromRGB(0, 140, 255)
_G.ApplyRainbowText(CircleToggleBtn)
_G.CircleToggleBtn = CircleToggleBtn

local MainFrame = Instance.new("Frame")
MainFrame.Size = _G.OriginalMenuSize
MainFrame.Position = _G.OriginalMenuPos
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 3
_G.ApplyRainbowBorder(MainStroke)

local TopTitle = Instance.new("TextLabel")
TopTitle.Size = UDim2.new(1, 0, 0, 30)
TopTitle.Position = UDim2.new(0, 0, 0, 5)
TopTitle.BackgroundTransparency = 1
TopTitle.Text = "all games V1.3"
TopTitle.TextColor3 = Color3.fromRGB(255, 50, 50)
TopTitle.Font = Enum.Font.SourceSansBold
TopTitle.TextSize = 14
TopTitle.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -32, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.Parent = MainFrame
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local NavFrame = Instance.new("Frame")
NavFrame.Size = UDim2.new(0, 130, 1, -45)
NavFrame.Position = UDim2.new(0, 10, 0, 38)
NavFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
NavFrame.Parent = MainFrame
Instance.new("UICorner", NavFrame).CornerRadius = UDim.new(0, 8)

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -160, 1, -45)
ContentFrame.Position = UDim2.new(0, 150, 0, 38)
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.Parent = MainFrame
Instance.new("UICorner", ContentFrame).CornerRadius = UDim.new(0, 8)
-- =================================================================
-- PHẦN 7: HỆ THỐNG TABS NAVIGATION & CONFIRM POPUP
-- =================================================================
local TargetConfirmPos = UDim2.new(0.5, -130, 0.5, -65)
local StartConfirmPos = UDim2.new(0.5, -130, 0, -150)

local ConfirmFrame = Instance.new("Frame")
ConfirmFrame.Size = UDim2.new(0, 260, 0, 130)
ConfirmFrame.Position = StartConfirmPos
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ConfirmFrame.Visible = false
ConfirmFrame.Active = true
ConfirmFrame.ZIndex = 10
ConfirmFrame.Parent = ScreenGui
Instance.new("UICorner", ConfirmFrame).CornerRadius = UDim.new(0, 12)

local ConfirmStroke = Instance.new("UIStroke", ConfirmFrame)
ConfirmStroke.Thickness = 2
ConfirmStroke.Color = Color3.fromRGB(255, 60, 60)

local ConfirmTitle = Instance.new("TextLabel")
ConfirmTitle.Size = UDim2.new(1, -20, 0, 40)
ConfirmTitle.Position = UDim2.new(0, 10, 0, 15)
ConfirmTitle.BackgroundTransparency = 1
ConfirmTitle.Text = "Bạn có muốn đóng tab không?"
ConfirmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmTitle.Font = Enum.Font.SourceSansBold
ConfirmTitle.TextSize = 15
ConfirmTitle.ZIndex = 11
ConfirmTitle.Parent = ConfirmFrame

local BtnNo = Instance.new("TextButton")
BtnNo.Size = UDim2.new(0, 90, 0, 35)
BtnNo.Position = UDim2.new(0.1, 0, 0.6, 0)
BtnNo.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
BtnNo.Text = "Không"
BtnNo.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnNo.Font = Enum.Font.SourceSansBold
BtnNo.ZIndex = 11
BtnNo.Parent = ConfirmFrame
Instance.new("UICorner", BtnNo).CornerRadius = UDim.new(0, 6)

local BtnYes = Instance.new("TextButton")
BtnYes.Size = UDim2.new(0, 90, 0, 35)
BtnYes.Position = UDim2.new(0.55, 0, 0.6, 0)
BtnYes.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
BtnYes.Text = "Có"
BtnYes.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnYes.Font = Enum.Font.SourceSansBold
BtnYes.ZIndex = 11
BtnYes.Parent = ConfirmFrame
Instance.new("UICorner", BtnYes).CornerRadius = UDim.new(0, 6)

_G.FeatureTabs = {}
local function HideAllTabs()
	for _, tab in pairs(_G.FeatureTabs) do tab.Visible = false end
end

local function CreateTab(name)
	local Tab = Instance.new("Frame")
	Tab.Size = UDim2.new(1, 0, 1, 0)
	Tab.BackgroundTransparency = 1
	Tab.Visible = false
	Tab.Parent = ContentFrame
	_G.FeatureTabs[name] = Tab
	return Tab
end

local ButtonsList = {"main", "profile", "aimbot", "esp", "noclip", "speed & jump", "fly"}
local NavBtnObjects = {}

function _G.SelectTab(name)
	for bName, bObj in pairs(NavBtnObjects) do
		if bName == name then
			bObj.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			bObj.TextColor3 = Color3.fromRGB(0, 0, 0)
		else
			bObj.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			bObj.TextColor3 = Color3.fromRGB(200, 200, 200)
		end
	end
	HideAllTabs()
	if _G.FeatureTabs[name] then
		_G.FeatureTabs[name].Visible = true
	end
end

for i, name in ipairs(ButtonsList) do
	local Btn = Instance.new("TextButton")
	Btn.Size = UDim2.new(0.9, 0, 0, 28)
	Btn.Position = UDim2.new(0.05, 0, 0, (i - 1) * 33 + 10)
	Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Btn.Text = name
	Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	Btn.Font = Enum.Font.SourceSansBold
	Btn.TextSize = 12
	Btn.Parent = NavFrame
	Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
	
	NavBtnObjects[name] = Btn
	Btn.MouseButton1Click:Connect(function() _G.SelectTab(name) end)
end

_G.MainTab = CreateTab("main")
_G.ProfileTab = CreateTab("profile")
_G.AimTab = CreateTab("aimbot")
_G.ESPTab = CreateTab("esp")
_G.NoclipTab = CreateTab("noclip")
_G.SpeedTab = CreateTab("speed & jump")
_G.FlyTab = CreateTab("fly")
-- =================================================================
-- PHẦN 8: MAIN TAB, PROFILE TAB & ANIMATION ĐÓNG MỞ MENU
-- =================================================================
local StatsService = game:GetService("Stats")
local RunService = game:GetService("RunService")

local MainUsersLabel = Instance.new("TextLabel")
MainUsersLabel.Size = UDim2.new(1, -20, 0, 40)
MainUsersLabel.Position = UDim2.new(0, 10, 0, 60)
MainUsersLabel.BackgroundTransparency = 1
MainUsersLabel.Text = "Số người đã bật & sài script:\n1 Users"
MainUsersLabel.TextColor3 = Color3.fromRGB(0, 230, 120)
MainUsersLabel.Font = Enum.Font.SourceSansBold
MainUsersLabel.TextSize = 16
MainUsersLabel.Parent = _G.MainTab

local function UpdateActiveUserCount()
	local activeCount = #Players:GetPlayers()
	MainUsersLabel.Text = "Số người đã bật & sài script:\n" .. tostring(activeCount) .. " Users"
end

Players.PlayerAdded:Connect(UpdateActiveUserCount)
Players.PlayerRemoving:Connect(UpdateActiveUserCount)
UpdateActiveUserCount()

local MainYtLabel = Instance.new("TextLabel")
MainYtLabel.Size = UDim2.new(1, -20, 0, 30)
MainYtLabel.Position = UDim2.new(0, 10, 0, 120)
MainYtLabel.BackgroundTransparency = 1
MainYtLabel.Text = "YouTube: Baconcute-99"
MainYtLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
MainYtLabel.Font = Enum.Font.SourceSansBold
MainYtLabel.TextSize = 15
MainYtLabel.Parent = _G.MainTab

local ProfileNameLabel = Instance.new("TextLabel")
ProfileNameLabel.Size = UDim2.new(0.55, 0, 0, 40)
ProfileNameLabel.Position = UDim2.new(0.05, 0, 0, 15)
ProfileNameLabel.BackgroundTransparency = 1
ProfileNameLabel.Text = "User: " .. LocalPlayer.DisplayName
ProfileNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ProfileNameLabel.TextXAlignment = Enum.TextXAlignment.Left
ProfileNameLabel.Font = Enum.Font.SourceSansBold
ProfileNameLabel.TextSize = 14
ProfileNameLabel.TextWrapped = true
ProfileNameLabel.Parent = _G.ProfileTab

local ProfileFpsLabel = Instance.new("TextLabel")
ProfileFpsLabel.Size = UDim2.new(0.55, 0, 0, 25)
ProfileFpsLabel.Position = UDim2.new(0.05, 0, 0, 60)
ProfileFpsLabel.BackgroundTransparency = 1
ProfileFpsLabel.Text = "FPS: --"
ProfileFpsLabel.TextColor3 = Color3.fromRGB(0, 220, 255)
ProfileFpsLabel.TextXAlignment = Enum.TextXAlignment.Left
ProfileFpsLabel.Font = Enum.Font.SourceSansBold
ProfileFpsLabel.TextSize = 13
ProfileFpsLabel.Parent = _G.ProfileTab

local ProfilePingLabel = Instance.new("TextLabel")
ProfilePingLabel.Size = UDim2.new(0.55, 0, 0, 25)
ProfilePingLabel.Position = UDim2.new(0.05, 0, 0, 90)
ProfilePingLabel.BackgroundTransparency = 1
ProfilePingLabel.Text = "Ping: -- ms"
ProfilePingLabel.TextColor3 = Color3.fromRGB(255, 170, 0)
ProfilePingLabel.TextXAlignment = Enum.TextXAlignment.Left
ProfilePingLabel.Font = Enum.Font.SourceSansBold
ProfilePingLabel.TextSize = 13
ProfilePingLabel.Parent = _G.ProfileTab

local AvatarBG = Instance.new("Frame")
AvatarBG.Size = UDim2.new(0, 80, 0, 80)
AvatarBG.Position = UDim2.new(0.62, 0, 0, 45)
AvatarBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AvatarBG.Parent = _G.ProfileTab
Instance.new("UICorner", AvatarBG).CornerRadius = UDim.new(0, 12)

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.new(1, -6, 1, -6)
AvatarImg.Position = UDim2.new(0, 3, 0, 3)
AvatarImg.BackgroundTransparency = 1
AvatarImg.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
AvatarImg.Parent = AvatarBG
Instance.new("UICorner", AvatarImg).CornerRadius = UDim.new(0, 10)

task.spawn(function()
	local content = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
	AvatarImg.Image = content
end)

task.spawn(function()
	local lastTime = os.clock()
	local frameCount = 0
	
	RunService.RenderStepped:Connect(function()
		frameCount = frameCount + 1
		local currentTime = os.clock()
		
		if currentTime - lastTime >= 1 then
			local fps = math.floor(frameCount / (currentTime - lastTime))
			ProfileFpsLabel.Text = "FPS: " .. tostring(fps)
			
			local ping = 0
			pcall(function()
				ping = math.floor(StatsService.Network.ServerStatsItem["Data Ping"]:GetValue())
			end)
			ProfilePingLabel.Text = "Ping: " .. tostring(ping) .. " ms"
			
			frameCount = 0
			lastTime = currentTime
		end
	end)
end)

local isAnimating = false

function _G.OpenMenuWithAnimation()
	if isAnimating then return end
	isAnimating = true
	local centerPos = _G.OriginalMenuPos
	local startSize = UDim2.new(0, 0, 0, 0)
	local startPos = UDim2.new(centerPos.X.Scale, centerPos.X.Offset + (_G.OriginalMenuSize.X.Offset / 2), centerPos.Y.Scale, centerPos.Y.Offset + (_G.OriginalMenuSize.Y.Offset / 2))
	MainFrame.Size = startSize
	MainFrame.Position = startPos
	MainFrame.Visible = true
	local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local tweenSize = TweenService:Create(MainFrame, tweenInfo, {Size = _G.OriginalMenuSize, Position = _G.OriginalMenuPos})
	tweenSize:Play()
	tweenSize.Completed:Connect(function() isAnimating = false end)
end

function _G.CloseMenuWithAnimation()
	if isAnimating then return end
	isAnimating = true
	local centerPos = _G.OriginalMenuPos
	local targetSize = UDim2.new(0, 0, 0, 0)
	local targetPos = UDim2.new(centerPos.X.Scale, centerPos.X.Offset + (_G.OriginalMenuSize.X.Offset / 2), centerPos.Y.Scale, centerPos.Y.Offset + (_G.OriginalMenuSize.Y.Offset / 2))
	local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	local tweenSize = TweenService:Create(MainFrame, tweenInfo, {Size = targetSize, Position = targetPos})
	tweenSize:Play()
	tweenSize.Completed:Connect(function()
		MainFrame.Visible = false
		MainFrame.Size = _G.OriginalMenuSize
		MainFrame.Position = _G.OriginalMenuPos
		isAnimating = false
	end)
end

CircleToggleBtn.MouseButton1Click:Connect(function()
	if MainFrame.Visible then
		_G.CloseMenuWithAnimation()
	else
		_G.OpenMenuWithAnimation()
	end
end)

CloseBtn.MouseButton1Click:Connect(function()
	ConfirmFrame.Position = StartConfirmPos
	ConfirmFrame.Visible = true
	local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	TweenService:Create(ConfirmFrame, tweenInfo, {Position = TargetConfirmPos}):Play()
end)

BtnNo.MouseButton1Click:Connect(function()
	local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	local tw = TweenService:Create(ConfirmFrame, tweenInfo, {Position = StartConfirmPos})
	tw:Play()
	tw.Completed:Connect(function()
		ConfirmFrame.Visible = false
	end)
end)

BtnYes.MouseButton1Click:Connect(function()
	if _G.ESP_Folder then _G.ESP_Folder:Destroy() end
	ScreenGui:Destroy()
end)
-- =================================================================
-- PHẦN 9: XÂY DỰNG GIAO DIỆN TÍNH NĂNG (AIMBOT, ESP, NOCLIP, SPEED, FLY)
-- =================================================================
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

_G.LockedTargetPlayer = nil
_G.CurrentAimbotTarget = nil
_G.AimbotEnabled = false
_G.AimTorso = true
_G.AimHead = false
_G.NoAimAlly = true

_G.ESPEnabled = false
_G.NoclipEnabled = false
_G.SpeedValue = 16
_G.JumpPowerValue = 16

_G.FlyEnabled = false
_G.FlySpeed = 16

_G.ESP_Folder = Instance.new("Folder", Workspace)
_G.ESP_Folder.Name = "Universal_ESP_Folder"

local function IsAlly(player)
	if not player then return false end
	if player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
		return true
	end
	return false
end

local function CreateToggleBtn(parent, yPos, text, defaultState, isFullWidth, callback)
	local Btn = Instance.new("TextButton")
	if isFullWidth then
		Btn.Size = UDim2.new(0.96, 0, 0, 36)
		Btn.Position = UDim2.new(0.02, 0, 0, yPos)
	else
		Btn.Size = UDim2.new(0.48, 0, 0, 32)
		Btn.Position = UDim2.new(0.02, 0, 0, yPos)
	end
	
	Btn.BackgroundColor3 = defaultState and Color3.fromRGB(0, 170, 80) or Color3.fromRGB(50, 50, 50)
	Btn.Text = text .. ": " .. (defaultState and "ON" or "OFF")
	Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	Btn.Font = Enum.Font.SourceSans
	Btn.TextSize = 12
	Btn.Parent = parent
	Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

	Btn.MouseButton1Click:Connect(function()
		local newState = not (Btn.BackgroundColor3 == Color3.fromRGB(0, 170, 80))
		Btn.BackgroundColor3 = newState and Color3.fromRGB(0, 170, 80) or Color3.fromRGB(50, 50, 50)
		Btn.Text = text .. ": " .. (newState and "ON" or "OFF")
		callback(newState)
	end)
	return Btn
end

CreateToggleBtn(_G.AimTab, 10, "Bật Aimbot", false, false, function(s) _G.AimbotEnabled = s end)
CreateToggleBtn(_G.AimTab, 50, "No Aim Ally", true, false, function(s) _G.NoAimAlly = s end)

local TorsoBtn, HeadBtn

TorsoBtn = CreateToggleBtn(_G.AimTab, 90, "Aim Torso", true, false, function(s)
	_G.AimTorso = s
	if s then
		_G.AimHead = false
		if HeadBtn then
			HeadBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			HeadBtn.Text = "Aim Head: OFF"
		end
	end
end)

HeadBtn = CreateToggleBtn(_G.AimTab, 130, "Aim Head", false, false, function(s)
	_G.AimHead = s
	if s then
		_G.AimTorso = false
		if TorsoBtn then
			TorsoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			TorsoBtn.Text = "Aim Torso: OFF"
		end
	end
end)

local PlayerListScroll = Instance.new("ScrollingFrame")
PlayerListScroll.Size = UDim2.new(0.46, 0, 0.9, 0)
PlayerListScroll.Position = UDim2.new(0.52, 0, 0.05, 0)
PlayerListScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PlayerListScroll.ScrollBarThickness = 4
PlayerListScroll.Parent = _G.AimTab
Instance.new("UICorner", PlayerListScroll).CornerRadius = UDim.new(0, 6)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = PlayerListScroll
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)

local function RefreshPlayerList()
	for _, child in pairs(PlayerListScroll:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local PBtn = Instance.new("TextButton")
			PBtn.Size = UDim2.new(1, -6, 0, 25)
			PBtn.Position = UDim2.new(0, 3, 0, 0)
			
			if _G.LockedTargetPlayer == player then
				PBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
				PBtn.Text = "[LOCKED] " .. player.DisplayName
			else
				PBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				PBtn.Text = player.DisplayName
			end
			
			PBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			PBtn.Font = Enum.Font.SourceSansBold
			PBtn.TextSize = 11
			PBtn.Parent = PlayerListScroll
			Instance.new("UICorner", PBtn).CornerRadius = UDim.new(0, 4)
			
			PBtn.MouseButton1Click:Connect(function()
				if _G.LockedTargetPlayer == player then
					_G.LockedTargetPlayer = nil
				else
					_G.LockedTargetPlayer = player
				end
				RefreshPlayerList()
			end)
		end
	end
	PlayerListScroll.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 29)
end

Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(function(plr)
	if _G.LockedTargetPlayer == plr then _G.LockedTargetPlayer = nil end
	RefreshPlayerList()
end)
RefreshPlayerList()

CreateToggleBtn(_G.ESPTab, 15, "ESP Kẻ Địch/Đồng Minh", false, true, function(s) _G.ESPEnabled = s end)
CreateToggleBtn(_G.NoclipTab, 15, "Noclip Xuyên Tường", false, true, function(s) _G.NoclipEnabled = s end)

local SliderLabel = Instance.new("TextLabel")
SliderLabel.Size = UDim2.new(1, -20, 0, 20)
SliderLabel.Position = UDim2.new(0, 10, 0, 10)
SliderLabel.BackgroundTransparency = 1
SliderLabel.Text = "Tốc độ (Speed): 16"
SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SliderLabel.Font = Enum.Font.SourceSans
SliderLabel.TextSize = 13
SliderLabel.Parent = _G.SpeedTab

local SliderBG = Instance.new("TextButton")
SliderBG.Size = UDim2.new(0.96, 0, 0, 14)
SliderBG.Position = UDim2.new(0.02, 0, 0, 35)
SliderBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SliderBG.Text = ""
SliderBG.AutoButtonColor = false
SliderBG.Parent = _G.SpeedTab
Instance.new("UICorner", SliderBG).CornerRadius = UDim.new(0, 6)

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SliderFill.Parent = SliderBG
Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 6)

local isDraggingSpeed = false

local function UpdateSpeed(input)
	local mousePosX = input.Position.X
	local bgAbsPos = SliderBG.AbsolutePosition.X
	local bgAbsSize = SliderBG.AbsoluteSize.X
	
	local percent = math.clamp((mousePosX - bgAbsPos) / bgAbsSize, 0, 1)
	SliderFill.Size = UDim2.new(percent, 0, 1, 0)
	_G.SpeedValue = math.floor(16 + (percent * (100 - 16)))
	SliderLabel.Text = "Tốc độ (Speed): " .. tostring(_G.SpeedValue)
end

SliderBG.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDraggingSpeed = true
		UpdateSpeed(input)
	end
end)

local JumpLabel = Instance.new("TextLabel")
JumpLabel.Size = UDim2.new(1, -20, 0, 20)
JumpLabel.Position = UDim2.new(0, 10, 0, 80)
JumpLabel.BackgroundTransparency = 1
JumpLabel.Text = "Jumping Power"
JumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpLabel.Font = Enum.Font.SourceSans
JumpLabel.TextSize = 13
JumpLabel.Parent = _G.SpeedTab

local JumpInput = Instance.new("TextBox")
JumpInput.Size = UDim2.new(0.96, 0, 0, 32)
JumpInput.Position = UDim2.new(0.02, 0, 0, 105)
JumpInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JumpInput.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpInput.Text = "16"
JumpInput.Font = Enum.Font.SourceSans
JumpInput.TextSize = 14
JumpInput.Parent = _G.SpeedTab
Instance.new("UICorner", JumpInput).CornerRadius = UDim.new(0, 6)

JumpInput.FocusLost:Connect(function()
	local num = tonumber(JumpInput.Text)
	if num then
		_G.JumpPowerValue = math.clamp(num, 0, 100)
		JumpInput.Text = tostring(_G.JumpPowerValue)
	else
		JumpInput.Text = tostring(_G.JumpPowerValue)
	end
end)

local FlySliderLabel = Instance.new("TextLabel")
FlySliderLabel.Size = UDim2.new(1, -20, 0, 20)
FlySliderLabel.Position = UDim2.new(0, 10, 0, 10)
FlySliderLabel.BackgroundTransparency = 1
FlySliderLabel.Text = "Tốc độ bay: 16"
FlySliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FlySliderLabel.Font = Enum.Font.SourceSans
FlySliderLabel.TextSize = 13
FlySliderLabel.Parent = _G.FlyTab

local FlySliderBG = Instance.new("TextButton")
FlySliderBG.Size = UDim2.new(0.96, 0, 0, 14)
FlySliderBG.Position = UDim2.new(0.02, 0, 0, 35)
FlySliderBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FlySliderBG.Text = ""
FlySliderBG.AutoButtonColor = false
FlySliderBG.Parent = _G.FlyTab
Instance.new("UICorner", FlySliderBG).CornerRadius = UDim.new(0, 6)

local FlySliderFill = Instance.new("Frame")
FlySliderFill.Size = UDim2.new(0, 0, 1, 0)
FlySliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
FlySliderFill.Parent = FlySliderBG
Instance.new("UICorner", FlySliderFill).CornerRadius = UDim.new(0, 6)

local isDraggingFly = false

local function UpdateFlySpeed(input)
	local mousePosX = input.Position.X
	local bgAbsPos = FlySliderBG.AbsolutePosition.X
	local bgAbsSize = FlySliderBG.AbsoluteSize.X
	
	local percent = math.clamp((mousePosX - bgAbsPos) / bgAbsSize, 0, 1)
	FlySliderFill.Size = UDim2.new(percent, 0, 1, 0)
	_G.FlySpeed = math.floor(16 + (percent * (50 - 16)))
	FlySliderLabel.Text = "Tốc độ bay: " .. tostring(_G.FlySpeed)
end

FlySliderBG.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDraggingFly = true
		UpdateFlySpeed(input)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDraggingSpeed = false
		isDraggingFly = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if isDraggingSpeed then UpdateSpeed(input) end
		if isDraggingFly then UpdateFlySpeed(input) end
	end
end)

local FlyFullBtn = Instance.new("TextButton")
FlyFullBtn.Size = UDim2.new(0.96, 0, 0, 36)
FlyFullBtn.Position = UDim2.new(0.02, 0, 0, 75)
FlyFullBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FlyFullBtn.Text = "FLY: OFF"
FlyFullBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyFullBtn.Font = Enum.Font.SourceSansBold
FlyFullBtn.TextSize = 13
FlyFullBtn.Parent = _G.FlyTab
Instance.new("UICorner", FlyFullBtn).CornerRadius = UDim.new(0, 6)
-- =================================================================
-- PHẦN 10: LUỒNG THỰC THI GAMEPLAY (AIMBOT, NOCLIP, FLY, SPEED & ESP)
-- =================================================================
local Camera = Workspace.CurrentCamera
local bodyVel, bodyGyro

local function StopFlying()
	if bodyVel then bodyVel:Destroy() bodyVel = nil end
	if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.PlatformStand = false
	end
end

local function StartFlying()
	StopFlying()
	local char = LocalPlayer.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChild("Humanoid")
	if not hrp or not hum then return end

	bodyVel = Instance.new("BodyVelocity")
	bodyVel.MaxForce = Vector3.new(1e9, 1e9, 1e9)
	bodyVel.Velocity = Vector3.zero
	bodyVel.Parent = hrp

	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
	bodyGyro.P = 9e4
	bodyGyro.CFrame = hrp.CFrame
	bodyGyro.Parent = hrp

	hum.PlatformStand = true
end

FlyFullBtn.MouseButton1Click:Connect(function()
	_G.FlyEnabled = not _G.FlyEnabled
	if _G.FlyEnabled then
		FlyFullBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
		FlyFullBtn.Text = "FLY: ON"
		StartFlying()
	else
		FlyFullBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		FlyFullBtn.Text = "FLY: OFF"
		StopFlying()
	end
end)

local function GetTargetPart()
	if _G.LockedTargetPlayer and _G.LockedTargetPlayer.Character and _G.LockedTargetPlayer.Character:FindFirstChild("Humanoid") and _G.LockedTargetPlayer.Character.Humanoid.Health > 0 then
		if not (_G.NoAimAlly and IsAlly(_G.LockedTargetPlayer)) then
			local part = _G.AimHead and _G.LockedTargetPlayer.Character:FindFirstChild("Head") or _G.LockedTargetPlayer.Character:FindFirstChild("HumanoidRootPart")
			if part then return part end
		end
	end
	
	if _G.CurrentAimbotTarget and _G.CurrentAimbotTarget.Parent then
		local hum = _G.CurrentAimbotTarget.Parent:FindFirstChild("Humanoid")
		local targetPlr = Players:GetPlayerFromCharacter(_G.CurrentAimbotTarget.Parent)
		
		if hum and hum.Health > 0 and not (_G.NoAimAlly and targetPlr and IsAlly(targetPlr)) then
			local _, onScreen = Camera:WorldToViewportPoint(_G.CurrentAimbotTarget.Position)
			if onScreen then return _G.CurrentAimbotTarget end
		end
	end

	local closestTarget = nil
	local shortestDistance = math.huge

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
			if _G.NoAimAlly and IsAlly(player) then continue end

			local targetPart = _G.AimHead and player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
			if targetPart then
				local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
				if onScreen then
					local mouseLoc = UserInputService:GetMouseLocation()
					local distance = (Vector2.new(screenPos.X, screenPos.Y) - mouseLoc).Magnitude
					if distance < shortestDistance then
						shortestDistance = distance
						closestTarget = targetPart
					end
				end
			end
		end
	end
	
	_G.CurrentAimbotTarget = closestTarget
	return closestTarget
end

RunService.RenderStepped:Connect(function()
	if _G.AimbotEnabled then
		local target = GetTargetPart()
		if target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position) end
	else
		_G.CurrentAimbotTarget = nil
	end

	if _G.NoclipEnabled and LocalPlayer.Character then
		for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
	end

	if _G.FlyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
		if hum then hum.PlatformStand = true end
		if not bodyVel or not bodyVel.Parent then StartFlying() end
		
		local moveDir = hum and hum.MoveDirection or Vector3.zero
		local flyVec = Vector3.zero
		
		if moveDir.Magnitude > 0 then
			local flatCamCFrame = CFrame.new(Vector3.zero, Camera.CFrame.LookVector * Vector3.new(1, 0, 1))
			local localMove = flatCamCFrame:VectorToObjectSpace(moveDir)
			
			local forwardVec = Camera.CFrame.LookVector * (-localMove.Z)
			local rightVec = Camera.CFrame.RightVector * localMove.X
			flyVec = (forwardVec + rightVec).Unit * _G.FlySpeed
		end
		
		bodyVel.Velocity = flyVec
		bodyGyro.CFrame = Camera.CFrame
	else
		if bodyVel then StopFlying() end
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
			local hum = LocalPlayer.Character.Humanoid
			hum.WalkSpeed = _G.SpeedValue
			hum.UseJumpPower = true
			hum.JumpPower = _G.JumpPowerValue
		end
	end
end)

task.spawn(function()
	while task.wait(0.5) do
		_G.ESP_Folder:ClearAllChildren()
		if _G.ESPEnabled then
			for _, player in pairs(Players:GetPlayers()) do
				if player ~= LocalPlayer then
					local char = player.Character or Workspace:FindFirstChild(player.Name)
					if char then
						local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char.PrimaryPart
						local head = char:FindFirstChild("Head")
						local hum = char:FindFirstChildOfClass("Humanoid")
						
						if hrp and head and hum and hum.Health > 0 then
							local isAlly = IsAlly(player)
							local color = isAlly and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(255, 30, 30)

							local Highlight = Instance.new("Highlight")
							Highlight.Adornee = char
							Highlight.FillColor = color
							Highlight.FillTransparency = 0.5
							Highlight.OutlineColor = color
							Highlight.Parent = _G.ESP_Folder

							local Billboard = Instance.new("BillboardGui")
							Billboard.Adornee = head
							Billboard.Size = UDim2.new(0, 150, 0, 30)
							Billboard.StudsOffset = Vector3.new(0, 2.5, 0)
							Billboard.AlwaysOnTop = true
							Billboard.Parent = _G.ESP_Folder

							local NameLabel = Instance.new("TextLabel")
							NameLabel.Size = UDim2.new(1, 0, 1, 0)
							NameLabel.BackgroundTransparency = 1
							NameLabel.Text = player.DisplayName
							NameLabel.TextColor3 = color
							NameLabel.TextStrokeTransparency = 0.2
							NameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
							NameLabel.Font = Enum.Font.SourceSansBold
							NameLabel.TextSize = 14
							NameLabel.Parent = Billboard
						end
					end
				end
			end
		end
	end
end)
