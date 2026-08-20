-- إنشاء الشاشة والقائمة
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FarmButton = Instance.new("TextButton")
local ShowPointsButton = Instance.new("TextButton")
local SpeedInput = Instance.new("TextBox")
local CodeButton = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 230)
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
    Vector3.new(159.49, 254.99, 204.32), -- النقطة 4
    Vector3.new(164.69, 254.99, 202.29), -- النقطة 5 (التوظف)
    Vector3.new(148.91, 254.74, 208.63), -- النقطة 6 (أخذ الصناديق)
    Vector3.new(125.54, 254.74, 201.89)  -- النقطة 7 (منتصف المتجر / الرادار)
}

-- النقاط الست للممرات
local aislePoints = {
    Vector3.new(121.61, 255.32, 202.77), -- ممر 1 (بداية)
    Vector3.new(90.95, 255.32, 202.59),  -- ممر 1 (نهاية)
    Vector3.new(129.45, 255.32, 182.76), -- ممر 2 (بداية)
    Vector3.new(91.50, 255.32, 184.21),  -- ممر 2 (نهاية)
    Vector3.new(128.39, 255.32, 167.04), -- ممر 3 (بداية)
    Vector3.new(95.99, 255.32, 167.45)   -- ممر 3 (نهاية)
}

SpeedInput.Parent = MainFrame
SpeedInput.Size = UDim2.new(0.9, 0, 0, 30)
SpeedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.PlaceholderText = "السرعة (افتراضي: 25)"
SpeedInput.Text = "25"
SpeedInput.TextSize = 13

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

local autoFarm = false
local showPointsEnabled = false
local pointsFolder = nil
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- دالة إظهار أو إخفاء النقاط
local function toggleVisualPoints()
    showPointsEnabled = not showPointsEnabled
    if showPointsEnabled then
        ShowPointsButton.Text = "إظهار النقاط: [ظاهرة]"
        ShowPointsButton.BackgroundColor3 = Color3.fromRGB(150, 100, 0)
        
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
            txt.Font = Enum.Font.SourceSansBold
            txt.Parent = bb
        end
        
        for i, pos in ipairs(waypoints) do
            createMarker(pos, BrickColor.new("Bright blue"), "WP " .. i)
        end
        
        for i, pos in ipairs(aislePoints) do
            createMarker(pos, BrickColor.new("Bright green"), "Aisle " .. i)
        end
    else
        ShowPointsButton.Text = "إظهار النقاط: [مخفية]"
        ShowPointsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        if pointsFolder then
            pointsFolder:Destroy()
            pointsFolder = nil
        end
    end
end

ShowPointsButton.MouseButton1Click:Connect(toggleVisualPoints)

-- دالة التحرك الآمن
local function moveToPosition(hrp, targetPos, speed)
    if not autoFarm then return end
    
    local safePos = Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z)
    local distance = (hrp.Position - safePos).Magnitude
    local tweenTime = distance / math.max(speed, 1)
    
    local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(safePos)})
    
    tween:Play()
    
    local start = tick()
    repeat
        task.wait(0.05)
    until (tick() - start >= tweenTime) or not autoFarm
    
    if not autoFarm then
        tween:Cancel()
    end
end

-- ضغط مفتاح E (مخصص لنقطة 6 فقط لأخذ الصناديق)
local function pressEKey()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

-- ضغط الماوس للتسجيل
local function clickCenter()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local centerX = viewportSize.X / 2
    local centerY = (viewportSize.Y / 2) + 50
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
end

-- فحص حالة التوظف
local function checkEmploymentStatusText()
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        for _, gui in ipairs(playerGui:GetDescendants()) do
            if (gui:IsA("TextLabel") or gui:IsA("TextButton")) and gui.Visible then
                local text = string.lower(gui.Text or "")
                if text:find("leave") then return "employed" end
                if text:find("apply") then return "unemployed" end
            end
        end
    end
    return "unknown"
end

-- فحص الصناديق
local function playerHasBox()
    local player = game.Players.LocalPlayer
    if player.Character then
        local tool = player.Character:FindFirstChildOfClass("Tool")
        if tool then
            return true
        end
    end
    return false
end

-- البحث عن الرف المطلوب من نقطة 7
local function findHiddenDeliveryTarget()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    local searchCenter = waypoints[7]
    local targetPos = nil
    local minDist = 120

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(char) then
            local dist = (obj.Position - searchCenter).Magnitude
            if dist <= minDist then
                local isMatch = false
                if obj.Name == "Base" and obj:IsA("MeshPart") and obj.Size.Y < 2.5 then
                    isMatch = true
                end
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

