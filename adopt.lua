local args = {
    [1] = "\128",
    [2] = 123
}

game:GetService("ReplicatedStorage").API:FindFirstChild("RadioAPI/Add"):InvokeServer(unpack(args))
