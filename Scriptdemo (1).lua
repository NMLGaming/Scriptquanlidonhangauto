-- Chờ game tải xong hoàn toàn
if not game:IsLoaded() then game.Loaded:Wait() end

local player = game.Players.LocalPlayer
local tenDon = "Trống"

-- Xóa GUI cũ nếu có
if player.PlayerGui:FindFirstChild("DonHangGui_Delta") then
    player.PlayerGui.DonHangGui_Delta:Destroy()
end

-- Khởi tạo GUI (Dùng PlayerGui để Delta dễ nhận diện)
local gui = Instance.new("ScreenGui")
gui.Name = "DonHangGui_Delta"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- 1 & 2: Khung chính (Màu xám)
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Parent = gui
frame.Size = UDim2.new(0, 280, 0, 70)
frame.Position = UDim2.new(0.5, -140, 0.05, 0) -- Hiện phía trên cùng màn hình
frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- Màu xám
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true -- Có thể di chuyển được

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- 3: Icon cài đặt (Góc trái trên)
local gearIcon = Instance.new("ImageButton")
gearIcon.Parent = frame
gearIcon.Size = UDim2.new(0, 25, 0, 25)
gearIcon.Position = UDim2.new(0, 8, 0, 8)
gearIcon.BackgroundTransparency = 1
gearIcon.Image = "rbxassetid://7072721682" -- Icon bánh răng chuẩn
gearIcon.ImageColor3 = Color3.new(1, 1, 1)

-- Text hiển thị đơn hàng
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, -50, 0.5, 0)
title.Position = UDim2.new(0, 40, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Đơn: " .. tenDon
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

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
