-- AutoConfig - Icaro.xzin7 Hub
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Config = {}
local HttpService = game:GetService("HttpService")

-- Caminho do arquivo de salvamento
local SavePath = "Icaro_xzin7_Settings.json"

-- Configurações padrão
Config.Default = {
    Speed = 100,
    Distance = 10,
    Height = 20,
    AutoClick = true,
    AntiAFK = true
}

-- Carregar configurações salvas
function Config.Load()
    if isfile(SavePath) then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile(SavePath))
        end)
        if success and type(data) == "table" then
            for k, v in pairs(data) do
                Config.Default[k] = v
            end
        end
    end
end

-- Salvar configurações atuais
function Config.Save()
    writefile(SavePath, HttpService:JSONEncode(Config.Default))
end

-- Resetar para padrão
function Config.Reset()
    Config.Default = {
        Speed = 100,
        Distance = 10,
        Height = 20,
        AutoClick = true,
        AntiAFK = true
    }
    Config.Save()
end

-- Aplicar configurações (como velocidade)
function Config.Apply()
    pcall(function()
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.Default.Speed
    end)
end

-- Auto Clique (funciona no celular)
function Config.EnableAutoClick()
    task.spawn(function()
        while Config.Default.AutoClick and task.wait(0.1) do
            pcall(function()
                mouse1click()
            end)
        end
    end)
end

-- Anti-AFK
function Config.EnableAntiAFK()
    local vu = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        if Config.Default.AntiAFK then
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
    end)
end

return Config
