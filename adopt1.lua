setthreadidentity(2)
local router = require(game:GetService("ReplicatedStorage").ClientModules.Core.RouterClient.RouterClient)
local cd = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
local furnituresdb = require(game:GetService("ReplicatedStorage").ClientDB.Housing.FurnitureDB)
local texturesdb = require(game:GetService("ReplicatedStorage").ClientDB.Housing.TexturesDB)
local plr = game:GetService("Players").LocalPlayer
setthreadidentity(8)
local le = loadstring(game:HttpGet("https://raw.githubusercontent.com/Davesatcali/game/refs/heads/main/luaencode.lua"))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "House copier",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Adopt me",
   LoadingSubtitle = "by Void",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
if not isfolder("Savedhouses") then makefolder("Savedhouses") end
if #listfiles("Savedhouses") == 0 then writefile("Savedhouses/house0.lua", "") end
local Tab = Window:CreateTab("Main", 4483362458)
local fcount = Tab:CreateLabel("Furnitures count: 0", 4483362458, _, false)
local fcost = Tab:CreateLabel("Furnitures cost: 0", 4483362458, _, false) -- Title, Icon, Color, IgnoreTheme
local tcost = Tab:CreateLabel("Textures cost: 0", 4483362458, _, false) -- Title, Icon, Color, IgnoreTheme
local progress = Tab:CreateLabel("Progress: 0%", 4483362458, _, false)
local housedb = require(game:GetService("ReplicatedStorage").ClientDB.Housing.HouseDB)
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
local function setcosts(furncount, furncost, textcost)
	fcount:Set(tostring("Furnitures count: "..tostring(furncount)), 4483362458, _, false)
    fcost:Set(tostring("Furnitures cost: "..tostring(furncost)), 4483362458, _, false)
    tcost:Set(tostring("Textures cost: "..tostring(textcost)), 4483362458, _, false)
end
local function updateprogress(percent)
    progress:Set(tostring("Progress: "..tostring(percent).."%"), 4483362458, _, false)
end
local function gethousesoftype(housetype)
	local t = {}
	for i, v in listfiles("Savedhouses") do
		if readfile(v) == "" then
			if housetype == "micro_2023" then
				table.insert(t,v)--empty files are inside of micro_2023
			end
			continue
		end
		local str = readfile(v)
		if not str:find("building_type") then continue end
		if str:sub(str:find("building_type")+15, str:find(",", str:find("building_type"))-2) == housetype then
			table.insert(t,v)
		end
	end
	return t
end
local housetypes = {}
for i,v in pairs(housedb) do
	table.insert(housetypes,i)
end
local filename 
local housetype = Tab:CreateDropdown({
    Name = "Select house type",
    Options = housetypes,
    CurrentOption = {"micro_2023"},
    MultipleOptions = false,
    Flag = "ignore",
    Callback = function(Options)
		filename:Refresh(gethousesoftype(Options[1]))
    end,
})
filename = Tab:CreateDropdown({
    Name = "Select house",
    Options = gethousesoftype(housetype.CurrentOption[1]),
    CurrentOption = (gethousesoftype(housetype.CurrentOption[1])[1] and {gethousesoftype(housetype.CurrentOption[1])[1]}),
    MultipleOptions = false,
    Flag = "filename",
    Callback = function(Options)
    end,
})
 local addreplay = Tab:CreateInput({
    Name = "Add house file",
    CurrentValue = "",
    PlaceholderText = "insert house name here",
    RemoveTextAfterFocusLost = false,
    Flag = "addreplay",
    Callback = function(Text)
    if not string.find(Text, "%.lua") then
       if string.find(Text, ".") then
       Text = string.split(Text, ".")[1]
       end
       Text = Text..".lua"
    end
    writefile("Savedhouses/"..Text, "")
    filename:Refresh(gethousesoftype(housetype.CurrentOption))
    end,
 })
local copyhousetofile = Tab:CreateButton({
    Name = "Save house to file",
    Callback = function()
    setthreadidentity(7)
    local house = loadstring("return "..le(cd.get("house_interior")))()
    if house.player == nil then
        Rayfield:Notify({
            Title = "Error",
            Content = "You need to enter a house to copy",
            Duration = 3,
            Image = 4483362458,
        })
        return
    end
    for i,v in pairs(house.furniture) do
        if v.creator then v.creator = nil end
    end
    house.player = nil
    writefile(filename.CurrentOption[1], "return "..le(house))
    Rayfield:Notify({
        Title = "Success",
        Content = "Saved house to file",
        Duration = 3,
        Image = 4483362458,
    })
	filename:Refresh(gethousesoftype(housetype.CurrentOption))
    end
})
local function countfurnitures(furnitures)
    local count = 0
    for i,v in pairs(furnitures) do
        count+=1
    end
    return count
