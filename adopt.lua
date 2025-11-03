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
wait(10)
-- Robust purchase runner with stickers first
--// Load Bypass
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
task.wait(0.2)

local RepStore = game:GetService("ReplicatedStorage")
local ShopRemote = RepStore:WaitForChild("API"):WaitForChild("ShopAPI/BuyItem")

-- CONFIG
local DELAY = 0.1
local CHUNK = 1
local MAX_RETRIES = 5
local BACKOFF_BASE = 0.25

-- Generate fallback category list
local function genCategoryCandidates(cat)
    local candidates = {cat}
    if cat:sub(-1) == "s" then
        table.insert(candidates, cat:sub(1, -2))
    else
        table.insert(candidates, cat .. "s")
    end
    if cat == "strollers" then table.insert(candidates, "stroller") end
    if cat == "gifts" then table.insert(candidates, "gift") end
    if cat == "transport" then table.insert(candidates, "transport_items") end
    local seen, out = {}, {}
    for _,v in ipairs(candidates) do
        if not seen[v] then seen[v] = true; table.insert(out, v) end
    end
    return out
end

-- Core buy with fallbacks
local function safeBuyWithCategoryFallback(origCategory, itemName, count)
    for _, category in ipairs(genCategoryCandidates(origCategory)) do
        local args = { category, itemName, { buy_count = count } }
        local ok, res = pcall(function()
            return ShopRemote:InvokeServer(unpack(args))
        end)
        if ok then
            return true, res, category
        else
            warn(("InvokeServer failed for category '%s': %s"):format(category, tostring(res)))
        end
    end
    return false, "all fallbacks failed", nil
end

-- Retry wrapper
local function safeBuy(category, itemName, count)
    local attempt = 0
    while attempt < MAX_RETRIES do
        attempt += 1
        print(("[Attempt %d] %s -> %s x%d"):format(attempt, category, itemName, count))
        local ok, res, usedCategory = safeBuyWithCategoryFallback(category, itemName, count)
        if ok then
            print(("[OK] %s x%d (category used: %s)"):format(itemName, count, usedCategory))
            return true, res, usedCategory
        else
            warn(("[Retry %d/%d] %s x%d failed: %s"):format(attempt, MAX_RETRIES, itemName, count, tostring(res)))
            task.wait(BACKOFF_BASE * (2 ^ (attempt - 1)))
        end
    end
    return false, "max retries reached", nil
end

-- Chunked buyer
local function buyTotal(category, itemName, total)
    if not total or total <= 0 then return 0 end
    local bought = 0
    while bought < total do
        local toSend = math.min(CHUNK, total - bought)
        local ok = safeBuy(category, itemName, toSend)
        if ok then
            bought += toSend
        else
            warn(("Failed permanently on %s after partial success (%d/%d)"):format(itemName, bought, total))
            break
        end
        task.wait(DELAY)
    end
    return bought
end

-- ITEM DEFINITIONS
local items = {
    -- 1. Stickers FIRST
    gifts = {
        { name = "halloween_2025_sticker_pack", total = 200 },
        { name = "halloween_2025_spider_box", total = 10 },
    },

    -- 2. Then normal shop stuff
    strollers = {
        { name = "halloween_2025_scarebear_stroller", total = 1 },
    },

    transport = {
        { name = "halloween_2025_lava_dragon_bike", total = 1 },
        { name = "halloween_2025_keyboard_skateboard", total = 1 },
    },

    toys = {
        { name = "halloween_2025_keyboard_leash", total = 1 },
        { name = "halloween_2025_noob_voodoo_doll_chew_toy", total = 1 },
        { name = "halloween_2025_slimingo_feather", total = 1 },
        { name = "halloween_2025_skeleton_winged_glider", total = 1 },
        { name = "halloween_2025_fashion_minigame_accessory", total = 1 },
    },

    pet_accessories = {
        { name = "halloween_2025_swamp_mist_wings", total = 1 },
        { name = "halloween_2025_keyboard_necklace", total = 1 },
        { name = "halloween_2025_ghostly_opera_glasses", total = 1 },
        { name = "halloween_2025_spiderweb_coffin_backpack", total = 1 },
    },

    -- 3. Pets (last)
    pets = {
        { name = "halloween_2025_spider", total = 1 },
        { name = "halloween_2025_ghostly_cat", total = 20 },
        { name = "halloween_2025_dj_snooze", total = 12 },
        { name = "halloween_2025_patchy_the_bear", total = 8 },
        { name = "halloween_2025_spider_4", total = 1 },
        { name = "halloween_2025_skelebat", total = 1 },
        { name = "halloween_2025_aye_aye", total = 16 },
        { name = "halloween_2025_phantom_dragon", total = 1 },
        { name = "halloween_2025_cryptid", total = 1 },
        { name = "halloween_2025_spider_5", total = 1 },
        { name = "halloween_2025_black_dog", total = 0 },
        { name = "halloween_2025_spider_2", total = 1 },
        { name = "halloween_2025_bat_cat", total = 1 },
        { name = "halloween_2025_slimingo", total = 1 },

        -- duplicate pet list
        { name = "halloween_2025_spider", total = 0 },
        { name = "halloween_2025_dj_snooze", total = 0 },
        { name = "halloween_2025_patchy_the_bear", total = 0 },
        { name = "halloween_2025_ghostly_cat", total = 20 },
    },
}

