wait(10)
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

-- Function to reset the battle pass
local function resetPass()
    local args = {
        "house_pets_2025_pass_1"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("BattlePassAPI/AttemptBattlePassReset"):InvokeServer(unpack(args))
end

-- Main loop to run the script
while true do
    -- Loop from 1 to 20 for the reward tiers
    for i = 1, 20 do
        claimReward(i)
        task.wait(0.5) -- Wait 0.5 seconds between claims
    end

    -- Wait 0.5s after last claim, then reset
    task.wait(0.5)
    resetPass()

    -- Wait 30 seconds before starting the cycle again
    task.wait(30)
end
