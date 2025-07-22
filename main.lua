-- سكربت Delta لسرقة العقول مع واجهة عربية وزر انتقال

local player = game.Players.LocalPlayer
local brainName = "Brain"

-- واجهة المستخدم
local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 150)
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

-- التليبورت التلقائي
local running = false

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
        wait(1)
    end
end)

escapeButton.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(0, 50, 0) -- نقطة آمنة داخل الخريطة
    end
end)
