-- Adopt Me Zotti Autofarm by 0_Void
getgenv().farmsettings = {
    pet = "2d_tuesdays_2025_2d_kitty", -- Leave blank for auto-select
    babyfarm = true,
    switchpetsongrown = false, -- False for age potions
	prioritizeeggs = false,
	buykeys = false,
    webhook = "",
	gui = false,
}
--writefile("adoptmeautofarm.txt")
if getgenv().running then 
    warn("Script already running")
    return 
end
getgenv().running = true

repeat task.wait() until game:IsLoaded()

-- Set default settings if not provided
getgenv().farmsettings = getgenv().farmsettings or {
    pet = "",
    babyfarm = true,
    switchpetsongrown = false,
    prioritizeeggs = false,
    webhook = "",
	gui = true
}

-- Initialize settings with defaults
getgenv().farmsettings.pet = getgenv().farmsettings.pet or ""
getgenv().farmsettings.babyfarm = getgenv().farmsettings.babyfarm == nil and true or getgenv().farmsettings.babyfarm
getgenv().farmsettings.switchpetsongrown = if getgenv().farmsettings.switchpetsongrown == nil then false else getgenv().farmsettings.switchpetsongrown
getgenv().farmsettings.prioritizeeggs = if getgenv().farmsettings.prioritizeeggs == nil then false else getgenv().farmsettings.prioritizeeggs
getgenv().farmsettings.gui = getgenv().farmsettings.gui == nil and true or getgenv().farmsettings.gui
-- Wait for game to load
repeat task.wait() until game:IsLoaded()
task.wait(2.5)
setthreadidentity(2)
-- Services and modules
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local plr = Players.LocalPlayer
local router = require(ReplicatedStorage.ClientModules.Core.RouterClient.RouterClient)
local cd = require(ReplicatedStorage.ClientModules.Core.ClientData)
local petentitymanager = require(ReplicatedStorage.ClientModules.Game.PetEntities.PetEntityManager)
local inventorydb = require(ReplicatedStorage.ClientDB.Inventory.InventoryDB)
local minigamemanager = require(game:GetService("ReplicatedStorage").ClientModules.Game.MinigameClientManager)
local terrainhelper = require(game:GetService("ReplicatedStorage").SharedModules.TerrainHelper)
local Fsys = require(ReplicatedStorage.Fsys)
local liveopstime = Fsys.load("LiveOpsTime")
local wintertrainnet = require(game:GetService("ReplicatedStorage").SharedModules.ContentPacks.Winter2025.Game.Train.WinterTrainNet) --event
setthreadidentity(8)
if plr.Character == nil then
    repeat 
        local playbutton = game:GetService("Players").LocalPlayer.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Buttons.PlayButton
        firesignal(playbutton.MouseButton1Down)
        firesignal(playbutton.MouseButton1Up)
        firesignal(playbutton.MouseButton1Click)
        task.wait(2)
		if game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Visible then
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Info.Response:GetChildren()[8].MouseButton1Down)
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Info.Response:GetChildren()[8].MouseButton1Up)
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Info.Response:GetChildren()[8].MouseButton1Click)
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Buttons.ButtonTemplate.MouseButton1Down)
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Buttons.ButtonTemplate.MouseButton1Up)
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Buttons.ButtonTemplate.MouseButton1Click)
        end
    until not (plr.Character == nil)
end
-- GUI Creation
local function createGUI()
    local screenGui = Instance.new("ScreenGui", gethui())
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = -1
    screenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.BorderSizePixel = 0
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.Size = UDim2.new(1, 0, 1, 100)
    mainFrame.Position = UDim2.new(0, 0, -0.1, 0)
    mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	mainFrame.Visible = getgenv().farmsettings.gui

    local title = Instance.new("TextLabel", mainFrame)
    title.BorderSizePixel = 0
    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 84
    title.FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(0, 260, 0, 82)
    title.BorderColor3 = Color3.fromRGB(0, 0, 0)
    title.Text = "Zotti autofarm"
    title.Name = "Title"
    title.Position = UDim2.new(0.45, 0, 0.116, 0)

    local labels = {
        {name = "Pet", text = "Current pet: None", position = UDim2.new(-0.57227, 0, 1.93902, 0)},
        {name = "Task", text = "Current task: None", position = UDim2.new(-0.57227, 0, 2.54878, 0)},
        {name = "Money", text = "Money farmed: 0", position = UDim2.new(-0.57227, 0, 3.15854, 0)},
        {name = "Event", text = "No Event", position = UDim2.new(-0.57227, 0, 3.76829, 0)},
        {name = "Potions", text = "Gained potions: 0", position = UDim2.new(-0.57227, 0, 4.37805, 0)},
        {name = "Time", text = "Time elapsed: 00:00.000", position = UDim2.new(-0.57227, 0, 4.9878, 0)}
    }

    for _, labelInfo in ipairs(labels) do
        local label = Instance.new("TextLabel", title)
        label.BorderSizePixel = 0
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 33
        label.FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(0, 533, 0, 50)
        label.BorderColor3 = Color3.fromRGB(0, 0, 0)
        label.Text = labelInfo.text
        label.Name = labelInfo.name
        label.Position = labelInfo.position
    end

    return screenGui
