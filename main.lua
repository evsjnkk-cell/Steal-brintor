local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- واجهة
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "AzizGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 220)
frame.Position = UDim2.new(0, 10, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 2

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "عزيز"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.TextScaled = true

local hideBtn = Instance.new("TextButton", frame)
hideBtn.Text = "إخفاء / إظهار"
hideBtn.Size = UDim2.new(1, -10, 0, 30)
hideBtn.Position = UDim2.new(0, 5, 0, 45)
hideBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hideBtn.TextColor3 = Color3.new(1, 1, 1)
hideBtn.Font = Enum.Font.Gotham
hideBtn.TextScaled = true

local tpBtn = Instance.new("TextButton", frame)
tpBtn.Text = "الهروب السريع"
tpBtn.Size = UDim2.new(1, -10, 0, 30)
tpBtn.Position = UDim2.new(0, 5, 0, 85)
tpBtn.BackgroundColor3 = Color3.fromRGB(70, 120, 70)
tpBtn.TextColor3 = Color3.new(1, 1, 1)
tpBtn.Font = Enum.Font.Gotham
tpBtn.TextScaled = true

local jumpBtn = Instance.new("TextButton", frame)
jumpBtn.Text = "قفز لا نهائي"
jumpBtn.Size = UDim2.new(1, -10, 0, 30)
jumpBtn.Position = UDim2.new(0, 5, 0, 125)
jumpBtn.BackgroundColor3 = Color3.fromRGB(90, 90, 120)
jumpBtn.TextColor3 = Color3.new(1, 1, 1)
jumpBtn.Font = Enum.Font.Gotham
jumpBtn.TextScaled = true

local espBtn = Instance.new("TextButton", frame)
espBtn.Text = "كشف اللاعبين"
espBtn.Size = UDim2.new(1, -10, 0, 30)
espBtn.Position = UDim2.new(0, 5, 0, 165)
espBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 80)
espBtn.TextColor3 = Color3.new(1, 1, 1)
espBtn.Font = Enum.Font.Gotham
espBtn.TextScaled = true

-- زر الإخفاء/الإظهار
local visible = true
hideBtn.MouseButton1Click:Connect(function()
    visible = not visible
    frame.Visible = visible
end)

-- زر النقل السريع
tpBtn.MouseButton1Click:Connect(function()
    local base = workspace:FindFirstChild(player.Name.."'s Base") or workspace:FindFirstChild("MyBase")
    if base then
        local front = base:FindFirstChild("Front") or base:FindFirstChildWhichIsA("Part")
        if front then
            for i = 1, 5 do
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = front.CFrame + Vector3.new(0, 5, 0)
                    wait(0.2)
                end
            end
        end
    end
end)

-- قفز لا نهائي
jumpBtn.MouseButton1Click:Connect(function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:ChangeState("Jumping")
        end
    end)
end)

-- كشف اللاعبين (ESP)
espBtn.MouseButton1Click:Connect(function()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
            local bill = Instance.new("BillboardGui", plr.Character.Head)
            bill.Size = UDim2.new(0, 100, 0, 40)
            bill.AlwaysOnTop = true
            local txt = Instance.new("TextLabel", bill)
            txt.Text = plr.Name
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.TextColor3 = Color3.new(1, 0, 0)
            txt.Font = Enum.Font.GothamBold
            txt.TextScaled = true
        end
    end
end)
