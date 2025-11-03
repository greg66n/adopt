
f plr.Character == nil then
    repeat 
        local playbutton = game:GetService("Players").LocalPlayer.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Buttons.PlayButton
        firesignal(playbutton.MouseButton1Down)
        firesignal(playbutton.MouseButton1Up)
        firesignal(playbutton.MouseButton1Click)
        task.wait(2)
    until not (plr.Character == nil)
if getgenv()._purchaseRunnerStarted then return end
getgenv()._purchaseRunnerStarted = true

--// Load Bypass once
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
end)
task.wait(0.25)

local RepStore = game:GetService("ReplicatedStorage")
local ShopRemote = RepStore:WaitForChild("API"):WaitForChild("ShopAPI/BuyItem")

local DELAY, CHUNK, MAX_RETRIES, BACKOFF_BASE = 0.1, 1, 5, 0.25

-- Build safe category fallbacks
local function genCategoryCandidates(cat)
    local out = {cat}
    if cat:sub(-1) == "s" then table.insert(out, cat:sub(1, -2)) else table.insert(out, cat.."s") end
    if cat=="strollers" then table.insert(out,"stroller") end
    if cat=="gifts" then table.insert(out,"gift") end
    if cat=="transport" then table.insert(out,"transport_items") end
    local uniq,final={},{}
    for _,v in ipairs(out) do if not uniq[v] then uniq[v]=true table.insert(final,v) end end
    return final
end

-- Safe single buy
local function safeBuy(category,item,count)
    for _,cat in ipairs(genCategoryCandidates(category)) do
        local ok,res = pcall(function()
            return ShopRemote:InvokeServer(cat,item,{buy_count=count})
        end)
        if ok then
            print(("[OK] %s x%d via %s"):format(item,count,cat))
            return true
        else
            warn(("Failed for %s via %s: %s"):format(item,cat,tostring(res)))
        end
    end
    return false
end

-- Chunked total purchase with retry/backoff
local function buyTotal(category,item,total)
    local bought = 0
    for attempt = 1, MAX_RETRIES do
        while bought < total do
            local toSend = math.min(CHUNK,total-bought)
            local ok = safeBuy(category,item,toSend)
            if ok then
                bought += toSend
            else
                warn(("Retrying %s (%d/%d) after fail"):format(item,attempt,MAX_RETRIES))
                task.wait(BACKOFF_BASE*(2^(attempt-1)))
            end
            task.wait(DELAY)
        end
        if bought >= total then break end
    end
    return bought
end

-- Items list
local items = {
    gifts = {
        {name="halloween_2025_sticker_pack",total=200},
        {name="halloween_2025_spider_box",total=10},
    },
    strollers = {
        {name="halloween_2025_scarebear_stroller",total=1},
    },
    transport = {
        {name="halloween_2025_lava_dragon_bike",total=1},
        {name="halloween_2025_keyboard_skateboard",total=1},
    },
    toys = {
        {name="halloween_2025_keyboard_leash",total=1},
        {name="halloween_2025_noob_voodoo_doll_chew_toy",total=1},
        {name="halloween_2025_slimingo_feather",total=1},
        {name="halloween_2025_skeleton_winged_glider",total=1},
        {name="halloween_2025_fashion_minigame_accessory",total=1},
    },
    pet_accessories = {
        {name="halloween_2025_swamp_mist_wings",total=1},
        {name="halloween_2025_keyboard_necklace",total=1},
        {name="halloween_2025_ghostly_opera_glasses",total=1},
        {name="halloween_2025_spiderweb_coffin_backpack",total=1},
    },
    pets = {
        {name="halloween_2025_spider",total=1},
        {name="halloween_2025_ghostly_cat",total=20},
        {name="halloween_2025_dj_snooze",total=12},
        {name="halloween_2025_patchy_the_bear",total=8},
        {name="halloween_2025_spider_4",total=1},
        {name="halloween_2025_skelebat",total=1},
        {name="halloween_2025_aye_aye",total=16},
        {name="halloween_2025_phantom_dragon",total=1},
        {name="halloween_2025_cryptid",total=1},
        {name="halloween_2025_spider_5",total=1},
        {name="halloween_2025_spider_2",total=1},
        {name="halloween_2025_bat_cat",total=1},
        {name="halloween_2025_slimingo",total=0},
        {name="halloween_2025_spider",total=0},
        {name="halloween_2025_dj_snooze",total=0},
        {name="halloween_2025_patchy_the_bear",total=0},
        {name="halloween_2025_ghostly_cat",total=20},
    }
}

-- Execution order (stickers first)
local order = {"gifts","strollers","transport","toys","pet_accessories","pets"}
for _,cat in ipairs(order) do
    for _,item in ipairs(items[cat]) do
        if item.total>0 then
            print(("Buying %s x%d"):format(item.name,item.total))
            buyTotal(cat,item.name,item.total)
        else
            print(("Skipping %s (x0)"):format(item.name))
        end
    end
end
print("==== PURCHASE RUNNER COMPLETE ====")
----------------------------------------------------------
-- Finished cleanly, other scripts can now continue
----------------------------------------------------------

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

