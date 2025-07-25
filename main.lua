--[[
  سكربت MM2 لأداة Delta
  واجهة سوداء - نص أبيض
  يحتوي على:
  - ESP
  - Aimbot
  - Teleport
  - NoClip
  - زر للسلاح الشرف
  - زر إعادة للماپ لو مت
  - زر مربع لإخفاء/إظهار الواجهة
  - زر نسخ الشخصية (Clone Character)
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

local UIS = UserInputService
local Camera = workspace.CurrentCamera

local guiVisible = true

-- واجهة GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Aziz_MM2_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui -- أو PlayerGui حسب الاداة

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 450)
mainFrame.Position = UDim2.new(0, 10, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Aziz MM2 Script"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.TextColor3 = Color3.new(1,1,1)
title.Parent = mainFrame

local function CreateButton(name, text, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 280, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 20
    btn.Text = text
    btn.Parent = mainFrame
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ESP
local ESPEnabled = false
local ESPBoxes = {}

local function CreateESP(player)
    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    box.Size = Vector3.new(4,6,1)
    box.Transparency = 0.5
    box.ZIndex = 10
    box.AlwaysOnTop = true
    box.Color3 = Color3.fromRGB(255, 0, 0)
    box.Parent = workspace
    return box
end

local function ToggleESP()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                if not ESPBoxes[p.Name] then
                    ESPBoxes[p.Name] = CreateESP(p)
                end
            end
        end
    else
        for _, box in pairs(ESPBoxes) do
            box:Destroy()
        end
        ESPBoxes = {}
    end
end

RunService.RenderStepped:Connect(function()
    if ESPEnabled then
        for pName, box in pairs(ESPBoxes) do
            local p = Players:FindFirstChild(pName)
            if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                box.Adornee = p.Character.HumanoidRootPart
                box.Visible = true
            else
                box.Visible = false
            end
        end
    end
end)

-- Aimbot
local AimbotEnabled = false
local AimbotFOV = 100

local function GetClosestEnemy()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local screenPos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).magnitude
                if dist < shortestDistance and dist < AimbotFOV then
                    shortestDistance = dist
                    closestPlayer = p
                end
            end
        end
    end
    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    if AimbotEnabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        local target = GetClosestEnemy()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local pos = target.Character.Head.Position
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, pos)
        end
    end
end)

-- Teleport
local function TeleportToPosition(pos)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
    end
end

local btnTeleport = CreateButton("TeleportButton", "Teleport to Mouse", UDim2.new(0, 10, 0, 100), function()
    if Mouse.Target then
        TeleportToPosition(Mouse.Hit.p)
    end
end)

-- NoClip
local NoClipEnabled = false

local function NoClipToggle()
    NoClipEnabled = not NoClipEnabled
end

RunService.Stepped:Connect(function()
    if NoClipEnabled then
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    else
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

local btnNoClip = CreateButton("NoClipButton", "Toggle NoClip", UDim2.new(0, 10, 0, 150), function()
    NoClipToggle()
end)

local btnESP = CreateButton("ESPButton", "Toggle ESP", UDim2.new(0, 10, 0, 200), function()
    ToggleESP()
end)

local btnAimbot = CreateButton("AimbotButton", "Toggle Aimbot", UDim2.new(0, 10, 0, 250), function()
    AimbotEnabled = not AimbotEnabled
end)

local btnLastKnife = CreateButton("LastKnifeButton", "Equip Last Knife", UDim2.new(0, 10, 0, 300), function()
    local backpack = LocalPlayer.Backpack
    local lastKnife
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            lastKnife = item
        end
    end
    if lastKnife then
        lastKnife.Parent = LocalPlayer.Character
    end
end)

local btnRespawn = CreateButton("RespawnButton", "Respawn / Return to Map", UDim2.new(0, 10, 0, 350), function()
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end
    end
end)

-- زر نسخ الشخصية (Clone Character)
local function CloneCharacter()
    if LocalPlayer.Character then
        local clone = LocalPlayer.Character:Clone()
        clone.Name = LocalPlayer.Name .. "_Clone_" .. tostring(math.random(1000,9999))
        clone.Parent = workspace
        clone:SetPrimaryPartCFrame(LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(5,0,0))
    end
end

local btnClone = CreateButton("CloneButton", "Clone Character", UDim2.new(0, 10, 0, 400), function()
    CloneCharacter()
end)

-- زر إخفاء / إظهار الواجهة
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 320, 0, 50)
toggleButton.BackgroundColor3 = Color3.new(0,0,0)
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Text = "☰"
toggleButton.Parent = ScreenGui
toggleButton.ZIndex = 20

toggleButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    mainFrame.Visible = guiVisible
end)

return ScreenGui