-- MAIN EXECUTION
local summary = {}

-- Ensure “gifts” (stickers) run first explicitly
local order = {"gifts", "strollers", "transport", "toys", "pet_accessories", "pets"}

for _, category in ipairs(order) do
    local list = items[category]
    if list then
        print(("=== Category: %s ==="):format(category))
        for _, entry in ipairs(list) do
            if entry.total > 0 then
                print(("Buying %s x%d"):format(entry.name, entry.total))
                local bought = buyTotal(category, entry.name, entry.total)
                summary[entry.name] = (summary[entry.name] or 0) + bought
            else
                print(("Skipping %s (x0)"):format(entry.name))
            end
        end
    end
end

print("===== PURCHASE SUMMARY =====")
for name, amt in pairs(summary) do
    print(name .. " = " .. amt)
end
print("===== ALL DONE =====")
-- Robust purchase runner with stickers first
--// Load Bypass
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
task.wait(0.2)

local RepStore = game:GetService("ReplicatedStorage")
local ShopRemote = RepStore:WaitForChild("API"):WaitForChild("ShopAPI/BuyItem")

-- CONFIG
local DELAY = 0.1
local CHUNK = 1
local MAX_RETRIES = 5
local BACKOFF_BASE = 0.25

-- Generate fallback category list
local function genCategoryCandidates(cat)
    local candidates = {cat}
    if cat:sub(-1) == "s" then
        table.insert(candidates, cat:sub(1, -2))
    else
        table.insert(candidates, cat .. "s")
    end
    if cat == "strollers" then table.insert(candidates, "stroller") end
    if cat == "gifts" then table.insert(candidates, "gift") end
    if cat == "transport" then table.insert(candidates, "transport_items") end
    local seen, out = {}, {}
    for _,v in ipairs(candidates) do
        if not seen[v] then seen[v] = true; table.insert(out, v) end
    end
    return out
end

-- Core buy with fallbacks
local function safeBuyWithCategoryFallback(origCategory, itemName, count)
    for _, category in ipairs(genCategoryCandidates(origCategory)) do
        local args = { category, itemName, { buy_count = count } }
        local ok, res = pcall(function()
            return ShopRemote:InvokeServer(unpack(args))
        end)
        if ok then
            return true, res, category
        else
            warn(("InvokeServer failed for category '%s': %s"):format(category, tostring(res)))
        end
    end
    return false, "all fallbacks failed", nil
end

-- Retry wrapper
local function safeBuy(category, itemName, count)
    local attempt = 0
    while attempt < MAX_RETRIES do
        attempt += 1
        print(("[Attempt %d] %s -> %s x%d"):format(attempt, category, itemName, count))
        local ok, res, usedCategory = safeBuyWithCategoryFallback(category, itemName, count)
        if ok then
            print(("[OK] %s x%d (category used: %s)"):format(itemName, count, usedCategory))
            return true, res, usedCategory
        else
            warn(("[Retry %d/%d] %s x%d failed: %s"):format(attempt, MAX_RETRIES, itemName, count, tostring(res)))
            task.wait(BACKOFF_BASE * (2 ^ (attempt - 1)))
        end
    end
    return false, "max retries reached", nil
end

-- Chunked buyer
local function buyTotal(category, itemName, total)
    if not total or total <= 0 then return 0 end
    local bought = 0
    while bought < total do
        local toSend = math.min(CHUNK, total - bought)
        local ok = safeBuy(category, itemName, toSend)
        if ok then
            bought += toSend
        else
            warn(("Failed permanently on %s after partial success (%d/%d)"):format(itemName, bought, total))
            break
        end
        task.wait(DELAY)
    end
    return bought
end

