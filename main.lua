-- سكربت Delta مع واجهة عربية وزر سرعة التليبورت وزر زيادة سرعة اللاعب

local player = game.Players.LocalPlayer
local brainName = "Brain"

local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 220, 0, 250)
Frame.Position = UDim2.new(0, 10, 0, 100)
Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Frame.BorderSizePixel = 2

local UICorner = Instance.new("UICorner", Frame)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "سرقة العقول 🧠"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

local tpButton = Instance.new("TextButton", Frame)
tpButton.Text = "تشغيل التليبورت التلقائي"
tpButton.Size = UDim2.new(1, -10, 0, 40)
tpButton.Position = UDim2.new(0, 5, 0, 40)
tpButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
tpButton.TextColor3 = Color3.new(1, 1, 1)
tpButton.Font = Enum.Font.Gotham
tpButton.TextScaled = true

local escapeButton = Instance.new("TextButton", Frame)
escapeButton.Text = "خروج من منطقة العدو"
escapeButton.Size = UDim2.new(1, -10, 0, 40)
escapeButton.Position = UDim2.new(0, 5, 0, 90)
escapeButton.BackgroundColor3 = Color3.new(0.3, 0.1, 0.1)
escapeButton.TextColor3 = Color3.new(1, 1, 1)
escapeButton.Font = Enum.Font.Gotham
escapeButton.TextScaled = true

local speedButton = Instance.new("TextButton", Frame)
speedButton.Text = "سرعة التليبورت: 1 ثانية"
speedButton.Size = UDim2.new(1, -10, 0, 30)
speedButton.Position = UDim2.new(0, 5, 0, 140)
speedButton.BackgroundColor3 = Color3.new(0.2, 0.4, 0.2)
speedButton.TextColor3 = Color3.new(1, 1, 1)
speedButton.Font = Enum.Font.Gotham
speedButton.TextScaled = true

local walkSpeedButton = Instance.new("TextButton", Frame)
walkSpeedButton.Text = "سرعة اللاعب: 16"
walkSpeedButton.Size = UDim2.new(1, -10, 0, 30)
walkSpeedButton.Position = UDim2.new(0, 5, 0, 180)
walkSpeedButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.5)
walkSpeedButton.TextColor3 = Color3.new(1, 1, 1)
walkSpeedButton.Font = Enum.Font.Gotham
walkSpeedButton.TextScaled = true

local running = false
local tpSpeed = 1 -- سرعة التليبورت

function tpToBrains()
    for _, brain in pairs(workspace:GetDescendants()) do
        if brain.Name == brainName and brain:IsA("Part") then
            player.Character.HumanoidRootPart.CFrame = brain.CFrame
            wait(0.5)
        end
    end
end

tpButton.MouseButton1Click:Connect(function()
    running = not running
    tpButton.Text = running and "إيقاف التليبورت" or "تشغيل التليبورت التلقائي"
    while running do
        tpToBrains()
        wait(tpSpeed)
    end
end)

escapeButton.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local startPos = hrp.Position
        local steps = 5
        local stepSize = 20

        for i = 1, steps do
            local newPos = startPos + Vector3.new(i * stepSize, 0, i * stepSize)
            hrp.CFrame = CFrame.new(newPos)
            wait(0.3)
        end
    end
end)

speedButton.MouseButton1Click:Connect(function()
    tpSpeed = tpSpeed - 0.3
    if tpSpeed < 0.1 then
        tpSpeed = 2
    end
    speedButton.Text = ("سرعة التليبورت: %.1f ثانية"):format(tpSpeed)
end)

walkSpeedButton.MouseButton1Click:Connect(function()
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        -- زيادة سرعة اللاعب تدريجياً: 16 (الافتراضي) → 32 → 48 → 64 → 80 ثم يرجع 16
        local speeds = {16, 32, 48, 64, 80}
        local currentSpeed = humanoid.WalkSpeed
        local nextSpeed = 16
        for i, speed in ipairs(speeds) do
            if currentSpeed < speed then
                nextSpeed = speed
                break
            end
        end
        humanoid.WalkSpeed = nextSpeed
        walkSpeedButton.Text = "سرعة اللاعب: " .. tostring(nextSpeed)
    end
end)
