-- Módulo Auto Boss (Sea 1) - Icaro.xzin7 Hub
local AutoBoss = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

local bossesSea1 = {
    "Gorila Rei", "Yeti", "Mob Líder", "Almirante da Marinha", "Saber Expert", "Enel", "Magma Admiral"
}

local farmingBoss = false
local bossThread

-- Teleporte suave
local function Teleportar(pos)
    local info = TweenInfo.new((HRP.Position - pos).Magnitude / 200, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(HRP, info, {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end

-- Atacar boss
local function Atacar()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    task.wait(0.1)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

-- Detectar e farmar boss ativo
local function FarmarBoss()
    while farmingBoss and task.wait(1) do
        for _, boss in pairs(workspace.Enemies:GetChildren()) do
            if table.find(bossesSea1, boss.Name) and boss:FindFirstChild("HumanoidRootPart") and boss.Humanoid.Health > 0 then
                warn("[Icaro.xzin7] Boss detectado: " .. boss.Name)
                local pos = boss.HumanoidRootPart.Position + Vector3.new(0, 20, 0)
                repeat
                    Teleportar(pos)
                    Atacar()
                    task.wait(0.2)
                until not boss or boss.Humanoid.Health <= 0 or not farmingBoss
            end
        end
    end
end

-- Ativar ou desativar farm de bosses
function AutoBoss.Toggle()
    farmingBoss = not farmingBoss

    if farmingBoss then
        warn("[Icaro.xzin7] Auto Boss Ativado")
        bossThread = task.spawn(FarmarBoss)
    else
        warn("[Icaro.xzin7] Auto Boss Desativado")
        if bossThread then
            task.cancel(bossThread)
        end
    end
end

return AutoBoss
