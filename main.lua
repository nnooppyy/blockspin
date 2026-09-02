-- انتظار تحميل اللعبة واللاعب بالكامل
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 10)

if not PlayerGui then return end

local DiscordInviteLink = "https://discord.gg/VPS4DC3Afb"

-- تنظيف أي نسخة قديمة لتجنب التكرار
if PlayerGui:FindFirstChild("UltimateControlGui") then
    PlayerGui.UltimateControlGui:Destroy()
end

-- إنشاء الشاشة الرئيسية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateControlGui"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- زر الدائرة العائم
local FloatingToggle = Instance.new("ImageButton")
FloatingToggle.Parent = ScreenGui
FloatingToggle.Size = UDim2.new(0, 52, 0, 52)
FloatingToggle.Position = UDim2.new(0.02, 0, 0.38, 0)
FloatingToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
FloatingToggle.Image = "rbxassetid://102828634787804" 
FloatingToggle.Draggable = true
FloatingToggle.ZIndex = 100

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = FloatingToggle

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 80, 100)
UIStroke.Thickness = 2.5
UIStroke.Parent = FloatingToggle

-- القائمة الرئيسية
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
MainFrame.BackgroundTransparency = 0.25
MainFrame.Position = UDim2.new(0.08, 0, 0.22, 0)
MainFrame.Size = UDim2.new(0, 360, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 50

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(90, 90, 110)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- شريط العنوان العلوي
local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
TopBar.BackgroundTransparency = 0.2
TopBar.ZIndex = 51

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

local FixCorner = Instance.new("Frame")
FixCorner.Parent = TopBar
FixCorner.Size = UDim2.new(1, 0, 0, 10)
FixCorner.Position = UDim2.new(0, 0, 1, -10)
FixCorner.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
FixCorner.BackgroundTransparency = 0.2
FixCorner.BorderSizePixel = 0
FixCorner.ZIndex = 51

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TopBar
TitleLabel.Size = UDim2.new(0, 150, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Control Menu"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 52

-- زر الإغلاق
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TopBar
CloseButton.Size = UDim2.new(0, 26, 0, 26)
CloseButton.Position = UDim2.new(1, -30, 0.5, -13)
CloseButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12
CloseButton.Font = Enum.Font.GothamBold
CloseButton.ZIndex = 52

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

----------------------------------------------------
-- التقسيم الداخلي
----------------------------------------------------
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 110, 1, -45)
Sidebar.Position = UDim2.new(0, 8, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
Sidebar.BackgroundTransparency = 0.4
Sidebar.ZIndex = 51

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 6)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local TabFarmButton = Instance.new("TextButton")
TabFarmButton.Parent = Sidebar
TabFarmButton.Size = UDim2.new(0.9, 0, 0, 34)
TabFarmButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
TabFarmButton.Text = "📦 Farm"
TabFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TabFarmButton.TextSize = 12
TabFarmButton.Font = Enum.Font.GothamBold
TabFarmButton.ZIndex = 52

local TabFarmCorner = Instance.new("UICorner")
TabFarmCorner.CornerRadius = UDim.new(0, 6)
TabFarmCorner.Parent = TabFarmButton

local TabSettingsButton = Instance.new("TextButton")
TabSettingsButton.Parent = Sidebar
TabSettingsButton.Size = UDim2.new(0.9, 0, 0, 34)
TabSettingsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TabSettingsButton.BackgroundTransparency = 0.3
TabSettingsButton.Text = "⚙️ Settings"
TabSettingsButton.TextColor3 = Color3.fromRGB(180, 180, 200)
TabSettingsButton.TextSize = 12
TabSettingsButton.Font = Enum.Font.GothamBold
TabSettingsButton.ZIndex = 52

local TabSettingsCorner = Instance.new("UICorner")
TabSettingsCorner.CornerRadius = UDim.new(0, 6)
TabSettingsCorner.Parent = TabSettingsButton

local TabOtherButton = Instance.new("TextButton")
TabOtherButton.Parent = Sidebar
TabOtherButton.Size = UDim2.new(0.9, 0, 0, 34)
TabOtherButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TabOtherButton.BackgroundTransparency = 0.3
TabOtherButton.Text = "📂 Other"
TabOtherButton.TextColor3 = Color3.fromRGB(180, 180, 200)
TabOtherButton.TextSize = 12
TabOtherButton.Font = Enum.Font.GothamBold
TabOtherButton.ZIndex = 52

local TabOtherCorner = Instance.new("UICorner")
TabOtherCorner.CornerRadius = UDim.new(0, 6)
TabOtherCorner.Parent = TabOtherButton

local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainFrame
ContentArea.Size = UDim2.new(1, -135, 1, -45)
ContentArea.Position = UDim2.new(0, 124, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 51

----------------------------------------------------
-- 1. محتوى قسم الفارم
----------------------------------------------------
local FarmContent = Instance.new("ScrollingFrame")
FarmContent.Parent = ContentArea
FarmContent.Size = UDim2.new(1, 0, 1, 0)
FarmContent.BackgroundTransparency = 1
FarmContent.Visible = true
FarmContent.CanvasSize = UDim2.new(0, 0, 0, 170)
FarmContent.ScrollBarThickness = 3
FarmContent.ZIndex = 51

local FarmContentLayout = Instance.new("UIListLayout")
FarmContentLayout.Parent = FarmContent
FarmContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
FarmContentLayout.Padding = UDim.new(0, 8)
FarmContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- زر الفارم الرئيسي
local FarmToggleContainer = Instance.new("TextButton")
FarmToggleContainer.Parent = FarmContent
FarmToggleContainer.Size = UDim2.new(0.95, 0, 0, 36)
FarmToggleContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
FarmToggleContainer.BackgroundTransparency = 0.3
FarmToggleContainer.Text = ""
FarmToggleContainer.AutoButtonColor = false
FarmToggleContainer.ZIndex = 52

local FarmToggleCorner = Instance.new("UICorner")
FarmToggleCorner.CornerRadius = UDim.new(0, 6)
FarmToggleCorner.Parent = FarmToggleContainer

local FarmToggleLabel = Instance.new("TextLabel")
FarmToggleLabel.Parent = FarmToggleContainer
FarmToggleLabel.Size = UDim2.new(1, -55, 1, 0)
FarmToggleLabel.Position = UDim2.new(0, 10, 0, 0)
FarmToggleLabel.BackgroundTransparency = 1
FarmToggleLabel.Text = "Quick-11 📦"
FarmToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmToggleLabel.TextSize = 12
FarmToggleLabel.Font = Enum.Font.GothamBold
FarmToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
FarmToggleLabel.ZIndex = 53

local SwitchBackground = Instance.new("Frame")
SwitchBackground.Parent = FarmToggleContainer
SwitchBackground.Size = UDim2.new(0, 38, 0, 20)
SwitchBackground.Position = UDim2.new(1, -44, 0.5, -10)
SwitchBackground.BackgroundColor3 = Color3.fromRGB(80, 80, 95)
SwitchBackground.ZIndex = 53

local SwitchBgCorner = Instance.new("UICorner")
SwitchBgCorner.CornerRadius = UDim.new(1, 0)
SwitchBgCorner.Parent = SwitchBackground

local SwitchKnob = Instance.new("Frame")
SwitchKnob.Parent = SwitchBackground
SwitchKnob.Size = UDim2.new(0, 16, 0, 16)
SwitchKnob.Position = UDim2.new(0, 2, 0.5, -8)
SwitchKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SwitchKnob.ZIndex = 54

local SwitchKnobCorner = Instance.new("UICorner")
SwitchKnobCorner.CornerRadius = UDim.new(1, 0)
SwitchKnobCorner.Parent = SwitchKnob

-- زر الايداع التلقائي
local DepositToggleContainer = Instance.new("TextButton")
DepositToggleContainer.Parent = FarmContent
DepositToggleContainer.Size = UDim2.new(0.95, 0, 0, 36)
DepositToggleContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
DepositToggleContainer.BackgroundTransparency = 0.3
DepositToggleContainer.Text = ""
DepositToggleContainer.AutoButtonColor = false
DepositToggleContainer.ZIndex = 52

local DepositToggleCorner = Instance.new("UICorner")
DepositToggleCorner.CornerRadius = UDim.new(0, 6)
DepositToggleCorner.Parent = DepositToggleContainer

local DepositToggleLabel = Instance.new("TextLabel")
DepositToggleLabel.Parent = DepositToggleContainer
DepositToggleLabel.Size = UDim2.new(1, -55, 1, 0)
DepositToggleLabel.Position = UDim2.new(0, 10, 0, 0)
DepositToggleLabel.BackgroundTransparency = 1
DepositToggleLabel.Text = "Auto Deposit 💰"
DepositToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DepositToggleLabel.TextSize = 12
DepositToggleLabel.Font = Enum.Font.GothamBold
DepositToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
DepositToggleLabel.ZIndex = 53

local DepositSwitchBackground = Instance.new("Frame")
DepositSwitchBackground.Parent = DepositToggleContainer
DepositSwitchBackground.Size = UDim2.new(0, 38, 0, 20)
DepositSwitchBackground.Position = UDim2.new(1, -44, 0.5, -10)
DepositSwitchBackground.BackgroundColor3 = Color3.fromRGB(80, 80, 95)
DepositSwitchBackground.ZIndex = 53

local DepositSwitchBgCorner = Instance.new("UICorner")
DepositSwitchBgCorner.CornerRadius = UDim.new(1, 0)
DepositSwitchBgCorner.Parent = DepositSwitchBackground

local DepositSwitchKnob = Instance.new("Frame")
DepositSwitchKnob.Parent = DepositSwitchBackground
DepositSwitchKnob.Size = UDim2.new(0, 16, 0, 16)
DepositSwitchKnob.Position = UDim2.new(0, 2, 0.5, -8)
DepositSwitchKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DepositSwitchKnob.ZIndex = 54

local DepositSwitchKnobCorner = Instance.new("UICorner")
DepositSwitchKnobCorner.CornerRadius = UDim.new(1, 0)
DepositSwitchKnobCorner.Parent = DepositSwitchKnob

local DepositInputBox = Instance.new("TextBox")
DepositInputBox.Parent = FarmContent
DepositInputBox.Size = UDim2.new(0.95, 0, 0, 32)
DepositInputBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
DepositInputBox.Text = "200"
DepositInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
DepositInputBox.PlaceholderText = "Target Deposit Amount..."
DepositInputBox.TextSize = 12
DepositInputBox.Font = Enum.Font.GothamBold
DepositInputBox.ZIndex = 52

local DepositInputCorner = Instance.new("UICorner")
DepositInputCorner.CornerRadius = UDim.new(0, 6)
DepositInputCorner.Parent = DepositInputBox

----------------------------------------------------
-- 2. محتوى قسم الإعدادات
----------------------------------------------------
local SettingsContent = Instance.new("Frame")
SettingsContent.Parent = ContentArea
SettingsContent.Size = UDim2.new(1, 0, 1, 0)
SettingsContent.BackgroundTransparency = 1
SettingsContent.Visible = false
SettingsContent.ZIndex = 51

local SettingsContentLayout = Instance.new("UIListLayout")
SettingsContentLayout.Parent = SettingsContent
SettingsContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
SettingsContentLayout.Padding = UDim.new(0, 8)
SettingsContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local ShowPointsButton = Instance.new("TextButton")
ShowPointsButton.Parent = SettingsContent
ShowPointsButton.Size = UDim2.new(0.95, 0, 0, 36)
ShowPointsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
ShowPointsButton.BackgroundTransparency = 0.2
ShowPointsButton.Text = "📍 Points: [Hidden]"
ShowPointsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowPointsButton.TextSize = 12
ShowPointsButton.Font = Enum.Font.GothamBold
ShowPointsButton.ZIndex = 52

local PointsCorner = Instance.new("UICorner")
PointsCorner.CornerRadius = UDim.new(0, 6)
PointsCorner.Parent = ShowPointsButton

local CopyLinkButton = Instance.new("TextButton")
CopyLinkButton.Parent = SettingsContent
CopyLinkButton.Size = UDim2.new(0.95, 0, 0, 36)
CopyLinkButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
CopyLinkButton.Text = "📋 Copy Server Link"
CopyLinkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyLinkButton.TextSize = 12
CopyLinkButton.Font = Enum.Font.GothamBold
CopyLinkButton.ZIndex = 52

local CopyLinkCorner = Instance.new("UICorner")
CopyLinkCorner.CornerRadius = UDim.new(0, 6)
CopyLinkCorner.Parent = CopyLinkButton

local CopyPosButton = Instance.new("TextButton")
CopyPosButton.Parent = SettingsContent
CopyPosButton.Size = UDim2.new(0.95, 0, 0, 36)
CopyPosButton.BackgroundColor3 = Color3.fromRGB(60, 130, 90)
CopyPosButton.Text = "📍 Copy Current Position"
CopyPosButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyPosButton.TextSize = 12
CopyPosButton.Font = Enum.Font.GothamBold
CopyPosButton.ZIndex = 52

local CopyPosCorner = Instance.new("UICorner")
CopyPosCorner.CornerRadius = UDim.new(0, 6)
CopyPosCorner.Parent = CopyPosButton

----------------------------------------------------
-- قائمة الإحداثيات الكاملة
----------------------------------------------------
local preStartPoint = Vector3.new(-96.79, 254.37, 555.12)  
local customStartPoint = Vector3.new(-67.63, 254.62, 550.38) 
local autoDepositPoint = Vector3.new(94.06, 254.74, 167.08) 

local waypoints = {
    Vector3.new(-445.96, 254.62, 295.86), 
    Vector3.new(-299.55, 254.63, 299.31), 
    Vector3.new(-72.42, 254.53, 300.61),  
    Vector3.new(160.40, 254.86, 250.37),  
    Vector3.new(160.37, 255.18, 227.71),
    Vector3.new(159.49, 254.99, 204.32),
    Vector3.new(164.69, 254.99, 202.29), -- نقطة 7 (للتوظيف)
    Vector3.new(146.79, 255.47, 204.95),  -- نقطة 8
    Vector3.new(125.54, 254.74, 201.89),  -- نقطة 9
}

local aislePoints = {
    Vector3.new(121.61, 255.32, 202.77), 
    Vector3.new(125.51, 255.32, 184.90), 
    Vector3.new(128.39, 255.32, 167.04)  -- رف S3
}

local pointsFolder = Instance.new("Folder")
pointsFolder.Name = "CustomWaypointsFolder"
pointsFolder.Parent = workspace

local function createVisualPoint(pos, text, colorName)
    local part = Instance.new("Part")
    part.Size = Vector3.new(1.5, 1.5, 1.5)
    part.Position = pos
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 0.5
    part.BrickColor = BrickColor.new(colorName)
    part.Parent = pointsFolder

    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 50, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = part

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard
end

local pointsVisible = false
ShowPointsButton.MouseButton1Click:Connect(function()
    pointsVisible = not pointsVisible
    if pointsVisible then
        ShowPointsButton.Text = "📍 Points: [Visible]"
        pointsFolder:ClearAllChildren()
        
        for index, pos in ipairs(waypoints) do
            createVisualPoint(pos, tostring(index), "Lime green")
        end
        for index, pos in ipairs(aislePoints) do
            createVisualPoint(pos, "S" .. tostring(index), "Bright blue")
        end
        createVisualPoint(autoDepositPoint, "Bank", "Bright yellow")
    else
        ShowPointsButton.Text = "📍 Points: [Hidden]"
        pointsFolder:ClearAllChildren()
    end
end)

CopyLinkButton.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(DiscordInviteLink) end)
    CopyLinkButton.Text = "✅ Copied Link!"
    task.wait(1.5)
    CopyLinkButton.Text = "📋 Copy Server Link"
end)

