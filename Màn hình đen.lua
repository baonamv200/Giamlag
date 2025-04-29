local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local gui = Instance.new("ScreenGui")
gui.Name = "HugeBlackScreen"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local black
local button
local overlayActive = true

-- Tạo màn hình đen siêu to
local function createBlackScreen()
    black = Instance.new("Frame")
    black.Name = "BlackOverlay"
    black.Parent = gui
    black.Size = UDim2.new(10, 0, 10, 0)
    black.Position = UDim2.new(-4.5, 0, -4.5, 0)
    black.BackgroundColor3 = Color3.new(0, 0, 0)
    black.BorderSizePixel = 0
    black.ZIndex = 1  -- Đảm bảo lớp đen ở dưới
end

-- Tạo nút tắt mở
local function createButton()
    button = Instance.new("TextButton")
    button.Name = "ToggleButton"
    button.Parent = gui
    button.Size = UDim2.new(0, 80, 0, 40)
    button.Position = UDim2.new(1, -100, 1, -60) -- Góc phải dưới
    button.AnchorPoint = Vector2.new(0, 0)
    button.BackgroundColor3 = Color3.new(1, 1, 1)
    button.Text = "TẮT"
    button.TextColor3 = Color3.new(0, 0, 0)
    button.Font = Enum.Font.SourceSansBold
    button.TextScaled = true
    button.Active = true
    button.Draggable = true -- Cho phép kéo
    button.ZIndex = 2  -- Đảm bảo nút trên cùng

    -- Khi bấm nút, toggle (bật/tắt) màn hình đen
    button.MouseButton1Click:Connect(function()
        if overlayActive then
            black:Destroy()
            button.Text = "MỞ LẠI"
        else
            createBlackScreen()
            button.Text = "TẮT"
        end
        overlayActive = not overlayActive -- Đổi trạng thái
    end)
end

-- Tạo FPS
local function createFPSDisplay()
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Parent = gui
    fpsLabel.Size = UDim2.new(0, 100, 0, 50)
    fpsLabel.Position = UDim2.new(0, 10, 0, 10)
    fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.TextScaled = true
    fpsLabel.Text = "FPS: 0"
    fpsLabel.ZIndex = 2  -- Đảm bảo FPS ở trên cùng

    local colors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 165, 0), Color3.fromRGB(255, 255, 0),
                    Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(75, 0, 130), Color3.fromRGB(238, 130, 238)}

    -- Cập nhật FPS
    game:GetService("RunService").Heartbeat:Connect(function()
        local fps = math.floor(1 / game:GetService("RunService").Heartbeat:Wait())
        fpsLabel.Text = "FPS: " .. fps

        -- Thay đổi màu sắc theo FPS
        local colorIndex = math.min(math.floor(fps / 10) + 1, #colors)
        fpsLabel.TextColor3 = colors[colorIndex]
    end)
end

-- Tạo các thành phần giao diện
createBlackScreen()
createButton()
createFPSDisplay()
