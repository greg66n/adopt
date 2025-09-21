local soaux = loadstring(game:HttpGet("https://raw.githubusercontent.com/0Void2391/Sulfoxide/refs/heads/main/soaux.lua"))()
local le = loadstring(game:HttpGet("https://github.com/0Void2391/Sulfoxide/raw/refs/heads/main/modules/luaencode.lua"))()
local plr = game:GetService("Players").LocalPlayer
setthreadidentity(2)
if plr.Character == nil then
    repeat 
        local playbutton = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("NewsApp").EnclosingFrame.MainFrame.Buttons.PlayButton
        firesignal(playbutton.MouseButton1Down)
        firesignal(playbutton.MouseButton1Up)
        firesignal(playbutton.MouseButton1Click)
        task.wait(2)
    until not (plr.Character == nil)
end
local cd = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
local constants = {
    "settings",
    "touch_to_enter",
    "destination_id",
    "current_location",
    "player_about_to_be_unanchored"
}
local func = soaux.searchClosure(game:GetService("ReplicatedStorage").ClientModules.Core.InteriorsM.InteriorsM, "unanchor_and_teleport_player_async", constants)
if isfunctionhooked(func) then
	restorefunction(func)
end
local old; old = hookfunction(func, function(var)
    if getgenv().teleport == false then
        print("asd")
        return
    end
    return old(var)
 end)
local load = require(game:GetService("ReplicatedStorage").Fsys).load
local interiors = load("InteriorsM")
local enter = interiors.enter
local furnituresdb = require(game:GetService("ReplicatedStorage").ClientDB.Housing.FurnitureDB)
local function loadhouse(teleport, player)
getgenv().teleport = teleport
task.spawn(enter, "housing", "MainDoor", {house_owner = player})
end
local function countfurnitures(furnitures)
    local count = 0
    for i,v in pairs(furnitures) do
        count+=1
    end
    return count
end
local function scan()
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
    task.wait(0.1)
    if v~=game:GetService("Players").LocalPlayer then
        loadhouse(true, v)
        if not game:GetService("Players"):FindFirstChild(v.Name) then warn("couldn't find player (left), skibidi") continue end
        workspace:WaitForChild("HouseInteriors"):WaitForChild("blueprint"):WaitForChild(v.Name, 10)
        if not workspace:WaitForChild("HouseInteriors"):WaitForChild("blueprint"):FindFirstChild(v.Name) then 
			continue
		end
		warn(countfurnitures(cd.get("house_interior").furniture))
        if countfurnitures(cd.get("house_interior").furniture) >= 1000 then
            warn("insane house: "..v.Name)
            warn("furniture quantity: "..countfurnitures(cd.get("house_interior").furniture))
            warn("building type: "..cd.get("house_interior").building_type)
            local housetable = cd.get("house_interior")
            housetable.player = housetable.player.Name
			for i,v in pairs(housetable.furniture) do
				if v.creator then v.creator = nil end
			end
			local furnitureCost = 0
			if housetable.furniture and type(housetable.furniture) == "table" then
				for _, item in pairs(housetable.furniture) do
					if furnituresdb[item.id] and furnituresdb[item.id].cost then
						furnitureCost += furnituresdb[item.id].cost
					end
				end
			end
			local furniturecount = countfurnitures(housetable)
			local date = string.gsub(os.date("%x"), "/", "")
            writefile("Savedhouses/"..housetable.building_type.."_"..furniturecount.."_"..furnitureCost.."_"..date.."_"..housetable.player..".lua", "return "..le(housetable))
        end
    end
end
warn("finished scanning!")
end
scan()

-- Server hopping
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId
local LocalPlayer = plr

local function serverHop()
    local servers = {}
    local cursor = nil
    local pagesToSkip = 9

    for i = 1, pagesToSkip do
        setthreadidentity(7)
        local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
        if cursor then
            url = url .. "&cursor=" .. cursor
        end
        local req = game:HttpGet(url)
        setthreadidentity(2)

        local data = HttpService:JSONDecode(req)
        if not data.nextPageCursor then
            warn("Reached end of server list before page 10")
            return
        end
        cursor = data.nextPageCursor
    end

    setthreadidentity(7)
    local finalUrl = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&cursor=" .. cursor
    local req = game:HttpGet(finalUrl)
    setthreadidentity(2)

    local data = HttpService:JSONDecode(req)

    for _, server in pairs(data.data) do
        if server.playing >= 10 and server.playing <= 31 and server.playing < server.maxPlayers and server.id ~= game.JobId then
            table.insert(servers, server.id)
        end
    end

    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], LocalPlayer)
    else
        warn("No suitable server found on page 10!")
    end
end

-- Run it all
local function start()
    scan()
    task.wait(2)
    serverHop()
end

start()
