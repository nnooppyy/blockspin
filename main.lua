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

-- القائمة الرئيسية
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FarmButton = Instance.new("TextButton")
local SpeedInput = Instance.new("TextBox")
local UIListLayout = Instance.new("UIListLayout")

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.08, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 50

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "قائمة التحكم المبسطة"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.ZIndex = 50

UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

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
FarmButton.Text = "تشغيل الفرام: [معطل]"
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.TextSize = 14
FarmButton.ZIndex = 50

FloatingToggle.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local autoFarm = false
local TweenService = game:GetService("TweenService")

FarmButton.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    if autoFarm then
        FarmButton.Text = "تشغيل الفرام: [مفعل]"
        FarmButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        print("تم تفعيل الفرام بنجاح!")
    else
        FarmButton.Text = "تشغيل الفرام: [معطل]"
        FarmButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        print("تم إيقاف الفرام.")
    end
end)

print("تم تحميل واجهة التحكم بنجاح!")
