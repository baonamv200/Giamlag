-- Xóa các công trình không cần thiết, giữ lại đất, nước, npc,...
for _, obj in pairs(game:GetService("Workspace").Map:GetDescendants()) do
    if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("MeshPart") then
        local name = obj.Name:lower()
        
        if not name:find("ground") and
           not name:find("floor") and
           not name:find("sea") and
           not name:find("npc") and
           not name:find("spawn") and
           not name:find("water") and
           not name:find("island") then
            pcall(function()
                obj:Destroy()
            end)
        end
    end
end

-- Tạo một sàn đứng an toàn
local platform = Instance.new("Part")
platform.Size = Vector3.new(100, 1, 100)
platform.Position = Vector3.new(0, 50, 0) -- Tuỳ chỉnh vị trí cao thấp
platform.Anchored = true
platform.Name = "SafePlatform"
platform.BrickColor = BrickColor.new("Really black")
platform.Parent = workspace

-- Dịch chuyển người chơi lên sàn
local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(platform.Position + Vector3.new(0, 5, 0))
