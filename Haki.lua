-- Haki.lua - Sistema de Haki Icaro.xzin7 Hub
local Haki = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local function AtivarArmamento()
    pcall(function()
        if not LocalPlayer.Character:FindFirstChild("HasBuso") then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
        end
    end)
end

local function AtivarObservacao()
    pcall(function()
        if not LocalPlayer.Character:FindFirstChild("HasObservationHaki") then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Ken", true)
        end
    end)
end

-- Farm automático de desvios (para V2)
local function FarmDesvio()
    spawn(function()
        while Haki.FarmDesviosAtivo do
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    hrp.Velocity = Vector3.new(50, 0, 0)
                    wait(0.1)
                    hrp.Velocity = Vector3.new(-50, 0, 0)
                end
            end)
            task.wait(0.3)
        end
    end)
end

-- Auto comprar cor do haki (Sea 2 ou 3)
function Haki.ComprarCorHaki(cor)
    local coresSuportadas = {
        ["Red"] = "BuyColor", ["Blue"] = "BuyColor", ["Purple"] = "BuyColor",
        ["Green"] = "BuyColor", ["Yellow"] = "BuyColor", ["Pink"] = "BuyColor",
        ["Cyan"] = "BuyColor", ["Orange"] = "BuyColor", ["White"] = "BuyColor"
    }

    if coresSuportadas[cor] then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("ColorsDealer", coresSuportadas[cor], cor)
        print("🔵 Cor do haki trocada para:", cor)
    else
        warn("⚠️ Cor de Haki inválida ou não suportada.")
    end
end

-- Auto habilitar hakis disponíveis
function Haki.AtivarHakis()
    AtivarArmamento()
    AtivarObservacao()
end

-- Iniciar farm de desvio para observação V2
function Haki.IniciarFarmDesvios()
    Haki.FarmDesviosAtivo = true
    FarmDesvio()
end

function Haki.PararFarmDesvios()
    Haki.FarmDesviosAtivo = false
end

return Haki
