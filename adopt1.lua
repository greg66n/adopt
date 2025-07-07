script_key="YDizWtCsoUWCWDMoEGyWgIZZjPCgquVY" loadstring(game:HttpGet("https://zekehub.com/scripts/AdoptMeEventFarm.lua"))()
wait(5)
setthreadidentity(2)
local load = require(game:GetService("ReplicatedStorage").Fsys).load
local interiors = load("InteriorsM")
local enter = interiors.enter
local function enterinterior(name)
task.spawn(enter, name, "", {})
end
enterinterior("MainMap!Snow")