end
local gui = createGUI()
-- Utility Functions
local function formatTime(elapsedTime)
    local minutes = math.floor(elapsedTime / 60)
    local seconds = math.floor(elapsedTime % 60)
    local milliseconds = math.floor((elapsedTime * 1000) % 1000)
    return string.format("%02d:%02d.%03d", minutes, seconds, milliseconds)
end

local function getPetKind()
    for id, petData in pairs(inventorydb.pets) do
        if petData and petData.name and getgenv().farmsettings.pet and string.lower(petData.name) == string.lower(getgenv().farmsettings.pet) then
            return id
        end
    end
    return ""
end

local function getPetNameFromId(id)
    for petId, petData in pairs(cd.get("inventory").pets) do
        if petId == id and inventorydb.pets[petData.kind].name then
            return inventorydb.pets[petData.kind].name
        end
    end
    return ""
end

local function isPetOwner(kind)
    for _, petData in pairs(cd.get("inventory").pets) do
        if petData.kind == kind then
            return true
        end
    end
    return false
end

local function getPetId()
    local highestAge = 0
    local highestFriendship = 0
    local petKind = getPetKind()
    
    -- Prioritize eggs if enabled
    if getgenv().farmsettings.prioritizeeggs then
        for petId, petData in pairs(cd.get("inventory").pets) do
            if inventorydb.pets[petData.kind].is_egg then
                return petId
            end
        end
    end
    if #cd.get("inventory").pets == 1 then
		return next(cd.get("inventory").pets)
	end
    -- Find highest age and friendship levels
    for _, petData in pairs(cd.get("inventory").pets) do
        if petData.properties.age > highestAge and petData.id ~= "practice_dog" then
            highestAge = petData.properties.age
        end
        if petData.properties.friendship_level > highestFriendship then
            highestFriendship = petData.properties.friendship_level
        end
    end
    
    -- Select appropriate pet
    for petId, petData in pairs(cd.get("inventory").pets) do
        if petKind ~= "" and petData.kind == petKind then
            return petId
        elseif petKind ~= "" and isPetOwner(petKind) then
            continue
        end
        
        if highestFriendship > 0 then
            if petData.properties.friendship_level == highestFriendship then
                return petId
            else
                continue
            end
        end
        
        if petData.properties.age == 6 and not getgenv().farmsettings.switchpetsongrown and petData.id ~= "practice_dog" then
            return petId
        elseif highestAge == 0 and petData.id ~= "practice_dog" then -- All pets full grown
            return petId
        elseif highestAge == petData.properties.age and petData.id ~= "practice_dog" then
            return petId
        end
    end
end

local function getAilments(ailmentType, pet)
    if ailmentType == "baby" then
        return cd.get("ailments_manager").baby_ailments or {}
    else
        return cd.get("ailments_manager").ailments[pet] or {}
    end
end

local function getStrollerId()
    for strollerId, strollerData in pairs(cd.get("inventory").strollers) do
        if strollerData.kind == "stroller-default" then
            return strollerId
        end
    end
end

local function getPetChar(pet)
    local petEntities = debug.getupvalue(petentitymanager.get_pet_entity, 1)
    for char, entity in pairs(petEntities) do
        if entity.unique_id == pet.."-"..tostring(plr.UserId) then
            return char
        end
    end
end

local function useStroller(pet)
    router.get("ToolAPI/Equip"):InvokeServer(getStrollerId())
    if not plr.Character:WaitForChild("StrollerTool", 3) then
		useStroller(pet)
		return
	end
    local args = {
		plr,
        getPetChar(pet),
        plr.Character:WaitForChild("StrollerTool").ModelHandle.TouchToSits.TouchToSit
    }
    router.get("AdoptAPI/UseStroller"):InvokeServer(unpack(args))