end
local savedhouse
local loadhousefromfile = Tab:CreateButton({
    Name = "Load house from file",
    Callback = function()
        setthreadidentity(7)
        if not filename.CurrentOption or not filename.CurrentOption[1] then
            return Rayfield:Notify({
                Title = "Error",
                Content = "No file selected",
                Duration = 3,
                Image = 4483362458,
            })
        end
        local fileContent = readfile(filename.CurrentOption[1])
        if not fileContent or fileContent == "" then
            return Rayfield:Notify({
                Title = "Error",
                Content = "The selected file is empty",
                Duration = 3,
                Image = 4483362458,
            })
        end
        local success, result = pcall(loadstring(fileContent))
        if not success or type(result) ~= "table" then
            warn(result)
            return Rayfield:Notify({
                Title = "Error",
                Content = "Failed to load house data",
                Duration = 3,
                Image = 4483362458,
            })
        end
        savedhouse = result
        if not savedhouse or type(savedhouse) ~= "table" then
            return Rayfield:Notify({
                Title = "Error",
                Content = "Invalid house data format",
                Duration = 3,
                Image = 4483362458,
            })
        end
        local furnitureCost = 0
        if savedhouse.furniture and type(savedhouse.furniture) == "table" then
            for _, item in pairs(savedhouse.furniture) do
                if furnituresdb[item.id] and furnituresdb[item.id].cost then
                    furnitureCost += furnituresdb[item.id].cost
                end
            end
        end
        local textureCost = 0
        if savedhouse.textures and type(savedhouse.textures) == "table" then
            for _, texture in pairs(savedhouse.textures) do
                if texture.walls and texturesdb.walls[texture.walls] and texturesdb.walls[texture.walls].cost then
                    textureCost += texturesdb.walls[texture.walls].cost
                end
                if texture.floors and texturesdb.floors[texture.floors] and texturesdb.floors[texture.floors].cost then
                    textureCost += texturesdb.floors[texture.floors].cost
                end
            end
        end
        task.spawn(setcosts, countfurnitures(savedhouse.furniture), furnitureCost, textureCost)

        Rayfield:Notify({
            Title = "Success",
            Content = "Successfully loaded house from file",
            Duration = 3,
            Image = 4483362458,
        })
    end
})
local clearhouse = Tab:CreateButton({
    Name = "Clear house",
    Callback = function()
		local t = {}
        for i,v in pairs(cd.get("house_interior").furniture) do
			table.insert(t, i)
        end
		local args = {
                false,
				t,
                "sell"
            }
        router.get("HousingAPI/SellFurniture"):FireServer(unpack(args))
    end
})
local copyhouse = Tab:CreateButton({
    Name = "Save house",
    Callback = function()
    setthreadidentity(7)
    local house = loadstring("return "..le(cd.get("house_interior")))()
    if house.player == nil then
        Rayfield:Notify({
            Title = "Error",
            Content = "You need to enter a house to copy",
            Duration = 3,
            Image = 4483362458,
        })
        return
    end
    savedhouse = house
    for i,v in pairs(savedhouse.furniture) do
        if v.creator then v.creator = nil end
    end
    local furniturecost = 0
    for i,v in pairs(savedhouse.furniture) do
        if not furnituresdb[v.id] then
            continue
        end
        furniturecost += furnituresdb[v.id].cost or 0
    end
    local texturecost = 0
    for i,v in pairs(savedhouse.textures) do
        if not texturesdb.walls[v.walls] then
            continue
        end
        texturecost += texturesdb.walls[v.walls].cost or 0
        if not texturesdb.floors[v.floors] then
            continue
        end
        texturecost += texturesdb.floors[v.floors].cost or 0
    end
    task.spawn(setcosts, countfurnitures(savedhouse.furniture), furniturecost, texturecost)
    Rayfield:Notify({
        Title = "Success",
        Content = "Saved house",
        Duration = 3,
        Image = 4483362458,
    })
    return
    end,
})
local Pastetextures = Tab:CreateToggle({
   Name = "Paste textures",
   CurrentValue = true,
   Flag = "Pastetextures", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   end,
})
local function canbuyfurniture(kind)
    if furnituresdb[kind] == nil or (furnituresdb[kind] and not furnituresdb[kind].cost) or furnituresdb[kind].off_sale then
        return false, false
    end
    return furnituresdb[kind] and furnituresdb[kind].cost < cd.get_data()[plr.Name].money, true
