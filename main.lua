local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

print("========== بحث أعمق ==========")

-- نبحث في كل اللعبة
local count = 0
for _, obj in ipairs(game:GetDescendants()) do
    if obj:IsA("ProximityPrompt") then
        count = count + 1
        local inCharacter = obj:IsDescendantOf(character)
        print("------------------------------")
        print("Name:", obj.Name)
        print("ObjectText:", obj.ObjectText)
        print("ActionText:", obj.ActionText)
        print("Parent:", obj.Parent and obj.Parent:GetFullName())
        print("Enabled:", obj.Enabled)
        print("في الشخصية؟", inCharacter)
    end
end

print("إجمالي عدد ProximityPrompt في اللعبة:", count)
print("================================")