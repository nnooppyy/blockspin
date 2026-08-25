-- التأكد من تحميل اللاعب والـ PlayerGui
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- رابط السيرفر المطلوب نسخه
local DiscordInviteLink = "https://discord.gg/USGvBYEych"

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

-- زر الدائرة العائم (⚡)
local FloatingToggle = Instance.new("TextButton")
FloatingToggle.Parent = ScreenGui
FloatingToggle.Size = UDim2.new(0, 52, 0, 52)
FloatingToggle.Position = UDim2.new(0.02, 0, 0.38, 0)
FloatingToggle.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
FloatingToggle.Text = "⚡"
FloatingToggle.TextColor3 = Color3.fromRGB(255, 215, 0)
FloatingToggle.TextSize = 22
FloatingToggle.Font = Enum.Font.GothamBold
FloatingToggle.Draggable = true
FloatingToggle.ZIndex = 100

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = FloatingToggle

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(120, 80, 220)
UIStroke.Thickness = 2.5
UIStroke.Parent = FloatingToggle

-- القائمة الرئيسية
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
MainFrame.Position = UDim2.new(0.08, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 230, 0, 270)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 50

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 45, 90)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- شريط العنوان العلوي
local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.Size = UDim2.new(1, 0, 0, 38)
TopBar.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
TopBar.ZIndex = 51

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