end

local function unequipStroller(pet)
    router.get("AdoptAPI/EjectBaby"):FireServer(getPetChar(pet))
    router.get("ToolAPI/Unequip"):InvokeServer(getStrollerId())
end

local function randomMove()
    local rootPart = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character.Humanoid:MoveTo(rootPart.Position + Vector3.new(-10, 0, 0))
    task.wait(0.5)
    plr.Character.Humanoid:MoveTo(rootPart.Position + Vector3.new(10, 0, 0))
    task.wait(0.5)
    plr.Character.Humanoid:MoveTo(rootPart.Position)
end

local function resetPet(pet)
	if pet then
		router.get("ToolAPI/Unequip"):InvokeServer(pet)
		task.wait(0.1)
		router.get("ToolAPI/Equip"):InvokeServer(pet)
	end
end

local function furnitureExists(kind, properties)
    for _, furniture in pairs(cd.get("house_interior").furniture) do
        if furniture.id == kind and furniture.cframe == properties.cframe then
            return true
        end
    end
    return false
end

local function buyFurnitureWithRetry(id, props)
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
    if not furnitureExists(id, props) then
        warn("Couldn't buy furniture, retrying")
        buyFurnitureWithRetry(id, props)
    end
end	

local function getFurnitures()
    local furnitureIds = {
        "toilet",
        "modernshower",
        "ailments_refresh_2024_cheap_food_bowl",
        "ailments_refresh_2024_cheap_water_bowl",
        "cheapbathtub",
        "basiccrib",
		"lures_2023_normal_lure",
    }
    
    local furnitureToId = {}
    
    for _, furnitureId in ipairs(furnitureIds) do
        local found = false
        for furnitureDbId, furnitureData in pairs(cd.get("house_interior").furniture) do
            if furnitureData.id == furnitureId then
                furnitureToId[furnitureId] = furnitureDbId
                found = true
                break
            end
        end
        
        if not found then
            buyFurnitureWithRetry(furnitureId, {cframe = CFrame.new(0, 0, 0)})
            task.wait(0.1)
            for furnitureDbId, furnitureData in pairs(cd.get("house_interior").furniture) do
                if furnitureData.id == furnitureId then
                    furnitureToId[furnitureId] = furnitureDbId
                    found = true
                    break
                end
            end
        end
    end
    
    return furnitureToId
end
local function get_items_of_kind(kind, category)
	local items = {}
	for i,v in cd.get("inventory")[category] do
		if v.id == kind then
			table.insert(items, v)
		end
	end
	return items
end
local function getBoneId()
    for toyId, toyData in pairs(cd.get("inventory").toys) do
        if toyData.kind == "squeaky_bone_default" then
            return toyId
        end
    end
end

local function useBone()
    local args = {
        "__Enum_PetObjectCreatorType_1",
        {
            reaction_name = "ThrowToyReaction",
            unique_id = getBoneId()
        }
    }
    router.get("PetObjectAPI/CreatePetObject"):InvokeServer(unpack(args))
end

local function setupTeleportHook()
    local func
    for i,v in getgc() do
        if type(v) == "function" and getfenv(v).script == ReplicatedStorage.ClientModules.Core.InteriorsM.InteriorsM and debug.getinfo(v).name == "unanchor_and_teleport_player_async" then
            func = v
            break
        end
    end
    local old
    old = hookfunction(func, function(var)
        if getgenv().teleport == false then
            return
        end
        return old(var)
    end)
end

local function loadInterior(interiorType, teleport, name)
    setthreadidentity(2)
    local interiors = Fsys.load("InteriorsM")
    local enter = interiors.enter
    
    getgenv().teleport = teleport
    
    if interiorType == "interior" then
		if not workspace.Interiors:GetChildren()[1] or not string.find(workspace.Interiors:GetChildren()[1].Name,name) then
			enter(name, "", {})
		end
    elseif interiorType == "house" then 
		if not workspace.HouseInteriors.blueprint:FindFirstChild(plr.Name) then
        	enter("housing", "MainDoor", {house_owner = name})
		end
    end
    
    setthreadidentity(8)
end