CopyPosButton.MouseButton1Click:Connect(function()
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local pos = LocalPlayer.Character.HumanoidRootPart.Position
            local posString = string.format("Vector3.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z)
            setclipboard(posString)
            CopyPosButton.Text = "✅ Copied Position!"
            task.wait(1.5)
            CopyPosButton.Text = "📍 Copy Current Position"
        end
    end)
end)

----------------------------------------------------
-- 3. محتوى قسم الأخرى (Other)
----------------------------------------------------
local OtherContent = Instance.new("Frame")
OtherContent.Parent = ContentArea
OtherContent.Size = UDim2.new(1, 0, 1, 0)
OtherContent.BackgroundTransparency = 1
OtherContent.Visible = false
OtherContent.ZIndex = 51

local OtherContentLayout = Instance.new("UIListLayout")
OtherContentLayout.Parent = OtherContent
OtherContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
OtherContentLayout.Padding = UDim.new(0, 8)
OtherContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local RespawnToggleContainer = Instance.new("TextButton")
RespawnToggleContainer.Parent = OtherContent
RespawnToggleContainer.Size = UDim2.new(0.95, 0, 0, 40)
RespawnToggleContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
RespawnToggleContainer.BackgroundTransparency = 0.3
RespawnToggleContainer.Text = ""
RespawnToggleContainer.AutoButtonColor = false
RespawnToggleContainer.ZIndex = 52

