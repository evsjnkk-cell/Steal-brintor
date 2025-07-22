-- سكربت: Steal Brainrot - إصدار "عزيز"
-- إعداد: بناءً على طلبك، مع واجهة عربية وزر اختراق القواعد
-- مخصص لـ Delta Executor

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- واجهة GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "AzizGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 280, 0, 300)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Visible = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "واجهة عزيز"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

-- اختصارات
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.RightShift then
		frame.Visible = not frame.Visible
	end
end)

-- أزرار
function createButton(text, yPos, callback)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, yPos)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 18
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- زر: الانتقال السريع إلى القاعدة
createButton("الانتقال لمنطقتي", 0.15, function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	local base = workspace:FindFirstChild(player.Name .. "'s Base") or workspace:FindFirstChild(player.Name .. " Base")
	if hrp and base then
		for i = 1, 5 do
			hrp.CFrame = CFrame.new(base.Position + Vector3.new(0, 5, 8))
			wait(0.05)
		end
	end
end)

-- زر: قفز لا نهائي
local infiniteJump = false
createButton("قفز لا نهائي", 0.35, function()
	infiniteJump = not infiniteJump
end)

UserInputService.JumpRequest:Connect(function()
	if infiniteJump then
		player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end
end)

-- زر: كشف اللاعبين
createButton("كشف أماكن اللاعبين", 0.55, function()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
			local billboard = Instance.new("BillboardGui", plr.Character.Head)
			billboard.Size = UDim2.new(0,100,0,20)
			billboard.AlwaysOnTop = true
			local name = Instance.new("TextLabel", billboard)
			name.Size = UDim2.new(1,0,1,0)
			name.Text = plr.Name
			name.TextColor3 = Color3.new(1,0,0)
			name.BackgroundTransparency = 1
		end
	end
end)

-- زر: NoClip (اختراق الجدران)
local noclip = false
createButton("اختراق الجدران (NoClip)", 0.75, function()
	noclip = not noclip
end)

RunService.Stepped:Connect(function()
	if noclip and player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- زر: تفعيل ثغرة "قاعدة قريبة تعتبر داخلك"
createButton("ثغرة دخول قاعدة الخصم", 0.90, function()
	local bases = {}
	for _, obj in pairs(workspace:GetChildren()) do
		if obj:IsA("Model") and obj:FindFirstChild("Main") and obj.Name:find("Base") then
			table.insert(bases, obj)
		end
	end

	table.sort(bases, function(a, b)
		return (player.Character.HumanoidRootPart.Position - a:GetModelCFrame().p).Magnitude <
		       (player.Character.HumanoidRootPart.Position - b:GetModelCFrame().p).Magnitude
	end)

	local closest = bases[1]
	if closest then
		local fakeInside = Instance.new("Part", workspace)
		fakeInside.Anchored = true
		fakeInside.Transparency = 1
		fakeInside.CanCollide = false
		fakeInside.Position = closest:GetModelCFrame().p
		player.Character.HumanoidRootPart.CFrame = fakeInside.CFrame
	end
end)
