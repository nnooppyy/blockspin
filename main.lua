local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character

local countAll, countShown = 0, 0

print("========== الباقي فقط ==========")

for _, obj in ipairs(game:GetDescendants()) do
    if obj:IsA("ProximityPrompt") then
        countAll += 1

        local name = string.lower(tostring(obj.Name))
        local action = string.lower(tostring(obj.ActionText))
        local object = string.lower(tostring(obj.ObjectText))
        local parent = obj.Parent and obj.Parent:GetFullName() or ""
        local parentLow = string.lower(parent)

        local skip = false

        -- سيارات
        if string.find(name, "drive") or string.find(action, "drive") or string.find(parentLow, ".car.") then
            skip = true
        end

        -- برومبتات اللاعبين
        if string.find(parentLow, "humanoidrootpart") then
            skip = true
        end
        if name == "pickupprompt" or name == "finishprompt" then
            skip = true
        end
        if action == "pick up" or action == "finish" then
            skip = true
        end

        -- أسلحة وقوالب
        if string.find(parentLow, "replicatedstorage.items") then
            skip = true
        end

        -- محل النادي
        if string.find(parentLow, "shopzone") or string.find(action, "open shop") then
            skip = true
        end

        if not skip then
            countShown += 1
            print("------------------------------")
            print("Name:", obj.Name)
            print("ObjectText:", obj.ObjectText)
            print("ActionText:", obj.ActionText)
            print("Parent:", parent)
            print("Enabled:", obj.Enabled)
        end
    end
end

print("الكل:", countAll)
print("الباقي:", countShown)
print("================================")