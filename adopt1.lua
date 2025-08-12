
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xenijo/AdoptMe-RemoteBypass/main/Bypass.lua"))()
wait(0.1)
repeat task.wait() until game:IsLoaded()
task.wait(2.5)
setthreadidentity(2)
-- Services and modules
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local plr = Players.LocalPlayer
local router = require(ReplicatedStorage.ClientModules.Core.RouterClient.RouterClient)
local cd = require(ReplicatedStorage.ClientModules.Core.ClientData)
local petentitymanager = require(ReplicatedStorage.ClientModules.Game.PetEntities.PetEntityManager)
local inventorydb = require(ReplicatedStorage.ClientDB.Inventory.InventoryDB)
local minigamemanager = require(game:GetService("ReplicatedStorage").ClientModules.Game.MinigameClientManager)
local terrainhelper = require(game:GetService("ReplicatedStorage").SharedModules.TerrainHelper)
local Fsys = require(ReplicatedStorage.Fsys)
local liveopstime = Fsys.load("LiveOpsTime")
setthreadidentity(8)
if plr.Character == nil then
	router.get("LegacyTutorialAPI/MarkTutorialCompleted"):FireServer()
	router.get("LegacyTutorialAPI/EquipTutorialEgg"):FireServer()
    repeat 
        local playbutton = game:GetService("Players").LocalPlayer.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Buttons.PlayButton
        firesignal(playbutton.MouseButton1Down)
        firesignal(playbutton.MouseButton1Up)
        firesignal(playbutton.MouseButton1Click)
        task.wait(1)
		if game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Visible then
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Info.Response:GetChildren()[8].MouseButton1Down)
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Info.Response:GetChildren()[8].MouseButton1Up)
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Info.Response:GetChildren()[8].MouseButton1Click)
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Buttons.ButtonTemplate.MouseButton1Down)
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Buttons.ButtonTemplate.MouseButton1Up)
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Buttons.ButtonTemplate.MouseButton1Click)
        else
			firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.SpawnChooserDialog.UpperCardContainer.ChoicesContent.Choices.Home.Button.MouseButton1Down)
			firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.SpawnChooserDialog.UpperCardContainer.ChoicesContent.Choices.Home.Button.MouseButton1Up)
			firesignal(game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.SpawnChooserDialog.UpperCardContainer.ChoicesContent.Choices.Home.Button.MouseButton1Click)
		end
    until not (plr.Character == nil)
end

