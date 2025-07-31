-- Módulo Sniper de Frutas - Icaro.xzin7 Hub
local SniperFruta = {}

local frutaDetectada = false
local ativo = false

-- Verifica frutas no chão
local function VerificarFrutas()
    for _, fruta in pairs(workspace:GetChildren()) do
        if fruta:IsA("Tool") and fruta:FindFirstChild("Handle") and fruta.Name:lower():find("fruit") then
            return fruta
        end
    end
    return nil
end

-- Teleporta até a fruta
local function ColetarFruta(fruta)
    local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    hrp.CFrame = fruta.Handle.CFrame + Vector3.new(0, 5, 0)
    wait(1)
    firetouchinterest(hrp, fruta.Handle, 0)
    firetouchinterest(hrp, fruta.Handle, 1)
end

-- Loop sniper
local function SniperLoop()
    while ativo and wait(1) do
        local fruta = VerificarFrutas()
        if fruta and not frutaDetectada then
            frutaDetectada = true
            warn("[Icaro.xzin7] Fruta detectada: " .. fruta.Name)
            ColetarFruta(fruta)
            wait(5)
            frutaDetectada = false
        end
    end
end

-- Ativar/desativar sniper
function SniperFruta.Toggle()
    ativo = not ativo
    if ativo then
        warn("[Icaro.xzin7] Sniper de Frutas Ativado")
        task.spawn(SniperLoop)
    else
        warn("[Icaro.xzin7] Sniper de Frutas Desativado")
    end
end

return SniperFruta
