getgenv().hub_key = "4d964454191739793dcfa2a29ed7193a"
getgenv().custom_label = "VPS1"
loadstring(game:HttpGet("https://nb0.xyz/scripts/2GMANAGER_FARM.lua"))()
wait(10)
local accessories = {
    shuriken = 02,
    lny2022_gold_ingot = 02,
    gold_circle_glasses = 02,
    black_sneakers = 02,
    cowboy_hat = 02,
    clout_goggles = 02,
    fried_egg = 02,
    gold_tiara = 02,
    pink_cat_ear_headphones = 300,
    pink_heart_glasses = 300,
    kiwi_2023_red_scarf = 02,
    lny_2022_shoes = 02,
    lny_2022_red_envelope = 02,
    lny_2022_mandarin_hat = 02,
    lny_2022_collar = 02,
    jade_moth_wings = 02,
    striped_necktie = 02,
    jeffs_nametag = 02
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BuyItem = ReplicatedStorage.API:FindFirstChild("ShopAPI/BuyItem")

for accessory, buyCount in pairs(accessories) do
    if buyCount > 0 then  -- Only buy if the count is greater than zero
        for i = 1, buyCount do
            local args = {
                [1] = "pet_accessories",
                [2] = accessory,
                [3] = {}
            }

            BuyItem:InvokeServer(unpack(args))
            wait(0.2)  -- Delay between purchases
        end
    end
end

