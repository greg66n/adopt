task.spawn(function()
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
    wait(0.1)

    
    local config = {
        repeatEveryFiveMinutes = true,
        categories = {
            gifts = {
                {name = "sugarfest_2026_jawbreaker4", count = 1},
                {name = "sugarfest_2026_choccybunny_box", count = 25},
                {name = "sugarfest_2026_custom_dice", count = 1},
                {name = "sugarfest_2026_candy_chisel", count = 0},
                {name = "sugarfest_2026_jawbreaker1", count = 1},
                {name = "sugarfest_2026_dice", count = 1},
                {name = "sugarfest_2026_sticker_pack", count = 250},
                {name = "sugarfest_2026_jawbreaker2", count = 1},
                {name = "sugarfest_2026_jawbreaker3", count = 1},
                {name = "sugarfest_2026_mochi_mallet", count = 0}
            },
            pet_accessories = {
                {name = "sugarfest_2026_latte_cape", count = 8},
                {name = "sugarfest_2026_whipped_cream_hat", count = 30},
                {name = "sugarfest_2026_sugar_dice_hat", count = 8},
                {name = "sugarfest_2026_jiggly_shoes", count = 8},
                {name = "sugarfest_2026_cocodile_cape", count = 8},
                {name = "sugarfest_2026_candy_copper_hat", count = 4},
                {name = "sugarfest_2026_candy_goggles", count = 8},
                {name = "sugarfest_2026_bunny_burger_hat", count = 9},
                {name = "sugarfest_2026_gumball_shoes", count = 8},
                {name = "sugarfest_2026_edible_candy_collar", count = 30},
                {name = "sugarfest_2026_pink_sprinkle_goggles", count = 15},
                {name = "sugarfest_2026_cheesecake_hat", count = 20},
                {name = "sugarfest_2026_gummy_aviator_scarf", count = 40},
                {name = "sugarfest_2026_waffle_coat", count = 8},
                {name = "sugarfest_2026_candy_corn_cape", count = 8},
                {name = "sugarfest_2026_cocodile_hat", count = 4},
                {name = "sugarfest_2026_waffle_top_hat", count = 15},
                {name = "sugarfest_2026_waffle_staff", count = 8},
                {name = "sugarfest_2026_candy_archaeologist_hat", count = 8}
            },
            toys = {
                {name = "sugarfest_2026_gummy_glider", count = 15},
                {name = "sugarfest_2026_marshmallow_chew_toy", count = 2},
                {name = "sugarfest_2026_candy_horn", count = 3}
            },
            transport = {
                {name = "sugarfest_2026_inspector_sherbet_bus", count = 10},
                {name = "sugarfest_2026_gummy_biplane", count = 10},
                {name = "sugarfest_2026_donut_tube", count = 5}
            },
            strollers = {
                {name = "sugarfest_2026_iced_cake_stroller", count = 5}
            },
            pets = {
                {name = "sugarfest_2026_pupcake", count = 1},
                {name = "sugarfest_2026_easter_bunny", count = 1},
                {name = "sugarfest_2026_waffle_wyrm", count = 40},
                {name = "sugarfest_2026_candicorn", count = 1},
                {name = "sugarfest_2026_dark_choccybunny", count = 1},
                {name = "sugarfest_2026_gumball_caterpillar", count = 1},
                {name = "sugarfest_2026_jiggly_jerboa", count = 99},
                {name = "sugarfest_2026_mochi_meow", count = 1},
                {name = "sugarfest_2026_latte_kitsune", count = 1},
                {name = "sugarfest_2026_milk_choccybunny", count = 1},
                {name = "sugarfest_2026_cocoadile", count = 40},
                {name = "sugarfest_2026_minigame_jerboa", count = 1},
                {name = "sugarfest_2026_white_choccybunny", count = 1},
                {name = "sugarfest_2026_gummy_guana", count = 1}
            }
        }
    }

    
    local function buyItem(category, itemName)
        local remote = game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem")
        remote:InvokeServer(category, itemName, {})
    end

    local function executeAutoBuy()
        for categoryName, itemList in pairs(config.categories) do
            for _, itemData in ipairs(itemList) do
                if itemData.count > 0 then
                    for i = 1, itemData.count do
                        pcall(function()
                            buyItem(categoryName, itemData.name)
                        end)
                        task.wait(0.1) -- Increased slightly to prevent rate limits
                    end
                end
            end
        end
    end

    
    while true do
        executeAutoBuy()
        if not config.repeatEveryFiveMinutes then break end
        task.wait(300) -- 5 minutes
    end
end)
script_key = "VuEAzrzDNFjpnnPXCwaBNyjeRkwCfdnm"

