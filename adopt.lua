wait(5)
local locations = {"MainMap"}

for _, location in ipairs(locations) do
    for i = 1, 100 do
        local args = {
            [1] = location,
            [2] = tostring(i)
        }
        game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
        wait(0.2)  -- 0.1 second delay
    end
end
wait(1)
local locations = {"MoonInterior"}

for _, location in ipairs(locations) do
    for i = 1, 100 do
        local args = {
            [1] = location,
            [2] = tostring(i)
        }
        game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
        wait(0.2)  -- 0.1 second delay
    end
end
wait(1)
local args = {
    [1] = "MoonInterior",
    [3] = true
}

for i = 1, 100 do
    args[2] = tostring(i)
    game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
    wait(0.2)  -- Delay of 0.2 seconds
end
end
wait(1)
local args = {
    [1] = "MainMap",
    [3] = true
}

for i = 1, 100 do
    args[2] = tostring(i)
    game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
    wait(0.2)  -- Delay of 0.2 seconds
end


