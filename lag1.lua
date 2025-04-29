local player = game.Players.LocalPlayer
local ws = game:GetService("Workspace")

-- Hàm tìm map phù hợp (Sea 1, 2, 3)
local function getMap()
	for _, obj in ipairs(ws:GetChildren()) do
		if obj:IsA("Model") and obj.Name:lower():find("map") then
			return obj
		end
	end
	return nil
end

-- Hàm xoá công trình và tạo sàn đứng
local function cleanMapAndCreatePlatform()
	local map = getMap()
	if map then
		for _, obj in pairs(map:GetDescendants()) do
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

		-- Tạo sàn đứng
		local platform = Instance.new("Part")
		platform.Size = Vector3.new(100, 1, 100)
		platform.Position = Vector3.new(0, 50, 0)
		platform.Anchored = true
		platform.Name = "SafePlatform"
		platform.BrickColor = BrickColor.new("Really black")
		platform.Parent = workspace

		-- Đưa người chơi lên sàn
		local char = player.Character or player.CharacterAdded:Wait()
		char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(platform.Position + Vector3.new(0, 5, 0))
	end
end

-- Gọi hàm khi bắt đầu
cleanMapAndCreatePlatform()

-- Tự động làm lại khi nhân vật respawn hoặc chuyển map
player.CharacterAdded:Connect(function()
	wait(1)
	cleanMapAndCreatePlatform()
end)