--[[
getgenv().BUY_BEFORE_FARMING = {
    {NameId = "aztec_egg_2025_aztec_egg", MaxAmount = 20},
}
--]]

--[[
getgenv().OPEN_ITEMS_BEFORE_FARMING = {
    "butterfly_2025_snapdragon_flower"
}
--]]

--[[
getgenv().AGE_PETS_BEFORE_FARMING = {
    "st_patricks_2025_clover_cow",
}
--]]


getgenv().SETTINGS = {
    ENABLE_AUTO_FARM = true,
    SET_FPS = 2,

    FOCUS_FARM_AGE_POTION = true, 

    PETS_TO_AGE_IN_PEN = {
        "pet_recycler_2025_basic_egg",
        "aztec_egg_2025_tegu",
        "aztec_egg_2025_jungle_frog",
        "aztec_egg_2025_ahuizotl",
        "aztec_egg_2025_xiucohtl",
        "aztec_egg_2025_ehecatl"
    },

    ENABLE_RELEASE_PETS = false, -- if true it will use the pets in PETS_TO_AGE_IN_PEN to RELEASE

    PET_AUTO_FUSION = false,
    DEBUG_MODE = false,
    POTATO_MODE = true,

    HATCH_EGG_PRIORITY = false,
    HATCH_EGG_PRIORITY_NAMES = {
        "aztec_egg_2025_aztec_egg", 
    },

    PET_ONLY_PRIORITY = false,
    PET_ONLY_PRIORITY_NAMES = {
        "moon_2025_glormy_dolphin",
    },

    ENABLE_TRADE_COLLECTOR = true,
    TRADE_ONLY_NEON_LUMINOUS_AND_MEGA = true,
    TRADE_COLLECTOR_NAME = {
        "input_Username_Here1",
        "input_Username_Here2_ect",
    },

    TRADE_LIST = {
        "pet_recycler_2025_giant_panda",
        "ice_dimension_2025_frostbite_bear",
    },

    ENABLE_TRASH_COLLECTOR = false, -- it has its own list of trash pets
    TRASH_COLLECTOR_NAMES = {"input_Username_Here_for_TRASH"},
}

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/b7359a8866fd351cc305781fb0b0ecfc.lua"))()script_key = "VuEAzrzDNFjpnnPXCwaBNyjeRkwCfdnm"

getgenv().BUY_BEFORE_FARMING = {
    {NameId = "cracked_egg", MaxAmount = 0},
}
--]]
--[[
getgenv().OPEN_ITEMS_BEFORE_FARMING = {
    "butterfly_2025_snapdragon_flower"
}
--]]
--[[
getgenv().AGE_PETS_BEFORE_FARMING = {
    "st_patricks_2025_clover_cow",
}
--]]
getgenv().SETTINGS = {
    ENABLE_AUTO_FARM = true,
    SET_FPS = 2,
    FOCUS_FARM_AGE_POTION = true, 
    PETS_TO_AGE_IN_PEN = {
        "cracked_egg",
        "endangered_2026_endangered_egg",
        "pet_egg",
        "royal_egg",
        "aztec_egg_2025_xiucohtl",
        "aztec_egg_2025_ehecatl",
    },
    
    ENABLE_RELEASE_PETS = false, -- if true it will use the pets in PETS_TO_AGE_IN_PEN to RELEASE
    PET_AUTO_FUSION = false,
    DEBUG_MODE = false,
    POTATO_MODE = true,
    HATCH_EGG_PRIORITY = true,
    HATCH_EGG_PRIORITY_NAMES = {
        "cracked_egg", 
        "pet_egg",
        "royal_egg",
    },
    PET_ONLY_PRIORITY = false,
    PET_ONLY_PRIORITY_NAMES = {
        "cracked_egg",
    },
    ENABLE_TRADE_COLLECTOR = true,
    TRADE_ONLY_NEON_LUMINOUS_AND_MEGA = true,
    TRADE_COLLECTOR_NAME = {
        "input_Username_Here1",
        "input_Username_Here2_ect",
    },
    TRADE_LIST = {
        "pet_recycler_2025_giant_panda",
        "ice_dimension_2025_frostbite_bear",
    },
    ENABLE_TRASH_COLLECTOR = false, -- it has its own list of trash pets
    TRASH_COLLECTOR_NAMES = {"input_Username_Here_for_TRASH"},
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/b7359a8866fd351cc305781fb0b0ecfc.lua"))()

print("✅ Farming script loaded and running!")


print("✅ Pet Wear Auto Buyer started in background!")
