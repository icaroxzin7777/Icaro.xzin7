-- Estilos de Luta - Icaro.xzin7 Hub
local Estilos = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local estilosDisponiveis = {
    ["God Human"] = "Godhuman",
    ["Dragon Talon"] = "DragonTalon",
    ["Sharkman Karate"] = "SharkmanKarate",
    ["Superhuman"] = "Superhuman",
    ["Death Step"] = "DeathStep",
    ["Electric Claw"] = "ElectricClaw",
    ["Electric"] = "Electro",
    ["Water Kung Fu"] = "WaterKungFu",
    ["Dark Step"] = "DarkStep",
    ["Dragon Breath"] = "DragonBreath"
}

-- Função para equipar estilo
function Estilos.Equipar(estiloNome)
    local estiloId = estilosDisponiveis[estiloNome]
    if not estiloId then
        warn("Estilo inválido: " .. estiloNome)
        return
    end

    local remote = ReplicatedStorage:WaitForChild("Remotes").CommF_:FindFirstChild("Buy" .. estiloId)
    if remote then
        remote:InvokeServer("Buy" .. estiloId)
        print("➡️ Estilo equipado:", estiloNome)
    else
        warn("⚠️ Estilo não encontrado no servidor:", estiloNome)
    end
end

-- Retorna a lista para a interface
function Estilos.Listar()
    local lista = {}
    for nome in pairs(estilosDisponiveis) do
        table.insert(lista, nome)
    end
    table.sort(lista)
    return lista
end

return Estilos
