-- التأكد من تحميل اللاعب والـ PlayerGui
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- حذف أي نسخة قديمة لتجنب التكرار
local oldGui = PlayerGui:FindFirstChild("FinalControlGui")
if oldGui then
    oldGui:Destroy()
end

-- إنشاء الشاشة الرئيسية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FinalControlGui"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- الخدمات
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- زر الدائرة العائم
local FloatingToggle = Instance.new("TextButton")
FloatingToggle.Parent = ScreenGui
FloatingToggle.Size = UDim2.new(0, 50, 0, 50)
FloatingToggle.Position = UDim2.new(0.02, 0, 0.4, 0)
FloatingToggle.BackgroundColor3 = Color3.fromRGB(40, 15, 55)
FloatingToggle.Text = "Z"
FloatingToggle.TextColor3 = Color3.fromRGB(180, 120, 220)
FloatingToggle.TextSize = 22
FloatingToggle.Font = Enum.Font.SourceSansBold
FloatingToggle.Draggable = true
FloatingToggle.ZIndex = 100

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = FloatingToggle

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(15, 10, 20)
UIStroke.Thickness = 3
UIStroke.Parent = FloatingToggle

-- القائمة الرئيسية
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FarmButton = Instance.new("TextButton")
local ShowPointsButton = Instance.new("TextButton")
local SpeedInput = Instance.new("TextBox")
local CodeButton = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.08, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 230)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 50

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "قائمة التحكم النهائية"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.ZIndex = 50

UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- الإحداثيات العامة
local waypoints = {
    Vector3.new(61.82, 254.96, 56.74),
    Vector3.new(47.26, 254.76, 263.28),
    Vector3.new(160.40, 254.86, 250.37),
    Vector3.new(160.37, 255.18, 227.71),
    Vector3.new(159.49, 254.99, 204.32),
    Vector3.new(164.69, 254.99, 202.29),
    Vector3.new(148.91, 254.74, 208.63),
    Vector3.new(125.54, 254.74, 201.89),
}

local aislePoints = {
    Vector3.new(121.61, 255.32, 202.77),
    Vector3.new(125.51, 255.32, 184.90),
    Vector3.new(128.39, 255.32, 167.04),
}

-- إعدادات العناصر
SpeedInput.Parent = MainFrame
SpeedInput.Size = UDim2.new(0.9, 0, 0, 30)
SpeedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.PlaceholderText = "السرعة (افتراضي: 25)"
SpeedInput.Text = "25"
SpeedInput.TextSize = 13
SpeedInput.ZIndex = 50

FarmButton.Parent = MainFrame
FarmButton.Size = UDim2.new(0.9, 0, 0, 35)
FarmButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
FarmButton.Text = "فرام صناديق: [معطل]"
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.TextSize = 14
FarmButton.ZIndex = 50

ShowPointsButton.Parent = MainFrame
ShowPointsButton.Size = UDim2.new(0.9, 0, 0, 35)
ShowPointsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
ShowPointsButton.Text = "إظهار النقاط: [مخفية]"
ShowPointsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowPointsButton.TextSize = 14
ShowPointsButton.ZIndex = 50

CodeButton.Parent = MainFrame
CodeButton.Size = UDim2.new(0.9, 0, 0, 35)
CodeButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
CodeButton.Text = "كود (نسخ الإحداثيات)"
CodeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CodeButton.TextSize = 14
CodeButton.ZIndex = 50

-- المتغيرات
local autoFarm = false
local showPointsEnabled = false
local pointsFolder = nil

-- نتيجة فحص التوظيف المحفوظة
local employmentStatus = "unknown"

-- منع تشغيل أكثر من حلقة في نفس الوقت
local farmRunning = false

-- إظهار وإخفاء القائمة
FloatingToggle.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- إلغاء الجلوس
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

-- التحقق من دخول المتجر
local function isInsideGrocery(pos)
    local minX, maxX = 85, 172
    local minZ, maxZ = 158, 218

    return pos.X >= minX
        and pos.X <= maxX
        and pos.Z >= minZ
        and pos.Z <= maxZ
end