function findUiElementByText(text)
    local placesToSearch = { game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"), game:GetService("CoreGui") }
    for _, container in pairs(placesToSearch) do
        for _, descendant in pairs(container:GetDescendants()) do
            if descendant:IsA("GuiObject") and pcall(function() return descendant.Text end) and descendant.Text == text then
                return descendant
            end
        end
    end
    return nil
end

function findClickableParent(startObject)
    local currentObject = startObject
    for i = 1, 10 do
        if currentObject:IsA("TextButton") or currentObject:IsA("ImageButton") then
            return currentObject
        end
        if currentObject.Parent then
            currentObject = currentObject.Parent
        else
            return nil
        end
    end
    return nil
end

local args = { "ruin_rush" }
game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("MinigameAPI/LobbyCreate"):InvokeServer(unpack(args))
task.wait(0.5)

local textLabel = findUiElementByText("Play Temple Trek")
if textLabel then
    local playButton = findClickableParent(textLabel)
    if playButton then
        warn("Clicking the Play button to start...")
        firesignal(playButton.MouseButton1Down); task.wait(0.05)
        firesignal(playButton.MouseButton1Up); task.wait(0.05)
        firesignal(playButton.MouseButton1Click)
    end
end

warn("Waiting 15 seconds for minigame to fully load...")
task.wait(15)

-- =================================================================== --
--                      PART 2: COLLECT THE SKULLS
-- =================================================================== --

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local API = ReplicatedStorage:WaitForChild("API")
local MessageServer = API:WaitForChild("MinigameAPI/MessageServer")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local processedSkulls = {}
local instanceId = nil
local skullsCollected = 0

print("--- GoldenSkull Hunter (Arrow Reader) Activated ---")

function findAndCacheInstanceId()
    if instanceId then return instanceId end
    local Interiors = Workspace:FindFirstChild("Interiors")
    if Interiors then
        for _, child in pairs(Interiors:GetChildren()) do
            if child.Name:match("^RuinRushInterior::") then
                instanceId = child.Name:match("^RuinRushInterior::(.+)")
                return instanceId
            end
        end
    end
    return nil
end

function collectSkull(skullModel)
    if not findAndCacheInstanceId() then return end

    local fullPath = skullModel:GetFullName()
    local skullId = nil
    
    if fullPath:find("AztecEndRoom") then skullId = 1
    elseif fullPath:find("UpliftStones") then skullId = 2
    elseif fullPath:find("middle_room_") then skullId = 3 end
    
    if not skullId then return end
    
    print("\n--- Processing Skull #" .. skullId .. " ---")
    
    -- [[ THE CRITICAL PUZZLE SOLVER FOR SKULL #3 ]] --
    if skullId == 3 then
        print("  -> Special handling for Skull #3 puzzle.")
        local instanceFolder = skullModel:FindFirstAncestor(function(a) return a.Name:match("^RuinRushInterior::") end)
        local boulder = instanceFolder and instanceFolder:FindFirstChild("Boulder", true)
        
        if boulder and boulder:IsA("Model") then
            local boulderPos = boulder:GetPivot().Position
            
            print("  -> Teleporting to boulder to start the puzzle.")
            humanoidRootPart.CFrame = CFrame.new(boulderPos + Vector3.new(0, 5, 0))
            task.wait(2)

            -- Find the arrow UI element
            print("  -> Searching for the direction arrow UI...")
            local playerGui = player:WaitForChild("PlayerGui")
            local arrowImage = playerGui:FindFirstChild("BoulderUI", true) and playerGui:FindFirstChild("BoulderUI", true):FindFirstChild("Arrow", true)

            if not arrowImage or not arrowImage:IsA("ImageLabel") then
                warn("  -> Could not find the Arrow UI! Aborting skull #3.")
                skullsCollected = skullsCollected + 1 -- Mark as "done" to avoid infinite loop
                return
            end
            
            print("  -> Found arrow! Reading direction...")
            local angle = math.rad(arrowImage.Rotation)
            -- Convert the UI rotation into a 3D world direction vector
            -- This assumes the camera is facing forward (negative Z axis)
            local runDirection = (CFrame.Angles(0, angle, 0) * CFrame.new(0,0,-2)).Position
            
            print("  -> Simulating 'running' on the boulder in the correct direction...")
            
            local spamActive = true
            local spamCoroutine = coroutine.create(function()
                while spamActive do
                    pcall(function()
                        local args = { "RuinRushInterior::" .. instanceId, "pickup_skull", skullId }
                        MessageServer:FireServer(unpack(args))
                    end)
                    task.wait(0.2)
                end
            end)
            coroutine.resume(spamCoroutine)
            
            local runEndTime = tick() + 7 -- Run for 7 seconds to be safe
            while tick() < runEndTime do
                humanoidRootPart.CFrame = humanoidRootPart.CFrame + runDirection
                RunService.Heartbeat:Wait() -- Use Heartbeat for smoother movement simulation
            end
            
            spamActive = false
            
        else
            -- Fallback
            humanoidRootPart.CFrame = CFrame.new(skullModel:GetPivot().Position + Vector3.new(0, 3, 0))
            task.wait(3)
            pcall(function()
                local args = { "RuinRushInterior::" .. instanceId, "pickup_skull", skullId }
                MessageServer:FireServer(unpack(args))
            end)
        end
    else
        -- Simple logic for Skulls #1 and #2
        humanoidRootPart.CFrame = CFrame.new(skullModel:GetPivot().Position + Vector3.new(0, 3, 0))
        task.wait(3)
        pcall(function()
            local args = { "RuinRushInterior::" .. instanceId, "pickup_skull", skullId }
            MessageServer:FireServer(unpack(args))
        end)
    end
    
    print("  ✓ Collection attempt finished for Skull #" .. skullId)
    skullsCollected = skullsCollected + 1
end

-- Main monitoring loop with a safety timeout
local startTime = tick()
local timeout = 120
while skullsCollected < 3 and (tick() - startTime) < timeout do
    task.wait(1)
    local interiors = Workspace:FindFirstChild("Interiors")
    if interiors then
        for _, model in pairs(interiors:GetDescendants()) do
            if model.Name == "GoldenSkull" and model:IsA("Model") then
                if not table.find(processedSkulls, model) then
                    table.insert(processedSkulls, model)
                    collectSkull(model)
                end
            end
        end
    end
end

-- =================================================================== --
--                      PART 3: EXIT THE MINIGAME
-- =================================================================== --
if skullsCollected < 3 then
    warn("Warning: Timed out or failed to collect all 3 skulls. Proceeding to exit...")
else
    print("\n=== All Skulls Collected! ===")
end

task.wait(3)
local playerGui = player:WaitForChild("PlayerGui", 5)
local minigameApp = playerGui and playerGui:WaitForChild("MinigameInGameApp", 5)
local exitButton = minigameApp and minigameApp:WaitForChild("ExitButton", 5)

if exitButton then
    warn("Found first Exit button! Clicking...")
    firesignal(exitButton.MouseButton1Down); task.wait(0.05)
    firesignal(exitButton.MouseButton1Up); task.wait(0.05)
    firesignal(exitButton.MouseButton1Click)

    warn("Patiently waiting for the final 'Exit Game' button to appear...")
    local confirmExitButton = nil
    local exitStartTime = tick()
    while not confirmExitButton and (tick() - exitStartTime) < 10 do
        local confirmExitText = findUiElementByText("Exit Game")
        if confirmExitText then
            confirmExitButton = findClickableParent(confirmExitText)
        end
        task.wait(0.5)
    end

    if confirmExitButton then
        warn("Found final Exit button! Clicking to confirm...")
        firesignal(confirmExitButton.MouseButton1Down); task.wait(0.05)
        firesignal(confirmExitButton.MouseButton1Up); task.wait(0.05)
        firesignal(confirmExitButton.MouseButton1Click)
    end
else
    warn("Could not find the 'Exit Minigame' button.")
end

print("--- Script Finished ---")