-- ITEM DEFINITIONS
local items = {
    -- 1. Stickers FIRST
    gifts = {
        { name = "halloween_2025_sticker_pack", total = 0 },
        { name = "halloween_2025_spider_box", total = 5 },
    },

    -- 2. Then normal shop stuff
    strollers = {
        { name = "halloween_2025_scarebear_stroller", total = 1 },
    },

    transport = {
        { name = "halloween_2025_lava_dragon_bike", total = 1 },
        { name = "halloween_2025_keyboard_skateboard", total = 1 },
    },

    toys = {
        { name = "halloween_2025_keyboard_leash", total = 1 },
        { name = "halloween_2025_noob_voodoo_doll_chew_toy", total = 1 },
        { name = "halloween_2025_slimingo_feather", total = 1 },
        { name = "halloween_2025_skeleton_winged_glider", total = 1 },
        { name = "halloween_2025_fashion_minigame_accessory", total = 1 },
    },

    pet_accessories = {
        { name = "halloween_2025_swamp_mist_wings", total = 1 },
        { name = "halloween_2025_keyboard_necklace", total = 1 },
        { name = "halloween_2025_ghostly_opera_glasses", total = 1 },
        { name = "halloween_2025_spiderweb_coffin_backpack", total = 1 },
    },

    -- 3. Pets (last)
    pets = {
        { name = "halloween_2025_spider", total = 1 },
        { name = "halloween_2025_ghostly_cat", total = 20 },
        { name = "halloween_2025_dj_snooze", total = 12 },
        { name = "halloween_2025_patchy_the_bear", total = 8 },
        { name = "halloween_2025_spider_4", total = 1 },
        { name = "halloween_2025_skelebat", total = 1 },
        { name = "halloween_2025_aye_aye", total = 16 },
        { name = "halloween_2025_phantom_dragon", total = 1 },
        { name = "halloween_2025_cryptid", total = 1 },
        { name = "halloween_2025_spider_5", total = 1 },
        { name = "halloween_2025_black_dog", total = 0 },
        { name = "halloween_2025_spider_2", total = 1 },
        { name = "halloween_2025_bat_cat", total = 1 },
        { name = "halloween_2025_slimingo", total = 0 },

        -- duplicate pet list
        { name = "halloween_2025_spider", total = 0 },
        { name = "halloween_2025_dj_snooze", total = 0 },
        { name = "halloween_2025_patchy_the_bear", total = 0 },
        { name = "halloween_2025_ghostly_cat", total = 20 },
    },
}

-- MAIN EXECUTION
local summary = {}

-- Ensure “gifts” (stickers) run first explicitly
local order = {"gifts", "strollers", "transport", "toys", "pet_accessories", "pets"}

for _, category in ipairs(order) do
    local list = items[category]
    if list then
        print(("=== Category: %s ==="):format(category))
        for _, entry in ipairs(list) do
            if entry.total > 0 then
                print(("Buying %s x%d"):format(entry.name, entry.total))
                local bought = buyTotal(category, entry.name, entry.total)
                summary[entry.name] = (summary[entry.name] or 0) + bought
            else
                print(("Skipping %s (x0)"):format(entry.name))
            end
        end
    end
end

print("===== PURCHASE SUMMARY =====")
for name, amt in pairs(summary) do
    print(name .. " = " .. amt)
end
print("===== ALL DONE =====")
wait(1)
-- Robust purchase runner with stickers first
--// Load Bypass
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
task.wait(0.2)

local RepStore = game:GetService("ReplicatedStorage")
local ShopRemote = RepStore:WaitForChild("API"):WaitForChild("ShopAPI/BuyItem")

-- CONFIG
local DELAY = 0.1
local CHUNK = 1
local MAX_RETRIES = 5
local BACKOFF_BASE = 0.25

-- Generate fallback category list
local function genCategoryCandidates(cat)
    local candidates = {cat}
    if cat:sub(-1) == "s" then
        table.insert(candidates, cat:sub(1, -2))
    else
        table.insert(candidates, cat .. "s")
    end
    if cat == "strollers" then table.insert(candidates, "stroller") end
    if cat == "gifts" then table.insert(candidates, "gift") end
    if cat == "transport" then table.insert(candidates, "transport_items") end
    local seen, out = {}, {}
    for _,v in ipairs(candidates) do
        if not seen[v] then seen[v] = true; table.insert(out, v) end
    end
    return out
end

-- Core buy with fallbacks
local function safeBuyWithCategoryFallback(origCategory, itemName, count)
    for _, category in ipairs(genCategoryCandidates(origCategory)) do
        local args = { category, itemName, { buy_count = count } }
        local ok, res = pcall(function()
            return ShopRemote:InvokeServer(unpack(args))
        end)
        if ok then
            return true, res, category
        else
            warn(("InvokeServer failed for category '%s': %s"):format(category, tostring(res)))
        end
    end
    return false, "all fallbacks failed", nil