local FixCorner = Instance.new("Frame")
FixCorner.Parent = TopBar
FixCorner.Size = UDim2.new(1, 0, 0, 10)
FixCorner.Position = UDim2.new(0, 0, 1, -10)
FixCorner.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
FixCorner.BorderSizePixel = 0
FixCorner.ZIndex = 51

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "✨ Pro Control Panel"
Title.TextColor3 = Color3.fromRGB(240, 240, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 52

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TopBar
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Position = UDim2.new(1, -32, 0.5, -14)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 13
CloseButton.Font = Enum.Font.GothamBold
CloseButton.ZIndex = 52

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

----------------------------------------------------
-- 1. القائمة الرئيسية (Main Menu Container)
----------------------------------------------------
local MainMenuContainer = Instance.new("Frame")
MainMenuContainer.Parent = MainFrame
MainMenuContainer.Size = UDim2.new(1, -16, 1, -50)
MainMenuContainer.Position = UDim2.new(0, 8, 0, 44)
MainMenuContainer.BackgroundTransparency = 1
MainMenuContainer.Visible = true
MainMenuContainer.ZIndex = 51

local MainLayout = Instance.new("UIListLayout")
MainLayout.Parent = MainMenuContainer
MainLayout.SortOrder = Enum.SortOrder.LayoutOrder
MainLayout.Padding = UDim.new(0, 10)
MainLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- خانة السرعة
local SpeedInput = Instance.new("TextBox")
SpeedInput.Parent = MainMenuContainer
SpeedInput.Size = UDim2.new(1, 0, 0, 36)
SpeedInput.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.PlaceholderText = "Speed (Default: 25)"
SpeedInput.Text = "25"
SpeedInput.TextSize = 13
SpeedInput.Font = Enum.Font.GothamMedium
SpeedInput.ZIndex = 51

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = SpeedInput

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(50, 50, 70)
InputStroke.Thickness = 1
InputStroke.Parent = SpeedInput

-- زر الفرام (Farm Button)
local FarmButton = Instance.new("TextButton")
FarmButton.Parent = MainMenuContainer
FarmButton.Size = UDim2.new(1, 0, 0, 44)
FarmButton.BackgroundColor3 = Color3.fromRGB(40, 140, 60)
FarmButton.Text = "📦 Farm: [Off]"
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.TextSize = 14
FarmButton.Font = Enum.Font.GothamBold
FarmButton.ZIndex = 51

local FarmCorner = Instance.new("UICorner")
FarmCorner.CornerRadius = UDim.new(0, 8)
FarmCorner.Parent = FarmButton

-- زر إظهار النقاط
local ShowPointsButton = Instance.new("TextButton")
ShowPointsButton.Parent = MainMenuContainer
ShowPointsButton.Size = UDim2.new(1, 0, 0, 40)
ShowPointsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
ShowPointsButton.Text = "📍 Show Points: [Hidden]"
ShowPointsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowPointsButton.TextSize = 13
ShowPointsButton.Font = Enum.Font.GothamBold
ShowPointsButton.ZIndex = 51

local PointsCorner = Instance.new("UICorner")
PointsCorner.CornerRadius = UDim.new(0, 8)
PointsCorner.Parent = ShowPointsButton

-- زر الانتقال للاعدادات (Settings Button)
local SettingsNavButton = Instance.new("TextButton")
SettingsNavButton.Parent = MainMenuContainer
SettingsNavButton.Size = UDim2.new(1, 0, 0, 40)
SettingsNavButton.BackgroundColor3 = Color3.fromRGB(50, 90, 140)
SettingsNavButton.Text = "⚙️ Settings ➔"
SettingsNavButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsNavButton.TextSize = 13
SettingsNavButton.Font = Enum.Font.GothamBold
SettingsNavButton.ZIndex = 51

local SettingsNavCorner = Instance.new("UICorner")
SettingsNavCorner.CornerRadius = UDim.new(0, 8)
SettingsNavCorner.Parent = SettingsNavButton

----------------------------------------------------
-- 2. قائمة الإعدادات الفرعية (Settings Menu Container)
----------------------------------------------------
local SettingsMenuContainer = Instance.new("Frame")
SettingsMenuContainer.Parent = MainFrame
SettingsMenuContainer.Size = UDim2.new(1, -16, 1, -50)
SettingsMenuContainer.Position = UDim2.new(0, 8, 0, 44)
SettingsMenuContainer.BackgroundTransparency = 1
SettingsMenuContainer.Visible = false
SettingsMenuContainer.ZIndex = 51

local SettingsLayout = Instance.new("UIListLayout")
SettingsLayout.Parent = SettingsMenuContainer
SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
SettingsLayout.Padding = UDim.new(0, 12)
SettingsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- زر نسخ رابط السيرفر (Copy Discord Link)
local CopyLinkButton = Instance.new("TextButton")
CopyLinkButton.Parent = SettingsMenuContainer
CopyLinkButton.Size = UDim2.new(1, 0, 0, 45)
CopyLinkButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- لون ديسكورد المميز
CopyLinkButton.Text = "📋 Copy Server Link"
CopyLinkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyLinkButton.TextSize = 14
CopyLinkButton.Font = Enum.Font.GothamBold
CopyLinkButton.ZIndex = 51

local CopyLinkCorner = Instance.new("UICorner")
CopyLinkCorner.CornerRadius = UDim.new(0, 8)
CopyLinkCorner.Parent = CopyLinkButton

-- زر الرجوع للقائمة الرئيسية (Back Button)
local BackButton = Instance.new("TextButton")
BackButton.Parent = SettingsMenuContainer
BackButton.Size = UDim2.new(1, 0, 0, 45)
BackButton.BackgroundColor3 = Color3.fromRGB(90, 70, 110)
BackButton.Text = "⬅️ Back to Main"
BackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BackButton.TextSize = 14
BackButton.Font = Enum.Font.GothamBold
BackButton.ZIndex = 51

local BackCorner = Instance.new("UICorner")
BackCorner.CornerRadius = UDim.new(0, 8)
BackCorner.Parent = BackButton

----------------------------------------------------
-- ربط التنقل بين القائمتين
----------------------------------------------------
SettingsNavButton.MouseButton1Click:Connect(function()
    MainMenuContainer.Visible = false
    SettingsMenuContainer.Visible = true
    Title.Text = "⚙️ Settings Menu"
end)

BackButton.MouseButton1Click:Connect(function()
    SettingsMenuContainer.Visible = false
    MainMenuContainer.Visible = true
    Title.Text = "✨ Pro Control Panel"
end)

-- وظيفة زر نسخ الرابط
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

----------------------------------------------------
-- الإحداثيات والبرمجة الداخلية للفرام والصناديق
----------------------------------------------------
local waypoints = {
    Vector3.new(61.82, 254.96, 56.74),   -- 1
    Vector3.new(47.26, 254.76, 263.28),  -- 2
    Vector3.new(160.40, 254.86, 250.37), -- 3
    Vector3.new(160.37, 255.18, 227.71), -- 4
    Vector3.new(159.49, 254.99, 204.32), -- 5
    Vector3.new(164.69, 254.99, 202.29), -- 6 (التوظيف)
    Vector3.new(146.79, 255.47, 204.95), -- 7 (مكان الصناديق)
    Vector3.new(125.54, 254.74, 201.89), -- 8 (ممر الرفوف)
}

local aislePoints = {
    Vector3.new(121.61, 255.32, 202.77), -- 1
    Vector3.new(125.51, 255.32, 184.90), -- 2
    Vector3.new(128.39, 255.32, 167.04)  -- 3
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

-- فحص هل الصندوق في اليد، وإذا طاح يرجع يشيله تلقائياً (حل مشكلة سقوط الصندوق)
local function ensureBoxEquipped()
    if not LocalPlayer.Character then return end
    local char = LocalPlayer.Character
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    -- التحقق إذا كانت الأداة (الصندوق) موجودة بالحقيبة ولم تُمسك باليد
    local boxTool = nil
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:IsA("Tool") then
            boxTool = item
            break
        end
    end
    
    local equippedTool = char:FindFirstChildOfClass("Tool")
    if not equippedTool and boxTool then
        humanoid:EquipTool(boxTool)
        task.wait(0.1)
    end
end

local function toggleVisualPoints()
    showPointsEnabled = not showPointsEnabled
    if showPointsEnabled then
        ShowPointsButton.Text = "📍 Show Points: [Visible]"
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
        ShowPointsButton.Text = "📍 Show Points: [Hidden]"
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
        ensureBoxEquipped() -- التحقق المستمر من حمل الصندوق أثناء الحركة
        
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

local function checkEmploymentStatusText()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        for _, gui in ipairs(playerGui:GetDescendants()) do
            if (gui:IsA("TextLabel") or gui:IsA("TextButton")) and gui.Visible then
                local text = string.lower(gui.Text or "")
                if string.find(text, "leave") then 
                    return "employed" 
                end
                if string.sub(text, 1, 2) == "ap" or string.find(text, "apply") then 
                    return "unemployed" 
                end
            end
        end
    end
    return "unknown"
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

FarmButton.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    if autoFarm then
        FarmButton.Text = "📦 Farm: [Active]"
        FarmButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        
        -- نظام نبضات الشفت
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
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                local speed = tonumber(SpeedInput.Text) or 25
                
                checkAndUnsit(humanoid)
                
                if isInsideGrocery(hrp.Position) then
                    local internalPoint = getClosestInternalAisle(hrp.Position)
                    moveToPosition(hrp, internalPoint, speed)
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
                    local status = checkEmploymentStatusText()
                    if status ~= "employed" then
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
                    local speed = tonumber(SpeedInput.Text) or 25

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
                        ensureBoxEquipped() -- ضمان حمل الصندوق دائماً
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
                                ensureBoxEquipped()
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
    else
        FarmButton.Text = "📦 Farm: [Off]"
        FarmButton.BackgroundColor3 = Color3.fromRGB(40, 140, 60)
    end
end)
