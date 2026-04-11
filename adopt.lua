script_key = "VuEAzrzDNFjpnnPXCwaBNyjeRkwCfdnm"

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
