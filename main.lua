local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

print("========== تشخيص البرومبتات ==========")

local found = 0

for _, prompt in ipairs(workspace:GetDescendants()) do
    if prompt:IsA("ProximityPrompt") then
        if prompt:IsDescendantOf(character) then
            continue
        end

        local pos = nil
        local parentName = "nil"
        local parentClass = "nil"

        if prompt.Parent then
            parentName = prompt.Parent.Name
            parentClass = prompt.Parent.ClassName

            if prompt.Parent:IsA("BasePart") then
                pos = prompt.Parent.Position
            elseif prompt.Parent.Parent and prompt.Parent.Parent:IsA("BasePart") then
                pos = prompt.Parent.Parent.Position
                parentName = prompt.Parent.Parent.Name
                parentClass = prompt.Parent.Parent.ClassName
            elseif prompt.Parent:IsA("Model") and prompt.Parent.PrimaryPart then
                pos = prompt.Parent.PrimaryPart.Position
            end
        end

        if pos then
            local dist = (hrp.Position - pos).Magnitude
            if dist < 25 then
                found = found + 1
                print("------------------------------")
                print("Name:", prompt.Name)
                print("ObjectText:", prompt.ObjectText)
                print("ActionText:", prompt.ActionText)
                print("Parent:", parentName)
                print("Parent Class:", parentClass)
                print("Distance:", string.format("%.2f", dist))
                print("Enabled:", prompt.Enabled)
                print("RequiresLineOfSight:", prompt.RequiresLineOfSight)
                print("MaxActivationDistance:", prompt.MaxActivationDistance)
                print("HoldDuration:", prompt.HoldDuration)
            end
        end
    end
end

print("عدد البرومبتات القريبة:", found)
print("======================================")