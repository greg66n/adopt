

wait(30)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(1)
local locations = {"Neighborhood", "MainMap","SkyCastle"}

while true do  -- loop infinitely
    for i = 1, 100 do
        for _, location in ipairs(locations) do
            local args = {
                [1] = location,
                [2] = tostring(i)
            }
            game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
            wait(0.5)  -- 0.5 second delay prevent crash.. don't remove this to execute faster
        end
    end
    wait(43200)  -- loop every 12h
end