local RespawnToggleCorner = Instance.new("UICorner")
RespawnToggleCorner.CornerRadius = UDim.new(0, 6)
RespawnToggleCorner.Parent = RespawnToggleContainer

local RespawnToggleLabel = Instance.new("TextLabel")
RespawnToggleLabel.Parent = RespawnToggleContainer
RespawnToggleLabel.Size = UDim2.new(1, -55, 1, 0)
RespawnToggleLabel.Position = UDim2.new(0, 10, 0, 0)
RespawnToggleLabel.BackgroundTransparency = 1
RespawnToggleLabel.Text = "Auto Respawn 💀"
RespawnToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
RespawnToggleLabel.TextSize = 12
RespawnToggleLabel.Font = Enum.Font.GothamBold
RespawnToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
RespawnToggleLabel.ZIndex = 53

local RespawnSwitchBackground = Instance.new("Frame")
RespawnSwitchBackground.Parent = RespawnToggleContainer
RespawnSwitchBackground.Size = UDim2.new(0, 38, 0, 20)
RespawnSwitchBackground.Position = UDim2.new(1, -44, 0.5, -10)
RespawnSwitchBackground.BackgroundColor3 = Color3.fromRGB(80, 80, 95)
RespawnSwitchBackground.ZIndex = 53

