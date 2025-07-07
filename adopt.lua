local plr = game:GetService("Players").LocalPlayer

if plr.Character == nil then
    repeat 
        local playbutton = plr:WaitForChild("PlayerGui"):WaitForChild("NewsApp")
            :WaitForChild("EnclosingFrame"):WaitForChild("MainFrame")
            :WaitForChild("Buttons"):WaitForChild("PlayButton")

        firesignal(playbutton.MouseButton1Down)
        firesignal(playbutton.MouseButton1Up)
        firesignal(playbutton.MouseButton1Click)

        task.wait(2)
    until plr.Character ~= nil
end
wait(5)
setthreadidentity(2)
local load = require(game:GetService("ReplicatedStorage").Fsys).load
local interiors = load("InteriorsM")
local enter = interiors.enter
local function enterinterior(name)
task.spawn(enter, name, "", {})
end
enterinterior("MainMap!Snow")
wait(5)
script_key="YDizWtCsoUWCWDMoEGyWgIZZjPCgquVY" loadstring(game:HttpGet("https://zekehub.com/scripts/AdoptMeEventFarm.lua"))()
