-- سكربت Delta لسرقة العقول مع واجهة عربية + زر إخفاء + زر تليبورت أوتوماتيكي + زر نقل لقاعدتي

local player = game.Players.LocalPlayer
local brainName = "Brain"
local autoTP = false
local tpSpeed = 0.5

-- واجهة المستخدم
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "BrainrotGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 200)
frame.Position = UDim2.new(0, 10, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 2

local hideBtn = Instance.new("TextButton", frame)
hideBtn.Text = "إخفاء الواجهة"
hideBtn.Size = UDim2.new(1, -10, 0, 30)
hideBtn.Position = UDim2.new(0, 5, 0, 5)
hideBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
hideBtn.TextColor3 = Color3.new(1, 1, 1)
hideBtn.Font = Enum.Font.GothamBold
hideBtn.TextScaled = true

local tpToggle = Instance.new("TextButton", frame)
tpToggle.Text = "تشغيل التليبورت التلقائي"
tpToggle.Size = UDim2.new(1, -10, 0, 30)
tpToggle.Position = UDim2.new(0, 5, 0, 45)
tpToggle.BackgroundColor3 = Color3.fromRGB(70, 130, 70)
tpToggle.TextColor3 = Color3.new(1, 1, 1)
tpToggle.Font = Enum.Font.Gotham
tpToggle.TextScaled = true

local escapeBtn = Instance.new("TextButton", frame)
escapeBtn.Text = "نقل إلى قاعدتي"
escapeBtn.Size = UDim2.new(1, -10, 0, 30)
escapeBtn.Position = UDim2.new(0, 5, 0, 85)
escapeBtn.BackgroundColor3 = Color3.fromRGB(130, 70, 70)
escapeBtn.TextColor3 = Color3.new(1, 1, 1)
escapeBtn.Font = Enum.Font.Gotham
escapeBtn.TextScaled = true

-- وظائف الأزرار

hideBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

tpToggle.MouseButton1Click:Connect(function()
    autoTP = not autoTP
    tpToggle.Text = autoTP and "إيقاف التليبورت" or "تشغيل التليبورت التلقائي"
end)

escapeBtn.MouseButton1Click:Connect(function()
    local base = workspace:FindFirstChild(player.Name.."'s Base")
        or workspace:FindFirstChild("MyBase")
        or workspace:FindFirstChild("Base")
    if base and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local target = base:FindFirstChild("Front") or base:FindFirstChildWhichIsA("Part")
        if target then
            for i = 1, 5 do
                player.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
                wait(0.2)
            end
        end
    end
end)

task.spawn(function()
    while true do
        if autoTP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, brain in pairs(workspace:GetDescendants()) do
                if brain.Name == brainName and brain:IsA("Part") then
                    player.Character.HumanoidRootPart.CFrame = brain.CFrame + Vector3.new(0, 2, 0)
                    wait(tpSpeed)
                end
            end
        end
        wait(1)
    end
end)