local function useFurniture(furniture, char)
    local furnitureToId = getFurnitures()
    local id = furnitureToId[furniture]
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
    repeat task.wait() until cd.get("house_interior").furniture ~= nil
    for furnitureId, furnitureData in pairs(cd.get("house_interior").furniture) do
        if furnitureData.id == "doctor" then
            local args = {
                furnitureId,
                "UseBlock",
                "Yes",
                plr.Character
            }
            router.get("HousingAPI/ActivateInteriorFurniture"):InvokeServer(unpack(args))
        end
    end
end

local function refillFood()
    loadInterior("interior", false, "PizzaShop")
    task.wait(0.2)
    for _ = 1, 20 do
        local args = {
            "f-12",
            "Ham",
            nil,
            plr.Character
        }
        router.get("HousingAPI/ActivateInteriorFurniture"):InvokeServer(unpack(args))
    end
end

local function eatFood()
    local ham
    for foodId, foodData in pairs(cd.get("inventory").food) do
        if foodData.kind == "pizza_shop_ham" then
            ham = foodId
            break
        end
    end
    
    if not ham then
        refillFood()
        for foodId, foodData in pairs(cd.get("inventory").food) do
            if foodData.kind == "pizza_shop_ham" then
                ham = foodId
                break
            end
        end
    end
    
    router.get("ToolAPI/ServerUseTool"):FireServer(ham, "START")
    task.wait(0.5)
    router.get("ToolAPI/ServerUseTool"):FireServer(ham, "END")
    task.wait(0.5)
end

local function refillWater()
    loadInterior("interior", false, "PizzaShop")
    task.wait(0.2)
    for _ = 1, 20 do
        local args = {
            "f-90",
            "UseBlock",
            nil,
            plr.Character
        }
        router.get("HousingAPI/ActivateInteriorFurniture"):InvokeServer(unpack(args))
    end
end

local function drinkWater()
    local water
    for foodId, foodData in pairs(cd.get("inventory").food) do
        if foodData.kind == "water_paper_cup" then
            water = foodId
            break
        end
    end
    
    if not water then
        refillWater()
        for foodId, foodData in pairs(cd.get("inventory").food) do
            if foodData.kind == "water_paper_cup" then
                water = foodId
                break
            end
        end
    end
    
    router.get("ToolAPI/ServerUseTool"):FireServer(water, "START")
    task.wait(0.5)
    router.get("ToolAPI/ServerUseTool"):FireServer(water, "END")
    task.wait(0.5)
end

local function solveMystery(pet)
    if not cd.get("ailments_manager").ailments[pet] then return end
    
    setthreadidentity(2)
    local WeightedRandom = require(ReplicatedStorage.new.modules.Utilities.WeightedRandom)
    local LegacyLoad = require(ReplicatedStorage.new.modules.LegacyLoad)
    local CloudValues = LegacyLoad("CloudValues")
    local MysteryHelper = require(ReplicatedStorage.new.modules.Ailments.Helpers.MysteryHelper)
    
    local mystery = cd.get("ailments_manager").ailments[pet].mystery
    if not mystery or not mystery.components then return end
    
    local components = MysteryHelper.get_action(mystery)
    local seed = components.options.random_seed
    local get_ailment_slots = components.options.get_ailment_slots
    
    local function get_slot_categories(v11)
        local zotti = CloudValues:getValue("ailments", "mysteryAilmentCategoryWeights")
        return WeightedRandom.get_values(zotti, 3, v11)
    end
    
    local petTable
    for _, v in pairs(getgc(true)) do
        if typeof(v) == "table" and rawget(v, "pet_id") and rawget(v, "player") == plr then
            petTable = v
            break
        end
    end
	local toreturn = get_ailment_slots(seed, get_slot_categories(seed), petTable)
	setthreadidentity(8)
    return toreturn
end

local function antiAFK()
    local GC = getconnections or get_signal_cons
    if GC then
        for _, connection in pairs(getconnections(plr.Idled)) do
            if connection["Disable"] then
                connection["Disable"](connection)
            elseif connection["Disconnect"] then
                connection["Disconnect"](connection)
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
local function getcurrentminigame()
	local currentminigame
	for i,v in pairs(minigamemanager.get_all()) do
		if string.find(i,"::") then
			currentminigame = v
		end
	end
	return currentminigame
end
local function canminigame()
	for i,v in pairs(minigamemanager.get_all()) do
		if v.join_zone_helper and v.join_zone_helper:get_next_time() and liveopstime.get_time_until(v.join_zone_helper:get_next_time()) < 70 or v.is_participating then
			return true
		end
	end
	return false
