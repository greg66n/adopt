Config = {
    PetFarm = {
        Enabled = true,   -- Enable/disable pet farming
        AutoNeon = false,  -- Auto create neon pets (4 full-grown)
        FarmUntilFullyGrown = false, -- Farm youngest first (true) or oldest (false)
        PrioritizeFriendship = true, -- Farm highest friendship pets first
        FarmEggs = false,  -- Auto-farm eggs until they hatch
        EggType = "cracked_egg", -- Egg to farm: cracked, royal, etc.
        SelectFarmEgg = "any",  -- "any" = all eggs, or specify one
        BuyEggs = false,  -- Auto-buy eggs if needed
        AutoAgePotionEnabled = false, -- Use age potions for faster growth
        AutoAgePotionPets = { "winter_2024_ice_cube", "winter_2024_berry_cool_cube" }, -- Pets that get age potions
        ExcludedTasks = {
            Enabled = false, -- If true, skips listed tasks
            Tasks = { 
                "camping", "hungry", "thirsty", "sick", "sleepy", "dirty", "bored", "toilet", 
                "school", "salon", "beach_party", "pizza_party", "play", "walk", "ride", "moon", 
                "pet_me", "catch"
            }
        },
        RarityFarming = {
            Enabled = false,  -- Farm by rarity instead of age
            Order = { "ultra_rare", "common", "legendary", "rare", "uncommon" }
        }
    },
    BabyFarm = {
        Enabled = true,   -- Enable/disable baby farming
        Priority = "PetFirst", -- "BabyFirst" does baby tasks first
        ExcludedTasks = {
            Enabled = false, 
            Tasks = { "camping" } -- same as the pet farm js add the tasks you want to exclude
        }
    },
    Webhook = {
        Enabled = true,  -- Enable Discord notifications
        URL = "webhook here"  -- Replace with actual webhook URL
    }
}

script_key="OkbUgSyCLieCMbeVqgTZOAgbKIdxjRLH"
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/8a2399ec22841391ee52540ec7c001e1.lua"))() --Adopt Me Potion Farm / Mass Farming
