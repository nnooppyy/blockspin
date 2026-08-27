-- التأكد من تحميل اللاعب والـ PlayerGui
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- رابط الديسكورد
local DiscordInviteLink = "https://discord.gg/zux"

-- حذف أي نسخة قديمة لتجنب التكرار
if PlayerGui:FindFirstChild("UltimateControlGui") then
    PlayerGui.UltimateControlGui:Destroy()
end

-- إنشاء الشاشة الرئيسية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateControlGui"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- زر الدائرة العائم (شعار Zunex الخاص بك)
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
Title.Text = "✨ Zunex Store"
Title.TextColor3 = Color3.fromRGB(230, 230, 240)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 52

-- رابط الديسكورد
local DiscordLabel = Instance.new("TextLabel")
DiscordLabel.Parent = TopBar
DiscordLabel.Size = UDim2.new(0, 85, 1, 0)
DiscordLabel.Position = UDim2.new(1, -120, 0, 0)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Text = "discord.gg/zux"
DiscordLabel.TextColor3 = Color3.fromRGB(150, 170, 255)
DiscordLabel.TextSize = 10
DiscordLabel.Font = Enum.Font.GothamMedium
DiscordLabel.TextXAlignment = Enum.TextXAlignment.Right
DiscordLabel.ZIndex = 52

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
-- 3. محتوى قسم الأخرى (Other) مع زر Auto Respawn بنفس تصميم الصناديق
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
    TabFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabSettingsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabSettingsButton.TextColor3 = Color3.fromRGB(180, 180, 200)
    TabOtherButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabOtherButton.TextColor3 = Color3.fromRGB(180, 180, 200)
end)

TabSettingsButton.MouseButton1Click:Connect(function()
    FarmContent.Visible = false
    SettingsContent.Visible = true
    OtherContent.Visible = false
    
    TabSettingsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    TabSettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabFarmButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabFarmButton.TextColor3 = Color3.fromRGB(180, 180, 200)
    TabOtherButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabOtherButton.TextColor3 = Color3.fromRGB(180, 180, 200)
end)

TabOtherButton.MouseButton1Click:Connect(function()
    FarmContent.Visible = false
    SettingsContent.Visible = false
    OtherContent.Visible = true
    
    TabOtherButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    TabOtherButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabFarmButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabFarmButton.TextColor3 = Color3.fromRGB(180, 180, 200)
    TabSettingsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabSettingsButton.TextColor3 = Color3.fromRGB(180, 180, 200)
end)

CopyLinkButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DiscordInviteLink)
        CopyLinkButton.Text = "✅ Link Copied!"
    else
        CopyLinkButton.Text = "⚠️ Not Supported"
    end
    task.wait(1.5)
    CopyLinkButton.Text = "📋 Copy Server Link"
end)

CopyPosButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local pos = LocalPlayer.Character.HumanoidRootPart.Position
        local posString = string.format("Vector3.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z)
        if setclipboard then
            setclipboard(posString)
            CopyPosButton.Text = "✅ Position Copied!"
        else
            CopyPosButton.Text = "⚠️ Not Supported"
        end
    else
        CopyPosButton.Text = "⚠️ Character Not Found"
    end
    task.wait(1.5)
    CopyPosButton.Text = "📍 Copy Current Position"
end)

----------------------------------------------------
-- منطق الـ Auto Respawn الجديد (ينتظر ظهور كلمة Respawn ويضغط بعد 6 ثوانٍ مرة واحدة)
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

