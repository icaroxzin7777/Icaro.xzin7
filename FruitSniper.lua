-- FruitSniper - Icaro.xzin7 Hub
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local FruitSniper = {
    AutoTP = false,
    AutoStore = false,
    ShowTimer = true
}

-- Detectar frutas no mapa
function FruitSniper.ScanFruits()
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
            if string.find(obj.Name:lower(), "fruit") then
                return obj
            end
        end
    end
    return nil
end

-- Teleportar até a fruta
function FruitSniper.TeleportToFruit(fruit)
    if fruit and LocalPlayer.Character then
        LocalPlayer.Character:PivotTo(CFrame.new(fruit.Handle.Position + Vector3.new(0, 3, 0)))
    end
end

-- Guardar fruta no inventário
function FruitSniper.StoreFruit(fruit)
    if fruit and fruit:FindFirstChild("Handle") then
        local backpack = LocalPlayer:FindFirstChild("Backpack")
        if backpack and fruit.Parent ~= backpack then
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, fruit.Handle, 0)
            wait(0.2)
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, fruit.Handle, 1)
        end
    end
end

-- Temporizador de spawn (frutas aparecem a cada 60 minutos)
local lastSpawn = os.time()
local nextSpawn = lastSpawn + 60 * 60

function FruitSniper.GetSpawnTimer()
    local remaining = nextSpawn - os.time()
    return math.max(0, remaining)
end

-- Loop principal
RunService.Heartbeat:Connect(function()
    local fruit = FruitSniper.ScanFruits()
    if fruit then
        if FruitSniper.AutoTP then
            FruitSniper.TeleportToFruit(fruit)
        end
        if FruitSniper.AutoStore then
            FruitSniper.StoreFruit(fruit)
        end
    end
end)

-- Loja de frutas
function FruitSniper.OpenFruitShop()
    local args = {
        [1] = "GetFruits"
    }
    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
end

return FruitSniper