end
local startAutoFarm
-- Ailment Handling
local function waitForAilmentFinish(ailment, callback, ailmentType, pet)
    local started = tick()
    
    repeat 
        task.wait()
        if callback then callback() end
    until getAilments(ailmentType, pet)[ailment] == nil --[[or canminigame()]] or 
          tick() - started >= 70
	warn("done task", ailment, ailmentType)
    if tick() - started >= 70 then
        print("[DEBUG] Too much time spent on task, restarting")
        task.spawn(startAutoFarm)
        repeat task.wait() until true == false -- Infinite loop to stop current thread
    end
end

local ailmentFunctions = {
    ["toilet"] = function(pet)
        loadInterior("house", false, plr)
        resetPet(pet)
        task.wait(0.2)
        task.spawn(useFurniture, "toilet", getPetChar(pet))
        waitForAilmentFinish("toilet", nil, "pet", pet)
    end,
    
    ["hungry"] = function(pet)
        loadInterior("house", false, plr)
        resetPet(pet)
        task.wait(0.2)
        task.spawn(useFurniture, "ailments_refresh_2024_cheap_food_bowl", getPetChar(pet))
        waitForAilmentFinish("hungry", nil, "pet", pet)
    end,
    
    ["sick"] = function(pet, ailmentType)
        loadInterior("interior", false, "Hospital")
        task.wait(0.5)
        heal()
        waitForAilmentFinish("sick", nil, ailmentType, pet)
    end,
    
    ["thirsty"] = function(pet)
        loadInterior("house", false, plr)
        resetPet(pet)
        task.wait(0.2)
        task.spawn(useFurniture, "ailments_refresh_2024_cheap_water_bowl", getPetChar(pet))
        waitForAilmentFinish("thirsty", nil, "pet", pet)
    end,
    
    ["sleepy"] = function(pet)
        loadInterior("house", false, plr)
        resetPet(pet)
        task.wait(0.2)
        task.spawn(useFurniture, "basiccrib", getPetChar(pet))
        waitForAilmentFinish("sleepy", nil, "pet", pet)
    end,
    
    ["camping"] = function(pet, ailmentType)
        loadInterior("interior", false, "MainMap")
		local targetPos = workspace.StaticMap.Campsite.CampsiteOrigin.Position + Vector3.new(0, 3, 0)
		plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(targetPos)
        task.wait(0.3)
        resetPet(pet)
        waitForAilmentFinish("camping", nil, ailmentType, pet)
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100,1005,100)
    end,
    
    ["bored"] = function(pet, ailmentType)
        loadInterior("interior", false, "MainMap")
        local targetPos = workspace.StaticMap.Park.BoredAilmentTarget.Position + Vector3.new(0, 2, 0)
		plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(targetPos)
        task.wait(0.2)
        resetPet(pet)
        waitForAilmentFinish("bored", nil, ailmentType, pet)
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100,1005,100)
    end,
    
    ["salon"] = function(pet, ailmentType)
        loadInterior("interior", false, "Salon")
        waitForAilmentFinish("salon", nil, ailmentType, pet)
    end,
    
    ["play"] = function(pet)
        resetPet(pet)
        waitForAilmentFinish("play", function() 
            useBone()
            task.wait(6) 
        end, "pet", pet)
    end,
    
    ["beach_party"] = function(pet, ailmentType)
        loadInterior("interior", false, "MainMap")
        local targetPos = workspace.Interiors:WaitForChild("MainMap!Christmas").Buildings.BeachShop.Visual.BeachShopSetDressing:GetPivot().Position
		plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(targetPos)
        task.wait(0.2)
        resetPet(pet)
        waitForAilmentFinish("beach_party", nil, ailmentType, pet)
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100,1005,100)
    end,
    
    ["ride"] = function(pet)
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100, 1005, 100)
        resetPet(pet)
        useStroller(pet)
        waitForAilmentFinish("ride", randomMove, "pet", pet)
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100, 1005, 100)
        unequipStroller(pet)
    end,
    
    ["dirty"] = function(pet)
        loadInterior("house", false, plr)
        task.spawn(useFurniture, "modernshower", getPetChar(pet))
        waitForAilmentFinish("dirty", nil, "pet", pet)
        resetPet(pet)
    end,
    
    ["walk"] = function(pet)
		router.get("AdoptAPI/HoldBaby"):FireServer(
    		getPetChar(pet)
		)
        waitForAilmentFinish("walk", randomMove, "pet", pet)
		router.get("AdoptAPI/EjectBaby"):FireServer(
			getPetChar(pet)
		)
		plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100, 1005, 100)
    end,
    
    ["pet_me"] = function(pet)
        local function complete()
            router.get("AdoptAPI/FocusPet"):FireServer(getPetChar(pet))
            router.get("PetAPI/ReplicateActivePerformances"):FireServer(
                getPetChar(pet),
                {
                    FocusPet = true
                }
            )
            task.wait(0.3)
            router.get("AilmentsAPI/ProgressPetMeAilment"):FireServer(pet)
        end
        waitForAilmentFinish("pet_me", complete, "pet", pet)
    end,
    
    ["school"] = function(pet, ailmentType)
        loadInterior("interior", false, "School")
        waitForAilmentFinish("school", nil, ailmentType, pet)
    end,
    
    ["mystery"] = function(pet)
        local function complete()
            local solved = solveMystery(pet)
            local randomChoice = math.random(1, 3)
            if solved then
                router.get("AilmentsAPI/ChooseMysteryAilment"):FireServer(pet, "mystery", randomChoice, solved[randomChoice])
            end
        end
        waitForAilmentFinish("mystery", complete, "pet", pet)
    end,
    
    ["pizza_party"] = function(pet, ailmentType)
        loadInterior("interior", false, "PizzaShop")
        waitForAilmentFinish("pizza_party", nil, ailmentType, pet)
    end,
    ["ride_the_train"] = function(pet, ailmentType)
        loadInterior("interior", false, "MainMap")
        local valid
        for i,v in pairs(workspace:WaitForChild("WinterTrainSeats"):GetChildren()) do
            if v.Occupant == nil then
                valid = v
                break
            end
        end
        wintertrainnet.EnterCarriageSeat:fire_server({carriage=valid})
        waitForAilmentFinish("ride_the_train", nil, ailmentType, pet)
        router.get("AdoptAPI/ExitSeatStates"):FireServer()
        task.wait(0.1)
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100,1005,100)
    end,   
    ["dance_at_the_disco"] = function(pet, ailmentType)
        loadInterior("interior", false, "MainMap")
        plr.Character.HumanoidRootPart.CFrame = workspace.Interiors:WaitForChild("MainMap!Christmas").DiscoDome.DiscoCenter.CFrame
        resetPet(pet)
        waitForAilmentFinish("dance_at_the_disco", nil, ailmentType, pet)
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100,1005,100)
    end,
    ["ice_skating"] = function(pet, ailmentType)
        loadInterior("interior", false, "MainMap")
        workspace.Interiors:WaitForChild("MainMap!Christmas")
        task.wait(1)
        plr.Character.HumanoidRootPart.CFrame = workspace.Interiors:WaitForChild("MainMap!Christmas").Static.Terrain.Ice:GetChildren()[2].CFrame * CFrame.new(0,10,0)
        resetPet(pet)
        waitForAilmentFinish("ice_skating", nil, ailmentType, pet)
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(100,1005,100)
    end,
}

