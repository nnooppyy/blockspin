local player = game.Players.LocalPlayer
local char = player.Character
local hrp = char and char:FindFirstChild("HumanoidRootPart")

if hrp then
    local foundObjects = {}
    table.insert(foundObjects, "=== الأشياء الموجودة تحت اللاعب ===")
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(char) then
            local dist = (obj.Position - hrp.Position).Magnitude
            -- يبحث في دائرة ضيقة جداً (5 خطوات) حول اللاعب
            if dist <= 5 then
                local info = string.format("- الاسم: %s | النوع: %s | شفافية: %s", obj.Name, obj.ClassName, tostring(obj.Transparency))
                table.insert(foundObjects, info)
            end
        end
    end
    
    local result = table.concat(foundObjects, "\n")
    if setclipboard then
        setclipboard(result)
    end
    print(result)
end
