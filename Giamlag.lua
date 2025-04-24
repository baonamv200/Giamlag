-- UI + Auto Bật Giảm Lag (by ChatGPT)

-- Hàm giảm lag
local function GiamLag()
    -- Xóa hiệu ứng
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Explosion") or v:IsA("Fire") or v:IsA("Smoke") then
            v:Destroy()
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("PointLight") or v:IsA("SurfaceLight") or v:IsA("SpotLight") then
            v:Destroy()
        end
    end

    -- Xóa trái, kiếm, skill
    for _, obj in pairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if name:find("fruit") or name:find("flame") or name:find("bomb") or name:find("dark")
        or name:find("slash") or name:find("sword") or name:find("effect") then
            obj:Destroy()
        end
    end

    -- Xóa địa hình không cần thiết
    for _, obj in pairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if obj:IsA("Model") and (name:find("tree") or name:find("rock") or name:find("house") or name:find("building") or name:find("terrain")) then
            obj:Destroy()
        end
    end

    -- Lighting tối giản
    local Lighting = game:GetService("Lighting")
    Lighting.GlobalShadows = false
    Lighting.Brightness = 0
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("SunRaysEffect") then
            v:Destroy()
        end
    end

    -- Tối giản vật liệu
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
        end
    end

    -- Tắt shadow nhân vật
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        for _, part in pairs(lp.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CastShadow = false
            end
        end
    end

    print("Đã bật giảm lag.")
end

-- Tạo giao diện
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
local Button = Instance.new("TextButton", Frame)

-- UI setup
Frame.Size = UDim2.new(0, 200, 0, 80)
Frame.Position = UDim2.new(0, 20, 0, 200)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

Button.Size = UDim2.new(1, 0, 1, 0)
Button.Text = "Đã Bật Giảm Lag"
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
Button.TextColor3 = Color3.new(1,1,1)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 20

-- Trạng thái
local isLagReduced = true

-- Bật tắt bằng nút
Button.MouseButton1Click:Connect(function()
    isLagReduced = not isLagReduced
    if isLagReduced then
        GiamLag()
        Button.Text = "Đã Bật Giảm Lag"
        Button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        Button.Text = "Đã Tắt Giảm Lag"
        Button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    end
end)

-- Tự động bật khi vào game
task.wait(2)
GiamLag()
