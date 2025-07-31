-- Detector de Bosses - Icaro.xzin7 Hub Sea 1
local Bosses = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Lista de bosses do Sea 1
Bosses.Lista = {
    ["The Gorilla King"] = "Jungle",
    ["Bobby"] = "Pirate Village",
    ["Yeti"] = "Frozen Village",
    ["Mob Leader"] = "Magma Village",
    ["Vice Admiral"] = "Marine Fortress",
    ["Warden"] = "Prison",
    ["Chief Warden"] = "Prison",
    ["Swan"] = "Prison",
    ["Magma Admiral"] = "Magma Village",
    ["Fishman Lord"] = "Underwater City",
    ["Wysper"] = "Skylands",
    ["Thunder God"] = "Upper Sky",
    ["Cyborg"] = "Fountain City"
}

-- Detectar se boss está vivo
function Bosses.EstaVivo(nomeBoss)
    for _, obj in pairs(Workspace.Enemies:GetChildren()) do
        if obj.Name == nomeBoss then
            return true
        end
    end
    return false
end

-- Farmar boss específico
function Bosses.FarmarBoss(nomeBoss)
    spawn(function()
        while task.wait() do
            local boss = nil
            for _, npc in pairs(Workspace.Enemies:GetChildren()) do
                if npc.Name == nomeBoss then
                    boss = npc
                    break
                end
            end

            if boss and boss:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 20, 0)
                    -- Simula clique/ataque
                    mouse1click()
                end)
            else
                break
            end
        end
    end)
end

-- Retorna todos os bosses com status vivo/morto
function Bosses.StatusTodos()
    local status = {}
    for nome, _ in pairs(Bosses.Lista) do
        local vivo = Bosses.EstaVivo(nome)
        table.insert(status, {
            Nome = nome,
            Status = vivo and "🟢" or "🔴"
        })
    end
    return status
end

return Bosses
