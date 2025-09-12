-- Wait for necessary services and scripts to load
task.wait(10)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
task.wait(0.1)

-- Define the core function to claim the reward
local function claimReward(tier)
    local args = {
        "house_pets_2025_pass_2",
        tier
    }
    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("BattlePassAPI/ClaimReward"):InvokeServer(unpack(args))
end

-- Function to reset the battle pass
local function resetPass()
    local args = {
        "house_pets_2025_pass_2"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("BattlePassAPI/AttemptBattlePassReset"):InvokeServer(unpack(args))
end

-- Main loop to run the script
while true do
    -- First, run the battle pass claim loop 20 times
    for i = 1, 20 do
        claimReward(i)
        task.wait(0.5) -- Wait 0.5 seconds between claims
    end

    -- Wait 0.5s after the last claim, then reset the pass
    task.wait(0.5)
    resetPass()
    
    -- Now, run the item buying loop 5 times
    for i = 1, 5 do
        local args = {
            [1] = "pets",
            [2] = "house_pets_2025_siamese_cat",
            [3] = {}
        }
        game:GetService("ReplicatedStorage").API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
        task.wait(0.1)
    end

    -- Wait 30 seconds before starting the entire cycle again
    task.wait(30)
end
