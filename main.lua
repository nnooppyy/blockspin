-- قائمة الإحداثيات الخمس للمراحل (مع إضافة 0.25 للارتفاع Y)
local waypoints = {
    Vector3.new(61.82, 254.96, 56.74),   -- المرحلة الأولى
    Vector3.new(47.26, 254.76, 263.28),  -- المرحلة الثانية
    Vector3.new(160.40, 254.86, 250.37), -- المرحلة الثالثة
    Vector3.new(159.49, 254.99, 204.32), -- المرحلة الرابعة
    Vector3.new(164.69, 254.99, 202.29)  -- المرحلة الخامسة
}

-- ربط التنقل بزر "فرام صناديق"
local autoFarm = false
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
        while autoFarm do
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                -- المرور على جميع النقاط بالترتيب
                for index, point in ipairs(waypoints) do
                    if not autoFarm then break end
                    
                    -- نقل اللاعب إلى موقع المرحلة
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(point)
                    
                    -- الانتظار ثانية واحدة في كل نقطة (يمكنك تعديل الوقت حسب الحجم/الفارم)
                    task.wait(1)
                end
            else
                task.wait(1)
            end
        end
    end)
end)
