local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local guiVisible = true
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "Aziz_MM2_GUI"

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 600)
mainFrame.Position = UDim2.new(0, 100, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

-- العنوان
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Aziz MM2 Script"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.TextColor3 = Color3.new(1,1,1)

-- دالة زر
local function CreateButton(text, posY, callback)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0, 280, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 20
	btn.Text = text
	btn.BorderSizePixel = 0
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- ESP
local ESPEnabled = false
local ESPBoxes = {}
local function ToggleESP()
	ESPEnabled = not ESPEnabled
	if not ESPEnabled then
		for _, b in pairs(ESPBoxes) do b:Destroy() end
		ESPBoxes = {}
	end
end

RunService.RenderStepped:Connect(function()
	if ESPEnabled then
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				if not ESPBoxes[p.Name] then
					local box = Instance.new("BoxHandleAdornment")
					box.Adornee = p.Character.HumanoidRootPart
					box.Size = Vector3.new(4,6,1)
					box.Transparency = 0.5
					box.AlwaysOnTop = true
					box.Color3 = Color3.fromRGB(255, 0, 0)
					box.ZIndex = 10
					box.Parent = workspace
					ESPBoxes[p.Name] = box
				end
			end
		end
	end
end)

-- Aimbot
local AimbotEnabled = false
local function GetClosest()
	local closest, dist = nil, math.huge
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
			if onScreen then
				local d = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).magnitude
				if d < dist and d < 150 then
					dist = d
					closest = p
				end
			end
		end
	end
	return closest
end

RunService.RenderStepped:Connect(function()
	if AimbotEnabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
		local t = GetClosest()
		if t and t.Character:FindFirstChild("Head") then
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Character.Head.Position)
		end
	end
end)

-- Teleport
local function TeleportToMouse()
	if Mouse.Target and LocalPlayer.Character then
		LocalPlayer.Character:MoveTo(Mouse.Hit.p + Vector3.new(0,3,0))
	end
end

-- NoClip
local NoClip = false
RunService.Stepped:Connect(function()
	if NoClip and LocalPlayer.Character then
		for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- Clone الشخصية
local function CloneCharacter()
	if LocalPlayer.Character then
		local clone = LocalPlayer.Character:Clone()
		clone.Parent = workspace
		clone:SetPrimaryPartCFrame(LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(5, 0, 0))
	end
end

-- Respawn
local function Respawn()
	local char = LocalPlayer.Character
	if char and char:FindFirstChildOfClass("Humanoid") then
		char:FindFirstChildOfClass("Humanoid").Health = 0
	end
end

-- Near-Fly
local NearFlyEnabled = false
RunService.Heartbeat:Connect(function()
	if NearFlyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local root = LocalPlayer.Character.HumanoidRootPart
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				if (p.Character.HumanoidRootPart.Position - root.Position).Magnitude < 5 then
					root.CFrame = root.CFrame + Vector3.new(0, 50, 0)
				end
			end
		end
	end
end)

-- Fake Dummy
local function CreateFakeDummy()
	if LocalPlayer.Character then
		local dummy = LocalPlayer.Character:Clone()
		dummy.Name = "Fake_"..LocalPlayer.Name
		for _, v in ipairs(dummy:GetDescendants()) do
			if v:IsA("Script") or v:IsA("LocalScript") then
				v:Destroy()
			end
		end
		dummy.Parent = workspace
		dummy:SetPrimaryPartCFrame(LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(3, 0, 0))
	end
end

-- حذف جزء من جسم لاعب
local deleteMode = false
Mouse.Button1Down:Connect(function()
	if deleteMode then
		local t = Mouse.Target
		if t and t:IsA("BasePart") then
			t:Destroy()
			deleteMode = false
			title.Text = "Aziz MM2 Script"
		end
	end
end)

-- الأزرار
CreateButton("Toggle ESP", 50, function() ToggleESP() end)
CreateButton("Toggle Aimbot", 100, function() AimbotEnabled = not AimbotEnabled end)
CreateButton("Teleport to Mouse", 150, TeleportToMouse)
CreateButton("Toggle NoClip", 200, function() NoClip = not NoClip end)
CreateButton("Equip Last Knife", 250, function()
	for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			tool.Parent = LocalPlayer.Character
		end
	end
end)
CreateButton("Respawn", 300, Respawn)
CreateButton("Clone Character", 350, CloneCharacter)
CreateButton("Toggle Near-Fly", 400, function() NearFlyEnabled = not NearFlyEnabled end)
CreateButton("Create Fake Dummy", 450, CreateFakeDummy)
CreateButton("Enable Delete-Click", 500, function()
	deleteMode = not deleteMode
	if deleteMode then
		title.Text = "🔴 اضغط على أي جزء لحذفه"
	else
		title.Text = "Aziz MM2 Script"
	end
end)

-- زر الإخفاء
local toggleBtn = Instance.new("TextButton", ScreenGui)
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.new(0,0,0)
toggleBtn.Text = "☰"
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 25
toggleBtn.ZIndex = 100
toggleBtn.Active = true
toggleBtn.Draggable = true

toggleBtn.MouseButton1Click:Connect(function()
	guiVisible = not guiVisible
	mainFrame.Visible = guiVisible
end)
