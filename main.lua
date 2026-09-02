local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.wait(1)

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local closestPrompt = nil
local shortestDistance = 20

for _, prompt in ipairs(workspace:GetDescendants()) do
    if prompt:IsA("ProximityPrompt") then
        local pos = nil
        
        if prompt.Parent and prompt.Parent:IsA("BasePart") then
            pos = prompt.Parent.Position
        elseif prompt.Parent and prompt.Parent.Parent and prompt.Parent.Parent:IsA("BasePart") then
            pos = prompt.Parent.Parent.Position
        elseif prompt.Parent and prompt.Parent:IsA("Model") and prompt.Parent.PrimaryPart then
            pos = prompt.Parent.PrimaryPart.Position
        end

        if pos then
            local distance = (hrp.Position - pos).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestPrompt = prompt
            end
        end
    end
end

if closestPrompt then
    print("========== معلومات البرومبت ==========")
    print("Name: " .. tostring(closestPrompt.Name))
    print("ObjectText: " .. tostring(closestPrompt.ObjectText))
    print("ActionText: " .. tostring(closestPrompt.ActionText))
    print("Parent: " .. tostring(closestPrompt.Parent and closestPrompt.Parent.Name))
    print("Parent Class: " .. tostring(closestPrompt.Parent and closestPrompt.Parent.ClassName))
    print("Distance: " .. string.format("%.2f", shortestDistance))
    print("======================================")
else
    print("ما لقيت أي ProximityPrompt قريب")
end