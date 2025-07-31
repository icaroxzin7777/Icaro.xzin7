-- Interface principal do Icaro.xzin7 Hub
local Interface = {}

-- Serviços
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Janela principal
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Icaro_xzin7_Interface"
ScreenGui.ResetOnSpawn = false

-- Frame base
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 0, 50)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0.1
MainFrame.Name = "MainFrame"

-- Estilo neon glow
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(170, 0, 255)
UIStroke.Thickness = 2

-- Título
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Icaro.xzin7 Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextStrokeTransparency = 0
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20

-- Botão exemplo
local AutoFarmBtn = Instance.new("TextButton", MainFrame)
AutoFarmBtn.Size = UDim2.new(0, 200, 0, 40)
AutoFarmBtn.Position = UDim2.new(0.5, -100, 0.5, -20)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
AutoFarmBtn.Text = "🌾 Auto Farm"
AutoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmBtn.Font = Enum.Font.Gotham
AutoFarmBtn.TextSize = 18
AutoFarmBtn.Name = "AutoFarmBtn"

local UICorner2 = Instance.new("UICorner", AutoFarmBtn)
UICorner2.CornerRadius = UDim.new(0, 10)

-- Função do botão (exemplo)
AutoFarmBtn.MouseButton1Click:Connect(function()
    print("Auto Farm ativado!")
end)

return Interface
