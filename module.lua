-- HouseClonerModule
-- Converts the original house cloner script into a reusable module without UI.
-- All Rayfield and UI elements have been removed.
-- House preview is commented out because the required model asset (rbxassetid://112744324160814) is no longer available.

local module = {}

-- Dependencies (require from ReplicatedStorage; ensure the game has these modules)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local AvatarEditorService = game:GetService("AvatarEditorService")
local EncodingService = game:GetService("EncodingService")
local InsertService = game:GetService("InsertService")
local LocalPlayer = Players.LocalPlayer

-- Core client modules (must exist in the game)
local Router = require(ReplicatedStorage.ClientModules.Core.RouterClient.RouterClient)
local ClientData = require(ReplicatedStorage.ClientModules.Core.ClientData)

-- DBs (must exist in the game)
local FurnituresDB = require(ReplicatedStorage.ClientDB.Housing.FurnitureDB)
local TexturesDB = require(ReplicatedStorage.ClientDB.Housing.TexturesDB)
local HouseDB = require(ReplicatedStorage.ClientDB.Housing.HouseDB)

-- External serializer dependency
-- The original script uses 'le' (lua encoder) to serialize tables. You must provide a function that
-- takes a table and returns a string which, when loaded, reproduces the table exactly.
-- The original 'le' can be loaded from:
-- https://gist.githubusercontent.com/0Void2391/1ae255c47f2aadc9211f645bcb15642e/raw/cedfebe7553fba7d428f7d92e59854b3eebf703d/le.lua
-- Set this variable before using any save/load functions.
local le = loadstring(game:HttpGet("https://github.com/chadhyatt/LuaEncode/releases/download/1.4.5/LuaEncode.lua"))()
-- Helper to set thread identity inside functions when needed
local function setThreadIdentity(id)
	pcall(function()
		setthreadidentity(id)
	end)
end

-- ====== FILE / SAVED HOUSES ===========================================
-- Ensure the Savedhouses folder exists
if not isfolder("Savedhouses") then
	makefolder("Savedhouses")
end
if #listfiles("Savedhouses") == 0 then
	writefile("Savedhouses/house0.house", "")
end

function module.listSavedHouseFiles()
	return listfiles("Savedhouses")
end

-- Returns list of filenames that match housetype (special-case for empty files)
function module.getHousesOfType(housetype)
	local results = {}
	for _, path in ipairs(module.listSavedHouseFiles()) do
		local ok, content = pcall(readfile, path)
		if ok then
			-- Decode compressed .house files
			if content ~= "" and not (string.sub(content, 1, 6) == "return") then
				local succ, result = pcall(function()
					return buffer.tostring(EncodingService:DecompressBuffer(EncodingService:Base64Decode(buffer.fromstring(content)), 0))
				end)
				if succ then
					content = result
				end
			end
			if housetype == "All" then
				table.insert(results, path)
			elseif content == "" or string.sub(content, 1, 1) == "\0" and housetype == "micro_2023" then
				table.insert(results, path)
			else
				local value = content:match('building_type%s*=?%s*"?([%w_%-]+)"?')
				if value == housetype then
					table.insert(results, path)
				end
			end
		end
	end
	return results
end

function module.buyHouse(houseType)
	setThreadIdentity(7)
	local Event = ReplicatedStorage.API["HousingAPI/BuyHouseWithAddons"]
	Event:InvokeServer(
		houseType,
		{},
		Color3.new(0.76862746477127, 0.15686275064945, 0.10980392247438)
	)
end

-- ====== INTERIOR LOADER (Teleport) ====================================
function module.enterHouse(playerName)
	setThreadIdentity(2)
	local load = require(ReplicatedStorage.Fsys).load
	local interiors = load("InteriorsM")
	getgenv().teleport = true
	interiors.enter("housing", "MainDoor", {house_owner = playerName})
	setThreadIdentity(8)
end

-- ====== SAVE / LOAD / CLEAR ===========================================
-- Save the current house data to a file (filename should be like "Savedhouses/name.house" or "Savedhouses/name.lua")
function module.saveHouseToFile(filename)
	if not le then
		le = loadstring(game:HttpGet("https://github.com/chadhyatt/LuaEncode/releases/download/1.4.5/LuaEncode.lua"))()
	end
	setThreadIdentity(7)
	local raw = ClientData.get("house_interior")
	local ok, house = pcall(function() return loadstring("return "..le(raw))() end)
	if not ok or type(house) ~= "table" then
		error("You need to enter a house to copy")
	end
	-- Strip creator references to player names
	for _, v in pairs(house.furniture or {}) do
		if v.creator then
			v.creator = v.creator.Name
		end
	end
	house.player = house.player.Name

	-- Write file
	if string.sub(filename, #filename-3, #filename) == ".lua" then
		writefile(filename, "return "..le(house))
	else
		writefile(filename, buffer.tostring(EncodingService:Base64Encode(EncodingService:CompressBuffer(buffer.fromstring("return "..le(house)), 0, 1))))
	end
	return true
end

-- Load house data from a file into module._savedHouse (does not paste)
function module.loadHouseFromFile(filename)
	if not le then
		error("le encoder not set. Call setLE(encoder) first.")
	end
	setThreadIdentity(7)
	local fileContent = readfile(filename)
	if not fileContent or fileContent == "" then
		error("The selected file is empty")
	end
	if string.sub(filename, #filename-5, #filename) == ".house" then
		fileContent = buffer.tostring(EncodingService:DecompressBuffer(EncodingService:Base64Decode(buffer.fromstring(fileContent)), 0))
	end
	local success, result = pcall(loadstring(fileContent))
	if not success or type(result) ~= "table" then
		error("Failed to load house data: " .. tostring(result))
	end

	module._savedHouse = result
	return module._savedHouse
end

-- Load house from a raw link (HTTP get) and store in module._savedHouse
function module.loadHouseFromRawLink(url)
	if not le then
		error("le encoder not set. Call setLE(encoder) first.")
	end
	setThreadIdentity(7)
	local rawText = game:HttpGet(url)
	local success, result = pcall(loadstring(rawText))
	if not success then
		-- Try decompressing if it's Base64+compressed
		success, result = pcall(loadstring(buffer.tostring(EncodingService:DecompressBuffer(EncodingService:Base64Decode(buffer.fromstring(rawText)), 0))))
	end
	if not success or type(result) ~= "table" then
		error("Failed to load house data from link: " .. tostring(result))
	end

	module._savedHouse = result
	return module._savedHouse
end

-- Compute and return total furniture/texture cost of the stored house
function module.getStoredHouseCosts()
	local house = module._savedHouse
	if not house then
		return 0, 0, 0
	end
	local furnCount = 0
	for _ in pairs(house.furniture or {}) do furnCount = furnCount + 1 end

	local furnitureCost = 0
	for _, item in pairs(house.furniture or {}) do
		if FurnituresDB[item.id] and FurnituresDB[item.id].cost then
			furnitureCost = furnitureCost + FurnituresDB[item.id].cost
		end
	end

	local textureCost = 0
	for _, texture in pairs(house.textures or {}) do
		if texture.walls and TexturesDB.walls[texture.walls] and TexturesDB.walls[texture.walls].cost then
			textureCost = textureCost + TexturesDB.walls[texture.walls].cost
		end
		if texture.floors and TexturesDB.floors[texture.floors] and TexturesDB.floors[texture.floors].cost then
			textureCost = textureCost + TexturesDB.floors[texture.floors].cost
		end
	end

	return furnCount, furnitureCost, textureCost
end

-- ====== HOUSE PREVIEW (COMMENTED OUT: requires missing model asset) ======
--[[
local Model -- = InsertService:LoadLocalAsset("rbxassetid://112744324160814")
function module.previewHouse()
	if not Model then
		error("House preview model not loaded (asset missing).")
	end
	local base = workspace.HouseInteriors.blueprint:FindFirstChild(LocalPlayer.Name)
	if not base then
		error("Please enter your house to preview")
	end
	if not module._savedHouse then
		error("No house has been saved")
	end
	local function getfurnituremodel(kind)
		for _, v in ipairs(Model:GetChildren()) do
			if v:GetAttribute("furniture_kind") == kind then
				return v
			end
		end
		return nil
	end
	local function applycolor(instance, color)
		for _, v in ipairs(instance:GetChildren()) do
			if v:IsA("Folder") then
				task.spawn(applycolor, v, color)
			elseif v.Name == "Colorable" then
				v.Color = color
			end
		end
	end
	for _, v in pairs(module._savedHouse.furniture) do
		if not string.find(v.id, "lure") then
			local model = getfurnituremodel(v.id)
			if model then
				model = model:Clone()
				model.Parent = base.Parent.Parent.furniture
				model:ScaleTo(v.scale)
				model:PivotTo(base.WorldPivot:ToWorldSpace(v.cframe))
				applycolor(model, v.colors[1])
			end
		end
	end
end
--]]

-- ====== PASTE UTILS ====================================================
local placedFurnitures = {} -- track placed furniture to avoid duplicates

local function furnitureExists(kind, properties, furnitureId)
	if placedFurnitures[furnitureId] then return true end
	for _, v in pairs(ClientData.get("house_interior").furniture or {}) do
		if v.id == kind and (v.cframe.X == properties.cframe.X and v.cframe.Y == properties.cframe.Y and v.cframe.Z == properties.cframe.Z) and v.scale == properties.scale then
			placedFurnitures[furnitureId] = true
			return true
		end
	end
	return false
end

local function buyFurnitureWithRetry(kind, properties, furnitureId)
	Router.get("HousingAPI/BuyFurnitures"):InvokeServer({{kind = kind, properties = properties}})
	task.wait(0.05)
	if not furnitureExists(kind, properties, furnitureId) then
		warn("couldn't buy furniture: "..kind.." retrying")
		buyFurnitureWithRetry(kind, properties, furnitureId)
	end
end

local function textureExists(room, textureType, texture)
	if texture == "tile" then return true end
	for _, v in pairs(ClientData.get("house_interior").textures or {}) do
		if v[textureType] == texture then
			return true
		end
	end
	return false
end

local function buyTextureWithRetry(room, textureType, texture)
	Router.get("HousingAPI/BuyTexture"):FireServer(room, textureType, texture)
	task.wait(0.05)
	if not textureExists(room, textureType, texture) then
		warn("couldn't buy texture, retrying")
		buyTextureWithRetry(room, textureType, texture)
	end
end

local function canBuyFurniture(kind)
	if FurnituresDB[kind] == nil or (FurnituresDB[kind] and not FurnituresDB[kind].cost) or FurnituresDB[kind].off_sale then
		return false, false
	end
	local money = ClientData.get_data()[LocalPlayer.Name].money
	return FurnituresDB[kind] and FurnituresDB[kind].cost < money, true
end

local function getFurnitureIdFromProps(v)
	for a, b in pairs(ClientData.get("house_interior").furniture or {}) do
		if b.id == v.id and (v.cframe.X == b.cframe.X and v.cframe.Y == b.cframe.Y and v.cframe.Z == b.cframe.Z) and v.scale == b.scale then
			return a
		end
	end
	return nil
end

-- ====== PASTE HOUSE (FAST / SLOW) ======================================
-- Paste the currently stored house (module._savedHouse)
function module.pasteHouseFast()
	if not module._savedHouse then
		error("No house has been saved or loaded.")
	end
	setThreadIdentity(8)
	local currentInterior = ClientData.get("house_interior")
	if currentInterior.player == nil or currentInterior.player ~= LocalPlayer then
		error("Please enter your house to paste the house.")
	end

	-- Clear house first
	local toSell = {}
	for id, _ in pairs(currentInterior.furniture or {}) do
		table.insert(toSell, id)
	end
	if #toSell > 0 then
		Router.get("HousingAPI/SellFurniture"):FireServer(false, toSell, "sell")
	end

	-- Anchor player to prevent glitch falling
	local char = LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then hrp.Anchored = true end

	placedFurnitures = {}
	local savedHouse = module._savedHouse
	local validFurniture = {}
	local total = 0
	for i, v in pairs(savedHouse.furniture) do
		if v.id ~= "lures_2023_cozy_home_lure" then
			validFurniture[i] = v
			total = total + 1
		end
	end

	local batchToBuy = {}
	for i, v in pairs(validFurniture) do
		local canbuy, exists = canBuyFurniture(v.id)
		if not canbuy and exists == true then
			if hrp then hrp.Anchored = false end
			error("Insufficient funds for furniture: "..v.id)
		elseif canbuy then
			table.insert(batchToBuy, {kind = v.id, properties = {colors = v.colors, cframe = v.cframe, scale = v.scale}})
		end
	end

	Router.get("HousingAPI/BuyFurnitures"):InvokeServer(batchToBuy)

	-- Activate text/outfit furnitures
	for i, v in pairs(validFurniture) do
		if v.text then
			Router.get("HousingAPI/ActivateFurniture"):InvokeServer(LocalPlayer, getFurnitureIdFromProps(v), "UseBlock", v.text, LocalPlayer.Character)
		elseif v.outfit_name then
			-- Sanitize outfit assets
			for _, outfitAssetGroup in pairs(v.outfit.assets or {}) do
				if outfitAssetGroup[1] and type(outfitAssetGroup[1]) == "table" then
					for a = #outfitAssetGroup, 1, -1 do
						local b = outfitAssetGroup[a]
						if type(b.asset_id) == "number" and not pcall(AvatarEditorService.GetItemDetails, AvatarEditorService, b.properties.bundle_id or b.asset_id, b.properties.bundle_id and 2 or 1) then
							table.remove(outfitAssetGroup, a)
						end
					end
				else
					for a = #outfitAssetGroup, 1, -1 do
						local b = outfitAssetGroup[a]
						if type(b) == "number" and not pcall(AvatarEditorService.GetItemDetails, AvatarEditorService, b, 1) then
							table.remove(outfitAssetGroup, a)
						end
					end
				end
			end

			Router.get("AvatarAPI/StartEditingMannequin"):InvokeServer(v.outfit)
			Router.get("HousingAPI/ActivateFurniture"):InvokeServer(LocalPlayer, getFurnitureIdFromProps(v), "UseBlock", { save_outfit = true, outfit_name = "Outfit" }, LocalPlayer.Character)
		end
	end

	-- Apply textures
	for roomId, textureData in pairs(savedHouse.textures or {}) do
		if textureData.floors and not textureExists(roomId, "floors", textureData.floors) then
			buyTextureWithRetry(roomId, "floors", textureData.floors)
		end
		if textureData.walls and not textureExists(roomId, "walls", textureData.walls) then
			buyTextureWithRetry(roomId, "walls", textureData.walls)
		end
		task.wait()
	end

	if savedHouse.ambiance then
		Router.get("AmbianceAPI/UpdateAmbiance"):FireServer(savedHouse.ambiance)
	end
	if savedHouse.music then
		Router.get("RadioAPI/Play"):FireServer(savedHouse.music.name, savedHouse.music.id)
		if not savedHouse.music.playing then
			Router.get("RadioAPI/Pause"):InvokeServer()
		end
	end

	if hrp then hrp.Anchored = false end
	return true
end

function module.pasteHouseSlow()
	if not module._savedHouse then
		error("No house has been saved or loaded.")
	end
	setThreadIdentity(8)
	local currentInterior = ClientData.get("house_interior")
	if currentInterior.player == nil or currentInterior.player ~= LocalPlayer then
		error("Please enter your house to paste the house.")
	end

	-- Clear house first
	local toSell = {}
	for id, _ in pairs(currentInterior.furniture or {}) do
		table.insert(toSell, id)
	end
	if #toSell > 0 then
		Router.get("HousingAPI/SellFurniture"):FireServer(false, toSell, "sell")
	end

	local char = LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then hrp.Anchored = true end

	placedFurnitures = {}
	local savedHouse = module._savedHouse
	local validFurniture = {}
	local total = 0
	for i, v in pairs(savedHouse.furniture) do
		if not (string.find(v.id, "lure") and v.id ~= "lures_2023_normal_lure") then
			validFurniture[i] = v
			total = total + 1
		end
	end

	for i, v in pairs(validFurniture) do
		local canbuy, exists = canBuyFurniture(v.id)
		if not canbuy and exists == true then
			if hrp then hrp.Anchored = false end
			error("Insufficient funds for furniture: "..v.id)
		elseif canbuy then
			if not furnitureExists(v.id, {colors = v.colors, cframe = v.cframe, scale = v.scale}, i) then
				buyFurnitureWithRetry(v.id, {colors = v.colors, cframe = v.cframe, scale = v.scale}, i)
			end
		end
	end

	-- Activate text/outfit furnitures
	for i, v in pairs(validFurniture) do
		if v.text then
			Router.get("HousingAPI/ActivateFurniture"):InvokeServer(LocalPlayer, getFurnitureIdFromProps(v), "UseBlock", v.text, LocalPlayer.Character)
		elseif v.outfit_name then
			-- Sanitize outfit assets as in fast paste
			for _, outfitAssetGroup in pairs(v.outfit.assets or {}) do
				if outfitAssetGroup[1] and type(outfitAssetGroup[1]) == "table" then
					for a = #outfitAssetGroup, 1, -1 do
						local b = outfitAssetGroup[a]
						if type(b.asset_id) == "number" and not pcall(AvatarEditorService.GetItemDetails, AvatarEditorService, b.properties.bundle_id or b.asset_id, b.properties.bundle_id and 2 or 1) then
							table.remove(outfitAssetGroup, a)
						end
					end
				else
					for a = #outfitAssetGroup, 1, -1 do
						local b = outfitAssetGroup[a]
						if type(b) == "number" and not pcall(AvatarEditorService.GetItemDetails, AvatarEditorService, b, 1) then
							table.remove(outfitAssetGroup, a)
						end
					end
				end
			end

			Router.get("AvatarAPI/StartEditingMannequin"):InvokeServer(v.outfit)
			Router.get("HousingAPI/ActivateFurniture"):InvokeServer(LocalPlayer, getFurnitureIdFromProps(v), "UseBlock", { save_outfit = true, outfit_name = "Outfit" }, LocalPlayer.Character)
		end
	end

	for roomId, textureData in pairs(savedHouse.textures or {}) do
		if textureData.floors and not textureExists(roomId, "floors", textureData.floors) then
			buyTextureWithRetry(roomId, "floors", textureData.floors)
		end
		if textureData.walls and not textureExists(roomId, "walls", textureData.walls) then
			buyTextureWithRetry(roomId, "walls", textureData.walls)
		end
		task.wait()
	end

	if savedHouse.ambiance then
		Router.get("AmbianceAPI/UpdateAmbiance"):FireServer(savedHouse.ambiance)
	end
	if savedHouse.music then
		Router.get("RadioAPI/Play"):FireServer(savedHouse.music.name, savedHouse.music.id)
		if not savedHouse.music.playing then
			Router.get("RadioAPI/Pause"):InvokeServer()
		end
	end

	if hrp then hrp.Anchored = false end
	return true
end

-- ====== CLEAR ==========================================================
function module.clearHouse()
	setThreadIdentity(7)
	local toSell = {}
	for id, _ in pairs(ClientData.get("house_interior").furniture or {}) do
		table.insert(toSell, id)
	end
	if #toSell > 0 then
		Router.get("HousingAPI/SellFurniture"):FireServer(false, toSell, "sell")
	end
end

function module.clearLures()
	setThreadIdentity(7)
	for i, v in pairs(ClientData.get("house_interior").furniture or {}) do
		if v.lure then
			Router.get("HousingAPI/SellFurniture"):FireServer(false, {i}, "sell")
		end
	end
end

-- ====== SCAN HOUSES =====================================================
-- Scans all players, saves any house with at least minFurnitures furniture
function module.scanHouses(minFurnitures)
	minFurnitures = minFurnitures or 1281
	if not le then
		error("le encoder not set. Call setLE(encoder) first.")
	end
	setThreadIdentity(7)
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			module.enterHouse(player)
			if not Players:FindFirstChild(player.Name) then continue end
			workspace:WaitForChild("HouseInteriors"):WaitForChild("blueprint"):WaitForChild(player.Name)
			local furnitureCount = 0
			for _ in pairs(ClientData.get("house_interior").furniture or {}) do furnitureCount = furnitureCount + 1 end
			if furnitureCount >= minFurnitures then
				local houseTable = ClientData.get("house_interior")
				for _, v in pairs(houseTable.furniture or {}) do
					if v.creator then v.creator = v.creator.Name end
				end
				houseTable.player = houseTable.player.Name
				local filename = "Savedhouses/" .. houseTable.building_type .. "_" .. tostring(furnitureCount) .. ".house"
				writefile(filename, buffer.tostring(EncodingService:Base64Encode(EncodingService:CompressBuffer(buffer.fromstring("return "..le(houseTable)), 0, 1))))
			end
			task.wait(0.1)
		end
	end
end

-- ====== SERVERHOP (after scan) ==========================================
function module.serverhop(scanFirst, minFurnitures)
	minFurnitures = minFurnitures or 1281
	if scanFirst then
		module.scanHouses(minFurnitures)
	end

	local key = getgenv().key or "" -- expects a key variable (if needed by loader)
	local queueScript = string.format([[
		repeat task.wait() until game:IsLoaded()
		local plr = game:GetService("Players").LocalPlayer
		getgenv().key = "%s"
		getgenv().minfurnitures = %s
		repeat task.wait() until game:IsLoaded()
		task.wait(2.5)
		if plr.Character == nil then
			repeat 
				local playbutton = plr.PlayerGui:WaitForChild("NewsApp"):WaitForChild("EnclosingFrame"):WaitForChild("MainFrame"):WaitForChild("Buttons"):WaitForChild("PlayButton")
				firesignal(playbutton.MouseButton1Down)
				firesignal(playbutton.MouseButton1Up)
				firesignal(playbutton.MouseButton1Click)
				task.wait(2)
				if plr.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Visible then
					firesignal(plr.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Info.Response:GetChildren()[8].MouseButton1Down)
					firesignal(plr.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Info.Response:GetChildren()[8].MouseButton1Up)
					firesignal(plr.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Info.Response:GetChildren()[8].MouseButton1Click)
					firesignal(plr.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Buttons.ButtonTemplate.MouseButton1Down)
					firesignal(plr.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Buttons.ButtonTemplate.MouseButton1Up)
					firesignal(plr.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Buttons.ButtonTemplate.MouseButton1Click)
				end
				if plr.PlayerGui.DialogApp.Dialog.SpawnChooserDialog.Visible then
					firesignal(plr.PlayerGui.DialogApp.Dialog.SpawnChooserDialog.UpperCardContainer.ChoicesContent.Choices.Home.Button.MouseButton1Down)
					firesignal(plr.PlayerGui.DialogApp.Dialog.SpawnChooserDialog.UpperCardContainer.ChoicesContent.Choices.Home.Button.MouseButton1Up)
					firesignal(plr.PlayerGui.DialogApp.Dialog.SpawnChooserDialog.UpperCardContainer.ChoicesContent.Choices.Home.Button.MouseButton1Click)
				end
			until not (plr.Character == nil)
		end
		getgenv().serverhop = true
		loadstring(game:HttpGet("https://gist.githubusercontent.com/0Void2391/bb1b9c808a0a8378a71cde863da2f26d/raw/f2d6788c83859e282026e612a36bf794849d393a/loader.lua"))()
	]], key, tostring(minFurnitures))
	queue_on_teleport(queueScript)

	while task.wait(5) do
		local servers = {}
		local succ, req = pcall(game.HttpGet, game, "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
		if succ then
			local body = game:GetService("HttpService"):JSONDecode(req)
			if body and body.data then
				for _, v in ipairs(body.data) do
					if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
						table.insert(servers, 1, v.id)
					end
				end
			end
			if #servers > 0 then
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
			end
		end
	end
end

-- Automatically restart serverhop if getgenv().serverhop is true on script start
if getgenv().serverhop then
	task.spawn(module.serverhop, true, getgenv().minfurnitures or 1281)
end

return module
