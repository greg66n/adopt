-- This part runs in the background
task.spawn(function()
    while true do
        -- 1. Load the Bypass
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
        end)
        
        -- 2. Run the Remote if bypass was successful
        if success then
            local net = game:GetService("ReplicatedStorage"):FindFirstChild("adoptme_new_net")
            if net and net:FindFirstChild("TryClaimBunny") then
                net.TryClaimBunny:InvokeServer()
            end
        else
            warn("Bypass failed to load: " .. tostring(err))
        end

        -- 3. Wait 5 minutes (300 seconds)
        task.wait(300)
    end
end)

-- Your LuaArmor script goes here (it will run immediately)
-- loadstring(game:HttpGet("LuaArmor_Link_Here"))()
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
    SET_FPS = 20,

    FOCUS_FARM_AGE_POTION = true, 

    PETS_TO_AGE_IN_PEN = {
        "cracked_egg",
        
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
