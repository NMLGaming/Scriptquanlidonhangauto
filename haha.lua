--[[ 
    SCRIPT QUẢN LÝ ĐƠN HÀNG - BY LONGG MC
    TÍNH NĂNG: ANTI-BAN, FIX LAG VPS, MASK NAME 60%, AUTO-FILL UI
]]

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
wait(3)

local player = game.Players.LocalPlayer
local tenDon = "Trống"
local tenNguoiChoi = player.Name

-- 1. LOGIC HIỂN THỊ 40% TÊN (CHE 60%)
local doDaiTen = #tenNguoiChoi
local soKyTuHien = math.ceil(doDaiTen * 0.4) 
local tenBiChe = string.sub(tenNguoiChoi, 1, soKyTuHien) .. string.rep("*", doDaiTen - soKyTuHien)

-- 2. HỆ THỐNG BẢO MẬT ANTI-BAN & ANTI-CHEAT (UNC 100%)
local function SecureBypass()
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        -- Chặn các lệnh Kick từ Server để chống Ban/Kick bất ngờ
        if method == "Kick" or method == "kick" then
            warn("Phát hiện nỗ lực Kick nhưng đã được Longg MC chặn!")
            return nil
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
end
pcall(SecureBypass)

-- 3. KHỞI TẠO GIAO DIỆN (ẨN DANH)
local gui = Instance.new("ScreenGui")
gui.Name = "LonggMC_SecureUI_" .. math.random(100, 999)
gui.ResetOnSpawn = false
pcall(function()
    gui.Parent = (gethui and gethui()) or game:GetService("CoreGui") or player:WaitForChild("PlayerGui")
end)

-- KHUNG CHÍNH
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 115)
frame.Position = UDim2.new(0.5, -160, 0, -150) -- Vị trí ẩn để chạy Tween
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BackgroundTransparency = 0.1
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

-- VIỀN ĐEN TRANG TRÍ
local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1.2
stroke.Transparency = 0.8

-- ICON BÁNH RĂNG & NÚT CÀI ĐẶT
local gearIcon = Instance.new("ImageLabel", frame)
gearIcon.Size = UDim2.new(0, 22, 0, 22)
gearIcon.Position = UDim2.new(0, 8, 0, 8)
gearIcon.BackgroundTransparency = 1
gearIcon.Image = "rbxassetid://6031094678"
gearIcon.ImageColor3 = Color3.new(1, 1, 1)

local gearClick = Instance.new("TextButton", gearIcon)
gearClick.Size = UDim2.new(1.5, 0, 1.5, 0)
gearClick.Position = UDim2.new(-0.25, 0, -0.25, 0)
gearClick.BackgroundTransparency = 1
gearClick.Text = ""

-- TEXT ĐƠN HÀNG
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -45, 0.35, 0)
title.Position = UDim2.new(0, 38, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Đơn hàng: " .. tenDon
title.TextColor3 = Color3.fromRGB(255, 223, 0)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- TEXT TÊN PLAYER (40%)
local playerLabel = Instance.new("TextLabel", frame)
playerLabel.Size = UDim2.new(1, -20, 0.25, 0)
playerLabel.Position = UDim2.new(0, 12, 0.38, 0)
playerLabel.BackgroundTransparency = 1
playerLabel.Text = "Tên: " .. tenBiChe
playerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
playerLabel.TextScaled = true
playerLabel.Font = Enum.Font.SourceSansBold
playerLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Ô NHẬP ĐƠN HÀNG
local inputBox = Instance.new("TextBox", frame)
inputBox.Size = UDim2.new(1, -24, 0.22, 0)
inputBox.Position = UDim2.new(0, 12, 0.65, 0)
inputBox.PlaceholderText = "Nhập mã đơn tại đây..."
inputBox.Text = ""
inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.TextScaled = true
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 4)
Instance.new("UIStroke", inputBox).Color = Color3.fromRGB(255, 255, 255)

-- LOGO LONGG MC
local authorTag = Instance.new("TextLabel", frame)
authorTag.Size = UDim2.new(0, 100, 0, 20)
authorTag.Position = UDim2.new(1, -105, 1, -22)
authorTag.BackgroundTransparency = 1
authorTag.Text = "by Longg MC"
authorTag.TextColor3 = Color3.fromRGB(255, 255, 255)
authorTag.TextTransparency = 0.5
authorTag.Font = Enum.Font.Code
authorTag.TextSize = 12
authorTag.TextXAlignment = Enum.TextXAlignment.Right

-- 4. MENU CÀI ĐẶT (FIX LAG)
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0, 200, 0, 0)
menu.Position = UDim2.new(0.5, -100, 0.25, 0)
menu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
menu.ClipsDescendants = true
menu.Visible = false
Instance.new("UICorner", menu)
Instance.new("UIStroke", menu).Color = Color3.fromRGB(0, 255, 0)

local btnFixLag = Instance.new("TextButton", menu)
btnFixLag.Size = UDim2.new(0.9, 0, 0, 40)
btnFixLag.Position = UDim2.new(0.05, 0, 0.3, 0)
btnFixLag.Text = "TỐI ƯU VPS (FIX LAG)"
btnFixLag.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
btnFixLag.TextColor3 = Color3.new(1, 1, 1)
btnFixLag.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", btnFixLag)

-- 5. XỬ LÝ LOGIC SỰ KIỆN
-- Nhập đơn hàng
inputBox.FocusLost:Connect(function(enter)
    if enter and inputBox.Text ~= "" then
        tenDon = inputBox.Text
        title.Text = "Đơn hàng: " .. tenDon
        inputBox.Text = ""
    end
end)

-- Bật tắt Menu
local menuOpen = false
gearClick.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    if menuOpen then
        menu.Visible = true
        game:GetService("TweenService"):Create(menu, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 200, 0, 80)}):Play()
        game:GetService("TweenService"):Create(gearIcon, TweenInfo.new(0.4), {Rotation = 90}):Play()
    else
        game:GetService("TweenService"):Create(gearIcon, TweenInfo.new(0.4), {Rotation = 0}):Play()
        local tw = game:GetService("TweenService"):Create(menu, TweenInfo.new(0.3), {Size = UDim2.new(0, 200, 0, 0)})
        tw:Play()
        tw.Completed:Connect(function() if not menuOpen then menu.Visible = false end end)
    end
end)

-- Chạy tính năng Fix Lag
btnFixLag.MouseButton1Click:Connect(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("PostProcessEffect") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
    btnFixLag.Text = "ĐÃ TỐI ƯU!"
    btnFixLag.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)

-- Hiệu ứng trượt UI khi bắt đầu
game:GetService("TweenService"):Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quart), {Position = UDim2.new(0.5, -160, 0, 15)}):Play()

print("Full Script by Longg MC has been Loaded!")
