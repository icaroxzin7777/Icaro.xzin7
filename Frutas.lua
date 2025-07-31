-- Sistema de Frutas - Icaro.xzin7 Hub
local Frutas = {}
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local frutaSpawnada = nil
local frutaDetectada = false
local autoTeleportar = false
local autoGuardar = false

-- Detectar frutas no mapa
function Frutas.VerificarFrutas()
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
            if string.find(obj.Name:lower(), "fruit") then
                frutaSpawnada = obj
                frutaDetectada = true
                return obj
            end
        end
    end
    frutaSpawnada = nil
    frutaDetectada = false
    return nil
end

-- Ativar auto teleport
function Frutas.AtivarAutoTeleportar(ativar)
    autoTeleportar = ativar
    if ativar then
        RunService.Heartbeat:Connect(function()
            if frutaDetectada and frutaSpawnada and LocalPlayer.Character then
                pcall(function()
                    LocalPlayer.Character:PivotTo(frutaSpawnada.Handle.CFrame + Vector3.new(0, 2, 0))
                end)
            end
        end)
    end
end

-- Auto guardar frutas na mochila
function Frutas.AtivarAutoGuardar(ativar)
    autoGuardar = ativar
    if ativar then
        RunService.Heartbeat:Connect(function()
            local backpack = LocalPlayer.Backpack
            for _, item in pairs(backpack:GetChildren()) do
                if string.find(item.Name:lower(), "fruit") then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", item.Name)
                end
            end
        end)
    end
end

-- Loja de frutas (teleporta até o vendedor)
function Frutas.TeleportarLoja()
    local vendedor = Workspace:FindFirstChild("Fruit Dealer")
    if vendedor then
        LocalPlayer.Character:PivotTo(vendedor.CFrame + Vector3.new(0, 2, 0))
    else
        warn("❌ NPC 'Fruit Dealer' não encontrado.")
    end
end

-- Próximo tempo estimado de spawn (simulado)
function Frutas.ProximoSpawn()
    local tempoAtual = tick() % (60 * 60)
    local minutosRestantes = math.floor((60 - (tempoAtual / 60)) % 60)
    return minutosRestantes
end

return Frutas
