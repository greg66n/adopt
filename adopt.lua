loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(0.1)
local heartArgs = {
    [2] = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5,
        [6] = 6,
        [7] = 7,
        [8] = 8,
        [9] = 9,
        [10] = 10,
    }
}

local secondHeartArgs = {
    [2] = {
        [1] = 11,
        [2] = 12,
        [3] = 13,
        [4] = 14,
        [5] = 15,
        [6] = 16,
        [7] = 17,
        [8] = 18,
        [9] = 19,
        [10] = 20,
    }
}

for i = 1, 8 do
    local args = {
        [1] = i,  -- cycling through numbers 1 to 8
    }
    
    -- First call with PickupRose
    game:GetService("ReplicatedStorage").API:FindFirstChild("ValentinesEventAPI/PickupRose"):FireServer(unpack(args))
    wait(0.1)  -- Wait for 1 second
    
    -- Second call with PickupRoseHearts and first heartArgs
    heartArgs[1] = i
    game:GetService("ReplicatedStorage").API:FindFirstChild("ValentinesEventAPI/PickupRoseHearts"):FireServer(unpack(heartArgs))
    wait(0.1)  -- Wait for 1 second

    -- Third call with PickupRoseHearts and secondHeartArgs
    secondHeartArgs[1] = i
    game:GetService("ReplicatedStorage").API:FindFirstChild("ValentinesEventAPI/PickupRoseHearts"):FireServer(unpack(secondHeartArgs))
    wait(0.1)  -- Wait for 1 second
end

wait(0.1)

local args = {
    [1] = "pets",
    [2] = "valentines_2025_love_bird",
    [3] = {
        ["buy_count"] = 1
    }
}

while true do
    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
    wait(5)  -- Wait for 5 seconds before repeating the entire cycle
end
wait(0.1)
Time = 20 -- seconds
repeat wait() until game:IsLoaded()
wait(20)
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
