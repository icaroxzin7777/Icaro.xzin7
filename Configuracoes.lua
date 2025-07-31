-- Módulo de Configurações - Icaro.xzin7 Hub
local Configuracoes = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Configurações padrão
Configuracoes.Velocidade = 120
Configuracoes.AutoClique = false
Configuracoes.DistanciaNPC = 15
Configuracoes.AlturaFarm = 25

-- Anti-AFK
pcall(function()
    for _, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
        v:Disable()
    end
end)

-- Auto clique real (para mobile e PC)
function Configuracoes.AtivarAutoClique()
    spawn(function()
        while Configuracoes.AutoClique do
            pcall(function()
                local humanoide = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
                if humanoide and tool then
                    tool:Activate()
                end
            end)
            task.wait(0.15)
        end
    end)
end

-- Aplicar velocidade
function Configuracoes.AplicarVelocidade()
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Configuracoes.Velocidade
        end
    end
end

-- Salvar configurações localmente
