-- إنشاء الشاشة والقائمة
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FarmButton = Instance.new("TextButton")
local ShowPointsButton = Instance.new("TextButton")
local SpeedInput = Instance.new("TextBox")
local CodeButton = Instance.new("TextButton")

-- زر التبديل (الدائرة) مع حاويته
local ToggleContainer = Instance.new("Frame")
local ToggleLabel = Instance.new("TextLabel")
local ToggleCircleButton = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 270) -- تم زيادة الطول قليلاً لاستيعاب الخيار الجديد
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "قائمة التحكم النهائية"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- الإحداثيات العامة
local waypoints = {
    Vector3.new(61.82, 254.96, 56.74),   -- النقطة 1
    Vector3.new(47.26, 254.76, 263.28),  -- النقطة 2
    Vector3.new(160.40, 254.86, 250.37), -- النقطة 3
    Vector3.new(160.37, 255.18, 227.71), -- النقطة 4
    Vector3.new(159.49, 254.99, 204.32), -- النقطة 5
    Vector3.new(164.69, 254.99, 202.29), -- النقطة 6
    Vector3.new(148.91, 254.74, 208.63), -- النقطة 7
    Vector3.new(125.54, 254.74, 201.89)  -- النقطة 8
}

-- نقاط الممرات
local aislePoints = {
    Vector3.new(121.61, 255.32, 202.77), -- النقطة 1
    Vector3.new(125.51, 255.32, 184.90), -- النقطة 3
    Vector3.new(128.39, 255.32, 167.04)  -- النقطة 5
}

SpeedInput.Parent = MainFrame
SpeedInput.Size = UDim2.new(0.9, 0, 0, 30)
SpeedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.PlaceholderText = "السرعة (افتراضي: 25)"
SpeedInput.Text = "25"
SpeedInput.TextSize = 13

-- تصميم خيار الدائرة (تشغيل/إيقاف السكربت بالكامل)
ToggleContainer.Parent = MainFrame
ToggleContainer.Size = UDim2.new(0.9, 0, 0, 35)
ToggleContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

ToggleLabel.Parent = ToggleContainer
ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
ToggleLabel.Position = UDim2.new(0.05, 0, 0, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "تفعيل السكربت:"
ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleLabel.TextSize = 13
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

ToggleCircleButton.Parent = ToggleContainer
ToggleCircleButton.Size = UDim2.new(0, 24, 0, 24)
ToggleCircleButton.Position = UDim2.new(0.8, 0, 0.5, -12)
ToggleCircleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleCircleButton.Text = ""
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0) -- يجعل الزر على شكل دائرة كاملة
UICorner.Parent = ToggleCircleButton

FarmButton.Parent = MainFrame
FarmButton.Size = UDim2.new(0.9, 0, 0, 35)
FarmButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
FarmButton.Text = "فرام صناديق: [معطل]"
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.TextSize = 14

ShowPointsButton.Parent = MainFrame
ShowPointsButton.Size = UDim2.new(0.9, 0, 0, 35)
ShowPointsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
ShowPointsButton.Text = "إظهار النقاط: [مخفية]"
ShowPointsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowPointsButton.TextSize = 14

local scriptEnabled = true -- متغير للتحكم بتشغيل أو إيقاف السكربت بالكامل
local autoFarm = false
local showPointsEnabled = false
local pointsFolder = nil
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- دالة زر الدائرة لقفل أو فتح السكربت
ToggleCircleButton.MouseButton1Click:Connect(function()
    scriptEnabled = not scriptEnabled
    if scriptEnabled then
        ToggleCircleButton
