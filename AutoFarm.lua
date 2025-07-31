-- Módulo de Auto Farm do Sea 1 (Icaro.xzin7 Hub)
local AutoFarm = {}

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Variáveis internas
local farming = false
local farmThread

-- Função de ataque simples
local function Atacar()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    task.wait(0.1)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

-- Função de encontrar inimigo mais próximo
local function PegarInimigo()
    local inimigoMaisProximo
    local menorDistancia = math.huge

    for _, npc in pairs(workspace.Enemies:GetChildren()) do
        if npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") and npc.Humanoid.Health > 0 then
            local distancia = (npc.HumanoidRootPart.Position - HRP.Position).Magnitude
            if distancia < menorDistancia then
                menorDistancia = distancia
                inimigoMaisProximo = npc
            end
        end
    end

    return inimigoMaisProximo
end

-- Loop do farm
local function Farmar()
    while farming and task.wait() do
        local inimigo = PegarInimigo()
        if inimigo and inimigo:FindFirstChild("HumanoidRootPart") then
            local posicaoAcima = inimigo.HumanoidRootPart.Position + Vector3.new(0, 15, 0)
            HRP.CFrame = CFrame.new(posicaoAcima)
            Atacar()
        end
    end
end

-- Ativar ou desativar o farm
function AutoFarm.Toggle()
    farming = not farming

    if farming then
        warn("[Icaro.xzin7] Auto Farm Ativado")
        farmThread = task.spawn(Farmar)
    else
        warn("[Icaro.xzin7] Auto Farm Desativado")
        if farmThread then
            task.cancel(farmThread)
        end
    end
end

return AutoFarm
