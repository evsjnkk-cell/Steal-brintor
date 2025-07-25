-- سكربت مخصص لـ Steal Brainrot على Delta Executor
-- يشمل: نقل سريع لمنطقتك، قفز لا نهائي، ESP، واجهة عربية باسم "عزيز"

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- الواجهة
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "عزيز"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 300)
MainFrame.Visible = true

local UICorner = Instance.new("UICorner", MainFrame)

-- زر المربع الصغير
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.Text = ""
ToggleButton.Draggable = true
ToggleButton.Active = true

-- اخفاء واظهار الواجهة
ToggleButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- دالة تنقل سريع لمنطقة القاعدة
local function teleportToSafeZone()
	local myBase = workspace:FindFirstChild(player.Name .. "'s Base")
	if myBase then
		local safeZone = myBase:FindFirstChild("DropZone")
		if safeZone then
			for _ = 1, 1000 do
				character:WaitForChild("HumanoidRootPart").CFrame = safeZone.CFrame + Vector3.new(0, 3, 0)
				wait(0.001)
			end
		end
	end
end

-- قفز لا نهائي
game:GetService("UserInputService").JumpRequest:Connect(function()
	if _G.infiniteJumpEnabled then
		character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end
end)

-- ESP كشف اللاعبين
local function enableESP()
	for _, p in pairs(game.Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
			local Billboard = Instance.new("BillboardGui", p.Character.Head)
			Billboard.Size = UDim2.new(0, 100, 0, 40)
			Billboard.AlwaysOnTop = true

			local Text = Instance.new("TextLabel", Billboard)
			Text.Text = p.Name
			Text.TextColor3 = Color3.new(1, 0, 0)
			Text.BackgroundTransparency = 1
			Text.Size = UDim2.new(1, 0, 1, 0)
		end
	end
end

-- إنشاء الأزرار داخل الواجهة
local function createButton(text, posY, callback)
	local button = Instance.new("TextButton", MainFrame)
	button.Size = UDim2.new(0, 280, 0, 40)
	button.Position = UDim2.new(0, 10, 0, posY)
	button.BackgroundColor3 = Color3.fromRGB(math.random(100,255), math.random(100,255), math.random(100,255))
	button.Text = text
	button.TextColor3 = Color3.new(1,1,1)
	button.Font = Enum.Font.GothamBold
	button.TextScaled = true
	button.MouseButton1Click:Connect(callback)
end

-- الأزرار
createButton("🔁 انتقال سريع لمنطقتي", 10, teleportToSafeZone)
createButton("🚀 تفعيل قفز لا نهائي", 60, function() _G.infiniteJumpEnabled = true end)
createButton("🔎 كشف اللاعبين", 110, enableESP)
createButton("❌ إغلاق الواجهة", 160, function() MainFrame.Visible = false end)

-- تعيين اسم الواجهة
ScreenGui.DisplayOrder = 1000