end

-- Retry wrapper
local function safeBuy(category, itemName, count)
    local attempt = 0
    while attempt < MAX_RETRIES do
        attempt += 1
        print(("[Attempt %d] %s -> %s x%d"):format(attempt, category, itemName, count))
        local ok, res, usedCategory = safeBuyWithCategoryFallback(category, itemName, count)
        if ok then
            print(("[OK] %s x%d (category used: %s)"):format(itemName, count, usedCategory))
            return true, res, usedCategory
        else
            warn(("[Retry %d/%d] %s x%d failed: %s"):format(attempt, MAX_RETRIES, itemName, count, tostring(res)))
            task.wait(BACKOFF_BASE * (2 ^ (attempt - 1)))
        end
    end
    return false, "max retries reached", nil
end

-- Chunked buyer
local function buyTotal(category, itemName, total)
    if not total or total <= 0 then return 0 end
    local bought = 0
    while bought < total do
        local toSend = math.min(CHUNK, total - bought)
        local ok = safeBuy(category, itemName, toSend)
        if ok then
            bought += toSend
        else
            warn(("Failed permanently on %s after partial success (%d/%d)"):format(itemName, bought, total))
            break
        end
        task.wait(DELAY)
    end
    return bought
end

-- ITEM DEFINITIONS
local items = {
    -- 1. Stickers FIRST
    gifts = {
        { name = "halloween_2025_sticker_pack", total = 200 },
        { name = "halloween_2025_spider_box", total = 10 },
    },

    -- 2. Then normal shop stuff
    strollers = {
        { name = "halloween_2025_scarebear_stroller", total = 1 },
    },

    transport = {
        { name = "halloween_2025_lava_dragon_bike", total = 1 },
        { name = "halloween_2025_keyboard_skateboard", total = 1 },
    },

    toys = {
        { name = "halloween_2025_keyboard_leash", total = 1 },
        { name = "halloween_2025_noob_voodoo_doll_chew_toy", total = 1 },
        { name = "halloween_2025_slimingo_feather", total = 1 },
        { name = "halloween_2025_skeleton_winged_glider", total = 1 },
        { name = "halloween_2025_fashion_minigame_accessory", total = 1 },
    },

    pet_accessories = {
        { name = "halloween_2025_swamp_mist_wings", total = 1 },
        { name = "halloween_2025_keyboard_necklace", total = 1 },
        { name = "halloween_2025_ghostly_opera_glasses", total = 1 },
        { name = "halloween_2025_spiderweb_coffin_backpack", total = 1 },
    },

    -- 3. Pets (last)
    pets = {
        { name = "halloween_2025_spider", total = 1 },
        { name = "halloween_2025_ghostly_cat", total = 20 },
        { name = "halloween_2025_dj_snooze", total = 12 },
        { name = "halloween_2025_patchy_the_bear", total = 8 },
        { name = "halloween_2025_spider_4", total = 1 },
        { name = "halloween_2025_skelebat", total = 1 },
        { name = "halloween_2025_aye_aye", total = 16 },
        { name = "halloween_2025_phantom_dragon", total = 1 },
        { name = "halloween_2025_cryptid", total = 1 },
        { name = "halloween_2025_spider_5", total = 1 },
        { name = "halloween_2025_black_dog", total = 0 },
        { name = "halloween_2025_spider_2", total = 1 },
        { name = "halloween_2025_bat_cat", total = 1 },
        { name = "halloween_2025_slimingo", total = 0 },

        -- duplicate pet list
        { name = "halloween_2025_spider", total = 0 },
        { name = "halloween_2025_dj_snooze", total = 0 },
        { name = "halloween_2025_patchy_the_bear", total = 0 },
        { name = "halloween_2025_ghostly_cat", total = 20 },
    },
}

-- MAIN EXECUTION
local summary = {}

-- Ensure “gifts” (stickers) run first explicitly
local order = {"gifts", "strollers", "transport", "toys", "pet_accessories", "pets"}

for _, category in ipairs(order) do
    local list = items[category]
    if list then
        print(("=== Category: %s ==="):format(category))
        for _, entry in ipairs(list) do
            if entry.total > 0 then
                print(("Buying %s x%d"):format(entry.name, entry.total))
                local bought = buyTotal(category, entry.name, entry.total)
                summary[entry.name] = (summary[entry.name] or 0) + bought
            else
                print(("Skipping %s (x0)"):format(entry.name))
            end
        end
    end
end

print("===== PURCHASE SUMMARY =====")
for name, amt in pairs(summary) do
    print(name .. " = " .. amt)
end
print("===== ALL DONE =====")

wait(1)
