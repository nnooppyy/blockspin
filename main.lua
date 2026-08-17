-- إنشاء الشاشة والقائمة
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FarmButton = Instance.new("TextButton")
local SpeedInput = Instance.new("TextBox")
local CodeButton = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")

-- ربط الواجهة بلاعب اللعبة
ScreenGui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- تصميم الإطار الخارجي
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 190)
MainFrame.Active = true
MainFrame.Draggable = true

-- عنوان القائمة
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "قائمة التحكم"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

-- ترتيب الأزرار
UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- قائمة الإحداثيات الخمس (مرفوعة 0.25 عن الأرض)
local waypoints = {
    Vector3.new(61.82, 254.96, 56.74),   -- النقطة 1
    Vector3.new(47.26, 254.76, 263.28),  -- النقطة 2
    Vector3.new(160.40, 254.86, 250.37), -- النقطة 3
    Vector3.new(159.49, 254.99, 204.32), -- النقطة 4
    Vector3.new(164.69, 254.99, 202.29)  -- النقطة 5
}

-- 1. خانة تحديد السرعة
SpeedInput.Parent = MainFrame
SpeedInput.Size = UDim2.new(0.9, 0, 0, 30)
SpeedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.PlaceholderText = "السرعة (افتراضي: 25)"
SpeedInput.Text = "25"
SpeedInput.TextSize = 13

-- 2. زر "فرام صناديق"
FarmButton.Parent = MainFrame
FarmButton.Size = UDim2.new(0.9, 0, 0, 35)
FarmButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
FarmButton.Text = "فرام صناديق: [معطل]"
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.TextSize = 14

local autoFarm = false
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- وظيفة محاكاة ضغط سهم أسفل (Down Arrow)
local function pressDownArrow()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Down, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Down, false, game)
end

-- وظيفة محاكاة نقرة ماوس يسار (أسفل المنتصف بقليل)
local function clickSlightlyBelowCenter()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local centerX = viewportSize.X / 2
    local centerY = (viewportSize.Y / 2) + 50 -- إضافة 50 بكسل للضغط أسفل منتصف الشاشة قليلاً
    
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
end

-- البحث عن أقرب نقطة لللاعب
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
            
            -- تحديد أقرب نقطة للبدء منها
            local startIndex = getClosestWaypointIndex(hrp.Position)
            
            -- الحركة من أقرب نقطة وحتى آخر نقطة فقط
            for i = startIndex, #waypoints do
                if not autoFarm then break end
                
                local point = waypoints[i]
                local speed = tonumber(SpeedInput.Text) or 25
                if speed <= 0 then speed = 25 end
                
                local distance = (hrp.Position - point).Magnitude
                local tweenTime = distance / speed
                
                local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(point)})
                
                tween:Play()
                
                local start = tick()
                repeat
                    task.wait(0.1)
                until (tick() - start >= tweenTime) or not autoFarm
                
                if not autoFarm then
                    tween:Cancel()
                    break
                end
                
                -- إذا كانت هذه هي النقطة الأخيرة
                if i == #waypoints then
                    task.wait(0.2)
                    -- تنزيل الشخصية أسفل قليلاً (ينزل 0.3 نقطة على محور Y)
                    hrp.CFrame = hrp.CFrame - Vector3.new(0, 0.3, 0)
                    task.wait(0.2)
                    -- ضغط سهم أسفل
                    pressDownArrow()
                    task.wait(0.2)
                    -- ضغط الماوس تحت المنتصف
                    clickSlightlyBelowCenter()
                else
                    -- النقاط العادية (تفاعل عادي)
                    task.wait(0.3)
                    clickSlightlyBelowCenter()
                end
                
                task.wait(0.5)
            end
            
            -- التوقف تلقائياً بعد الوصول لآخر نقطة
            if autoFarm then
                autoFarm = false
                FarmButton.Text = "تم الوصول لأخر نقطة!"
                FarmButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
                task.wait(2)
                FarmButton.Text = "فرام صناديق: [معطل]"
            end
        end
    end)
end)

-- 3. زر "كود" (نسخ الإحداثيات)
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