-- فحص حالة التوظيف
local function checkEmploymentStatusText()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")

    if playerGui then
        for _, gui in ipairs(playerGui:GetDescendants()) do
            if (gui:IsA("TextLabel") or gui:IsA("TextButton")) and gui.Visible then
                local text = string.lower(gui.Text or "")

                if string.find(text, "leave", 1, true) then
                    return "employed"
                end

                if string.find(text, "apply", 1, true)
                    or string.sub(text, 1, 2) == "ap" then
                    return "unemployed"
                end
            end
        end
    end

    return "unknown"
end

-- إنشاء وإظهار النقاط
local function toggleVisualPoints()
    showPointsEnabled = not showPointsEnabled

    if showPointsEnabled then
        ShowPointsButton.Text = "إظهار النقاط: [ظاهرة]"
        ShowPointsButton.BackgroundColor3 = Color3.fromRGB(150, 100, 0)

        if pointsFolder then
            pointsFolder:Destroy()
        end

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

            local billboard = Instance.new("BillboardGui")
            billboard.Size = UDim2.new(0, 60, 0, 20)
            billboard.StudsOffset = Vector3.new(0, 1.5, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = part

            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = text
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.TextSize = 10
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.Parent = billboard
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

-- اكتشاف رسالة منع الانتقال
local function isTeleportDetected()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")

    if playerGui then
        for _, gui in ipairs(playerGui:GetDescendants()) do
            if (gui:IsA("TextLabel") or gui:IsA("TextButton")) and gui.Visible then
                local text = string.lower(gui.Text or "")

                if string.find(text, "teleport detected", 1, true) then
                    return true
                end
            end
        end
    end

    return false
end

-- التحرك إلى نقطة
local function moveToPosition(hrp, targetPos, speed)
    if not autoFarm or not hrp then
        return
    end

    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChild("Humanoid")

    checkAndUnsit(humanoid)

    while autoFarm and isTeleportDetected() do
        task.wait(0.2)
    end

    if not autoFarm then
        return
    end

    local safePos = Vector3.new(
        targetPos.X,
        hrp.Position.Y,
        targetPos.Z
    )

    local distance = (hrp.Position - safePos).Magnitude
    local tweenTime = distance / math.max(speed, 1)

    if distance <= 1 then
        return
    end

    local tweenInfo = TweenInfo.new(
        tweenTime,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )

    local tween = TweenService:Create(
        hrp,
        tweenInfo,
        {CFrame = CFrame.new(safePos)}
    )

    tween:Play()

    local endTime = tick() + tweenTime

    while autoFarm and tick() < endTime do
        task.wait(0.05)
        checkAndUnsit(humanoid)

        if isTeleportDetected() then
            tween:Pause()

            while autoFarm and isTeleportDetected() do
                task.wait(0.2)
            end

            if autoFarm then
                tween:Play()
            end
        end
    end

    if tween then
        if autoFarm then
            tween:Cancel()
        else
            tween:Cancel()
        end
    end
end

-- ضغط زر E
local function pressEKey()
    VirtualInputManager:SendKeyEvent(
        true,
        Enum.KeyCode.E,
        false,
        game
    )

    task.wait(0.1)

    VirtualInputManager:SendKeyEvent(
        false,
        Enum.KeyCode.E,
        false,
        game
    )
end

-- النقر في منتصف الشاشة
local function clickCenter()
    local camera = workspace.CurrentCamera
    if not camera then
        return
    end

    local viewportSize = camera.ViewportSize
    local centerX = viewportSize.X / 2
    local centerY = viewportSize.Y / 2 + 50

    VirtualInputManager:SendMouseButtonEvent(
        centerX,
        centerY,
        0,
        true,
        game,
        0
    )

    task.wait(0.05)

    VirtualInputManager:SendMouseButtonEvent(
        centerX,
        centerY,
        0,
        false,
        game,
        0
    )
end

-- التحقق من وجود صندوق
local function playerHasBox()
    local character = LocalPlayer.Character

    if character then
        return character:FindFirstChildOfClass("Tool") ~= nil
    end

    return false
end

-- أقرب نقطة بداية
local function getClosestStartPoint(playerPos)
    local closestIndex = 1
    local minDistance = math.huge

    for i = 1, 3 do
        local distance = (playerPos - waypoints[i]).Magnitude

        if distance < minDistance then
            minDistance = distance
            closestIndex = i
        end
    end

    return closestIndex
end

-- أقرب ممر داخلي
local function getClosestInternalAisle(playerPos)
    local closestPoint = aislePoints[1]
    local minDistance = math.huge

    for _, point in ipairs(aislePoints) do
        local distance = (playerPos - point).Magnitude

        if distance < minDistance then
            minDistance = distance
            closestPoint = point
        end
    end

    return closestPoint
end

-- البحث عن هدف التوصيل المخفي
local function findHiddenDeliveryTarget()
    local character = LocalPlayer.Character

    if not character then
        return nil
    end

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        return nil
    end

    local searchCenter = waypoints[8]
    local targetPosition = nil
    local maxDistance = 120

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(character) then
            local distance = (obj.Position - searchCenter).Magnitude

            if distance <= maxDistance then
                local isMatch = false

                if obj.Name == "Base"
                    and obj:IsA("MeshPart")
                    and obj.Size.Y < 2.5 then
                    isMatch = true
                end

                if obj.Name == "Shelf" and obj.Transparency == 1 then
                    for _, child in ipairs(obj:GetChildren()) do
                        if (
                            child:IsA("ParticleEmitter")
                            or child:IsA("Beam")
                            or child:IsA("Highlight")
                            or child:IsA("PointLight")
                        ) and child.Enabled then
                            isMatch = true
                            break
                        end
                    end
                end

                if isMatch then
                    maxDistance = distance
                    targetPosition = obj.Position
                end
            end
        end
    end

    return targetPosition
end

-- التحقق من بقاء هدف التوصيل
local function isTargetStillActive(targetPos)
    if not targetPos then
        return false
    end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart")
            and (obj.Position - targetPos).Magnitude < 4 then

            local isMatch = false

            if obj.Name == "Base"
                and obj:IsA("MeshPart")
                and obj.Size.Y < 2.5 then
                isMatch = true
            end

            if obj.Name == "Shelf" and obj.Transparency == 1 then
                for _, child in ipairs(obj:GetChildren()) do
                    if (
                        child:IsA("ParticleEmitter")
                        or child:IsA("Beam")
                        or child:IsA("Highlight")
                        or child:IsA("PointLight")
                    ) and child.Enabled then
                        isMatch = true
                        break
                    end
                end
            end

            if isMatch then
                return true
            end
        end
    end

    return false
end

-- أقرب نقطة ممر للهدف
local function getClosestAislePoint(targetPos)
    local closestPoint = aislePoints[1]
    local minDistance = math.huge

    for _, point in ipairs(aislePoints) do
        local distance = (point - targetPos).Magnitude

        if distance < minDistance then
            minDistance = distance
            closestPoint = point
        end
    end

    return closestPoint
end

-- استخدام حالة التوظيف المحفوظة بدون إعادة الفحص
local function handleEmployment()
    if employmentStatus ~= "employed" then
        task.wait(0.3)
        clickCenter()
        task.wait(0.5)

        -- لا يوجد فحص جديد هنا؛ تُستخدم القيمة الأصلية
        employmentStatus = "employed"
    end
end

-- تشغيل دورة الفرام
local function runFarmLoop()
    if farmRunning then
        return
    end

    farmRunning = true

    while autoFarm do
        pcall(function()
            VirtualInputManager:SendKeyEvent(
                true,
                Enum.KeyCode.LeftShift,
                false,
                game
            )
        end)

        local character = LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChild("Humanoid")

        if not hrp then
            task.wait(1)
            continue
        end

        checkAndUnsit(humanoid)

        local speed = tonumber(SpeedInput.Text) or 25

        if not playerHasBox() then
            if isInsideGrocery(hrp.Position) then
                local internalPoint = getClosestInternalAisle(hrp.Position)
                moveToPosition(hrp, internalPoint, speed)

                if not autoFarm then
                    break
                end

                moveToPosition(hrp, waypoints[6], speed)

                if not autoFarm then
                    break
                end

                handleEmployment()

                if autoFarm then
                    moveToPosition(hrp, waypoints[7], speed)
                end
            else
                local startIndex = getClosestStartPoint(hrp.Position)

                for i = startIndex, 3 do
                    if not autoFarm then
                        break
                    end

                    moveToPosition(hrp, waypoints[i], speed)
                end

                for i = 4, 6 do
                    if not autoFarm then
                        break
                    end

                    moveToPosition(hrp, waypoints[i], speed)
                end

                if autoFarm then
                    handleEmployment()
                end

                if autoFarm then
                    moveToPosition(hrp, waypoints[7], speed)
                end
            end

            if not autoFarm then
                break
            end

            task.wait(0.2)

            -- محاولة التقاط الصندوق
            for _ = 1, 5 do
                if not autoFarm or playerHasBox() then
                    break
                end

                pressEKey()
                task.wait(0.15)
            end

            task.wait(0.2)
        end

        if not autoFarm then
            break
        end

        if playerHasBox() then
            moveToPosition(hrp, waypoints[8], speed)

            if not autoFarm then
                break
            end

            task.wait(0.2)

            local realDeliveryPoint = findHiddenDeliveryTarget()

            if realDeliveryPoint then
                local targetAislePoint =
                    getClosestAislePoint(realDeliveryPoint)

                moveToPosition(hrp, targetAislePoint, speed)

                if not autoFarm then
                    break
                end

                task.wait(0.2)

                local finalPosition = Vector3.new(
                    realDeliveryPoint.X,
                    hrp.Position.Y,
                    realDeliveryPoint.Z
                )

                moveToPosition(hrp, finalPosition, speed)

                if not autoFarm then
                    break
                end

                while autoFarm and isTargetStillActive(realDeliveryPoint) do
                    checkAndUnsit(humanoid)
                    task.wait(0.3)
                end

                task.wait(0.2)

                moveToPosition(hrp, targetAislePoint, speed)
                task.wait(0.2)

                moveToPosition(hrp, waypoints[8], speed)

                if not autoFarm then
                    break
                end

                moveToPosition(hrp, waypoints[7], speed)

                if not autoFarm then
                    break
                end

                moveToPosition(hrp, waypoints[6], speed)

                if not autoFarm then
                    break
                end

                -- استخدام الحالة المحفوظة فقط
                handleEmployment()

                if autoFarm then
                    moveToPosition(hrp, waypoints[7], speed)
                end
            else
                task.wait(1)
            end
        end

        task.wait(0.2)
    end

    pcall(function()
        VirtualInputManager:SendKeyEvent(
            false,
            Enum.KeyCode.LeftShift,
            false,
            game
        )
    end)

    farmRunning = false
end

-- زر تشغيل وإيقاف الفرام
FarmButton.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm

    if autoFarm then
        -- الفحص يحدث مرة واحدة فقط عند التشغيل
        employmentStatus = checkEmploymentStatusText()

        FarmButton.Text = "فرام صناديق: [مفعل]"
        FarmButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

        pcall(function()
            VirtualInputManager:SendKeyEvent(
                true,
                Enum.KeyCode.LeftShift,
                false,
                game
            )
        end)

        task.spawn(runFarmLoop)
    else
        FarmButton.Text = "فرام صناديق: [معطل]"
        FarmButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)

        pcall(function()
            VirtualInputManager:SendKeyEvent(
                false,
                Enum.KeyCode.LeftShift,
                false,
                game
            )
        end)
    end
end)

-- زر نسخ الإحداثيات
CodeButton.MouseButton1Click:Connect(function()
    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")

    if not hrp then
        return
    end

    local pos = hrp.Position

    local coordsText = string.format(
        "Vector3.new(%.2f, %.2f, %.2f)",
        pos.X,
        pos.Y,
        pos.Z
    )

    if setclipboard then
        setclipboard(coordsText)
        CodeButton.Text = "تم نسخ الإحداثيات!"
    else
        CodeButton.Text = "النسخ غير مدعوم"
    end

    task.wait(1.5)
    CodeButton.Text = "كود (نسخ الإحداثيات)"
end)