local RespawnSwitchBgCorner = Instance.new("UICorner")
RespawnSwitchBgCorner.CornerRadius = UDim.new(1, 0)
RespawnSwitchBgCorner.Parent = RespawnSwitchBackground

local RespawnSwitchKnob = Instance.new("Frame")
RespawnSwitchKnob.Parent = RespawnSwitchBackground
RespawnSwitchKnob.Size = UDim2.new(0, 16, 0, 16)
RespawnSwitchKnob.Position = UDim2.new(0, 2, 0.5, -8)
RespawnSwitchKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RespawnSwitchKnob.ZIndex = 54

local RespawnSwitchKnobCorner = Instance.new("UICorner")
RespawnSwitchKnobCorner.CornerRadius = UDim.new(1, 0)
RespawnSwitchKnobCorner.Parent = RespawnSwitchKnob

----------------------------------------------------
-- التنقل بين التبويبات (Tabs)
----------------------------------------------------
TabFarmButton.MouseButton1Click:Connect(function()
    FarmContent.Visible = true
    SettingsContent.Visible = false
    OtherContent.Visible = false
    TabFarmButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    TabSettingsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabOtherButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
end)

TabSettingsButton.MouseButton1Click:Connect(function()
    FarmContent.Visible = false
    SettingsContent.Visible = true
    OtherContent.Visible = false
    TabSettingsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    TabFarmButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabOtherButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
end)

TabOtherButton.MouseButton1Click:Connect(function()
    FarmContent.Visible = false
    SettingsContent.Visible = false
    OtherContent.Visible = true
    TabOtherButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    TabFarmButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabSettingsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
end)

----------------------------------------------------
-- منطق الـ Auto Respawn
----------------------------------------------------
local autoRespawnEnabled = false

