-- واجهة GUI باسم "عزيز"
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 250)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Active = true
Frame.Draggable = true

local title = Instance.new("TextLabel", Frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "واجهة عزيز - Da Hood"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

-- زر الطيران
local flyBtn = Instance.new("TextButton", Frame)
flyBtn.Position = UDim2.new(0, 10, 0, 40)
flyBtn.Size = UDim2.new(0, 230, 0, 30)
flyBtn.Text = "تشغيل الطيران السريع"
flyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
flyBtn.TextColor3 = Color3.new(1, 1, 1)

-- زر القفز
local jumpBtn = Instance.new("TextButton", Frame)
jumpBtn.Position = UDim2.new(0, 10, 0, 80)
jumpBtn.Size = UDim2.new(0, 230, 0, 30)
jumpBtn.Text = "قفز لا نهائي"
jumpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
jumpBtn.TextColor3 = Color3.new(1, 1, 1)

-- زر تيلبورت للبنك
local bankTpBtn = Instance.new("TextButton", Frame)
bankTpBtn.Position = UDim2.new(0, 10, 0, 120)
bankTpBtn.Size = UDim2.new(0, 230, 0, 30)
bankTpBtn.Text = "تيلبورت إلى البنك"
bankTpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
bankTpBtn.TextColor3 = Color3.new(1, 1, 1)

-- زر تيلبورت للأسلحة
local gunTpBtn = Instance.new("TextButton", Frame)
gunTpBtn.Position = UDim2.new(0, 10, 0, 160)
gunTpBtn.Size = UDim2.new(0, 230, 0, 30)
gunTpBtn.Text = "تيلبورت إلى المتجر"
gunTpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
gunTpBtn.TextColor3 = Color3.new(1, 1, 1)

-- زر إخفاء الواجهة
local toggleBtn = Instance.new("TextButton", Frame)
toggleBtn.Position = UDim2.new(0, 10, 0, 200)
toggleBtn.Size = UDim2.new(0, 230, 0, 30)
toggleBtn.Text = "إخفاء / إظهار الواجهة"
toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)

-- الطيران السريع
flyBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://pastebin.com/raw/Y5tC2TDb"))() -- سكربت طيران سريع
end)

-- قفز لا نهائي
jumpBtn.MouseButton1Click:Connect(function()
    local plr = game.Players.LocalPlayer
    game:GetService("UserInputService").JumpRequest:Connect(function()
        plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

-- تيلبورت للبنك
bankTpBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-452, 22, -283) -- إحداثيات البنك
end)

-- تيلبورت للسلاح
gunTpBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-265, 22, -100) -- إحداثيات متجر السلاح
end)

-- إخفاء / إظهار
toggleBtn.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)