-- التحقق هل الرف لا زال موجوداً و Como طالبه تعبئة
local function isTargetStillActive(targetPos)
    if not targetPos then return false end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            if (obj.Position - targetPos).Magnitude < 4 then
                local isMatch = false
                if obj.Name == "Base" and obj:IsA("MeshPart") and obj.Size.Y < 2.5 then
                    isMatch = true
                end
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

-- اختيار أقرب إحداثي من نقاط الممرات
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

local function getClosestWaypointIndex(playerPos)
    local closestIndex = 1
    local minDistance = math.huge
    for index, point in ipairs(waypoints) do
        local dist = (playerPos - point).Magnitude
        if dist < minDistance then
            minDistance = dist
            closestIndex = index
        end
    end
    return closestIndex
end

FarmButton.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    if autoFarm then
        FarmButton.Text = "فرام صناديق: [مفعل]"
        FarmButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        FarmButton.Text = "فرام صناديق: [معطل]"
        FarmButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    end
    
    task.spawn(function()
        local player = game.Players.LocalPlayer
        
        while autoFarm do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                local speed = tonumber(SpeedInput.Text) or 25
                
                -- 1. التأكد من الدخول والتوظف
                local distToBoxes = (hrp.Position - waypoints[6]).Magnitude
                if distToBoxes > 50 then
                    local startIndex = getClosestWaypointIndex(hrp.Position)
                    for i = startIndex, 5 do
                        if not autoFarm then break end
                        moveToPosition(hrp, waypoints[i], speed)
                        
                        if i == 5 then
                            task.wait(0.3)
                            local status = checkEmploymentStatusText()
                            if status == "unemployed" or status == "unknown" then
                                clickCenter()
                                task.wait(0.3)
                            end
                        end
                    end
                end
                
                if not autoFarm then break end
                
                -- 2. إذا ما معه صندوق، يروح لنقطة 6 ويضغط E لين ياخذ الصندوق
                if not playerHasBox() then
                    moveToPosition(hrp, waypoints[6], speed)
                    if not autoFarm then break end
                    task.wait(0.3)
                    
                    for _ = 1, 10 do
                        if not autoFarm or playerHasBox() then break end
                        pressEKey()
                        task.wait(0.2)
                    end
                    task.wait(0.3)
                end
                
                if not autoFarm then break end
                
                -- 3. إذا معه صندوق، يروح لنقطة 7 (الرصد)
                if playerHasBox() then
                    moveToPosition(hrp, waypoints[7], speed)
                    if not autoFarm then break end
                    task.wait(0.3)
                    
                    -- البحث عن الرف
                    local realDeliveryPoint = findHiddenDeliveryTarget()
                    if realDeliveryPoint then
                        -- يمر بالممر الآمن
                        local targetAislePoint = getClosestAislePoint(realDeliveryPoint)
                        moveToPosition(hrp, targetAislePoint, speed)
                        if not autoFarm then break end
                        task.wait(0.2)
                        
                        -- الوقوف أمام الرف بدقة
                        local direction = (realDeliveryPoint - hrp.Position)
                        direction = Vector3.new(direction.X, 0, direction.Z).Unit
                        local finalShelfPos = realDeliveryPoint
                        if direction.Magnitude > 0 then
                            finalShelfPos = realDeliveryPoint - (direction * 2.5)
                        end
                        moveToPosition(hrp, Vector3.new(finalShelfPos.X, hrp.Position.Y, finalShelfPos.Z), speed)
                        if not autoFarm then break end
                        
                        -- الوقوف فقط (بدون أي ضغط E نهائياً) والانتظار حتى يكتمل الرف تماماً وتختفي علامته
                        while autoFarm and isTargetStillActive(realDeliveryPoint) do
                            task.wait(0.5)
                        end
                        
                        task.wait(0.3)
                        
                        -- أول ما يكتمل الرف تماماً، يرجع لنقطة 7 فوراً
                        moveToPosition(hrp, waypoints[7], speed)
                        task.wait(0.3)
                    else
                        task.wait(1)
                    end
                end
                
                task.wait(0.3)
                
            else
                task.wait(1)
            end
        end
    end)
end)

CodeButton.Parent = MainFrame
CodeButton.Size = UDim2.new(0.9, 0, 0, 35)
CodeButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
CodeButton.Text = "كود (نسخ الإحداثيات)"
CodeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CodeButton.TextSize = 14

CodeButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local pos = player.Character.HumanoidRootPart.Position
        local coordsText = string.format("Vector3.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z)
        if setclipboard then
            setclipboard(coordsText)
            CodeButton.Text = "تم نسخ الإحداثيات!"
        else
            CodeButton.Text = "النسخ غير مدعوم"
        end
        task.wait(1.5)
        CodeButton.Text = "كود (نسخ الإحداثيات)"
    end
end)
