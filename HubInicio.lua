-- Carregador principal do Icaro.xzin7 Hub (via GitHub)
-- Certifique-se que os arquivos externos estejam no mesmo repositório!

local HttpService = game:GetService("HttpService")
local function Import(url)
    return loadstring(game:HttpGet(url))()
end

-- Links diretos dos módulos (você vai criar esses arquivos depois)
local modules = {
    AutoFarm = "https://raw.githubusercontent.com/icaroxzin7777/Ícaro.xzin7/main/AutoFarm.lua",
    AutoBoss = "https://raw.githubusercontent.com/icaroxzin7777/Ícaro.xzin7/main/AutoBoss.lua",
    SniperFruta = "https://raw.githubusercontent.com/icaroxzin7777/Ícaro.xzin7/main/SniperFruta.lua",
    Interface = "https://raw.githubusercontent.com/icatoxzin7777-Ícaro.xzin7/main/Interface.lua",
    Configuracoes = "https://raw.githubusercontent.com/icaroxzin7777/Ícaro.xzin7/main/Configuracoes.lua"
}

-- Carregar o módulo principal da interface (responsável por tudo)
Import(modules.Interface)
