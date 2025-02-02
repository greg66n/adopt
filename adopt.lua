

wait(1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(1)
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


wait(1)
local args = {
    [1] = "pets",
    [2] = "lunar_2025_blossom_snake",
    [3] = {}
}

for i = 1, 8 do
    game:GetService("ReplicatedStorage").API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
    wait(0.2) -- Delay of 0.2 seconds between each call
end
wait(1)

local args = {
    [1] = "pet_accessories",
    [2] = "lunar_2025_knot_earrings", 
    [3] = {}
}

game:GetService("ReplicatedStorage").API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "toys",
    [2] = "lunar_2025_lucky_coin_flying_disc", 
    [3] = {}
}

game:GetService("ReplicatedStorage").API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "toys",
    [2] = "lunar_2025_lucky_coin_flying_disc", 
    [3] = {}
}

game:GetService("ReplicatedStorage").API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

