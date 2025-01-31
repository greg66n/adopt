task.spawn(function()
    task.wait(35)
    getgenv().API_KEY = "pQP1Ma1WE4h81mPToP54"
    loadstring(game:HttpGet("http://ii.sebas.sbs:4241/adoptme/dashboard.lua"))()
end)

task.spawn(function()
   -- ARCEUS, CODEX ETC
task.wait(35)
script_key="NxzplPKcRYahKMvLcZtfTAOQURrRclwP";
getgenv().Config = {
    ["Winter_EVENT"] = false,
    ["PetFarmActive"] = true,
    ["EggFarmActive"] = false,
    ["Blur_username"] = true,
    ["Blazing_Lion_Log"] = false,
    ["DiscordId"] = "942321951010086922",
    ["Webhook"] = "https://discord.com/api/webhooks/123456",
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/66567bfd337b57eb059b58dbe1badb89.lua"))()
end)
wait(1)
wait(1)
local args = {
    [1] = "pets",
    [2] = "winter_2024_frostbite_cub",
    [3] = {
        ["buy_count"] = 32
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1)

local args = {
    [1] = "toys",
    [2] = "winter_2024_snowflake_plush",
    [3] = {
        ["buy_count"] = 3
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pet_accessories",
    [2] = "winter_2024_santas_bow",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pet_accessories",
    [2] = "winter_2024_elf_shoes",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pet_accessories",
    [2] = "winter_2024_elf_shoes",
    [3] = {
        ["buy_count"] = 3
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)


local args = {
    [1] = "toys",
    [2] = "winter_2024_bauble_throw_toy",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))


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
    [1] = "pets",
    [2] = "garden_2024_egg", 
    [3] = {}
}

for i = 1, 100 do
    game:GetService("ReplicatedStorage").API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
    wait(0.1) -- Delay of 0.1 seconds between each call
end
wait(1)
local args = {
    [1] = "toys",
    [2] = "lunar_2025_lucky_coin_flying_disc", 
    [3] = {}
}

game:GetService("ReplicatedStorage").API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "pet_accessories",
    [2] = "lunar_2025_knot_earrings", 
    [3] = {}
}

game:GetService("ReplicatedStorage").API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))



