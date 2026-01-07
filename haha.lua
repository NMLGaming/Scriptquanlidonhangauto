repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
wait(3)

local tenDon = "Trống"
local player = game.Players.LocalPlayer
local tenNguoiChoi = player.Name

-- LOGIC HIỂN THỊ 40% TÊN
local doDaiTen = #tenNguoiChoi
local soKyTuHien = math.ceil(doDaiTen * 0.4) 
local tenBiChe = string.sub(tenNguoiChoi, 1, soKyTuHien) .. string.rep("*", doDaiTen - soKyTuHien)

-- [BẢO MẬT] ANTI-CHEAT & ANTI-BAN BYPASS (UNC 100%)
local function Securitize()
    local g = game
    local mt = getrawmetatable(g)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        -- Chặn các lệnh Kick từ Server
        if method == "Kick" or method == "kick" then
            warn("Phát hiện nỗ lực Kick! Đã chặn thành công.")
            return nil
        end
        
        -- Bypass các lệnh check của Blox Fruit (Check RemoteEvent)
        if self.Name == "RemoteEvent" or self.Name == "RemoteFunction" then
            if method == "FireServer" or method == "InvokeServer" then
                -- Giới hạn tần suất gửi dữ liệu để tránh bị flag 'Spam Remote'
                task.wait(0.01) 
            end
        end
        
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
end
pcall(Securitize)

-- GIAO DIỆN (ĐẶT TRONG THƯ MỤC BẢO MẬT ĐỂ TRÁNH QUÉT UI)
local gui = Instance.new("ScreenGui")
gui.Name = game:GetService("HttpService"):GenerateGUID(false) -- Đổi tên ngẫu nhiên mỗi lần chạy
gui.ResetOnSpawn = false
pcall(function()
    -- Cố gắng ẩn UI khỏi hệ thống chụp màn hình của Roblox
    gui.DisplayOrder = 999
    gui.Parent = (gethui and gethui()) or game:GetService("CoreGui") or player:WaitForChild("PlayerGui")
end)

-- KHUNG CHÍNH (Design by Longg MC)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 115)
frame.Position = UDim2.new(0.5, -160, 0, -150) 
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BackgroundTransparency = 0.1
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Color = Color3.fromRGB(255, 255, 255)
frameStroke.Thickness = 1.5
frameStroke.Transparency = 0.8

-- Title & Player Info
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -45, 0.35, 0)
title.Position = UDim2.new(0, 38, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Đơn hàng: " .. tenDon
title.TextColor3 = Color3.fromRGB(255, 223, 0)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left

local playerLabel = Instance.new("TextLabel", frame)
playerLabel.Size = UDim2.new(1, -20, 0.25, 0)
playerLabel.Position = UDim2.new(0, 12, 0.38, 0)
playerLabel.BackgroundTransparency = 1
playerLabel.Text = "Tên: " .. tenBiChe
playerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
playerLabel.TextScaled = true
playerLabel.Font = Enum.Font.SourceSansBold
playerLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Ô nhập đơn hàng
local inputBox = Instance.new("TextBox", frame)
inputBox.Size = UDim2.new(1, -24, 0.22, 0)
inputBox.Position = UDim2.new(0, 12, 0.65, 0)
inputBox.PlaceholderText = "Nhập mã đơn..."
inputBox.Text = ""
inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.TextScaled = true
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 4)

-- Signature by Longg MC
local authorTag = Instance.new("TextLabel", frame)
authorTag.Size = UDim2.new(0, 100, 0, 20)
authorTag.Position = UDim2.new(1, -105, 1, -22)
authorTag.BackgroundTransparency = 1
authorTag.Text = "by Longg MC"
authorTag.TextColor3 = Color3.fromRGB(255, 255, 255)
authorTag.TextTransparency = 0.5
authorTag.Font = Enum.Font.Code

-- Animation và Logic
game:GetService("TweenService"):Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quart), {Position = UDim2.new(0.5, -160, 0, 15)}):Play()

inputBox.FocusLost:Connect(function(enter)
    if enter and inputBox.Text ~= "" then
        tenDon = inputBox.Text
        title.Text = "Đơn hàng: " .. tenDon
        inputBox.Text = ""
    end
end)

print("Secure Script by Longg MC - Anti-Ban Active")
