wait(1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(1)
task.spawn(function()
    while true do
        -- Loop 20 times
        for i = 1, 20 do
            -- Arguments for invoking the server
            local args = {
                [1] = "food",
                [2] = "ice_dimension_2025_shiver_cone_bait", 
                [3] = {}
            }

            -- Make the request to the server
            game:GetService("ReplicatedStorage").API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

            -- Wait 0.3 seconds between executions
            wait(0.3)
        end

        -- Wait 60 seconds before repeating the loop
        wait(60)
    end
end)
wait(1)
getgenv().SETTINGS = {
    EVENT = {
        DO_MINIGAME = true, 
    },

    PET_TO_BUY = "moon_2025_egg", -- add pet or egg to buy when bot has no pets/egg left to level
    BAIT_TO_USE_IN_ORDER = {
        "ice_dimension_2025_shiver_cone_bait",
        "ice_dimension_2025_subzero_popsicle_bait",
        "ice_dimension_2025_ice_soup_bait"
    },

    ENABLE_AUTO_FARM = true,
    SET_FPS = 6, -- set to 6 when doing events, 3 when no event
    PET_NEON_PRIORITY = false, -- will age neon pets first
    PET_AUTO_FUSION = false, -- will auto make them neon/mega

    FOCUS_FARM_AGE_POTION = true, -- if true, this will only farm 1 pet an keep aging to get aging potions

    HATCH_EGG_PRIORITY = false,
    HATCH_EGG_PRIORITY_NAMES = { "moon_2025_egg" },

    ENABLE_TRADE_COLLECTOR = false, -- set to true to have bots trade your mule/collector
    TRADE_ONLY_LUMINOUS_MEGA = false, -- true will trade only neon LUMINOUS and megas, false will include fullgrown
    TRADE_COLLECTOR_NAME = {"add_username_here!"}, -- username of your bot that will collect from other bots

    -- anything inside TRADE_LIST will be traded to username in TRADE_COLLECTOR_NAME
    -- no matter what age the pet is.
    TRADE_LIST = {
        "moon_2025_royal_egg",
        "lures_2023_blazing_lion",
        "ice_dimension_2025_frostbite_bear",
    },

    --  pets in this list will prioritize over other pets
    PET_ONLY_PRIORITY = false,
    PET_ONLY_PRIORITY_NAMES = {
        "st_patricks_2025_clover_cow", -- example
    },
}

loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/b8a32e19f80163db7645bf88cbe4d9c5.lua"))()