local babyAilmentsFunctions = {
    ["hungry"] = function()
        waitForAilmentFinish("hungry", eatFood, "baby")
    end,
    
    ["thirsty"] = function()
        waitForAilmentFinish("thirsty", drinkWater, "baby")
    end,
    
    ["sleepy"] = function()
        loadInterior("house", false, plr)
        task.spawn(useFurniture, "basiccrib", plr.Character)
        waitForAilmentFinish("sleepy", nil, "baby")
        router.get("PetAPI/ExitFurnitureUseStates"):InvokeServer()
        router.get("AdoptAPI/ExitSeatStates"):FireServer()
    end,
    
    ["dirty"] = function()
        loadInterior("house", false, plr)
        task.spawn(useFurniture, "modernshower", plr.Character)
        waitForAilmentFinish("dirty", nil, "baby")
        router.get("PetAPI/ExitFurnitureUseStates"):InvokeServer()
        router.get("AdoptAPI/ExitSeatStates"):FireServer()
    end,    
}
local minigamefuncs = { --[minigame name] = function()
}
local function handlelures()
	loadInterior("house", false, plr)
	getFurnitures()
	local bait = get_items_of_kind("ice_dimension_2025_shiver_cone_bait", "food")[1] or get_items_of_kind("ice_dimension_2025_ice_soup_bait", "food")[1]
	local lure = cd.get("house_interior").furniture[getFurnitures()["lures_2023_normal_lure"]]
	if lure.lure and lure.lure.finished and lure.lure.reward then
		router.get("HousingAPI/ActivateFurniture"):InvokeServer(
			plr,
			getFurnitures()["lures_2023_normal_lure"],
			"UseBlock",
			{
				bait_unique = nil
			},
			plr.Character
		)
	end
	if not lure.lure then 
		router.get("HousingAPI/ActivateFurniture"):InvokeServer(
			plr,
			getFurnitures()["lures_2023_normal_lure"],
			"UseBlock",
			{
				bait_unique = bait.unique
			},
			plr.Character
		)
	end
