getgenv().hub_key = "4d964454191739793dcfa2a29ed7193a"
getgenv().custom_label = "VPS1"
getgenv().BabyFarmActive = true
getgenv().MiniGameFarm = false
---------------------------------
getgenv().PotFarm = true
---------------------------------
getgenv().PetFarm = false
getgenv().PetTypes = { "grave owl", "kraken", "cheetah" }
---------------------------------
getgenv().EggFarm = false
getgenv().EggTypes = { "garden egg", "royal egg" }
---------------------------------
getgenv().AutoNeon = false
getgenv().AutoMega = false
---------------------------------
loadstring(game:HttpGet("https://nb0.xyz/scripts/2GMANAGER_FARM.lua"))()
wait(1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(1)
local args = {
    [1] = "pets",
    [2] = "winter_2024_great_pyrenees",
    [3] = {
        ["buy_count"] = 20
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1) 
local args = {
    [1] = "strollers",
    [2] = "winter_2024_snowman_stroller",
    [3] = {
        ["buy_count"] = 3
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1) 
local args = {
    [1] = "toys",
    [2] = "winter_2024_lasso_propeller",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1) 
local args = {
    [1] = "toys",
    [2] = "winter_2024_tape_measure_leash",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "pets",
    [2] = "winter_2024_ratatoskr",
    [3] = {
        ["buy_count"] = 32
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args)) 
wait(1)
local args = {
    [1] = "toys",
    [2] = "winter_2024_festive_pogo",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1) 
local args = {
    [1] = "toys",
    [2] = "winter_2024_drone_balloon",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args)) 
