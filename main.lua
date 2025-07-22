local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "DanceGui"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0, 50, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "اختر الرقصة"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22

local dropdown = Instance.new("TextButton", frame)
dropdown.Size = UDim2.new(0, 200, 0, 30)
dropdown.Position = UDim2.new(0, 25, 0, 40)
dropdown.Text = "اختر رقصة ▼"
dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
dropdown.TextColor3 = Color3.new(1,1,1)
dropdown.Font = Enum.Font.SourceSans
dropdown.TextSize = 18

local listFrame = Instance.new("Frame", frame)
listFrame.Size = UDim2.new(0, 200, 0, 100)
listFrame.Position = UDim2.new(0, 25, 0, 70)
listFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
listFrame.Visible = false
listFrame.ClipsDescendants = true

local danceAnimations = {
    ["رقص 1"] = "rbxassetid://507771019", -- مثال انيمشن رقص
    ["رقص 2"] = "rbxassetid://507777826",
    ["رقص 3"] = "rbxassetid://507780686",
    ["رقص ترند تيك توك 1"] = "rbxassetid://12345678", -- استبدلها برابط الانميشن الحقيقي
    ["رقص ترند تيك توك 2"] = "rbxassetid://87654321",
}

local selectedDance = nil

-- إنشاء قائمة الاختيارات
local yPos = 0
for name, animId in pairs(danceAnimations) do
    local option = Instance.new("TextButton", listFrame)
    option.Size = UDim2.new(1, 0, 0, 25)
    option.Position = UDim2.new(0, 0, 0, yPos)
    option.Text = name
    option.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    option.TextColor3 = Color3.new(1,1,1)
    option.Font = Enum.Font.SourceSans
    option.TextSize = 16
    option.MouseButton1Click:Connect(function()
        selectedDance = animId
        dropdown.Text = name .. " ▼"
        listFrame.Visible = false
    end)
    yPos = yPos + 30
end

dropdown.MouseButton1Click:Connect(function()
    listFrame.Visible = not listFrame.Visible
end)

local playBtn = Instance.new("TextButton", frame)
playBtn.Size = UDim2.new(0, 100, 0, 30)
playBtn.Position = UDim2.new(0, 75, 0, 175)
playBtn.Text = "شغل الرقصة"
playBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
playBtn.TextColor3 = Color3.new(1,1,1)
playBtn.Font = Enum.Font.SourceSans
playBtn.TextSize = 18

local function playAnimation(animId)
    if not animId then return end
    local anim = Instance.new("Animation")
    anim.AnimationId = animId
    local animTrack = humanoid:LoadAnimation(anim)
    animTrack:Play()
end

playBtn.MouseButton1Click:Connect(function()
    if selectedDance then
        playAnimation(selectedDance)
    end
end)
