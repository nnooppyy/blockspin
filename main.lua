local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local ToggleCircle = Instance.new("TextButton", MainFrame)
local FarmButton = Instance.new("TextButton", MainFrame)

-- إعدادات القائمة
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Draggable = true

-- الزر الدائري (التشغيل العام)
ToggleCircle.Size = UDim2.new(0, 40, 0, 40)
ToggleCircle.Position = UDim2.new(0.05, 0, 0.1, 0)
ToggleCircle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleCircle.Text = "ON/OFF"
ToggleCircle.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", ToggleCircle).CornerRadius = UDim.new(1, 0)

-- زر الفرام
FarmButton.Size = UDim2.new(0.8, 0, 0, 40)
FarmButton.Position = UDim2.new(0.1, 0, 0.5, 0)
FarmButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
FarmButton.Text = "فرام: معطل"

local isEnabled = false
local autoFarm = false
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

-- وظيفة الركض التلقائي (الشفت)
task.spawn(function()
    while true do
        task.wait(0.5)
        if isEnabled and autoFarm then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
        else
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
        end
    end
end)

-- الزر الرئيسي (التشغيل)
ToggleCircle.MouseButton1Click:Connect(function()
    isEnabled = not isEnabled
    ToggleCircle.BackgroundColor3 = isEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

FarmButton.MouseButton1Click:Connect(function()
    if not isEnabled then return end
    autoFarm = not autoFarm
    FarmButton.Text = autoFarm and "فرام: مفعل" or "فرام: معطل"
    
    if autoFarm then
        task.spawn(function()
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            while autoFarm and isEnabled do
                -- 1. التأكد من التوظيف (وضعنا الإحداثية الجديدة كبداية)
                local pos = Vector3.new(160.37, 255.18, 227.71)
                
                -- التوجه للمكان
                local tween = TweenService:Create(hrp, TweenInfo.new(2), {CFrame = CFrame.new(pos)})
                tween:Play()
                tween.Completed:Wait()
                
                -- الضغط للتوظيف (استخدام كليك أو E)
                VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                task.wait(0.1)
                VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, game, 0)
                
                task.wait(2)
                
                -- 2. الذهاب لأخذ الصناديق (نقطة 7 القديمة)
                moveTo(Vector3.new(125.54, 254.74, 201.89))
                for i=1, 5 do
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                    task.wait(0.2)
                end
                
                -- 3. التوصيل (نقطة 3 الجديدة)
                moveTo(Vector3.new(125.51, 255.32, 184.90))
                task.wait(1)
            end
        end)
    end
end)

-- وظيفة الحركة المختصرة
function moveTo(target)
    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tween = TweenService:Create(hrp, TweenInfo.new(1), {CFrame = CFrame.new(target)})
    tween:Play()
    tween.Completed:Wait()
end
