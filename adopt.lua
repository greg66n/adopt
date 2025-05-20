
Config = {
    PetFarm = {
        Enabled = true,
        AutoNeon = false,
        FarmUntilFullyGrown = false,
        PrioritizeFriendship = true,
        FarmEggs = false,
        EggType = "cracked_egg",
        SelectFarmEgg = "any",
        BuyEggs = false,
        AutoAgePotionEnabled = false,
        AutoAgePotionPets = { "winter_2024_ice_cube", "winter_2024_berry_cool_cube" },
        ExcludedTasks = {
            Enabled = false,
            Tasks = {
                "camping", "hungry", "thirsty", "sick", "sleepy", "dirty", "bored", "toilet",
                "school", "salon", "beach_party", "pizza_party", "play", "walk", "ride", "moon",
                "pet_me", "catch"
            }
        },
        RarityFarming = {
            Enabled = false,
            Order = { "ultra_rare", "common", "legendary", "rare", "uncommon" }
        }
    },
    BabyFarm = {
        Enabled = true,
        Priority = "PetFirst",
        ExcludedTasks = {
            Enabled = false,
            Tasks = { "camping" }
        }
    },
    Webhook = {
        Enabled = true,
        URL = ""
    }
}
script_key="YDizWtCsoUWCWDMoEGyWgIZZjPCgquVY" loadstring(game:HttpGet("https://zekehub.com/scripts/AdoptMeMassFarm.lua"))()
