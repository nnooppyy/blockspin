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
MainFrame.Size = UDim2.new(0, 360, 0, 240)
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

-- العنوان
local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "✨ Zunex Store | discord.gg/zux"
Title.TextColor3 = Color3.fromRGB(230, 230, 240)
Title.TextSize = 11
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 52

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
FarmContent.CanvasSize = UDim2.new(0, 0, 0, 120)
FarmContent.ScrollBarThickness = 3
FarmContent.ZIndex = 51

local FarmContentLayout = Instance.new("UIListLayout")
FarmContentLayout.Parent = FarmContent
FarmContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
FarmContentLayout.Padding = UDim.new(0, 10)
FarmContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local FarmToggleContainer = Instance.new("TextButton")
FarmToggleContainer.Parent = FarmContent
FarmToggleContainer.Size = UDim2.new(0.95, 0, 0, 40)
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
local customStartPoint = Vector3.new(-67.63, 254.62, 550.38)

local waypoints = {
    Vector3.new(-445.96, 254.62, 295.86), -- نقطة 1 القديمة
    Vector3.new(-299.55, 254.63, 299.31), -- نقطة 2
    Vector3.new(-72.42, 254.53, 300.61),  -- نقطة 3
    Vector3.new(160.40, 254.86, 250.37),  -- نقطة 4
    Vector3.new(160.37, 255.18, 227.71),  -- نقطة 5
    Vector3.new(159.49, 254.99, 204.32),  -- نقطة 6
    Vector3.new(164.69, 254.99, 202.29),  -- نقطة 7
    Vector3.new(146.79, 255.47, 204.95),  -- نقطة 8
    Vector3.new(125.54, 254.74, 201.89),  -- نقطة 9
}

local aislePoints = {
    Vector3.new(121.61, 255.32, 202.77),
    Vector3.new(125.51, 255.32, 184.90),
    Vector3.new(128.39, 255.32, 167.04)
}

-- فولدر لإظهار النقاط مع أرقامها في اللعبة عند الضغط
local pointsFolder = Instance.new("Folder")
pointsFolder.Name = "CustomWaypointsFolder"
pointsFolder.Parent = workspace

local pointsVisible = false
ShowPointsButton.MouseButton1Click:Connect(function()
    pointsVisible = not pointsVisible
    if pointsVisible then
        ShowPointsButton.Text = "📍 Points: [Visible]"
        pointsFolder:ClearAllChildren()
        
        -- إظهار النقطة الجديدة
        local pPart = Instance.new("Part")
        pPart.Size = Vector3.new(2, 2, 2)
        pPart.Position = customStartPoint
        pPart.Anchored = true
        pPart.CanCollide = false
        pPart.Transparency = 0.5
        pPart.BrickColor = BrickColor.new("Cyan")
        pPart.Parent = pointsFolder
        
        local pBb = Instance.new("BillboardGui")
        pBb.Size = UDim2.new(0, 100, 0, 50)
        pBb.StudsOffset = Vector3.new(0, 3, 0)
        pBb.AlwaysOnTop = true
        pBb.Parent = pPart
        
        local pLbl = Instance.new("TextLabel")
        pLbl.Size = UDim2.new(1, 0, 1, 0)
        pLbl.BackgroundTransparency = 1
        pLbl.Text = "Custom Start"
        pLbl.TextColor3 = Color3.fromRGB(0, 255, 255)
        pLbl.TextSize = 16
        pLbl.Font = Enum.Font.GothamBold
        pLbl.TextStrokeTransparency = 0
        pLbl.Parent = pBb

        for index, pos in ipairs(waypoints) do
            local part = Instance.new("Part")
            part.Size = Vector3.new(2, 2, 2)
            part.Position = pos
            part.Anchored = true
            part.CanCollide = false
            part.Transparency = 0.5
            part.BrickColor = BrickColor.new("Lime green")
            part.Parent = pointsFolder
            
            local bb = Instance.new("BillboardGui")
            bb.Size = UDim2.new(0, 100, 0, 50)
            bb.StudsOffset = Vector3.new(0, 3, 0)
            bb.AlwaysOnTop = true
            bb.Parent = part
            
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = "Point " .. index
            lbl.TextColor3 = Color3.fromRGB(0, 255, 0)
            lbl.TextSize = 18
            lbl.Font = Enum.Font.GothamBold
            lbl.TextStrokeTransparency = 0
            lbl.Parent = bb
        end
    else
        ShowPointsButton.Text = "📍 Points: [Hidden]"
        pointsFolder:ClearAllChildren()
    end
end)