end
local function textureexists(room, texturetype, texture) --texture is texture id and texturetype is wall or floor
    if texture == "tile" then return true end --tile == no texture
    for i,v in pairs(cd.get("house_interior").textures) do
        if i == room and v[texturetype] == texture then
            return true
        end
    end
    return false
end
local function buytexturewithretry(room, texturetype, texture)
    router.get("HousingAPI/BuyTexture"):FireServer(room, texturetype, texture)
    task.wait(0.05)
    if not textureexists(room, texturetype, texture) then
        warn("couldn't buy texture, retrying")
        buytexturewithretry(room, texturetype, texture)
    end
    print("bought texture: "..texture)
end
local function getfurnitureid(v)
	for a,b in pairs(cd.get("house_interior").furniture) do
		if b.id == v.id and (v.cframe.X == b.cframe.X and v.cframe.Y == b.cframe.Y and v.cframe.Z == b.cframe.Z) and v.scale == b.scale then
			return a
		end
	end
end
local placedfurnitures = {}
local function furnitureexists(kind, properties, furnitureid)
    if placedfurnitures[furnitureid] then return true end
    for i,v in pairs(cd.get("house_interior").furniture) do
        if v.id == kind and (v.cframe.X == properties.cframe.X and v.cframe.Y == properties.cframe.Y and v.cframe.Z == properties.cframe.Z) and v.scale == properties.scale then
            placedfurnitures[furnitureid] = true
            return true
        end
    end
    return false
end
local function buyfurniturewithretry(kind,properties,furnitureid)
    router.get("HousingAPI/BuyFurnitures"):InvokeServer({{kind = kind, properties = properties}})
    task.wait(0.05)
    if not furnitureexists(kind, properties, furnitureid) then
        warn("couldn't buy furniture : "..kind.." retrying")
        buyfurniturewithretry(kind,properties,furnitureid)
    end
    print("[DEBUG] successfully bought furniture: "..kind)