local function updateRespawnSwitchVisual()
    local ts = game:GetService("TweenService")
    local info = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    if autoRespawnEnabled then
        ts:Create(RespawnSwitchBackground, info, {BackgroundColor3 = Color3.fromRGB(50, 180, 80)}):Play()
        ts:Create(RespawnSwitchKnob, info, {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
    else
        ts:Create(RespawnSwitchBackground, info, {BackgroundColor3 = Color3.fromRGB(80, 80, 95)}):Play()
        ts:Create(RespawnSwitchKnob, info, {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
    end
end

RespawnToggleContainer.MouseButton1Click:Connect(function()
    autoRespawnEnabled = not autoRespawnEnabled
    updateRespawnSwitchVisual()
end)

local function isTrulyVisible(gui)
    if not gui or not gui.Parent then return false end
    local currentObj = gui
    while currentObj do
        if currentObj:IsA("GuiObject") and not currentObj.Visible then return false end
        currentObj = currentObj.Parent
    end
    return true
end

task.spawn(function()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local GuiService = game:GetService("GuiService")
    while true do
        task.wait(0.2)
        if autoRespawnEnabled then
            pcall(function()
                local targetButton = nil
                for _, gui in ipairs(PlayerGui:GetDescendants()) do
                    if (gui:IsA("TextButton") or gui:IsA("ImageButton")) then
                        local name = string.lower(gui.Name or "")
                        local text = gui:IsA("TextButton") and string.lower(gui.Text or "") or ""
                        if string.find(name, "respawn") or string.find(text, "respawn") then
                            if isTrulyVisible(gui) then
                                targetButton = gui
                                break
                            end
                        end
                    end
                end
                while autoRespawnEnabled and targetButton and isTrulyVisible(targetButton) do
                    pcall(function()
                        if getconnections then
                            for _, conn in ipairs(getconnections(targetButton.MouseButton1Click)) do conn:Fire() end
                            for _, conn in ipairs(getconnections(targetButton.Activated)) do conn:Fire() end
                        end
                    end)
                    local absPos = targetButton.AbsolutePosition
                    local absSize = targetButton.AbsoluteSize
                    local inset, _ = GuiService:GetGuiInset()
                    local clickX = absPos.X + (absSize.X / 2)
                    local clickY = absPos.Y + (absSize.Y / 2) + inset.Y
                    VirtualInputManager:SendMouseButtonEvent(clickX, clickY, 0, true, game, 0)
                    task.wait(0.02)
                    VirtualInputManager:SendMouseButtonEvent(clickX, clickY, 0, false, game, 0)
                    task.wait(0.15)
                end
            end)
        end
    end
end)

----------------------------------------------------
-- دوال التفاعل بالنقر الفضائي المباشر (Screen Coordinates)
----------------------------------------------------
local VirtualInputManager = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")

local function clickAtScreenPosition(x, y)
    pcall(function()
        local inset, _ = GuiService:GetGuiInset()
        local finalX = x
        local finalY = y + inset.Y
        VirtualInputManager:SendMouseButtonEvent(finalX, finalY, 0, true, game, 0)
        task.wait(0.02)
        VirtualInputManager:SendMouseButtonEvent(finalX, finalY, 0, false, game, 0)
    end)
end

local function typeInTextBox(amount)
    for _, gui in ipairs(PlayerGui:GetDescendants()) do
        if gui:IsA("TextBox") and gui.Visible then
            pcall(function()
                gui:CaptureFocus()
                gui.Text = tostring(amount)
                gui:ReleaseFocus(true)
            end)
            return true
        end
    end
    return false
end

local function getPlayerCash()
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        for _, stat in ipairs(leaderstats:GetChildren()) do
            local name = string.lower(stat.Name)
            if name == "cash" or name == "money" or name == "coins" then
                return tonumber(stat.Value) or 0
            end
        end
    end
    
    for _, gui in ipairs(PlayerGui:GetDescendants()) do
        if gui:IsA("TextLabel") and gui.Visible and not gui:IsDescendantOf(ScreenGui) then
            local txt = gui.Text or ""
            if string.find(txt, "%$") then
                local cleanStr = string.gsub(txt, ",", "")
                local cleanNum = tonumber(string.match(cleanStr, "%d+"))
                if cleanNum and cleanNum > 0 then
                    return cleanNum
                end
            end
        end
    end
    return 0
end

local autoDepositEnabled = false
local targetDepositAmount = 200
local depositCooldownTime = 0 
local isDepositing = false
local hasDepositedThisCycle = false 

-- التأكد أن اللاعب داخل البقالة
local function isInsideGrocery(pos)
    local minX, maxX = 85, 172
    local minZ, maxZ = 158, 218
    return pos.X >= minX and pos.X <= maxX and pos.Z >= minZ and pos.Z <= maxZ
end

local function checkDepositCondition(hrp)
    if not autoDepositEnabled then return false end
    if hasDepositedThisCycle then return false end
    
    local currentCash = getPlayerCash()
    local targetVal = tonumber(DepositInputBox.Text) or targetDepositAmount
    
    if not isInsideGrocery(hrp.Position) then return false end
    if currentCash < targetVal then return false end
    if tick() < depositCooldownTime then return false end
    
    return true
end

local function updateDepositSwitchVisual()
    local ts = game:GetService("TweenService")
    local info = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    if autoDepositEnabled then
        ts:Create(DepositSwitchBackground, info, {BackgroundColor3 = Color3.fromRGB(50, 180, 80)}):Play()
        ts:Create(DepositSwitchKnob, info, {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
    else
        ts:Create(DepositSwitchBackground, info, {BackgroundColor3 = Color3.fromRGB(80, 80, 95)}):Play()
        ts:Create(DepositSwitchKnob, info, {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
    end
end

DepositToggleContainer.MouseButton1Click:Connect(function()
    autoDepositEnabled = not autoDepositEnabled
    updateDepositSwitchVisual()
end)

DepositInputBox.FocusLost:Connect(function()
    local amount = tonumber(DepositInputBox.Text)
    if amount then
        targetDepositAmount = amount
    else
        DepositInputBox.Text = tostring(targetDepositAmount)
    end
end)

----------------------------------------------------
-- منطق التنقل والحركة وإيداع الأموال
----------------------------------------------------
local autoFarm = false
local TweenService = game:GetService("TweenService")
local Backpack = LocalPlayer:WaitForChild("Backpack")

FloatingToggle.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
CloseButton.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

local function checkAndUnsit(humanoid)
    if humanoid then
        if humanoid.Sit then
            humanoid.Sit = false
            humanoid.Jump = true
        end
        if humanoid.PlatformStand then humanoid.PlatformStand = false end
    end
end

local function isTeleportDetected()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        for _, gui in ipairs(playerGui:GetDescendants()) do
            if (gui:IsA("TextLabel") or gui:IsA("TextButton")) and gui.Visible then
                local text = string.lower(gui.Text or "")
                if string.find(text, "teleport detected") then return true end
            end
        end
    end
    return false
end

function moveToPositionHelper(hrp, targetPos, speed)
    if not (autoFarm or isDepositing) then return end
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    checkAndUnsit(humanoid)

    while isTeleportDetected() and (autoFarm or isDepositing) do task.wait(0.2) end
    if humanoid and humanoid.Health <= 0 then return end
    
    local safePos = Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z)
    local distance = (hrp.Position - safePos).Magnitude
    local tweenTime = distance / math.max(speed, 1)
    
    local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(safePos)})
    tween:Play()
    
    local expectedEnd = tick() + tweenTime
    repeat
        task.wait(0.05)
        checkAndUnsit(humanoid)
        if humanoid and humanoid.Health <= 0 then tween:Cancel() return end

        if isTeleportDetected() then
            tween:Pause()
            while isTeleportDetected() and (autoFarm or isDepositing) do task.wait(0.2) end
            if (autoFarm or isDepositing) then
                local remainingDist = (hrp.Position - safePos).Magnitude
                local remainingTime = remainingDist / math.max(speed, 1)
                tweenInfo = TweenInfo.new(remainingTime, Enum.EasingStyle.Linear)
                tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(safePos)})
                expectedEnd = tick() + remainingTime
                tween:Play()
            end
        end
    until tick() >= expectedEnd or not (autoFarm or isDepositing)
end

local function pressEKey()
    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local closestPrompt = nil
    local shortestDistance = 15

    for _, prompt in ipairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
            -- تجاهل أي برومبت داخل شخصية اللاعب
            if prompt:IsDescendantOf(character) then
                continue
            end

            local objectText = string.lower(tostring(prompt.ObjectText or ""))
            local actionText = string.lower(tostring(prompt.ActionText or ""))
            local name = string.lower(tostring(prompt.Name or ""))

            local isBoxPrompt = string.find(objectText, "box") or 
                               string.find(actionText, "box") or 
                               string.find(objectText, "pick") or 
                               string.find(actionText, "pick") or
                               string.find(name, "box") or
                               string.find(name, "pickup") or
                               string.find(name, "pick")

            if isBoxPrompt then
                local pos = nil
                
                if prompt.Parent then
                    if prompt.Parent:IsA("BasePart") then
                        pos = prompt.Parent.Position
                    elseif prompt.Parent:IsA("Model") and prompt.Parent.PrimaryPart then
                        pos = prompt.Parent.PrimaryPart.Position
                    elseif prompt.Parent.Parent and prompt.Parent.Parent:IsA("BasePart") then
                        pos = prompt.Parent.Parent.Position
                    elseif prompt.Parent:IsA("Attachment") and prompt.Parent.Parent and prompt.Parent.Parent:IsA("BasePart") then
                        pos = prompt.Parent.Parent.Position
                    end
                end

                if pos then
                    local distance = (hrp.Position - pos).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestPrompt = prompt
                    end
                end
            end
        end
    end

    if closestPrompt then
        pcall(function()
            closestPrompt.RequiresLineOfSight = false
            closestPrompt.MaxActivationDistance = 20
            closestPrompt.Enabled = true
            closestPrompt.HoldDuration = 0

            if fireproximityprompt then
                fireproximityprompt(closestPrompt)
                task.wait(0.03)
                fireproximityprompt(closestPrompt)
            end
        end)
    end

    for i = 1, 8 do
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait(0.025)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        task.wait(0.025)
    end
end

local function pressTwoKey()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Two, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Two, false, game)
    task.wait(0.05)
end

-- دالة الضغط على زر التوظيف بالإحداثيات المحددة (تضغط مرة واحدة فقط)
local hasAppliedThisSession = false
local function checkAndApplyJobIfNeeded()
    if hasAppliedThisSession then return end
    pcall(function()
        clickAtScreenPosition(367, 180)
        hasAppliedThisSession = true
        task.wait(0.3)
    end)
end

local function playerHasBox()
    if LocalPlayer.Character then
        local toolCount = 0
        for _, child in ipairs(LocalPlayer.Character:GetChildren()) do
            if child:IsA("Tool") then toolCount = toolCount + 1 end
        end
        for _, child in ipairs(Backpack:GetChildren()) do
            if child:IsA("Tool") then toolCount = toolCount + 1 end
        end
        if toolCount > 0 then return true end
    end
    return false
end

local function isUsingBoxActive()
    local char = LocalPlayer.Character
    if not char then return false end
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("Tool") then
            return true
        end
    end
    return false
end

local function findHiddenDeliveryTarget()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local searchCenter = waypoints[9]
    local targetPos = nil
    local minDist = 120

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(char) then
            local dist = (obj.Position - searchCenter).Magnitude
            if dist <= minDist then
                local isMatch = false
                if obj.Name == "Base" and obj:IsA("MeshPart") and obj.Size.Y < 2.5 then isMatch = true end
                if obj.Name == "Shelf" and obj.Transparency == 1 then
                    for _, child in ipairs(obj:GetChildren()) do
                        if child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("Highlight") or child:IsA("PointLight") then
                            if child.Enabled then isMatch = true break end
                        end
                    end
                end
                if isMatch then
                    minDist = dist
                    targetPos = obj.Position
                end
            end
        end
    end
    return targetPos
end

local function isTargetStillActive(targetPos)
    if not targetPos then return false end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            if (obj.Position - targetPos).Magnitude < 4 then
                local isMatch = false
                if obj.Name == "Base" and obj:IsA("MeshPart") and obj.Size.Y < 2.5 then isMatch = true end
                if obj.Name == "Shelf" and obj.Transparency == 1 then
                    for _, child in ipairs(obj:GetChildren()) do
                        if child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("Highlight") or child:IsA("PointLight") then
                            if child.Enabled then isMatch = true break end
                        end
                    end
                end
                if isMatch then return true end
            end
        end
    end
    return false
end

local function getClosestAislePoint(targetPos)
    local closestPoint = aislePoints[1]
    local minDst = math.huge
    for _, pt in ipairs(aislePoints) do
        local dst = (pt - targetPos).Magnitude
        if dst < minDst then
            minDst = dst
            closestPoint = pt
        end
    end
    return closestPoint
end

----------------------------------------------------
-- مسار الإيداع
----------------------------------------------------
local function executeDepositSequence(speed)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    local cashBeforeDeposit = getPlayerCash()

    moveToPositionHelper(hrp, waypoints[9], speed)
    if not (autoFarm or isDepositing) then return end
    moveToPositionHelper(hrp, aislePoints[3], speed)
    if not (autoFarm or isDepositing) then return end
    moveToPositionHelper(hrp, autoDepositPoint, speed)
    task.wait(0.1)
    if not (autoFarm or isDepositing) then return end
    
    pressEKey()
    task.wait(0.5) 
    
    clickAtScreenPosition(372, 162)
    task.wait(0.2)
    
    local currentCash = cashBeforeDeposit
    if currentCash <= 0 then
        currentCash = tonumber(DepositInputBox.Text) or targetDepositAmount
    end
    
    typeInTextBox(currentCash)
    task.wait(0.2)
    
    clickAtScreenPosition(366, 196)
    task.wait(0.5) 
    
    local cashAfterDeposit = getPlayerCash()

    moveToPositionHelper(hrp, aislePoints[3], speed)
    moveToPositionHelper(hrp, waypoints[9], speed)

    if cashAfterDeposit >= cashBeforeDeposit then
        depositCooldownTime = tick() + 25 
        hasDepositedThisCycle = false 
    else
        hasDepositedThisCycle = true 
    end
end

-- حلقة مراقبة مستقلة للإيداع
task.spawn(function()
    while true do
        task.wait(0.5)
        if autoDepositEnabled then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            
            if hrp and hum and hum.Health > 0 then
                local currentCash = getPlayerCash()
                local targetVal = tonumber(DepositInputBox.Text) or targetDepositAmount
                
                if currentCash < targetVal then
                    hasDepositedThisCycle = false
                end
                
                if not autoFarm and not isDepositing then
                    if checkDepositCondition(hrp) then
                        isDepositing = true
                        executeDepositSequence(30)
                        task.wait(0.2)
                        isDepositing = false
                    end
                end
            end
        end
    end
end)

local function updateSwitchVisual()
    local ts = game:GetService("TweenService")
    local info = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    if autoFarm then
        ts:Create(SwitchBackground, info, {BackgroundColor3 = Color3.fromRGB(50, 180, 80)}):Play()
        ts:Create(SwitchKnob, info, {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
    else
        ts:Create(SwitchBackground, info, {BackgroundColor3 = Color3.fromRGB(80, 80, 95)}):Play()
        ts:Create(SwitchKnob, info, {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
    end
end

FarmToggleContainer.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    updateSwitchVisual()
    
    if autoFarm then
        task.spawn(function()
            while autoFarm do
                pcall(function()
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
                    task.wait(0.05)
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                end)
                task.wait(0.4)
            end
            pcall(function() VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game) end)
        end)
        
        task.spawn(function()
            while autoFarm do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                    
                    if not humanoid or humanoid.Health <= 0 then
                        task.wait(1)
                        continue
                    end

                    checkAndUnsit(humanoid)
                    local speed = 30

                    local currentCash = getPlayerCash()
                    local currentTargetVal = tonumber(DepositInputBox.Text) or targetDepositAmount

                    if checkDepositCondition(hrp) and not isDepositing then
                        isDepositing = true
                        executeDepositSequence(speed)
                        task.wait(0.2)
                        isDepositing = false
                        continue
                    end

                    if not isDepositing then
                        if not isInsideGrocery(hrp.Position) then
                            -- اللاعب برا البقالة (يمشي من البداية طبيعي)
                            local distToPreStart = (hrp.Position - preStartPoint).Magnitude
                            local distToPoint0 = (hrp.Position - customStartPoint).Magnitude
                            local distToPoint1 = (hrp.Position - waypoints[1]).Magnitude
                            local proximityThreshold = 40
                            local targetEndIndex = 7 

                            if distToPreStart <= proximityThreshold or distToPoint0 <= proximityThreshold then
                                moveToPositionHelper(hrp, preStartPoint, speed)
                                if autoFarm then moveToPositionHelper(hrp, customStartPoint, speed) end
                                if autoFarm then
                                    for i = 4, targetEndIndex do
                                        if not autoFarm or checkDepositCondition(hrp) then break end
                                        moveToPositionHelper(hrp, waypoints[i], speed)
                                    end
                                end
                                if autoFarm then 
                                    task.wait(0.1) 
                                    checkAndApplyJobIfNeeded() 
                                    task.wait(0.2) 
                                end
                            elseif distToPoint1 <= proximityThreshold then
                                for i = 1, targetEndIndex do
                                    if not autoFarm or checkDepositCondition(hrp) then break end
                                    moveToPositionHelper(hrp, waypoints[i], speed)
                                end
                                if autoFarm then 
                                    task.wait(0.1) 
                                    checkAndApplyJobIfNeeded() 
                                    task.wait(0.2) 
                                end
                            end
                        else
                            -- اللاعب جوا البقالة وبدون كرتون (يجيب كرتون)
                            if not playerHasBox() then
                                moveToPositionHelper(hrp, waypoints[9], speed)
                                if autoFarm then moveToPositionHelper(hrp, waypoints[8], speed) end
                                if autoFarm then moveToPositionHelper(hrp, waypoints[7], speed) end
                                if autoFarm then 
                                    task.wait(0.1) 
                                    checkAndApplyJobIfNeeded() 
                                    task.wait(0.2) 
                                end
                            end
                        end

                        if not playerHasBox() then
                            moveToPositionHelper(hrp, waypoints[8], speed)
                            if not autoFarm then break end
                            task.wait(0.1)
                            
                            for _ = 1, 2 do
                                if not autoFarm or playerHasBox() or checkDepositCondition(hrp) then break end
                                pressEKey()
                                task.wait(0.05)
                            end
                            task.wait(0.1)
                        end
                        
                        if not autoFarm then break end
                        
                        -- 🔥 المسار الذكي لتعبئة الرفوف (يتنقل من رف لرف مباشرة)
                        while autoFarm and playerHasBox() and not isDepositing do
                            if checkDepositCondition(hrp) then break end

                            local realDeliveryPoint = findHiddenDeliveryTarget()
                            
                            if realDeliveryPoint then
                                -- تحديد مكان الممر الحالي ومكان الممر للهدف الجديد
                                local currentAislePoint = getClosestAislePoint(hrp.Position)
                                local targetAislePoint = getClosestAislePoint(realDeliveryPoint)
                                
                                -- 1. الخروج إلى طرف الممر من المكان الحالي (عشان ما يعلق بالرفوف)
                                moveToPositionHelper(hrp, currentAislePoint, speed)
                                if not autoFarm or checkDepositCondition(hrp) then break end
                                
                                -- 2. الذهاب لمدخل الممر الخاص بالرف الجديد (مباشرة بدون نقطة 9)
                                if currentAislePoint ~= targetAislePoint then
                                    moveToPositionHelper(hrp, targetAislePoint, speed)
                                    if not autoFarm or checkDepositCondition(hrp) then break end
                                end
                                
                                -- 3. الدخول إلى الرف وتعبئته
                                local shelfPos = Vector3.new(realDeliveryPoint.X, hrp.Position.Y, realDeliveryPoint.Z)
                                moveToPositionHelper(hrp, shelfPos, speed)
                                if not autoFarm or checkDepositCondition(hrp) then break end
                                
                                task.wait(0.05)
                                if not isUsingBoxActive() then
                                    pressTwoKey()
                                    task.wait(0.1)
                                end
                                
                                -- التعبئة الفعلية (رمي الكراتين)
                                while autoFarm and isTargetStillActive(realDeliveryPoint) and not isDepositing do
                                    checkAndUnsit(humanoid)
                                    if checkDepositCondition(hrp) then break end
                                    
                                    local distFromCenter = (hrp.Position - shelfPos).Magnitude
                                    if distFromCenter > 3.5 then
                                        hrp.CFrame = CFrame.new(shelfPos)
                                        task.wait(0.05)
                                    end
                                    
                                    if not isUsingBoxActive() then
                                        pressTwoKey()
                                    end
                                    task.wait(0.05)
                                end
                                
                                -- 4. بعد ما يخلص، يرجع خطوة للخلف لطرف الممر بس (عشان يفحص وهو في الممر)
                                task.wait(0.05)
                                moveToPositionHelper(hrp, targetAislePoint, speed)
                                task.wait(0.05)
                                
                            else
                                -- إذا مافي رفوف فاضية أبداً، أو الكرتون خلص تماماً
                                -- يرجع لنقطة 9 ينتظر أو يستعد ياخذ كرتون جديد
                                moveToPositionHelper(hrp, waypoints[9], speed)
                                task.wait(0.5)
                                break
                            end
                        end
                    end
                    task.wait(0.05)
                else
                    task.wait(0.5)
                end
            end
        end)
    end
end)