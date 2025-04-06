getgenv().farmsettings = {
    pet = "Evil Unicorn", --leave blank to automatically select the pet
    babyfarm = true,
    switchpetsongrown = false, --leave false for age potions
    prioritizeeggs = false,
    webhook = "https://discord.com/api/webhooks/1357772344055173170/g1IcjUMlfNHEed4x_yNn36aLeBl8utXO4FtdS82RoDBq0_17IV8-suhn_WHjpVvuLkfx"
}
if getgenv().running then warn("already executed"); return end
getgenv().farmsettings = getgenv().farmsettings or {
    pet = "", --leave blank to automatically select the pet
    babyfarm = true,
    switchpetsongrown = false, --leave false for age potions
    prioritizeeggs = false,
    webhook = ""
}
getgenv().farmsettings.pet = getgenv().farmsettings.pet or ""
getgenv().farmsettings.babyfarm = (getgenv().farmsettings.babyfarm == nil and true) or getgenv().farmsettings.babyfarm
getgenv().farmsettings.switchpetsongrown = (getgenv().farmsettings.switchpetsongrown == nil and false) or getgenv().farmsettings.switchpetsongrown
getgenv().farmsettings.prioritizeeggs = (getgenv().farmsettings.prioritizeeggs == nil and false) or getgenv().farmsettings.prioritizeeggs
repeat task.wait() until game:IsLoaded()
task.wait(2.5)
setthreadidentity(2)
local router = require(game:GetService("ReplicatedStorage").ClientModules.Core.RouterClient.RouterClient)
local cd = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
local petentitymanager = require(game:GetService("ReplicatedStorage").ClientModules.Game.PetEntities.PetEntityManager)
local inventorydb = require(game:GetService("ReplicatedStorage").ClientDB.Inventory.InventoryDB)
local plr = game:GetService("Players").LocalPlayer
local l_load_0 = require(game.ReplicatedStorage.Fsys).load;
local liveopstime = l_load_0("LiveOpsTime");
local le = loadstring(game:HttpGet("https://raw.githubusercontent.com/0Void2391/Sulfoxide/refs/heads/main/modules/luaencode.lua"))()
local function creategui()
    local G2L = {};

    -- StarterGui.ScreenGui
    G2L["1"] = Instance.new("ScreenGui", gethui());
    G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
    G2L["1"]["DisplayOrder"] = 1
    G2L["1"]["ResetOnSpawn"] = false


    -- StarterGui.ScreenGui.Frame
    G2L["2"] = Instance.new("Frame", G2L["1"]);
    G2L["2"]["BorderSizePixel"] = 0;
    G2L["2"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
    G2L["2"]["Size"] = UDim2.new(1, 0, 1, 100);
    G2L["2"]["Position"] = UDim2.new(0, 0, -0.1, 0);
    G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


    -- StarterGui.ScreenGui.Frame.Title
    G2L["3"] = Instance.new("TextLabel", G2L["2"]);
    G2L["3"]["BorderSizePixel"] = 0;
    G2L["3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    G2L["3"]["TextSize"] = 84;
    G2L["3"]["FontFace"] = Font.new([[rbxasset://fonts/families/Zekton.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    G2L["3"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    G2L["3"]["BackgroundTransparency"] = 1;
    G2L["3"]["Size"] = UDim2.new(0, 260, 0, 82);
    G2L["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    G2L["3"]["Text"] = [[Parse]];
    G2L["3"]["Name"] = [[Title]];
    G2L["3"]["Position"] = UDim2.new(0.45, 0, 0.116, 0);


    -- StarterGui.ScreenGui.Frame.Title.Task
    G2L["4"] = Instance.new("TextLabel", G2L["3"]);
    G2L["4"]["BorderSizePixel"] = 0;
    G2L["4"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    G2L["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    G2L["4"]["TextSize"] = 33;
    G2L["4"]["FontFace"] = Font.new([[rbxasset://fonts/families/Zekton.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    G2L["4"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    G2L["4"]["BackgroundTransparency"] = 1;
    G2L["4"]["Size"] = UDim2.new(0, 533, 0, 50);
    G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    G2L["4"]["Text"] = [[Current task: None]];
    G2L["4"]["Name"] = [[Task]];
    G2L["4"]["Position"] = UDim2.new(-0.57227, 0, 2.54878, 0);


    -- StarterGui.ScreenGui.Frame.Title.Money
    G2L["5"] = Instance.new("TextLabel", G2L["3"]);
    G2L["5"]["BorderSizePixel"] = 0;
    G2L["5"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    G2L["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    G2L["5"]["TextSize"] = 33;
    G2L["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/Zekton.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    G2L["5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    G2L["5"]["BackgroundTransparency"] = 1;
    G2L["5"]["Size"] = UDim2.new(0, 533, 0, 50);
    G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    G2L["5"]["Text"] = [[Money farmed: 0]];
    G2L["5"]["Name"] = [[Money]];
    G2L["5"]["Position"] = UDim2.new(-0.57227, 0, 3.15854, 0);


    -- StarterGui.ScreenGui.Frame.Title.Potions
    G2L["6"] = Instance.new("TextLabel", G2L["3"]);
    G2L["6"]["BorderSizePixel"] = 0;
    G2L["6"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    G2L["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    G2L["6"]["TextSize"] = 33;
    G2L["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Zekton.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    G2L["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    G2L["6"]["BackgroundTransparency"] = 1;
    G2L["6"]["Size"] = UDim2.new(0, 533, 0, 50);
    G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    G2L["6"]["Text"] = [[Gained potions: 0]];
    G2L["6"]["Name"] = [[Potions]];
    G2L["6"]["Position"] = UDim2.new(-0.57227, 0, 3.76829, 0);


    -- StarterGui.ScreenGui.Frame.Title.Time
    G2L["7"] = Instance.new("TextLabel", G2L["3"]);
    G2L["7"]["BorderSizePixel"] = 0;
    G2L["7"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    G2L["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    G2L["7"]["TextSize"] = 33;
    G2L["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/Zekton.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    G2L["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    G2L["7"]["BackgroundTransparency"] = 1;
    G2L["7"]["Size"] = UDim2.new(0, 533, 0, 50);
    G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    G2L["7"]["Text"] = [[Time elapsed: 00:00.000]];
    G2L["7"]["Name"] = [[Time]];
    G2L["7"]["Position"] = UDim2.new(-0.57227, 0, 4.37805, 0);


    -- StarterGui.ScreenGui.Frame.Title.Pet
    G2L["8"] = Instance.new("TextLabel", G2L["3"]);
    G2L["8"]["BorderSizePixel"] = 0;
    G2L["8"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    G2L["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
    G2L["8"]["TextSize"] = 33;
    G2L["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/Zekton.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    G2L["8"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
    G2L["8"]["BackgroundTransparency"] = 1;
    G2L["8"]["Size"] = UDim2.new(0, 533, 0, 50);
    G2L["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
    G2L["8"]["Text"] = [[Current pet: None]];
    G2L["8"]["Name"] = [[Pet]];
    G2L["8"]["Position"] = UDim2.new(-0.57227, 0, 1.93902, 0);



    return G2L["1"], require;
end
if plr.Character == nil then
    repeat 
        local playbutton = game:GetService("Players").LocalPlayer.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Buttons.PlayButton
        firesignal(playbutton.MouseButton1Down)
        firesignal(playbutton.MouseButton1Up)
        firesignal(playbutton.MouseButton1Click)
        task.wait(2)
    until not (plr.Character == nil)
end
if getgenv().farmsettings.babyfarm then
    local args = {
        "Babies",
        {
            dont_respawn = true,
            source_for_logging = "avatar_editor"
        }
    }
    router.get("TeamAPI/ChooseTeam"):InvokeServer(unpack(args))
    task.wait(0.2)
end
setthreadidentity(8)
local gui = creategui()
local function getpetkind()
    for i,v in pairs(inventorydb.pets) do
        if getgenv().farmsettings.pet and string.lower(v.name) == string.lower(getgenv().farmsettings.pet) then
            return i
        end
    end
    return ""
end
local function getpetnamefromid(id)
    for i,v in pairs(cd.get("inventory").pets) do
        if i == id then
            return inventorydb.pets[v.kind].name
        end
    end
    return ""
end
local function getpetid()
    local highestage = 0
    local petkind = getpetkind()
    if getgenv().farmsettings.prioritizeeggs == true then
        for i,v in pairs(cd.get("inventory").pets) do
            if inventorydb.pets[v.kind].is_egg then
                return i
            end
        end
    end
    for i,v in pairs(cd.get("inventory").pets) do
        if petkind ~= "" and v.kind == petkind then
            return i
        elseif petkind ~= "" then
            continue
        end
        if v.properties.age == 6 and not getgenv().farmsettings.switchpetsongrown then
            return i
        elseif v.properties.age > highestage and v.properties.age ~= 6 then 
            highestage = v.properties.age
        end
    end
    for i,v in pairs(cd.get("inventory").pets) do
        if highestage == 0 and not (v.kind == "practice_dog") then --0 means that every pet is full grown and switchpetsongrown is true
            return i
        end
        if v.properties.age == highestage and not (v.kind == "practice_dog") then
            return i
        end
    end
end
local function getailments(ailmenttype, pet)
    if ailmenttype == "baby" then
        return cd.get("ailments_manager").baby_ailments or {}
    else
        return cd.get("ailments_manager").ailments[pet] or {}
    end
end
local function getstrollerid()
    for i,v in pairs(cd.get("inventory").strollers) do
        if v.kind == "stroller-default" then
            return i
        end
    end
end
local function getpetchar(pet)
    local f = petentitymanager.get_pet_entity
    for i, v in pairs(debug.getupvalue(f,1)) do
        if v.unique_id == pet.."-"..tostring(plr.UserId) then
            return i
        end
    end
end
local function usestroller(pet)
    router.get("ToolAPI/Equip"):InvokeServer(getstrollerid())
    task.wait(0.1)
    local args = {
        getpetchar(pet),
        plr.Character.StrollerTool.ModelHandle.TouchToSits.TouchToSit
    }
    router.get("AdoptAPI/UseStroller"):InvokeServer(unpack(args))
end
local function unequipstroller(pet)
    router.get("AdoptAPI/EjectBaby"):FireServer(getpetchar(pet))
    router.get("ToolAPI/Unequip"):InvokeServer(getstrollerid())
end
local function randommove()
    plr.Character.Humanoid:MoveTo(plr.Character:WaitForChild("HumanoidRootPart").Position+Vector3.new(-10,0,0))
    task.wait(0.5)
    plr.Character.Humanoid:MoveTo(plr.Character:WaitForChild("HumanoidRootPart").Position+Vector3.new(10,0,0))
    task.wait(0.5)
    plr.Character.Humanoid:MoveTo(plr.Character:WaitForChild("HumanoidRootPart").Position)
end
local function resetpet(pet)
    router.get("ToolAPI/Unequip"):InvokeServer(pet)
    task.wait(0.1)
    router.get("ToolAPI/Equip"):InvokeServer(pet)
end
local function furnitureexists(kind, properties)
    for i,v in pairs(cd.get("house_interior").furniture) do
        if v.id == kind and v.cframe == properties.cframe then
            return true
        end
    end
    return false
end
local function buyfurniturewithretry(id, props)
    local args = {
        {
            {
                properties = props,
                kind = id
            }
        }
    }
    router.get("HousingAPI/BuyFurnitures"):InvokeServer(unpack(args))
    task.wait(0.1)
    if not furnitureexists(id, props) then
        warn("couldn't buy furniture, retrying")
        buyfurniturewithretry(id, props)
    end
end
local function getfurnitures()
    local furnitureids = {
        [1] = "toilet",
        [2] = "modernshower",
        [3] = "ailments_refresh_2024_cheap_food_bowl",
        [4] = "ailments_refresh_2024_cheap_water_bowl",
        [5] = "cheapbathtub",
        [6] = "basiccrib",
    }
    local furnituretoid = {} --["basiccrib"] = "f-1"
    for _,v in pairs(furnitureids) do
        local found = false
        for a,b in pairs(cd.get("house_interior").furniture) do
            if b.id == v then
                furnituretoid[v] = a
                found = true
            end
        end
        if not found then
            buyfurniturewithretry(v, {cframe = CFrame.new(0,0,0)})
            task.wait(0.1)
            for a,b in pairs(cd.get("house_interior").furniture) do
                if b.id == v then
                    furnituretoid[v] = a
                    found = true
                end
            end
        end
    end
    return furnituretoid
end
local function getboneid()
    for i,v in pairs(cd.get("inventory").toys) do
        if v.kind == "squeaky_bone_default" then
            return i
        end
    end
end
local function usebone()
    local args = {
        "__Enum_PetObjectCreatorType_1",
        {
            reaction_name = "ThrowToyReaction",
            unique_id = getboneid()
        }
    }
    router.get("PetObjectAPI/CreatePetObject"):InvokeServer(unpack(args))
end
local function setupteleporthook()
    local soaux = loadstring(game:HttpGet("https://raw.githubusercontent.com/0Void2391/Sulfoxide/refs/heads/main/soaux.lua"))()
    local constants = {
        "settings",
        "touch_to_enter",
        "destination_id",
        "current_location",
        "player_about_to_be_unanchored"
    }
    local func = soaux.searchClosure(game:GetService("ReplicatedStorage").ClientModules.Core.InteriorsM.InteriorsM, "unanchor_and_teleport_player_async", constants)
    local old; old = hookfunction(func, function(var)
        if getgenv().teleport == false then
            return
        end
        return old(var)
    end)
end
local function loadinterior(interiortype, teleport, name) --in case you try to load a house then name is an instance (plr)
    setthreadidentity(2)
    local load = require(game:GetService("ReplicatedStorage").Fsys).load
    local interiors = load("InteriorsM")
    local enter = interiors.enter
    if interiortype == "interior" then 
        getgenv().teleport = teleport
        enter(name, "", {})
        return
    end
    if interiortype == "house" then 
        getgenv().teleport = teleport
        enter("housing", "MainDoor", {house_owner = name})
    end
    setthreadidentity(8)
end
local function usefurniture(furniture, char)
    local furnituretoid = getfurnitures()
    local id = furnituretoid[furniture]
    local args = {
        plr,
        id,   
        furniture == "toilet" and "Seat1" or "UseBlock",
        {
            cframe = plr.Character:WaitForChild("HumanoidRootPart").CFrame
        },
        char
    }
    router.get("HousingAPI/ActivateFurniture"):InvokeServer(unpack(args))
end
local function heal()
    for i,v in pairs(cd.get("house_interior").furniture) do
        if v.id == "doctor" then
            local args = {
                i,
                "UseBlock",
                "Yes",
                plr.Character
            }
            router.get("HousingAPI/ActivateInteriorFurniture"):InvokeServer(unpack(args))
        end
    end
end
local function refillfood()
    loadinterior("interior",false,"PizzaShop")
    task.wait(0.2)
    for i = 1, 20 do
        local args = {
            "f-12",
            "Ham",
            nil,
            game:GetService("Players").LocalPlayer.Character
        }
        router.get("HousingAPI/ActivateInteriorFurniture"):InvokeServer(unpack(args))
    end
end
local function eatfood()
    local ham
    for i,v in pairs(cd.get("inventory").food) do
        if v.kind == "pizza_shop_ham" then
            ham = i
        end
    end
    if ham == nil then
        refillfood()
    end
    for i,v in pairs(cd.get("inventory").food) do
        if v.kind == "pizza_shop_ham" then
            ham = i
        end
    end
    router.get("ToolAPI/ServerUseTool"):FireServer(ham, "START")
    task.wait(0.5)
    router.get("ToolAPI/ServerUseTool"):FireServer(ham, "END")
    task.wait(0.5)
end
local function refillwater()
    loadinterior("interior",false,"PizzaShop")
    task.wait(0.2)
    for i = 1, 20 do
        local args = {
            "f-90",
            "UseBlock",
            nil,
            game:GetService("Players").LocalPlayer.Character
        }
        router.get("HousingAPI/ActivateInteriorFurniture"):InvokeServer(unpack(args))
    end
end
local function drinkwater()
    local water
    for i,v in pairs(cd.get("inventory").food) do
        if v.kind == "water_paper_cup" then
            water = i
        end
    end
    if water == nil then
        refillwater()
    end
    for i,v in pairs(cd.get("inventory").food) do
        if v.kind == "water_paper_cup" then
            water = i
        end
    end
    local args = {
        water,
        "START"
    }
    router.get("ToolAPI/ServerUseTool"):FireServer(unpack(args))
    task.wait(0.5)
    local args = {
        water,
        "END"
    }
    router.get("ToolAPI/ServerUseTool"):FireServer(unpack(args))
    task.wait(0.5)
end
local function solvemystery(pet)
    if not cd.get("ailments_manager").ailments[pet] then return end --check if ailments for pet are still there. if they're not the pet has probably hatched (egg case)
    setthreadidentity(2)
    local v3 = require(game:GetService("ReplicatedStorage").new.modules.Utilities.WeightedRandom);
    local v5 = require(game:GetService("ReplicatedStorage").new.modules.LegacyLoad);
    local v6 = v5("CloudValues");   
    local mh = require(game:GetService("ReplicatedStorage").new.modules.Ailments.Helpers.MysteryHelper)
    local mystery = cd.get("ailments_manager").ailments[pet].mystery
    if not mystery or not mystery.components then return end
    local components = mh.get_action(mystery)
    local seed = components.options.random_seed
    local get_ailment_slots = components.options.get_ailment_slots
    local function get_slot_categories(v11) --[[ Line: 17 ]] --[[ Name: get_slot_categories ]]
        -- upvalues: v6 (copy), v3 (copy)
        local zotti = v6:getValue("ailments", "mysteryAilmentCategoryWeights");
        return v3.get_values(zotti, 3, v11);
    end;
    local skibidi
    for i,v in pairs(getgc(true)) do
        if typeof(v) == "table" then
            if rawget(v, "pet_id") and rawget(v, "player") == game:GetService("Players").LocalPlayer then
                skibidi = v
                break
            end
        end
    end
    return get_ailment_slots(seed,get_slot_categories(seed), skibidi)
end
local function antiafk()
    local GC = getconnections or get_signal_cons
    if GC then
        for i,v in pairs(getconnections(plr.Idled)) do
            if v["Disable"] then
                v["Disable"](v)
            elseif v["Disconnect"] then
                v["Disconnect"](v)
            end
        end
    else
        local VirtualUser = cloneref(game:GetService("VirtualUser"))
        plr.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end
local startautofarm
local function waitforailmentfinish(ailment, callback, ailmenttype, pet)
    local started = tick()
    repeat 
        task.wait()
        if callback then
            callback() 
        end 
    until getailments(ailmenttype, pet)[ailment] == nil or tick()-started >= 50 --handle cases in which it could be stuck
    if tick()-started >= 50 then
        print("[DEBUG] too much time spent on task, restarting")
        task.spawn(startautofarm)
        repeat task.wait() until true == false --make sure current thread cannot resume (can also check difference between last thread and current thread)
    end
end
local ailmentfunctions = {
    ["toilet"] = function(pet)
        loadinterior("house", false, plr)
        resetpet(pet)
        task.wait(0.2)
        task.spawn(usefurniture,"toilet",getpetchar(pet))
        waitforailmentfinish("toilet",nil,"pet",pet)
    end,
    ["hungry"] = function(pet)
        loadinterior("house", false, plr)
        resetpet(pet)
        task.wait(0.2)
        task.spawn(usefurniture,"ailments_refresh_2024_cheap_food_bowl",getpetchar(pet))
        waitforailmentfinish("hungry",nil,"pet",pet)
    end,
    ["sick"] = function(pet,ailmenttype)
        loadinterior("interior", false, "Hospital")
        task.wait(0.3)
        heal()
        waitforailmentfinish("sick",nil,ailmenttype, pet)
    end,
    ["thirsty"] = function(pet)
        loadinterior("house", false, plr)
        resetpet(pet)
        task.wait(0.2)
        task.spawn(usefurniture,"ailments_refresh_2024_cheap_water_bowl",getpetchar(pet))
        waitforailmentfinish("thirsty",nil,"pet",pet)
    end,
    ["sleepy"] = function(pet)
        loadinterior("house", false, plr)
        resetpet(pet)
        task.wait(0.2)
        task.spawn(usefurniture,"basiccrib",getpetchar(pet))
        waitforailmentfinish("sleepy",nil,"pet",pet)
    end,
    ["camping"] = function(pet,ailmenttype)
        local oldpos = plr.Character:WaitForChild("HumanoidRootPart").CFrame
        loadinterior("interior", false, "MainMap")
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(workspace.StaticMap.Campsite.CampsiteOrigin.Position + Vector3.new(0,3,0)) --change
        task.wait(0.2)
        resetpet(pet)
        waitforailmentfinish("camping",nil,ailmenttype,pet)
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = oldpos
    end,
    ["bored"] = function(pet,ailmenttype)
        local oldpos = plr.Character:WaitForChild("HumanoidRootPart").CFrame
        loadinterior("interior", false, "MainMap")
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = workspace.StaticMap.Park.BoredAilmentTarget.CFrame * CFrame.new(0,2,0)
        task.wait(0.2)
        resetpet(pet)
        waitforailmentfinish("bored",nil,ailmenttype,pet)
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = oldpos
    end,
    ["salon"] = function(pet,ailmenttype)
        loadinterior("interior",false,"Salon")
        waitforailmentfinish("salon",nil,ailmenttype,pet)
    end,
    ["play"] = function(pet)
        resetpet(pet)
        waitforailmentfinish("play", function() usebone(); task.wait(3.5) end)
    end,
    ["beach_party"] = function(pet,ailmenttype)
        local oldpos = plr.Character:WaitForChild("HumanoidRootPart").CFrame
        loadinterior("interior", false, "MainMap")
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = workspace.StaticMap.Beach.BeachPartyAilmentTarget.CFrame
        task.wait(0.2)
        resetpet(pet)
        waitforailmentfinish("beach_party",nil,ailmenttype,pet)
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = oldpos
        resetpet(pet)
    end,
    ["ride"] = function(pet)
        resetpet(pet)
        usestroller(pet)
        waitforailmentfinish("ride", randommove, "pet", pet)
        unequipstroller(pet)
    end,
    ["dirty"] = function(pet)
        loadinterior("house",false, plr)
        task.spawn(usefurniture,"modernshower",getpetchar(pet))
        waitforailmentfinish("dirty",nil,"pet",pet)
        resetpet(pet)
    end,
    ["walk"] = function(pet)
        resetpet(pet)
        plr.Character.Humanoid:MoveTo(plr.Character:WaitForChild("HumanoidRootPart").Position+Vector3.new(21,0,0))
        task.wait(1.05)
        waitforailmentfinish("walk", randommove, "pet", pet)
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100,1002,100)
    end,
    ["pet_me"] = function(pet)
        local function complete()
            router.get("AdoptAPI/FocusPet"):FireServer(getpetchar(pet))
            router.get("AvatarAPI/SetPlayerOnPlayerCollision"):FireServer(false)
            router.get("AilmentsAPI/ProgressPetMeAilment"):FireServer(pet)
            router.get("PetAPI/ReplicateActivePerformances"):FireServer(
                getpetchar(pet), {["FocusPet"] = true}
            )
            router.get("PetAPI/ReplicateActivePerformances"):FireServer(
                getpetchar(pet), {
                    ["FocusPet"] = true,
                    ["Petting"] = true,
                    ["Sick"] = true
                }
            )
        end
        waitforailmentfinish("pet_me", complete, "pet",pet) --shouldn't be needed
    end,
    ["school"] = function(pet,ailmenttype)
        loadinterior("interior",false,"School")
        waitforailmentfinish("school",nil,ailmenttype,pet)
    end,
    ["mystery"] = function(pet)
        local solved = solvemystery(pet)
        local randomchoice = math.random(1,3)
        router.get("AilmentsAPI/ChooseMysteryAilment"):FireServer(pet, "mystery",randomchoice,solved[randomchoice])
        waitforailmentfinish("mystery",nil,"pet",pet)
    end,
    ["pizza_party"] = function(pet,ailmenttype)
        loadinterior("interior", false, "PizzaShop")
        waitforailmentfinish("pizza_party",nil,ailmenttype,pet)
    end
}
babyailmentsfunctions = {
    ["hungry"] = function()
        waitforailmentfinish("hungry", eatfood, "baby")
    end,
    ["thirsty"] = function()
        waitforailmentfinish("thirsty", drinkwater, "baby")
    end,
    ["sleepy"] = function()
        loadinterior("house", false, plr)
        task.spawn(usefurniture,"basiccrib", plr.Character)
        waitforailmentfinish("sleepy", nil, "baby")
        router.get("PetAPI/ExitFurnitureUseStates"):InvokeServer()
        router.get("AdoptAPI/ExitSeatStates"):FireServer()
    end,
    ["dirty"] = function()
        loadinterior("house", false, plr)
        task.spawn(usefurniture, "modernshower", plr.Character)
        waitforailmentfinish("dirty", nil, "baby")
        router.get("PetAPI/ExitFurnitureUseStates"):InvokeServer()
        router.get("AdoptAPI/ExitSeatStates"):FireServer()
    end,
}
local function getminigametable()
    for i,v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "join_zone_helper") and v.join_zone_helper.name ~= "Debug Minigame" then
            return v
        end
    end
end
startautofarm = function()
    local minigamet = getminigametable()
    plr.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(100,1002,100)
    task.wait(0.4)
    local oldid = getpetid()
    resetpet(oldid)
    while task.wait() do
        minigamet.is_queued = true
        minigamet.join_zone_helper:update({
            is_in_queue = true
        })
        local pet = getpetid()
        if pet ~= oldid then
            resetpet(pet)
            oldid = pet
        end
        if liveopstime.get_time_until(minigamet.join_zone_helper:get_next_time()) < 15 or minigamet.is_participating then
            local timeelapsed = tick()
            loadinterior("interior", false, "MainMap")
            repeat task.wait() until minigamet.is_participating or tick()-timeelapsed > 10
            if tick()-timeelapsed > 10 then continue end
            task.wait(1)
            gui.Frame.Title.Task.Text = "Current task: blossom minigame"
            for i,v in pairs(workspace.Interiors.BlossomShakedownInterior.Rings:GetChildren()) do
                local args = {
                    [1] = "blossom_shakedown",
                    [2] = "petal_ring_flown_through",
                    [3] = v.Name
                }     
                router.get("MinigameAPI/MessageServer"):FireServer(unpack(args))
            end
            repeat task.wait(1) until not minigamet.is_participating
        end
        local pettext = "Current pet: "..getpetnamefromid(pet)
        setthreadidentity(8)
        gui.Frame.Title.Pet.Text = pettext
        for i,v in pairs(getailments("pet",pet)) do
            task.wait(0.1)
            setthreadidentity(8)
            gui.Frame.Title.Task.Text = "Current task: "..i
            ailmentfunctions[i](pet, "pet")
            setthreadidentity(8)
            gui.Frame.Title.Task.Text = "Current task: None"
        end
        if getgenv().farmsettings.babyfarm then
            for i,v in pairs(getailments("baby")) do
                task.wait(0.1)
                setthreadidentity(8)
                gui.Frame.Title.Task.Text = "Current task: baby "..i
                if not getailments(pet)[i] and not babyailmentsfunctions[i] then --if pet doesn't have that ailment and the baby functio doesn't exist
                    ailmentfunctions[i](nil, "baby")
                elseif babyailmentsfunctions[i] then
                    babyailmentsfunctions[i]()
                end
                setthreadidentity(8)
                gui.Frame.Title.Task.Text = "Current task: None"
            end
        end
    end
end
local function formatTime(elapsedTime)
    local minutes = math.floor(elapsedTime / 60)
    local seconds = math.floor(elapsedTime % 60)
    local milliseconds = math.floor((elapsedTime * 1000) % 1000)
    
    return string.format("%02d:%02d.%03d", minutes, seconds, milliseconds)
end
local function getpotions()
    local count = 0
    for i,v in pairs(cd.get("inventory").food) do
        if v.id == "pet_age_potion" then
            count+=1
        end
    end
    setthreadidentity(8)
    return count
end
local function updategui()
    local starttime = tick()
    local startpotions = getpotions()
    local startmoney = cd.get_data()[plr.Name].money
    while task.wait() do
        setthreadidentity(8)
        gui.Frame.Title.Time.Text = "Time elapsed: "..formatTime(tick()-starttime)
        gui.Frame.Title.Money.Text = "Money farmed: "..cd.get_data()[plr.Name].money - startmoney
        gui.Frame.Title.Potions.Text = "Gained potions: "..getpotions() - startpotions
    end
end
local function webhookpost()
    local starttime = tick()
    if getgenv().farmsettings.webhook ~= "" then
        while task.wait() do
            local content;
            if getgenv().farmsettings['webhook']['pingeveryone'] then
                content = "@everyone"
            end
            if getgenv().farmsettings['webhook']['discordid'] ~= nil then
                content = '<@' .. getgenv().farmsettings['webhook']['discordid'] .. ">"
            end
            if not content then
                content = ""
            end
            local data = {
                ["content"] = "",
                ["tts"] =  false,
                ["embeds"] = {
                    {
                    ["id"] = 652627557,
                    ["title"] = "Autofarm stats",
                    ["description"] = "Current stats about your account:\n",
                    ["color"] = 2326507,
                    ["footer"] = {
                        ["text"] = "made by 0_Void "
                    },
                    ["author"] = {
                        ["name"] = plr.Name,
                        ["url"] = "https://www.roblox.com/users/"..plr.UserId.."/profile",
                        ["icon_url"] = ""
                    },
                    ["thumbnail"] = {
                        ["url"] = ""
                    },
                    ["fields"] = {
                        {
                        ["id"] = 825972658,
                        ["name"] = "Money",
                        ["value"] = cd.get_data()[plr.Name].money,
                        ["inline"] = true
                        },
                        {
                        ["id"] = 290093250,
                        ["name"] = "Age potions",
                        ["value"] = getpotions(),
                        ["inline"] = true
                        },
                        {
                        ["id"] = 964801941,
                        ["name"] =  "Time elapsed",
                        ["value"] = formatTime(tick()-starttime),
                        ["inline"] = true
                        }
                    }
                    }
                },
                ["components"] = {},
                ["actions"] =  {},
                ["username"] = "Autofarm stats",
                ["avatar_url"] = ""
                }
            local newdata = game:GetService("HttpService"):JSONEncode(data)
            
                local headers = {
                ["content-type"] = "application/json"
                }
            request = http_request or request or HttpPost or syn.request
            local abcdef = {Url = getgenv().farmsettings['webhook'], Body = newdata, Method = "POST", Headers = headers}
            request(abcdef)
            task.wait(300)
        end
    end
end
local function init()
    setupteleporthook()
    local baseplate = Instance.new("Part")
    baseplate.Size = Vector3.new(100,2,100)
    baseplate.CFrame = CFrame.new(100,1000,100)
    baseplate.Parent = workspace
    baseplate.Anchored = true
    local gs = game:GetService 'GuiService'
    local teleportservice = cloneref(game:GetService("TeleportService"))
    gs.ErrorMessageChanged:connect(
        function()
        setthreadidentity(8)
            local error_type = gs:GetErrorType()
            if error_type == Enum.ConnectionError.DisconnectErrors then
                print('Detected disconnection! Reconnecting...')
                queue_on_teleport([[
                getgenv().farmsettings = ]]..le(getgenv().farmsettings,{Prettify = true})..[[    
                loadstring(readfile("adoptmeautofarm.txt"))()]])
                while task.wait(5) do
                    teleportservice:Teleport(game.PlaceId, plr)
                end
            end
            setthreadidentity(2)
    end)
    getgenv().running = true
    antiafk()
    task.spawn(updategui)
    task.spawn(webhookpost)
    startautofarm()
end
init()
