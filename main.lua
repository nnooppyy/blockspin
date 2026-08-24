-- التأكد من تحميل اللاعب والـ PlayerGui
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- حذف أي نسخة قديمة لتجنب التكرار
if PlayerGui:FindFirstChild("FinalControlGui") then
    PlayerGui.FinalControlGui:Destroy()
end

-- إنشاء الشاشة الرئيسية بشكل آمن
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FinalControlGui"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

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
    Vector3.new(61.82, 254.96, 56.74),   -- 1
    Vector3.new(47.26, 254.76, 263.28),  -- 2
    Vector3.new(160.40, 254.86, 250.37), -- 3
    Vector3.new(160.37, 255.18, 227.71), -- 4
    Vector3.new(159.49, 254.99, 204.32), -- 5
    Vector3.new(164.69, 254.99, 202.29), -- 6 (التوظيف)
    Vector3.new(148.91, 254.74, 208.63), -- 7 (الصناديق)
    Vector3.new(125.54, 254.74, 201.89), -- 8 (ممر الرفوف)
}

local aislePoints = {
    Vector3.new(121.61, 255.32, 202.77), -- 1 (الداخلية)
    Vector3.new(125.51, 255.32, 184.90), -- 2 (الداخلية)
    Vector3.new(128.39, 255.32, 167.04)  -- 3 (الداخلية)
}

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

local autoFarm = false
local showPointsEnabled = false
local pointsFolder = nil
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

FloatingToggle.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
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
    if not autoFarm then
        return
    end

    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    checkAndUnsit(humanoid)

    while isTeleportDetected() and autoFarm do
        task.wait(0.2)
    end

    local safePos = Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z)
    local distance = (hrp.Position - safePos).Magnitude
    local tweenTime = distance / math.max(speed, 1)

    local tweenInfo = TweenInfo.new(
        tweenTime,
        Enum.EasingStyle.Linear
    )

    local tween = TweenService:Create(
        hrp,
        tweenInfo,
        {
            CFrame = CFrame.new(safePos)
        }
    )

    tween:Play()

    local expectedEnd = tick() + tweenTime

    repeat
        task.wait(0.05)
        checkAndUnsit(humanoid)

        if isTeleportDetected() then
            tween:Pause()

            local pauseStart = tick()

            while isTeleportDetected() and autoFarm do
                task.wait(0.2)
            end

            local pauseDuration = tick() - pauseStart
            expectedEnd = expectedEnd + pauseDuration

            if autoFarm then
                tween:Play()
            end
        end

    until tick() >= expectedEnd or not autoFarm

    if not autoFarm then
        tween:Cancel()
    end
end

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

local function clickCenter()
    local viewportSize = workspace.CurrentCamera.ViewportSize

    local centerX = viewportSize.X / 2
    local centerY = (viewportSize.Y / 2) + 50

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

local function checkEmploymentStatusText()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")

    if playerGui then
        for _, gui in ipairs(playerGui:GetDescendants()) do
            if (gui:IsA("TextLabel") or gui:IsA("TextButton")) and gui.Visible then

                local text = string.lower(gui.Text or "")

                if string.find(text, "leave") then
                    return "employed"
                end

                if string.sub(text, 1, 2) == "ap"
                    or string.find(text, "apply") then

                    return "unemployed"
                end
            end
        end
    end

    return "unknown"
end