task.spawn(function()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    while true do
        task.wait(0.5)
        if autoRespawnEnabled then
            local pGui = LocalPlayer:FindFirstChild("PlayerGui")
            local respawnFound = false
            
            if pGui then
                for _, descendant in ipairs(pGui:GetDescendants()) do
                    if (descendant:IsA("TextButton") or descendant:IsA("TextLabel")) and descendant.Visible then
                        local text = string.lower(descendant.Text or "")
                        if string.find(text, "respawn") then
                            respawnFound = true
                            break
                        end
                    end
                end
            end
            
            -- إذا ظهرت الكلمة، ننتظر 6 ثوانٍ نتأكد خلالها أنها لم تختفِ، ثم نضغط مرة واحدة
            if respawnFound then
                local waitTimer = 0
                local aborted = false
                
                while waitTimer < 6 and autoRespawnEnabled do
                    task.wait(0.5)
                    waitTimer = waitTimer + 0.5
                    
                    -- التحقق هل ما زالت الكلمة موجودة أم اختفت
                    local stillExists = false
                    local currentGui = LocalPlayer:FindFirstChild("PlayerGui")
                    if currentGui then
                        for _, descendant in ipairs(currentGui:GetDescendants()) do
                            if (descendant:IsA("TextButton") or descendant:IsA("TextLabel")) and descendant.Visible then
                                local text = string.lower(descendant.Text or "")
                                if string.find(text, "respawn") then
                                    stillExists = true
                                    break
                                end
                            end
                        end
                    end
                    
                    if not stillExists then
                        aborted = true
                        break
                    end
                end
                
                -- إذا انقضت ال6 ثوانٍ ولم تختفِ الكلمة وما زال المفتاح شغّالاً، نقوم بالنقر مرة واحدة عند الإحداثيات (400, 220)
                if not aborted and autoRespawnEnabled then
                    local centerX = 400
                    local centerY = 220
                    
                    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
                    task.wait(0.05)
                    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
                    
                    -- الانتظار حتى تختفي القائمة تماماً لكي لا يتم التكرار
                    while autoRespawnEnabled do
                        task.wait(0.5)
                        local checkAgain = false
                        local curGui = LocalPlayer:FindFirstChild("PlayerGui")
                        if curGui then
                            for _, descendant in ipairs(curGui:GetDescendants()) do
                                if (descendant:IsA("TextButton") or descendant:IsA("TextLabel")) and descendant.Visible then
                                    local text = string.lower(descendant.Text or "")
                                    if string.find(text, "respawn") then
                                        checkAgain = true
                                        break
                                    end
                                end
                            end
                        end
                        if not checkAgain then break end
                    end
                end
            end
        end
    end
end)

----------------------------------------------------
-- المنطق والإحداثيات (باقي كود الفارم)
----------------------------------------------------
local waypoints = {
    Vector3.new(61.82, 254.96, 56.74),
    Vector3.new(47.26, 254.76, 263.28),
    Vector3.new(160.40, 254.86, 250.37),
    Vector3.new(160.37, 255.18, 227.71),
    Vector3.new(159.49, 254.99, 204.32),
    Vector3.new(164.69, 254.99, 202.29), -- نقطة التوظيف (6)
    Vector3.new(146.79, 255.47, 204.95), -- نقطة الصناديق (7)
    Vector3.new(125.54, 254.74, 201.89), -- نقطة المركز الداخلي (8)
}

local aislePoints = {
    Vector3.new(121.61, 255.32, 202.77),
    Vector3.new(125.51, 255.32, 184.90),
    Vector3.new(128.39, 255.32, 167.04)
}

local autoFarm = false
local showPointsEnabled = false
local pointsFolder = nil
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
        if humanoid.PlatformStand then
            humanoid.PlatformStand = false
        end
    end
end

local function isInsideGrocery(pos)
    local minX, maxX = 85, 172
    local minZ, maxZ = 158, 218
    return pos.X >= minX and pos.X <= maxX and pos.Z >= minZ and pos.Z <= maxZ
end

