--==================================================
-- PRE-FARMING SCRIPT (Runs First)
--==================================================
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

print("✅ Farming script loaded and running!")

--==================================================
-- Adopt Me | Pet Wear Auto Buyer + Rarity Sniper
--==================================================
task.spawn(function()
    --==================== CONFIG ======================
    local LOOP_DELAY = 300
    local DISCORD_WEBHOOK = "PUT_WEBHOOK_HERE"

    -- Rarity settings: set to false to ignore, or a number to buy that many (MAX 99 per call)
    local RARITY_SETTINGS = {
        common = false,           -- Set to false to ignore, or number like 10 to buy 10 of each
        uncommon = false,         -- Set to false to ignore, or number like 25 to buy 25 of each
        rare = false,             -- Set to false to ignore, or number like 50 to buy 50 of each
        ultra_rare = 99,          -- Buy 99 of each ultra rare (MAX is 99)
        legendary = 99            -- Buy 99 of each legendary (MAX is 99)
    }

    -- How many times to repeat the purchase cycle for each rarity
    -- Want 1000 items? Set RARITY_SETTINGS to 99 and REPEAT_PURCHASES to 11 (99 x 11 = 1089)
    local REPEAT_PURCHASES = {
        common = 1,
        uncommon = 1,
        rare = 1,
        ultra_rare = 1,           -- Will buy 99 copies, 1 time = 99 total
        legendary = 10            -- Will buy 99 copies, 10 times = 990 total
    }
    --==================================================
    --==================== SERVICES ====================
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local HttpService = game:GetService("HttpService")
    local player = Players.LocalPlayer

    --==================== BYPASS ======================
    loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"
    ))()
    task.wait(0.1)
    --==================== REMOTES =====================
    local BuyItemRemote =
        ReplicatedStorage.API["ShopAPI/BuyItem"]
    local ContentPacks =
        ReplicatedStorage.SharedModules.ContentPacks
    --==================== WEBHOOK =====================
    local function sendWebhook(itemName, rarity, amount)
        if DISCORD_WEBHOOK == "" or DISCORD_WEBHOOK == "PUT_WEBHOOK_HERE" then return end
        local payload = {
            username = "Pet Wear Sniper",
            embeds = {{
                title = "🧢 Pet Wear Purchased",
                color = rarity == "legendary" and 16766720 or 
                        rarity == "ultra_rare" and 11141290 or 
                        rarity == "rare" and 3447003 or 
                        rarity == "uncommon" and 8311585 or 
                        8421504,
                fields = {
                    { name = "Item", value = itemName, inline = true },
                    { name = "Rarity", value = rarity, inline = true },
                    { name = "Amount Purchased", value = tostring(amount), inline = true },
                    { name = "Account", value = player.Name, inline = false }
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }
        pcall(function()
            HttpService:PostAsync(
                DISCORD_WEBHOOK,
                HttpService:JSONEncode(payload)
            )
        end)
    end
    --==================== UTIL ========================
    local function collectItems(tbl, out)
        for _, v in pairs(tbl) do
            if type(v) == "table" and v.id and v.rarity then
                out[v.id] = {
                    name = v.name or v.id,
                    rarity = v.rarity
                }
            elseif type(v) == "table" then
                collectItems(v, out)
            end
        end
    end
    --==================== MAIN LOOP ===================
    while true do
        print("🔁 Starting Pet Wear purchase cycle...")
        local items = {}
        for _, pack in ipairs(ContentPacks:GetChildren()) do
            local inv = pack:FindFirstChild("InventorySubDB")
            if inv then
                local petWear = inv:FindFirstChild("PetAccessories")
                if petWear then
                    collectItems(require(petWear), items)
                end
            end
        end
        print("🧢 Pet Wears found:", #items)
        
        for id, data in pairs(items) do
            local buyAmount = RARITY_SETTINGS[data.rarity]
            local repeatTimes = REPEAT_PURCHASES[data.rarity] or 1
            
            -- Check if we should buy this rarity
            if buyAmount and buyAmount > 0 then
                -- Clamp to max of 99
                buyAmount = math.min(buyAmount, 99)
                local totalAmount = buyAmount * repeatTimes
                warn("🎯 FOUND:", data.name, "(" .. data.rarity .. ") - Buying", totalAmount, "copies (", buyAmount, "x", repeatTimes, ")")
                
                -- Repeat the purchase cycle
                for repeat_count = 1, repeatTimes do
                    pcall(function()
                        BuyItemRemote:InvokeServer(
                            "pet_accessories",
                            id,
                            { buy_count = buyAmount }
                        )
                    end)
                end
                
                sendWebhook(data.name, data.rarity, totalAmount)
            end
        end
        
        print("✅ Cycle finished. Waiting 5 minutes...")
        task.wait(LOOP_DELAY)
    end
end)

print("✅ Pet Wear Auto Buyer started in background!")
