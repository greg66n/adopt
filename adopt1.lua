local plr = game:GetService("Players").LocalPlayer

if plr.Character == nil then
    repeat 
        local playbutton = plr:WaitForChild("PlayerGui"):WaitForChild("NewsApp")
            :WaitForChild("EnclosingFrame"):WaitForChild("MainFrame")
            :WaitForChild("Buttons"):WaitForChild("PlayButton")
        
        firesignal(playbutton.MouseButton1Down)
        firesignal(playbutton.MouseButton1Up)
        firesignal(playbutton.MouseButton1Click)
        
        task.wait(2)
    until plr.Character ~= nil
end
wait(0.1)
local soaux = loadstring(game:HttpGet("https://raw.githubusercontent.com/0Void2391/Sulfoxide/refs/heads/main/soaux.lua"))()

local le = loadstring(game:HttpGet("https://github.com/0Void2391/Sulfoxide/raw/refs/heads/main/modules/luaencode.lua"))()

setthreadidentity(2)
local cd = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
local constants = {
	"settings",
	"touch_to_enter",
	"destination_id",
	"current_location",
	"player_about_to_be_unanchored"
}
local func = soaux.searchClosure(game:GetService("ReplicatedStorage").ClientModules.Core.InteriorsM.InteriorsM, "unanchor_and_teleport_player_async", constants)
-- It's important to check if the function was found before attempting to hook it.
if func then
	local old; old = hookfunction(func, function(var)
		if getgenv().teleport == false then
			print("asd")
			return
		end
		return old(var)
	end)
else
	warn("Error: Function 'unanchor_and_teleport_player_async' not found!")
	return -- Stop the script if the function isn't found to avoid further errors.
end
local load = require(game:GetService("ReplicatedStorage").Fsys).load
local interiors = load("InteriorsM")
local enter = interiors.enter
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
for i, v in pairs(game:GetService("Players"):GetPlayers()) do
    task.wait(0.1)
    if v ~= game:GetService("Players").LocalPlayer then
        loadhouse(true, v)
        local blueprint = workspace:WaitForChild("HouseInteriors"):WaitForChild("blueprint"):WaitForChild(v.Name, 5)
        if not blueprint then
            warn("couldn't find house for "..v.Name.." (skipping)")
            continue
        end
        if not game:GetService("Players"):FindFirstChild(v.Name) then
            warn("player left before scan, skipping "..v.Name)
            continue
        end
        local furnitureCount = countfurnitures(cd.get("house_interior").furniture)
        warn(furnitureCount)
        if furnitureCount >= 1000 then
            warn("insane house: "..v.Name)
            warn("furniture quantity: "..furnitureCount)
            warn("building type: "..cd.get("house_interior").building_type)
            local housetable = cd.get("house_interior")
            housetable.player = nil
            writefile("Savedhouses/"..cd.get("house_interior").building_type.."_"..tostring(furnitureCount)..".lua", "return "..le(housetable))
        end
    end
end
warn("finished scanning!")

end
scan()
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId
local LocalPlayer = game:GetService("Players").LocalPlayer

local function serverHop()
    local servers = {}
    local cursor = nil
    local pagesToSkip = 9

    -- Skip the first 9 pages to reach page 10
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

    -- Now fetch the actual 10th page
    setthreadidentity(7)
    local finalUrl = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&cursor=" .. cursor
    local req = game:HttpGet(finalUrl)
    setthreadidentity(2)

    local data = HttpService:JSONDecode(req)

    for _, server in pairs(data.data) do
        if server.playing >= 10 and server.playing <= 40 and server.playing < server.maxPlayers and server.id ~= game.JobId then
            table.insert(servers, server.id)
        end
    end

    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], LocalPlayer)
    else
        warn("No suitable server found on page 10!")
    end
end

-- Run scan and hop
local function start()
    scan()
    task.wait(2)
    serverHop()
end

start()
