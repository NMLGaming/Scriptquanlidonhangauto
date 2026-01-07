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

-- 4: Menu Cài đặt (Animation ẩn/hiện)
local menu = Instance.new("Frame")
menu.Parent = gui
menu.Size = UDim2.new(0, 200, 0, 0) -- Bắt đầu bằng 0 để chạy animation
menu.Position = UDim2.new(0.5, -100, 0.3, 0)
menu.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
menu.BorderSizePixel = 0
menu.ClipsDescendants = true
menu.Visible = false

local menuCorner = Instance.new("UICorner")
menuCorner.Parent = menu

local layout = Instance.new("UIListLayout")
layout.Parent = menu
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- 5: Phần 1 - Nhập đơn hàng
local btnNhap = Instance.new("TextButton")
btnNhap.Parent = menu
btnNhap.Size = UDim2.new(0.9, 0, 0, 35)
btnNhap.Text = "Nhập tên đơn hàng"
btnNhap.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
btnNhap.TextColor3 = Color3.new(1, 1, 1)
btnNhap.Font = Enum.Font.SourceSansBold

local boxNhap = Instance.new("TextBox")
boxNhap.Parent = menu
boxNhap.Size = UDim2.new(0.9, 0, 0, 30)
boxNhap.PlaceholderText = "Gõ tên vào đây..."
boxNhap.Visible = false
boxNhap.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
boxNhap.TextColor3 = Color3.new(1, 1, 1)

btnNhap.MouseButton1Click:Connect(function()
    boxNhap.Visible = not boxNhap.Visible
end)

boxNhap.FocusLost:Connect(function(enter)
    if enter then
        tenDon = boxNhap.Text
        title.Text = "Đơn: " .. tenDon
    end
end)

-- 5: Phần 2 - Fix Lag 60%
local btnFixLag = Instance.new("TextButton")
btnFixLag.Parent = menu
btnFixLag.Size = UDim2.new(0.9, 0, 0, 35)
btnFixLag.Text = "Fix Lag (60% Graphics)"
btnFixLag.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
btnFixLag.TextColor3 = Color3.new(1, 1, 1)
btnFixLag.Font = Enum.Font.SourceSansBold

btnFixLag.MouseButton1Click:Connect(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("PostProcessEffect") or v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
    btnFixLag.Text = "Đã Fix Lag!"
end)

-- Animation cho Menu
local ts = game:GetService("TweenService")
gearIcon.MouseButton1Click:Connect(function()
    if not menu.Visible then
        menu.Visible = true
        ts:Create(gearIcon, TweenInfo.new(0.3), {Rotation = 90}):Play()
        ts:Create(menu, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 200, 0, 130)}):Play()
    else
        ts:Create(gearIcon, TweenInfo.new(0.3), {Rotation = 0}):Play()
        local tw = ts:Create(menu, TweenInfo.new(0.3), {Size = UDim2.new(0, 200, 0, 0)})
        tw:Play()
        tw.Completed:Connect(function() menu.Visible = false end)
    end
end)

-- 6: Anti-Ban/Anti-Cheat siêu mạnh cho Delta
local function SecureAntiBan()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then 
            return nil 
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end
pcall(SecureAntiBan)

print("Script đã chạy thành công!")