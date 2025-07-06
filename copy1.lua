wait(99999999999999999)
local messages = {
    "This is too easy",
    "Let’s raid!",
    "Anyone got food?",
    "Where do I spawn?",
    "Haha got you!",
    "You scared me lol",
    "I'm stuck!",
    "Who built this?",
    "That’s crazy!",
    "What's happening?",
    "Did you see that?",
    "Best moment ever",
    "I wanna try that",
    "This looks cool",
    "Who made this game?",
    "Anyone from the US?",
    "I'm from the UK!",
    "What’s your pet power?",
    "This boss is hard!",
    "Don't leave me!",
    "I'm soloing it!",
    "We need more people",
    "Anyone trading?",
    "I’m grinding coins",
    "I found a secret!",
    "What's in that cave?",
    "This place is scary",
    "Let’s dance!",
    "Party at spawn!",
    "I need diamonds",
    "How do I get XP fast?",
    "Anyone wanna 1v1?",
    "I lost all my stuff!",
    "I just leveled up!",
    "How do I upgrade?",
    "This music is cool",
    "Is there PvP here?",
    "Who’s the best player?",
    "I’m not scared",
    "What’s that noise?",
    "Follow me for secrets!",
    "Can we build here?",
    "Help I’m being chased!",
    "Just vibing",
    "I love this vibe",
    "Who’s still alive?",
    "This game is underrated",
    "I’m gonna speedrun this",
    "I’m so close to winning",
    "I need one more item!",
    "Anyone wanna help?",
    "Where’s the safe zone?",
    "I'm hiding here",
    "I got lucky!",
    "Let’s win this!",
    "We got this!",
    "That was awesome",
    "BRB real quick",
    "I’m back!",
    "Let’s finish this!",
}

-- Function to make player chat
local function randomChat()
    local TextChatService = game:GetService("TextChatService")
    local channel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
    while true do
        local message = messages[math.random(1, #messages)]
        channel:SendAsync(message)
        local waitTime = math.random(1, 7, 26, 55, 73, 91, 106, 115, 153, 281, 290, 540)  -- seconds (20s to 9min)
        wait(waitTime)
    end
end

-- Run it
task.spawn(randomChat)
