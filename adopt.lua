getgenv().Config = {
    AutoFarm = {
        FrostclawsRevenge = {
            Enabled = true
        },
        Spleef = {
            Enabled = false
        }
    }
}
script_key="OkbUgSyCLieCMbeVqgTZOAgbKIdxjRLH"
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/138e2f78b57c8e78354ac45978d60113.lua"))()
wait(5)
game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("WinterEventAPI/UseExchangeKiosk"):InvokeServer()
