repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
wait(3)

local tenDon = "Trống"
local tenNguoiChoi = game.Players.LocalPlayer.Name

local gui = Instance.new("ScreenGui")
gui.Name = "DonHangGui"
gui.ResetOnSpawn = false
pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 320, 0, 100) -- Mở rộng chiều ngang nhẹ
frame.Position = UDim2.new(0.5, -160, 0, -120)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = frame

-- Icon bánh răng
local gearIcon = Instance.new("ImageLabel")
gearIcon.Parent = frame
gearIcon.Size = UDim2.new(0, 20, 0, 20)
gearIcon.Position = UDim2.new(0, 5, 0, 5)
gearIcon.BackgroundTransparency = 1
gearIcon.Image = "rbxassetid://6031094678" -- Icon bánh răng
gearIcon.ImageColor3 = Color3.new(1, 1, 1)

-- Nút vô hình để xử lý click icon bánh răng
local gearClick = Instance.new("TextButton")
gearClick.Parent = frame
gearClick.Size = gearIcon.Size
gearClick.Position = gearIcon.Position
gearClick.BackgroundTransparency = 1
gearClick.Text = ""
gearClick.AutoButtonColor = false

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, -35, 0.4, 0) -- Dịch qua phải để chừa icon
title.Position = UDim2.new(0, 30, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Đơn hàng: " .. tenDon
title.TextColor3 = Color3.fromRGB(255, 223, 0)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Tên người chơi (ẩn bớt ký tự)
local soKyTuHien = 4
local daHien = string.sub(tenNguoiChoi, 1, soKyTuHien)
local biChe = string.rep("*", #tenNguoiChoi - soKyTuHien)
local tenBiChe = daHien .. biChe

local playerLabel = Instance.new("TextLabel")
playerLabel.Parent = frame
playerLabel.Size = UDim2.new(1, -10, 0.3, 0)
playerLabel.Position = UDim2.new(0, 5, 0.4, 0)
playerLabel.BackgroundTransparency = 1
playerLabel.Text = "Tên player: " .. tenBiChe
playerLabel.TextColor3 = Color3.new(1, 1, 1)
playerLabel.TextScaled = true
playerLabel.Font = Enum.Font.SourceSans
playerLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Làm đậm chữ tên player
playerLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

local textSizeConstraint = Instance.new("UITextSizeConstraint")
textSizeConstraint.MaxTextSize = 18
textSizeConstraint.Parent = playerLabel

-- Ô nhập tên đơn hàng mới
local inputBox = Instance.new("TextBox")
inputBox.Parent = frame
inputBox.Size = UDim2.new(1, -10, 0.3, 0)
inputBox.Position = UDim2.new(0, 5, 0.7, 0)
inputBox.PlaceholderText = "Nhập tên đơn hàng mới và nhấn Enter..."
inputBox.Text = ""
inputBox.ClearTextOnFocus = false
inputBox.TextScaled = true
inputBox.Font = Enum.Font.SourceSans
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.BackgroundColor3 = Color3.new(0, 0, 0)
inputBox.TextColor3 = Color3.new(1, 1, 1)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed and inputBox.Text:match("%S") then
        tenDon = inputBox.Text
        title.Text = "Đơn hàng: " .. tenDon
        inputBox.Text = ""
    end
end)

-- Tween trượt xuống
local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local goal = {Position = UDim2.new(0.5, -160, 0, 10)}
local tween = tweenService:Create(frame, tweenInfo, goal)
tween:Play()

-- MENU CÀI ĐẶT
local settingsMenu = Instance.new("Frame")
settingsMenu.Parent = gui
settingsMenu.Size = UDim2.new(0, 150, 0, 80)
settingsMenu.Position = UDim2.new(0.5, -75, 0, 115)
settingsMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
settingsMenu.Visible = false
settingsMenu.BorderSizePixel = 0
settingsMenu.BackgroundTransparency = 0.1

local settingsCorner = Instance.new("UICorner")
settingsCorner.CornerRadius = UDim.new(0, 6)
settingsCorner.Parent = settingsMenu

-- Tùy chọn 1: Bật/Tắt âm thanh
local soundToggle = Instance.new("TextButton")
soundToggle.Parent = settingsMenu
soundToggle.Size = UDim2.new(1, -10, 0, 30)
soundToggle.Position = UDim2.new(0, 5, 0, 5)
soundToggle.Text = "🔊 Âm thanh: Bật"
soundToggle.TextScaled = true
soundToggle.Font = Enum.Font.SourceSans
soundToggle.TextColor3 = Color3.new(1, 1, 1)
soundToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local isSoundOn = true
soundToggle.MouseButton1Click:Connect(function()
    isSoundOn = not isSoundOn
    soundToggle.Text = isSoundOn and "🔊 Âm thanh: Bật" or "🔇 Âm thanh: Tắt"
end)

-- Tùy chọn 2: Đổi màu nền GUI
local bgToggle = Instance.new("TextButton")
bgToggle.Parent = settingsMenu
bgToggle.Size = UDim2.new(1, -10, 0, 30)
bgToggle.Position = UDim2.new(0, 5, 0, 40)
bgToggle.Text = "🎨 Đổi màu nền"
bgToggle.TextScaled = true
bgToggle.Font = Enum.Font.SourceSans
bgToggle.TextColor3 = Color3.new(1, 1, 1)
bgToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

bgToggle.MouseButton1Click:Connect(function()
    frame.BackgroundColor3 = Color3.fromRGB(math.random(30, 255), math.random(30, 255), math.random(30, 255))
end)

-- Bật/tắt menu khi nhấn icon bánh răng
gearClick.MouseButton1Click:Connect(function()
    settingsMenu.Visible = not settingsMenu.Visible
end)