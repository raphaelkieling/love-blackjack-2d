-- soundmanager.lua
local SoundManager = {}

-- Table to hold loaded sounds
local sounds = {}

function SoundManager.init()
    sounds.button = love.audio.newSource("assets/button.wav", "static")
    sounds.rewards = love.audio.newSource("assets/rewards.wav", "static")
    sounds.rewards:setVolume(0.3)
    sounds.cardFlip = love.audio.newSource("assets/card-flip.mp3", "static")
    sounds.cardFlip:setVolume(0.1)
end

function SoundManager.play(soundName)
    if sounds[soundName] then
        sounds[soundName]:play()
    else
        print("Warning: Sound '" .. soundName .. "' not found!")
    end
end

function SoundManager.playButton()
    SoundManager.play("button")
end

function SoundManager.playRewards()
    SoundManager.play("rewards")
end

function SoundManager.playCardFlip()
    SoundManager.play("cardFlip")
end

function SoundManager.addSound(name, filePath)
    sounds[name] = love.audio.newSource(filePath, "static")
end

return SoundManager
