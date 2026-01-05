wait(10)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
task.wait(0.5)

local ShopAPI = game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem")

-- SET QUANTITIES BELOW:
local shoppingList = {
  ["gifts"] = {
        ["winter_2025_angus_box"] = 30,
        ["winter_2025_sticker_pack"] = 300,
        ["winter_2025_sticker_pack"] = 2,
    ["winter_2025_sticker_pack"] = 1,
    ["winter_2025_sticker_pack"] = 1
    
    },
    ["strollers"] = {
        ["winter_2025_santas_helper_stroller"] = 1,
        ["winter_2025_humbug_stroller"] = 1
    },
    ["transport"] = {
        ["winter_2025_laser_disco_skates"] = 1,
        ["winter_2025_gift_dropper_copter"] = 1
    },
    ["toys"] = {
        ["winter_2025_star_topper_plush"] = 1,
        ["winter_2025_golden_rings_flying_disc"] = 1,
        ["winter_2025_holly_leash"] = 1,
        ["winter_2025_mistletroll_friend_plush"] = 1,
        ["winter_2025_badly_wrapped_toy_sword"] = 1
    },
    ["pet_accessories"] = {
        ["winter_2025_santa_beard"] = 1,
        ["winter_2025_snowstorm_hat"] = 1,
        ["winter_2025_yarn_beanie_hat"] = 1,
        ["winter_2025_ice_tiara"] = 1,
        ["winter_2025_festive_striped_scarf"] = 1,
        ["winter_2025_snowflake_earmuffs"] = 1,
        ["winter_2025_nutcracker_hat"] = 1,
        ["winter_2025_festive_antlers"] = 1,
        ["winter_2025_bauble_necklace"] = 1,
        ["winter_2025_toasty_mittens"] = 1,
        ["winter_2025_2026_nye_glasses"] = 1,
        ["winter_2025_gold_shimmery_cape"] = 1
    },
    ["pets"] = {
        ["winter_2025_japanese_snow_fairy"] = 40, 
        ["winter_2025_samoyed"] = 40,
        ["winter_2025_maine_coon"] = 4,
     ["winter_2025_maine_coon"] = 4,
    ["winter_2025_maine_coon"] = 4,
    ["winter_2025_maine_coon"] = 4,
    ["winter_2025_maine_coon"] = 4,
    ["winter_2025_maine_coon"] = 4,
    ["winter_2025_maine_coon"] = 4,
    ["winter_2025_maine_coon"] = 4,
    ["winter_2025_maine_coon"] = 4,
        ["winter_2025_christmas_spirit"] = 2,
        ["winter_2025_humbug"] = 16,
        ["winter_2025_angus_bull"] = 1,
        ["winter_2025_turtle_doves"] = 16,
        ["winter_2025_bunny_swirl"] = 1,
        
        ["winter_2025_mrs_whiskerpips"] = 1,
        ["winter_2025_cozy_mistletroll"] = 8,
        ["winter_2025_arctic_dusk_dragon"] = 1,
        ["winter_2025_old_king_coal"] = 1,
        ["winter_2025_xmas_tree_sasquatch"] = 1,
        
        ["winter_2025_snowball_pug"] = 1,
        ["winter_2025_angus_calf"] = 1,
        ["winter_2025_angus_cow"] = 1
    }
}

--- Processing Loop ---
print("Starting purchase sequence...")

for category, items in pairs(shoppingList) do
    for itemName, quantity in pairs(items) do
        if quantity > 0 then
            local args = {
                category,
                itemName,
                { buy_count = quantity }
            }
            
            -- Execution
            ShopAPI:InvokeServer(unpack(args))
            print("Purchased " .. quantity .. "x " .. itemName)
            
            -- Brief wait in between each item as requested
            task.wait(0.1) 
        end
    end
end

print("All items processed successfully.")
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

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/b7359a8866fd351cc305781fb0b0ecfc.lua"))()