end
local function pastehouseslow()
    placedfurnitures = {}
    local character = game:GetService("Players").LocalPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    Rayfield:Notify({
        Title = "Anchoring",
        Content = "Anchoring to prevent falling during paste (glitch houses)",
        Duration = 5,
        Image = 4483362458,
    })
    if humanoidRootPart then
        humanoidRootPart.Anchored = true
    end
    if not savedhouse or not savedhouse.furniture then
        if humanoidRootPart then
            humanoidRootPart.Anchored = false
        end
        return Rayfield:Notify({
            Title = "Error",
            Content = "No house has been saved",
            Duration = 3,
            Image = 4483362458,
        })
    end
    Rayfield:Notify({
        Title = "Loading",
        Content = "Pasting furnitures...",
        Duration = 3,
        Image = 4483362458,
    })
    local validFurniture = {}
    local totalfurnitures = 0
    for i, v in pairs(savedhouse.furniture) do
        if not (string.find(v.id, "lure") and v.id ~= "lures_2023_normal_lure") then
            validFurniture[i] = v
            totalfurnitures += 1
        end
    end
    local processedCount = 0
    for i, v in pairs(validFurniture) do
        local canbuy, exists = canbuyfurniture(v.id)
        if not canbuy and exists == true then
            if humanoidRootPart then
                humanoidRootPart.Anchored = false
            end
            return Rayfield:Notify({
                Title = "Error",
                Content = "Insufficient funds for furniture: "..v.id,
                Duration = 3,
                Image = 4483362458,
            })
        elseif not canbuy and exists == false then
            processedCount += 1
            continue
        end
        if not furnitureexists(v.id, {colors = v.colors, cframe = v.cframe, scale = v.scale}, i) then
            buyfurniturewithretry(v.id, {colors = v.colors, cframe = v.cframe, scale = v.scale}, i)
        end
        processedCount += 1
        task.spawn(updateprogress, math.floor(processedCount / totalfurnitures * 100))
    end
    for i,v in pairs(savedhouse.furniture) do --add text
		if v.text then
			router.get("HousingAPI/ActivateFurniture"):InvokeServer(
				plr,
				getfurnitureid(v),
				"UseBlock",
				v.text,
				plr.Character
			)
		elseif v.outfit_name then
			router.get("AvatarAPI/StartEditingMannequin"):InvokeServer(v.outfit)
			router.get("HousingAPI/ActivateFurniture"):InvokeServer(
				plr,
				getfurnitureid(v),
				"UseBlock",
				{
					save_outfit = true,
					outfit_name = "Outfit"
				},
				plr.Character
			)
		end
	end

    Rayfield:Notify({
        Title = "Loading",
        Content = "Finished furnitures! Applying walls and floors...",
        Duration = 3,
        Image = 4483362458,
    })
    if savedhouse.textures and Pastetextures.CurrentValue then
        for roomId, textureData in pairs(savedhouse.textures) do
            if textureData.floors and not textureexists(roomId, "floors", textureData.floors) then
                buytexturewithretry(roomId, "floors", textureData.floors)
            end
            if textureData.walls and not textureexists(roomId, "walls", textureData.walls) then
                buytexturewithretry(roomId, "walls", textureData.walls)
            end
            task.wait()
        end
    end
	if savedhouse.ambiance then
		router.get("AmbianceAPI/UpdateAmbiance"):FireServer(savedhouse.ambiance)
	end
	if savedhouse.music then
		router.get("RadioAPI/Play"):FireServer(
			savedhouse.music.name,
			savedhouse.music.id
		)
		if not savedhouse.music.playing then
			router.get("RadioAPI/Pause"):InvokeServer()
		end
	end
	if humanoidRootPart then
        humanoidRootPart.Anchored = false
    end
    Rayfield:Notify({
        Title = "Success",
        Content = "House pasted successfully!",
        Duration = 3,
        Image = 4483362458,
    })
end

local function pastehouse()
    placedfurnitures = {}
    local character = plr.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    Rayfield:Notify({
        Title = "Anchoring",
        Content = "Anchoring to prevent falling during paste (glitch houses)",
        Duration = 5,
        Image = 4483362458,
    })
    if humanoidRootPart then
        humanoidRootPart.Anchored = true
    end
    if not savedhouse or not savedhouse.furniture then
        if humanoidRootPart then
            humanoidRootPart.Anchored = false
        end
        return Rayfield:Notify({
            Title = "Error",
            Content = "No house has been saved",
            Duration = 3,
            Image = 4483362458,
        })
    end
    Rayfield:Notify({
        Title = "Loading",
        Content = "Pasting furnitures...",
        Duration = 3,
        Image = 4483362458,
    })
    local validFurniture = {}
    local totalfurnitures = 0
    for i, v in pairs(savedhouse.furniture) do
        if v.id ~= "lures_2023_cozy_home_lure" then
            validFurniture[i] = v
            totalfurnitures += 1
        end
    end
    local processedCount = 0
	local furniturest = {}
    for i, v in pairs(validFurniture) do
        local canbuy, exists = canbuyfurniture(v.id)
        if not canbuy and exists == true then
            if humanoidRootPart then
                humanoidRootPart.Anchored = false
            end
            return Rayfield:Notify({
                Title = "Error",
                Content = "Insufficient funds for furniture: "..v.id,
                Duration = 3,
                Image = 4483362458,
            })
        elseif not canbuy and exists == false then
            processedCount += 1
            continue
        end
		table.insert(furniturest, {kind = v.id, properties = {colors = v.colors, cframe = v.cframe, scale = v.scale}})
        processedCount += 1
    end
	router.get("HousingAPI/BuyFurnitures"):InvokeServer(furniturest)
	task.spawn(updateprogress, math.floor(processedCount / totalfurnitures * 100))
	for i,v in pairs(savedhouse.furniture) do --add text
		if v.text then
			router.get("HousingAPI/ActivateFurniture"):InvokeServer(
				plr,
				getfurnitureid(v),
				"UseBlock",
				v.text,
				plr.Character
			)
		elseif v.outfit_name then
			router.get("AvatarAPI/StartEditingMannequin"):InvokeServer(v.outfit)
			router.get("HousingAPI/ActivateFurniture"):InvokeServer(
				plr,
				getfurnitureid(v),
				"UseBlock",
				{
					save_outfit = true,
					outfit_name = "Outfit"
				},
				plr.Character
			)
		end
	end

    Rayfield:Notify({
        Title = "Loading",
        Content = "Finished furnitures! Applying walls and floors...",
        Duration = 3,
        Image = 4483362458,
    })
    if savedhouse.textures and Pastetextures.CurrentValue then
        for roomId, textureData in pairs(savedhouse.textures) do
            if textureData.floors and not textureexists(roomId, "floors", textureData.floors) then
                buytexturewithretry(roomId, "floors", textureData.floors)
            end
            if textureData.walls and not textureexists(roomId, "walls", textureData.walls) then
                buytexturewithretry(roomId, "walls", textureData.walls)
            end
            task.wait()
        end
    end
	if savedhouse.ambiance then
		router.get("AmbianceAPI/UpdateAmbiance"):FireServer(savedhouse.ambiance)
	end
	if savedhouse.music then
		router.get("RadioAPI/Play"):FireServer(
			savedhouse.music.name,
			savedhouse.music.id
		)
		if not savedhouse.music.playing then
			router.get("RadioAPI/Pause"):InvokeServer()
		end
	end
    if humanoidRootPart then
        humanoidRootPart.Anchored = false
    end
    Rayfield:Notify({
        Title = "Success",
        Content = "House pasted successfully!",
        Duration = 3,
        Image = 4483362458,
    })