CopyLinkButton.MouseButton1Click:Connect(function()
    pcall(function()
        setclipboard(DiscordInviteLink)
    end)
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
-- نظام التحقق من الوظيفة (apply / Leave)
----------------------------------------------------
local function checkEmploymentStatus()
    pcall(function()
        for _, gui in ipairs(PlayerGui:GetDescendants()) do
            if (gui:IsA("TextLabel") or gui:IsA("TextButton")) and gui.Visible then
                local text = string.lower(gui.Text or "")
                if string.find(text, "apply") then
                    -- غير متوظف
                elseif string.find(text, "leave") then
                    -- متوظف بالفعل
                end
            end
        end
    end)
end

task.spawn(function()
    while true do
        task.wait(1)
        checkEmploymentStatus()
    end
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
        if currentObj:IsA("GuiObject") and not currentObj.Visible then
            return false
        end
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
                            for _, conn in ipairs(getconnections(targetButton.MouseButton1Click)) do
                                conn:Fire()
                            end
                            for _, conn in ipairs(getconnections(targetButton.Activated)) do
                                conn:Fire()
                            end
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
-- منطق التنقل والحركة (Farm Logic)
----------------------------------------------------
local autoFarm = false
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Backpack = LocalPlayer:WaitForChild("Backpack")

FloatingToggle.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

local function checkAndUnsit(humanoid)
    if humanoid then
        if humanoid.Sit then
            humanoid.Sit = false
            humanoid.Jump = true
        end
        if humanoid.PlatformStand then humanoid.PlatformStand = false end
    end
end

local function isInsideGrocery(pos)
    local minX, maxX = 85, 172
    local minZ, maxZ = 158, 218
    return pos.X >= minX and pos.X <= maxX and pos.Z >= minZ and pos.Z <= maxZ
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

local function moveToPosition(hrp, targetPos, speed)
    if not autoFarm then return end
    
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    checkAndUnsit(humanoid)

    while isTeleportDetected() and autoFarm do task.wait(0.2) end
    
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
        
        if humanoid and humanoid.Health <= 0 then
            tween:Cancel()
            return
        end

        if isTeleportDetected() then
            tween:Pause()
            while isTeleportDetected() and autoFarm do task.wait(0.2) end
            if autoFarm then
                local remainingDist = (hrp.Position - safePos).Magnitude
                local remainingTime = remainingDist / math.max(speed, 1)
                tweenInfo = TweenInfo.new(remainingTime, Enum.EasingStyle.Linear)
                tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(safePos)})
                expectedEnd = tick() + remainingTime
                tween:Play()
            end
        end
    until tick() >= expectedEnd or not autoFarm
    
    if not autoFarm then tween:Cancel() end
end

local function pressEKey()
    for i = 1, 6 do
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        task.wait(0.05)
    end
end

local function clickCenter()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local centerX = viewportSize.X / 2
    local centerY = (viewportSize.Y / 2) + 50
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
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

local function findHiddenDeliveryTarget()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local searchCenter = waypoints[#waypoints]
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
            pcall(function()
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
            end)
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

                    if not isInsideGrocery(hrp.Position) then
                        -- إذا كان اللاعب قريب من النقطة الجديدة (أقل من 60 ستود)، يروح لها أولاً ثم يروح للنقطة 4 مباشرة
                        -- وإذا لم يكن قريباً منها، يتخطاها ويروح للنقطة 4 مباشرة بدون أي حوسة
                        local distToCustom = (hrp.Position - customStartPoint).Magnitude
                        
                        if distToCustom <= 60 then
                            moveToPosition(hrp, customStartPoint, speed)
                            if not autoFarm then break end
                        end

                        if not autoFarm then break end
                        moveToPosition(hrp, waypoints[4], speed)

                        -- إكمال باقي نقاط المسار داخل المتجر (من 5 إلى ما قبل الأخيرة)
                        for i = 5, #waypoints - 2 do
                            if not autoFarm then break end
                            moveToPosition(hrp, waypoints[i], speed)
                        end
                        
                        if autoFarm then
                            task.wait(0.3)
                            clickCenter()
                            task.wait(0.5)
                        end
                    end

                    if not playerHasBox() then
                        moveToPosition(hrp, waypoints[#waypoints - 1], speed)
                        if not autoFarm then break end
                        task.wait(0.3)
                        
                        for _ = 1, 8 do
                            if not autoFarm or playerHasBox() then break end
                            pressEKey()
                            task.wait(0.2)
                        end
                        task.wait(0.3)
                    end
                    
                    if not autoFarm then break end
                    
                    while autoFarm and playerHasBox() do
                        moveToPosition(hrp, waypoints[#waypoints], speed)
                        if not autoFarm then break end
                        task.wait(0.2)
                        
                        local realDeliveryPoint = findHiddenDeliveryTarget()
                        if realDeliveryPoint then
                            local targetAislePoint = getClosestAislePoint(realDeliveryPoint)
                            
                            moveToPosition(hrp, targetAislePoint, speed)
                            if not autoFarm then break end
                            task.wait(0.2)
                            
                            moveToPosition(hrp, Vector3.new(realDeliveryPoint.X, hrp.Position.Y, realDeliveryPoint.Z), speed)
                            if not autoFarm then break end
                            
                            while autoFarm and isTargetStillActive(realDeliveryPoint) do
                                checkAndUnsit(humanoid)
                                task.wait(0.3)
                            end
                            
                            task.wait(0.2)
                            moveToPosition(hrp, targetAislePoint, speed)
                            task.wait(0.2)
                            
                            moveToPosition(hrp, waypoints[#waypoints], speed)
                            if not autoFarm then break end
                        else
                            task.wait(1)
                            break
                        end
                        task.wait(0.2)
                    end
                    
                    task.wait(0.2)
                else
                    task.wait(1)
                end
            end
        end)
    end
end)
