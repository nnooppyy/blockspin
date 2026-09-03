local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local MAX_DISTANCE = 20
local countAll, countNear = 0, 0

local function getPos(prompt)
    local p = prompt.Parent
    if not p then return nil end
    if p:IsA("BasePart") then return p.Position end
    if p:IsA("Attachment") and p.Parent and p.Parent:IsA("BasePart") then
        return p.Parent.Position
    end
    if p:IsA("Model") and p.PrimaryPart then return p.PrimaryPart.Position end
    if p.Parent and p.Parent:IsA("BasePart") then return p.Parent.Position end
    return nil
end

print("========== القريب فقط ==========")

for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("ProximityPrompt") then
        countAll += 1

        local name = string.lower(tostring(obj.Name))
        local action = string.lower(tostring(obj.ActionText))
        local parent = obj.Parent and obj.Parent:GetFullName() or ""
        local parentLow = string.lower(parent)

        if string.find(name, "drive") or string.find(action, "drive") then continue end
        if string.find(parentLow, "humanoidrootpart") then continue end
        if name == "pickupprompt" or name == "finishprompt" then continue end
        if action == "pick up" or action == "finish" then continue end
        if string.find(parentLow, "shopzone") then continue end

        local pos = getPos(obj)
        if not pos then continue end

        local dist = (hrp.Position - pos).Magnitude
        if dist <= MAX_DISTANCE then
            countNear += 1
            print("------------------------------")
            print("Name:", obj.Name)
            print("ObjectText:", obj.ObjectText)
            print("ActionText:", obj.ActionText)
            print("Parent:", parent)
            print("Enabled:", obj.Enabled)
            print("Distance:", string.format("%.2f", dist))
        end
    end
end

print("كل برومبتات الورك سبيس:", countAll)
print("القريبة بعد الفلتر:", countNear)
print("================================")