end
local function checkminigame()
	for i,v in pairs(minigamemanager.get_all()) do
		if not string.find(i, "::") and v.join_zone_helper and v.join_zone_helper:get_next_time() and liveopstime.get_time_until(v.join_zone_helper:get_next_time()) < 70 then
			warn("Joining minigame: "..i)
			loadInterior("interior", false, "MainMap")
			v.is_queued = true
			v.join_zone_helper:on_enter()
			v.join_zone_helper:update({is_in_queue = true})
			local timeElapsed = tick()
			repeat 
				task.wait() 
			until (v.is_participating and workspace.Interiors:FindFirstChildWhichIsA("Model") and string.find(workspace.Interiors:FindFirstChildWhichIsA("Model").Name, "::") ) or 
					(tick() - timeElapsed > 100)
			
			if tick() - timeElapsed > 100 then
				continue
			end
			task.wait(1)
			setthreadidentity(8)
			gui.Frame.Title.Task.Text = "Current task: "..i
			minigamefuncs[i](v)
			repeat task.wait() until workspace.Interiors:FindFirstChildWhichIsA("Model") and string.find(workspace.Interiors:FindFirstChildWhichIsA("Model").Name, "MainMap") and not plr.Character.HumanoidRootPart.Anchored
			plr.Character.HumanoidRootPart.Anchored = true
			task.wait(8)
			plr.Character.HumanoidRootPart.Anchored = false
			plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
			plr.Character.HumanoidRootPart.CFrame = CFrame.new(100, 1005, 100)
			local TeamAPIChooseTeam = router.get("TeamAPI/ChooseTeam") -- RemoteFunction 
			pcall(TeamAPIChooseTeam.InvokeServer,
				TeamAPIChooseTeam,
				"Babies",
				{
					dont_respawn = true,
					source_for_logging = "avatar_editor"
				}
			)
		elseif not string.find(i, "::") and v.join_zone_helper and v.join_zone_helper:get_next_time() then
		end
	end
end
-- Main AutoFarm Function
startAutoFarm = function()
    plr.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(100, 1002, 100)
    task.wait(0.4)
    
    local oldPetId = getPetId()
    resetPet(oldPetId)
    for i = 1, 17 do
		if not cd.get("daily_login_manager").claimed_star_rewards["reward_"..i] then
			router.get("DailyLoginAPI/ClaimStarReward"):InvokeServer("reward_"..i)
			break
		end
	end
	router.get("DailyLoginAPI/ClaimDailyReward"):InvokeServer()
    while task.wait() do
        local petId = getPetId()
        router.get("ToolAPI/Equip"):InvokeServer(petId)
        -- Update pet if changed
        if petId ~= oldPetId then
            resetPet(petId)
            oldPetId = petId
        end
        -- Update pet info in GUI
        local petText = "Current pet: " .. getPetNameFromId(petId)
        setthreadidentity(8)
        gui.Frame.Title.Pet.Text = petText
        -- Handle minigame participation
		--checkminigame()
        -- Handle pet ailments
		setthreadidentity(8)
		gui.Frame.Title.Task.Text = "Current task: None"
        for ailment, _ in pairs(getAilments("pet", petId)) do
            task.wait(0.1)
            setthreadidentity(8)
            gui.Frame.Title.Task.Text = "Current task: " .. ailment
            ailmentFunctions[ailment](petId, "pet")
            setthreadidentity(8)
            gui.Frame.Title.Task.Text = "Current task: None"
        end
        
        -- Handle baby ailments if enabled
        if getgenv().farmsettings.babyfarm then
            for ailment, _ in pairs(getAilments("baby")) do
                task.wait(0.1)
                setthreadidentity(8)
                gui.Frame.Title.Task.Text = "Current task: baby " .. ailment
                
                if not getAilments(petId)[ailment] and not babyAilmentsFunctions[ailment] then
                    ailmentFunctions[ailment](nil, "baby")
                elseif babyAilmentsFunctions[ailment] then
                    babyAilmentsFunctions[ailment]()
                end
                
                setthreadidentity(8)
                gui.Frame.Title.Task.Text = "Current task: None"
            end
        end
		handlelures()
    end
