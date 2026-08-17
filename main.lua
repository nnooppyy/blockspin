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
    Vector3.new(164.69, 254.99, 202.29), -- النقطة 5 (فحص النص Apply / Leave)
    Vector3.new(148.91, 254.74, 208.63), -- النقطة 6 (أخذ الصناديق)
    Vector3.new(125.54, 254.74, 201.89)  -- النقطة 7 (بداية مسار التعبئة)
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

-- دالة للتحرك التلقائي
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

-- ضغط حرف E
local function pressEKey()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

-- ضغط الماوس في المنتصف
local function clickSlightlyBelowCenter()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local centerX = viewportSize.X / 2
    local centerY = (viewportSize.Y / 2) + 50
    
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
end

-- فحص قراءة الكلمات على الشاشة (Apply أو Leave)
local function checkEmploymentStatusText()
    local player = game.Players.LocalPlayer
    local playerGui = player:FindFirstChild("PlayerGui")
    
    if playerGui then
        for _, gui in ipairs(playerGui:GetDescendants()) do
            if (gui:IsA("TextLabel") or gui:IsA("TextButton")) and gui.Visible then
                local text = string.lower(gui.Text or "")
                
                -- إذا وجد كلمة leave
                if text:find("leave") then
                    return "employed"
                end
                
                -- إذا وجد كلمة apply
                if text:find("apply") then
                    return "unemployed"
                end
            end
        end
    end
    
    return "unknown"
end

-- البحث الذكي عن موقع السهم للتعبئة
local function findArrowDestination()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char then return nil end

    -- 1. البحث عن Beam (شريط السهم الممتد)
    for _, beam in ipairs(workspace:GetDescendants()) do
        if beam:IsA("Beam") and beam.Enabled then
            if beam.Attachment1 and beam.Attachment1.Parent then
                local targetPart = beam.Attachment1.Parent
                if targetPart:IsA("BasePart") then
                    return targetPart.Position
                end
            end
        end
    end

    -- 2. البحث عن أسهم أو مؤشرات اتجاه
    for _, obj in ipairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if name:find("arrow") or name:find("target") or name:find("destination") or name:find("pointer") or name:find("saham") then
            if obj:IsA("BasePart") then
                return obj.Position
            elseif obj:IsA("Model") and obj.PrimaryPart then
                return obj.PrimaryPart.Position
            end
        end
    end

    -- 3. البحث عن اللوحات المضيئة فوق منطقة التعبئة
    for _, gui in ipairs(workspace:GetDescendants()) do
        if gui:IsA("BillboardGui") and gui.Enabled then
            local parentPart = gui.Parent
            if parentPart and parentPart:IsA("BasePart") and parentPart ~= char:FindFirstChild("HumanoidRootPart") then
                return parentPart.Position
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
                
                -- تنفيذ الأوامر الخاصة لكل نقطة
                if i == 5 then
                    -- النقطة 5: فحص النص المكتوب (Apply / Leave)
                    task.wait(0.4)
                    local status = checkEmploymentStatusText()
                    
                    if status == "unemployed" or status == "unknown" then
                        -- إذا ظهر Apply أو لم يجد النص (غير متوظف) يضغط للتوظيف
                        clickSlightlyBelowCenter()
                        task.wait(0.3)
                    elseif status == "employed" then
                        -- إذا ظهر Leave (متوظف) يتعدى الضغط ويكمل للنقطة 6 مباشرة
                        task.wait(0.1)
                    end
                    
                elseif i == 6 then
                    -- النقطة 6: أخذ الصناديق عبر ضغط E
                    task.wait(0.2)
                    for _ = 1, 3 do
                        pressEKey()
                        task.wait(0.15)
                    end
                elseif i == 7 then
                    -- النقطة 7: تتبع السهم للتعبئة
                    task.wait(0.3)
                    local arrowTarget = findArrowDestination()
                    if arrowTarget then
                        moveToPosition(hrp, arrowTarget, speed)
                        task.wait(0.2)
                        pressEKey()
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