end
local function pastehouseinit(slow)
    setthreadidentity(8)
        if savedhouse == nil then
            Rayfield:Notify({
                Title = "Error",
                Content = "No house has been saved",
                Duration = 3,
                Image = 4483362458,
            })
            return
        elseif cd.get("house_interior").player == nil or cd.get("house_interior").player ~= game:GetService("Players").LocalPlayer then
            Rayfield:Notify({
                Title = "Error",
                Content = "Please enter your house to paste the house",
                Duration = 3,
                Image = 4483362458,
            })
        return
        end
        Rayfield:Notify({
            Title = "Loading",
            Content = "Clearing house",
            Duration = 3,
            Image = 4483362458,
        })
        for i,v in pairs(cd.get("house_interior").furniture) do
            local args = {
                true,
                {
                    i
                },
                "sell"
            }
            router.get("HousingAPI/SellFurniture"):FireServer(unpack(args))
        end
        task.wait(0.1)
		if slow then
			task.spawn(pastehouseslow)
			return
		end
        task.spawn(pastehouse)
end
local pastehouse = Tab:CreateButton({
    Name = "Paste house",
    Callback = pastehouseinit
})
local pastehouse = Tab:CreateButton({
    Name = "Paste house slow",
    Callback = function()
		pastehouseinit(true)
	end
})
local Teleport = Window:CreateTab("Teleport", 4483362458)

local function getplayernames()
    local players = game:GetService("Players"):GetPlayers()
    local names = table.create(#players)
    for i, player in ipairs(players) do
        names[i] = player.Name
    end
    return names
end

local selectedplayer = Teleport:CreateDropdown({
    Name = "Select Player",
    Options = getplayernames(),
    CurrentOption = {getplayernames()[1]},
    MultipleOptions = false,
    Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Options)
    -- The function that takes place when the selected option is changed
    -- The variable (Options) is a table of strings for the current selected options
    end,
})
game:GetService("Players").PlayerAdded:Connect(function(player)
    selectedplayer:Refresh(getplayernames())
end)
game:GetService("Players").PlayerRemoving:Connect(function(player)
    selectedplayer:Refresh(getplayernames())
end)
local teleportbutton = Teleport:CreateButton({
    Name = "Enter House",
    Callback = function()
        loadinterior("house", true, game:GetService("Players")[selectedplayer.CurrentOption[1]])
    end,
})
wait(1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(0.1)
-- Define the core function to claim the reward
local function claimReward(tier)
    local args = {
        "house_pets_2025_pass_1",
        tier
    }
    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("BattlePassAPI/ClaimReward"):InvokeServer(unpack(args))
end

-- Main loop to run the script
while true do
    -- Loop from 1 to 20 for the reward tiers
    for i = 1, 20 do
        claimReward(i)
        -- Wait 0.5 seconds before the next claim
        task.wait(0.5)
    end
    -- Wait 30 seconds before starting the cycle again
    task.wait(30)
end
wait(1)