end

-- GUI Update Functions
local function getPotions()
    local count = 0
    for _, foodData in pairs(cd.get("inventory").food) do
        if foodData.id == "pet_age_potion" then
            count = count + 1
        end
    end
    setthreadidentity(8)
    return count
end

local function updateGUI()
    local startTime = tick()
    local startPotions = getPotions()
    local startMoney = cd.get_data()[plr.Name].money
    local startEvent = cd.get_data()[plr.Name].cranky_coins_2025
    
    while task.wait() do
		--sorry for this but this is the only way to make it not break
        setthreadidentity(8)
        gui.Frame.Title.Time.Text = "Time elapsed: " .. formatTime(tick() - startTime)
		gui.Frame.Title.Money.Text = "Money farmed: " .. (cd.get_data()[plr.Name].money - startMoney)
		gui.Frame.Title.Potions.Text = "Gained potions: " .. (getPotions() - startPotions)
		gui.Frame.Title.Event.Text = "No event"
		gui.Frame.Visible = getgenv().farmsettings.gui
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
                        ["value"] = cd.get("money"),
                        ["inline"] = true
                        },
                        --[[{
                        ["id"] = 964801941,
                        ["name"] =  "Doubloons",
                        ["value"] = cd.get("cranky_coins_2025"),
                        ["inline"] = true
                        },]]
                        {
                        ["id"] = 290093250,
                        ["name"] = "Age potions",
                        ["value"] = getPotions(),
                        ["inline"] = true
                        },
                        {
                        ["id"] = 964803333,
                        ["name"] =  "Time elapsed",
                        ["value"] = formatTime(tick()-starttime),
                        ["inline"] = true
                        },
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
	if getgenv().farmsettings.babyfarm then
		local TeamAPIChooseTeam = router.get("TeamAPI/ChooseTeam") -- RemoteFunction 
		TeamAPIChooseTeam:InvokeServer(
			"Babies",
			{
				dont_respawn = true,
				source_for_logging = "avatar_editor"
			}
		)
	end
    setupTeleportHook()
    local baseplate = Instance.new("Part")
    baseplate.Size = Vector3.new(100,2,100)
    baseplate.CFrame = CFrame.new(100,1000,100)
    baseplate.Parent = workspace
    baseplate.Anchored = true
    --[=[local gs = game:GetService 'GuiService'
    local teleportservice = cloneref(game:GetService("TeleportService"))
	queue_on_teleport([[
		getgenv().farmsettings = ]]..le(getgenv().farmsettings,{Prettify = true})..[[    
		loadstring(readfile("adoptmeautofarm.txt"))()
	]])
    gs.ErrorMessageChanged:connect(
        function()
        setthreadidentity(8)
            local error_type = gs:GetErrorType()
            if error_type == Enum.ConnectionError.DisconnectErrors then
                print('Detected disconnection! Reconnecting...')
                while task.wait(5) do
                    teleportservice:Teleport(game.PlaceId, plr)
                end
            end
            setthreadidentity(2)
    end)]=]
    getgenv().running = true
    antiAFK()
    task.spawn(updateGUI)
    task.spawn(webhookpost)
	if not (#get_items_of_kind("trade_license", "toys") > 0) then
		loadInterior("interior", true, "SafetyHub")
		router.get("SettingsAPI/SetBooleanFlag"):FireServer(
			"has_talked_to_trade_quest_npc",
			true
		)

		loadInterior("interior", true, "TradeLicenseZone")
		router.get("TradeAPI/BeginQuiz"):FireServer()
		repeat task.wait() until cd.get("trade_license_quiz_manager")
		for i = 1,3 do

			router.get("TradeAPI/AnswerQuizQuestion"):FireServer(
				cd.get("trade_license_quiz_manager").quiz[i].answer
			)
		end
	end
    startAutoFarm()
end
init()
