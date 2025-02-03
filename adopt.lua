task.spawn(function()
    task.wait(35)
    getgenv().API_KEY = "RukIIrukYPFoGnQUcD7c"
    loadstring(game:HttpGet("http://ii.sebas.sbs:4241/adoptme/dashboard.lua"))()
end)

task.spawn(function()
    script_key="NxzplPKcRYahKMvLcZtfTAOQURrRclwP";
getgenv().Config = {
    ["PetFarmAutoSwitchFullGrown"] = false,
    ["PetFarmActive"] = true,
    ["EggFarmActive"] = false,
    ["Blur_username"] = false,
    ["Blazing_Lion_Log"] = false,
    ["DiscordId"] = "942321951010086922",
    ["Webhook"] = "https://discord.com/api/webhooks/123456",
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/66567bfd337b57eb059b58dbe1badb89.lua"))()-- add other scripts here
end)
wait(1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(1)
local locations = {"MainMap"}

for _, location in ipairs(locations) do
    for i = 1, 100 do
        local args = {
            [1] = location,
            [2] = tostring(i)
        }
        game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
        wait(0.2)  -- 0.1 second delay
    end
end
wait(1)
local locations = {"MoonInterior"}

for _, location in ipairs(locations) do
    for i = 1, 100 do
        local args = {
            [1] = location,
            [2] = tostring(i)
        }
        game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
        wait(0.2)  -- 0.1 second delay
    end
end
wait(1)
local args = {
    [1] = "MoonInterior",
    [3] = true
}

for i = 1, 100 do
    args[2] = tostring(i)
    game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
    wait(0.2)  -- Delay of 0.2 seconds
end
end
wait(1)
local args = {
    [1] = "MainMap",
    [3] = true
}

for i = 1, 100 do
    args[2] = tostring(i)
    game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
    wait(0.2)  -- Delay of 0.2 seconds
end
