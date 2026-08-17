-- إنشاء الشاشة والقائمة
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FarmButton = Instance.new("TextButton")
local SpeedInput = Instance.new("TextBox")
local CodeButton = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 190)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "قائمة التحكم"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- قائمة الإحداثيات
local waypoints = {
    Vector3.new(61.82, 254.96, 56.74),   -- النقطة 1
    Vector3.new(47.26, 254.76, 263.28),  -- النقطة 2
    Vector3.new(160.40, 254.86, 250.37), -- النقطة 3
    Vector3.new(159.49, 254.99, 204.32), -- النقطة 4
    Vector3.new(164.69, 254.99, 202.29), -- النقطة 5 (التوظف)
    Vector3.new(148.91, 254.74, 208.63), -- النقطة 6 (أخذ الصناديق - E)
    Vector3.new(125.54, 254.74, 201.89)  -- النقطة 7 (بداية البحث عن الدائرة الزرقاء)
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

local autoFarm = false
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- دالة التحرك
local function moveToPosition(hrp, targetPos, speed)
    if not autoFarm then return end
    local distance = (hrp.Position - targetPos).Magnitude
    local tweenTime = distance / math.max(speed, 1)
    
    local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPos)})
    
    tween:Play()
    
    local start = tick()
    repeat
        task.wait(0.05)
    until (tick() - start >= tweenTime) or not autoFarm
    
    if not autoFarm then
        tween:Cancel()
    end
end

-- ضغط مفتاح E
local function pressEKey()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

-- ضغط الماوس
local function clickCenter()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local centerX = viewportSize.X / 2
    local centerY = (viewportSize.Y / 2) + 50
    
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
end

-- البحث عن مكان الدائرة الزرقاء الظاهرة في السوبرماركت
local function findBlueZonePosition()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local hrp = char.HumanoidRootPart

    -- 1. البحث عن الأجزاء ذات اللون الأزرق أو الشفافة المضاءة كماركر
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            local c = part.Color
            -- فحص اللون الأزرق النقي/الفاتح للدائرة
            if (c.B > 0.6 and c.R < 0.5) or part.BrickColor.Name:lower():find("blue") or part.BrickColor.Name:lower():find("cyan") then
                local dist = (hrp.Position - part.Position).Magnitude
                if dist < 80 then
                    return part.Position
                end
            end
        elseif part:IsA("CylinderHandleAdornment") or part:IsA("Highlight") then
            if part.Adornee and part.Adornee:IsA("BasePart") then
                return part.Adornee.Position
            elseif part.Parent and part.Parent:IsA("BasePart") then
                return part.Parent.Position
            end
        end
    end

    return nil
end

-- تحديد أقرب نقطة لبداية المسار
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
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and autoFarm then
            local hrp = player.Character.HumanoidRootPart
            local speed = tonumber(SpeedInput.Text) or 25
            
            local startIndex = getClosestWaypointIndex(hrp.Position)
            
            for i = startIndex, #waypoints do
                if not autoFarm then break end
                
                local point = waypoints[i]
                moveToPosition(hrp, point, speed)
                
                if not autoFarm then break end
                
                -- النقطة 5: التوظف
                if i == 5 then
                    task.wait(0.3)
                    clickCenter()
                    pressEKey()
                    task.wait(0.2)

                -- النقطة 6: أخذ الصناديق (تضمين ضغط E المباشر)
                elseif i == 6 then
                    task.wait(0.3)
                    for _ = 1, 4 do
                        pressEKey()
                        task.wait(0.2)
                    end

                -- النقطة 7: التوجه للدائرة الزرقاء المحددة والتفريغ
                elseif i == 7 then
                    task.wait(0.3)
                    local blueZone = findBlueZonePosition()
                    
                    if blueZone then
                        moveToPosition(hrp, blueZone, speed)
                    end
                    
                    task.wait(0.3)
                    for _ = 1, 4 do
                        pressEKey()
                        task.wait(0.2)
                    end
                end
                
                task.wait(0.1)
            end
            
            if autoFarm then
                autoFarm = false
                FarmButton.Text = "تم التعبئة بنجاح!"
                FarmButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
                task.wait(2)
                FarmButton.Text = "فرام صناديق: [معطل]"
            end
        end
    end)
end)

-- زر النسخ
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
