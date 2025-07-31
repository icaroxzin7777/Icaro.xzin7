-- Configurações Globais - Icaro.xzin7 Hub
local Config = {}

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Caminho do arquivo salvo (identificador local)
local saveKey = "Icaro.xzin7_Settings"

-- Configurações padrão
local padrao = {
    Velocidade = 80,
    Altura = 10,
    Distancia = 30,
    AutoClique = true,
    AutoAFK = true,
    ProtecaoAntiBan = true
}

local atual = {}

-- Função para carregar configs
function Config.Carregar()
    local data = LocalPlayer:FindFirstChild(saveKey)
    if data then
        local sucesso, resultado = pcall(function()
            return HttpService:JSONDecode(data.Value)
        end)
        if sucesso and typeof(resultado) == "table" then
            atual = resultado
        else
            atual = padrao
        end
    else
        atual = padrao
    end
end

-- Função para salvar configs
function Config.Salvar()
    local json = HttpService:JSONEncode(atual)
    local existing = LocalPlayer:FindFirstChild(saveKey)
    if existing then
        existing.Value = json
    else
        local novo = Instance.new("StringValue")
        novo.Name = saveKey
        novo.Value = json
        novo.Parent = LocalPlayer
    end
end

-- Get/Set de valores
function Config.Definir(nome, valor)
    atual[nome] = valor
    Config.Salvar()
end

function Config.Obter(nome)
    return atual[nome]
end

-- Inicial
Config.Carregar()

return Config
