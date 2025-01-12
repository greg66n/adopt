Config = {
    PetFarm = {
        Enabled = true,            -- Master switch for pet farming
        AutoNeon = false,          -- Makes neon pets when you have 4 full grown
        FarmUntilFullyGrown = false, -- true = farms youngest pets | false = oldest pets
        PrioritizeFriendship = true, -- true = highest friendship pets | false = by age only
        FarmEggs = false,           -- Farm eggs until they hatch then buys more
        EggType = "cracked_egg",   -- cracked_egg, regular_pet_egg, royal_egg, garden_2024_egg
        SelectFarmEgg = "any",    
        BuyEggs = false,           -- Auto buys eggs when needed
        AutoAgePotionEnabled = false,
        AutoAgePotionPets = {"winter_2024_ice_cube","winter_2024_berry_cool_cube"}, -- example of how u use multiple pets
        RarityFarming = {
            Enabled = false, -- enable for rarity farming on wor
            Order = {
                "ultra_rare", -- highest priority 
                "common",
                "legendary",
                "rare",
                "uncommon" -- lowest priority 
            }
        }
    },
    BabyFarm = {
        Enabled = true,           -- Master switch for baby farming
        Priority = "PetFirst",    -- BabyFirst = do baby tasks first | PetFirst = do pet tasks first
    },
    Webhook = {
        Enabled = false,            -- Enable Discord alerts
        URL = "webhook here",          -- Your webhook
    },
    FPSSaver = {
        Enabled = false,           -- FPS boost mode
        Disable3DRendering = false, -- Max performance
        FPSCap = 60                -- FPS cap 
    },
    UI = {
        Maximized = false,          -- true = big | false = small
        Scale = 1                  -- 0.1 = tiny, 0.5 = half, 1 = full
    }
}

script_key="OkbUgSyCLieCMbeVqgTZOAgbKIdxjRLH"
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/8a2399ec22841391ee52540ec7c001e1.lua"))() --Adopt Me Potion Farm / Mass Farming
wait(5)
local args = {
    [1] = "pets",
    [2] = "winter_2024_mistletroll",
    [3] = {
        ["buy_count"] = 32
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1) 
darien
 — 
Yesterday at 11:20 PM
local args = {
    [1] = "pet_accessories",
    [2] = "winter_2024_gingerbread_beard",
    [3] = {
        ["buy_count"] = 5
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "pet_accessories",
    [2] = "winter_2024_gingerbread_beard",
    [3] = {
        ["buy_count"] = 5
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
darien
 — 
Yesterday at 11:33 PM
wait(1)
local args = {
    [1] = "gifts",
    [2] = "winter_2024_sticker_pack",
    [3] = {
        ["buy_count"] = 99
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "gifts",
    [2] = "winter_2024_sticker_pack",
    [3] = {
        ["buy_count"] =99
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "gifts",
    [2] = "winter_2024_sticker_pack",
    [3] = {
        ["buy_count"] = 99
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1)
local args = {
    [1] = "gifts",
    [2] = "winter_2024_sticker_pack",
    [3] = {
        ["buy_count"] = 99
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
    [1] = "pet_accessories",
    [2] = "winter_2024_adopt_lanyard",
    [3] = {
        ["buy_count"] = 3
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
