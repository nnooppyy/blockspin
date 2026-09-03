local character = game.Players.LocalPlayer.Character
local countAll, countShown = 0, 0

print("========== بدون سيارات ==========")

for _, obj in ipairs(game:GetDescendants()) do
    if obj:IsA("ProximityPrompt") then
        countAll += 1

        local name = string.lower(tostring(obj.Name))
        local action = string.lower(tostring(obj.ActionText))
        local object = string.lower(tostring(obj.ObjectText))
        local parent = obj.Parent and obj.Parent:GetFullName() or ""
        local parentLow = string.lower(parent)

        local isCar =
            string.find(name, "drive") or
            string.find(action, "drive") or
            string.find(parentLow, ".car.") or
            string.find(parentLow, "replicatedstorage.items.car")

        if not isCar then
            countShown += 1
            print("------------------------------")
            print("Name:", obj.Name)
            print("ObjectText:", obj.ObjectText)
            print("ActionText:", obj.ActionText)
            print("Parent:", parent)
            print("Enabled:", obj.Enabled)
            print("في الشخصية؟", character and obj:IsDescendantOf(character))
        end
    end
end

print("الكل:", countAll)
print("بعد حذف السيارات:", countShown)
print("================================")