local function toggleVisualPoints()
    showPointsEnabled = not showPointsEnabled
    if showPointsEnabled then
        ShowPointsButton.Text = "📍 Points: [Visible]"
        ShowPointsButton.BackgroundColor3 = Color3.fromRGB(180, 120, 20)
        
        pointsFolder = Instance.new("Folder")
        pointsFolder.Name = "DebugWaypointsFolder"
        pointsFolder.Parent = workspace
        
        local function createMarker(pos, color, text)
            local part = Instance.new("Part")
            part.Size = Vector3.new(1, 1, 1)
            part.Shape = Enum.PartType.Ball
            part.Position = pos
            part.Anchored = true
            part.CanCollide = false
            part.BrickColor = color
            part.Material = Enum.Material.Neon
            part.Parent = pointsFolder
            
            local bb = Instance.new("BillboardGui")
            bb.Size = UDim2.new(0, 60, 0, 20)
            bb.StudsOffset = Vector3.new(0, 1.5, 0)
            bb.AlwaysOnTop = true
            bb.Parent = part
            
            local txt = Instance.new("TextLabel")
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.Text = text
            txt.TextColor3 = Color3.fromRGB(255, 255, 255)
            txt.TextSize = 10
            txt.Font = Enum.Font.GothamBold
            txt.Parent = bb
        end
        
        for i, pos in ipairs(waypoints) do
            createMarker(pos, BrickColor.new("Bright blue"), "WP " .. i)
        end
        for i, pos in ipairs(aislePoints) do
            createMarker(pos, BrickColor.new("Bright green"), "Aisle " .. i)
        end
    else
        ShowPointsButton.Text = "📍 Points: [Hidden]"
        ShowPointsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
        if pointsFolder then
            pointsFolder:Destroy()
            pointsFolder = nil
        end
    end
end

ShowPointsButton.MouseButton1Click:Connect(toggleVisualPoints)

local function isTeleportDetected()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        for _, gui in ipairs(playerGui:GetDescendants()) do
            if (gui:IsA("TextLabel") or gui:IsA("TextButton")) and gui.Visible then
                local text = string.lower(gui.Text or "")
                if string.find(text, "teleport detected") then
                    return true
                end
            end
        end
    end
    return false
end

local function moveToPosition(hrp, targetPos, speed)
    if not autoFarm then return end
    
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    checkAndUnsit(humanoid)

    while isTeleportDetected() and autoFarm do
        task.wait(0.2)
    end
    
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
        
        if isTeleportDetected() then
            tween:Pause()
            while isTeleportDetected() and autoFarm do
                task.wait(0.2)
            end
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
            if child:IsA("Tool") then
                toolCount = toolCount + 1
            end
        end
        for _, child in ipairs(Backpack:GetChildren()) do
            if child:IsA("Tool") then
                toolCount = toolCount + 1
            end
        end
        if toolCount > 0 then return true end
    end
    return false
end

local function getClosestStartPoint(playerPos)
    local closestIndex = 1
    local minDistance = math.huge
    for i = 1, 3 do
        local dist = (playerPos - waypoints[i]).Magnitude
        if dist < minDistance then
            minDistance = dist
            closestIndex = i
        end
    end
    return closestIndex
end

local function getClosestInternalAisle(playerPos)
    local closestPoint = aislePoints[1]
    local minDistance = math.huge
    for _, pt in ipairs(aislePoints) do
        local dist = (playerPos - pt).Magnitude
        if dist < minDistance then
            minDistance = dist
            closestPoint = pt
        end
    end
    return closestPoint
end

local function findHiddenDeliveryTarget()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    local searchCenter = waypoints[8]
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
            if not playerHasBox() then
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                    local speed = 30
                    
                    checkAndUnsit(humanoid)
                    
                    if isInsideGrocery(hrp.Position) then
                        if autoFarm then moveToPosition(hrp, waypoints[8], speed) end
                        if autoFarm then moveToPosition(hrp, waypoints[7], speed) end
                        if autoFarm then moveToPosition(hrp, waypoints[6], speed) end
                    else
                        local startIndex = getClosestStartPoint(hrp.Position)
                        for i = startIndex, 3 do
                            if not autoFarm then break end
                            moveToPosition(hrp, waypoints[i], speed)
                        end
                        for i = 4, 6 do
                            if not autoFarm then break end
                            moveToPosition(hrp, waypoints[i], speed)
                        end
                    end
                    
                    if autoFarm then
                        task.wait(0.3)
                        clickCenter()
                        task.wait(0.5)
                    end
                end
            end

            while autoFarm do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                    
                    checkAndUnsit(humanoid)
                    local speed = 30

                    if not playerHasBox() then
                        moveToPosition(hrp, waypoints[7], speed)
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
                        moveToPosition(hrp, waypoints[8], speed)
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
                            
                            moveToPosition(hrp, waypoints[8], speed)
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
