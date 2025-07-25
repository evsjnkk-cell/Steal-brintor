-- سكربت Steal Brainrot GUI - باسم "عزيز"
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- إنشاء الواجهة
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "AzizGUI"

local main = Instance.new("Frame", ScreenGui)
main.Size = UDim2.new(0, 250, 0, 300)
main.Position = UDim2.new(0.05, 0, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Visible = true
main.Active = true
main.Draggable = true

-- زر إخفاء/إظهار الواجهة
UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.M then
		main.Visible = not main.Visible
	end
end)

local function createButton(text, yPos, callback)
	local btn = Instance.new("TextButton", main)
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.Position = UDim2.new(0, 25, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(math.random(100,255), math.random(100,255), math.random(100,255))
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Text = text
	btn.Font = Enum.Font.SourceSansBold
	btn.TextScaled = true
	btn.MouseButton1Click:Connect(callback)
end

-- زر النقل السريع خارج منطقة العدو
createButton("🚀 النقل السريع", 10, function()
	for i = 1, 1000 do
		task.spawn(function()
			pcall(function()
				player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(0, 100, 0)) -- غير الموقع حسب منطقتك
			end)
			task.wait()
		end)
	end
end)

-- زر زيادة سرعة اللاعب
createButton("⚡ زيادة السرعة", 60, function()
	pcall(function()
		player.Character.Humanoid.WalkSpeed = 100
	end)
end)

-- زر قفز لا نهائي
createButton("🌀 قفز لا نهائي", 110, function()
	local Jump = game:GetService("UserInputService")
	Jump.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space then
			if player.Character then
				player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
			end
		end
	end)
end)

-- زر ESP (كشف اللاعبين)
createButton("🔍 كشف اللاعبين ESP", 160, function()
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
			local Billboard = Instance.new("BillboardGui", plr.Character.Head)
			Billboard.Size = UDim2.new(0, 100, 0, 40)
			Billboard.Adornee = plr.Character.Head
			Billboard.AlwaysOnTop = true
			local label = Instance.new("TextLabel", Billboard)
			label.Size = UDim2.new(1, 0, 1, 0)
			label.Text = plr.Name
			label.TextColor3 = Color3.fromRGB(255, 50, 50)
			label.BackgroundTransparency = 1
			label.TextScaled = true
		end
	end
end)