local function playerHasBox()
    if LocalPlayer.Character then
        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")

        if tool then
            return true
        end
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

    if not char or not char:FindFirstChild("HumanoidRootPart") then
        return nil
    end

    local searchCenter = waypoints[8]
    local targetPos = nil
    local minDist = 120

    for _, obj in ipairs(workspace:GetDescendants()) do

        if obj:IsA("BasePart") and not obj:IsDescendantOf(char) then

            local dist = (obj.Position - searchCenter).Magnitude

            if dist <= minDist then

                local isMatch = false

                if obj.Name == "Base"
                    and obj:IsA("MeshPart")
                    and obj.Size.Y < 2.5 then

                    isMatch = true
                end

                if obj.Name == "Shelf"
                    and obj.Transparency == 1 then

                    for _, child in ipairs(obj:GetChildren()) do

                        if child:IsA("ParticleEmitter")
                            or child:IsA("Beam")
                            or child:IsA("Highlight")
                            or child:IsA("PointLight") then

                            if child.Enabled then
                                isMatch = true
                                break
                            end
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
    if not targetPos then
        return false
    end

    for _, obj in ipairs(workspace:GetDescendants()) do

        if obj:IsA("BasePart") then

            if (obj.Position - targetPos).Magnitude < 4 then

                local isMatch = false

                if obj.Name == "Base"
                    and obj:IsA("MeshPart")
                    and obj.Size.Y < 2.5 then

                    isMatch = true
                end

                if obj.Name == "Shelf"
                    and obj.Transparency == 1 then

                    for _, child in ipairs(obj:GetChildren()) do

                        if child:IsA("ParticleEmitter")
                            or child:IsA("Beam")
                            or child:IsA("Highlight")
                            or child:IsA("PointLight") then

                            if child.Enabled then
                                isMatch = true
                                break
                            end
                        end
                    end
                end

                if isMatch then
                    return true
                end
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

        return
    end

    task.spawn(function()

        -- =====================================================
        -- التعديل الوحيد:
        -- فحص التوظيف مرة واحدة عند تشغيل الفرام
        -- =====================================================
        if autoFarm then

            local status = checkEmploymentStatusText()

            if status ~= "employed" then

                task.wait(0.3)

                if autoFarm then
                    clickCenter()
                    task.wait(0.5)
                end
            end
        end

        -- =====================================================
        -- بداية دورة الفرام
        -- =====================================================
        while autoFarm do

            pcall(function()
                VirtualInputManager:SendKeyEvent(
                    true,
                    Enum.KeyCode.LeftShift,
                    false,
                    game
                )
            end)

            if LocalPlayer.Character
                and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

                local hrp = LocalPlayer.Character.HumanoidRootPart
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")

                checkAndUnsit(humanoid)

                local speed = tonumber(SpeedInput.Text) or 25

                -- =================================================
                -- ما معه صندوق
                -- =================================================
                if not playerHasBox() then

                    if isInsideGrocery(hrp.Position) then

                        local internalPoint =
                            getClosestInternalAisle(hrp.Position)

                        moveToPosition(
                            hrp,
                            internalPoint,
                            speed
                        )

                        if not autoFarm then
                            break
                        end

                        moveToPosition(
                            hrp,
                            waypoints[6],
                            speed
                        )

                        if not autoFarm then
                            break
                        end

                        -- التعديل:
                        -- حذف فحص التوظيف من هنا

                        if autoFarm then
                            moveToPosition(
                                hrp,
                                waypoints[7],
                                speed
                            )
                        end

                    else

                        local startIndex =
                            getClosestStartPoint(hrp.Position)

                        for i = startIndex, 3 do

                            if not autoFarm then
                                break
                            end

                            moveToPosition(
                                hrp,
                                waypoints[i],
                                speed
                            )
                        end

                        for i = 4, 6 do

                            if not autoFarm then
                                break
                            end

                            moveToPosition(
                                hrp,
                                waypoints[i],
                                speed
                            )
                        end

                        -- التعديل:
                        -- حذف فحص التوظيف من هنا أيضاً

                        if autoFarm then
                            moveToPosition(
                                hrp,
                                waypoints[7],
                                speed
                            )
                        end
                    end

                    if not autoFarm then
                        break
                    end

                    task.wait(0.2)

                    -- ضغط زر E خمس مرات لالتقاط الصندوق
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

                -- =================================================
                -- معه صندوق
                -- =================================================
                if playerHasBox() then

                    moveToPosition(
                        hrp,
                        waypoints[8],
                        speed
                    )

                    if not autoFarm then
                        break
                    end

                    task.wait(0.2)

                    local realDeliveryPoint =
                        findHiddenDeliveryTarget()

                    if realDeliveryPoint then

                        local targetAislePoint =
                            getClosestAislePoint(realDeliveryPoint)

                        moveToPosition(
                            hrp,
                            targetAislePoint,
                            speed
                        )

                        if not autoFarm then
                            break
                        end

                        task.wait(0.2)

                        moveToPosition(
                            hrp,
                            Vector3.new(
                                realDeliveryPoint.X,
                                hrp.Position.Y,
                                realDeliveryPoint.Z
                            ),
                            speed
                        )

                        if not autoFarm then
                            break
                        end

                        while autoFarm
                            and isTargetStillActive(realDeliveryPoint) do

                            checkAndUnsit(humanoid)
                            task.wait(0.3)
                        end

                        task.wait(0.2)

                        moveToPosition(
                            hrp,
                            targetAislePoint,
                            speed
                        )

                        if not autoFarm then
                            break
                        end

                        task.wait(0.2)

                        -- الرجوع الطبيعي:
                        -- 8 -> 7 -> 6

                        moveToPosition(
                            hrp,
                            waypoints[8],
                            speed
                        )

                        if not autoFarm then
                            break
                        end

                        moveToPosition(
                            hrp,
                            waypoints[7],
                            speed
                        )

                        if not autoFarm then
                            break
                        end

                        moveToPosition(
                            hrp,
                            waypoints[6],
                            speed
                        )

                        if not autoFarm then
                            break
                        end

                        -- التعديل:
                        -- لا يوجد فحص توظيف هنا.
                        -- يكمل مباشرة للصندوق التالي.

                        if autoFarm then
                            moveToPosition(
                                hrp,
                                waypoints[7],
                                speed
                            )
                        end

                    else
                        task.wait(1)
                    end
                end

                task.wait(0.2)

            else
                task.wait(1)
            end
        end

        pcall(function()
            VirtualInputManager:SendKeyEvent(
                false,
                Enum.KeyCode.LeftShift,
                false,
                game
            )
        end)
    end)
end)

CodeButton.MouseButton1Click:Connect(function()

    if LocalPlayer.Character
        and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

        local pos = LocalPlayer.Character.HumanoidRootPart.Position

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
    end
end)