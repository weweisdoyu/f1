-- FishIt Safe Remote Scanner (Khusus Delta Android, Tanpa Copy Button)

if game.PlaceId == 121864768012064 then local plr = game.Players.LocalPlayer local UIS = game:GetService("UserInputService")

-- UI Terminal
local gui = Instance.new("ScreenGui", plr.PlayerGui)
gui.Name = "FishItAndroidScanner"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 500, 0, 400)
frame.Position = UDim2.new(0.05, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BorderSizePixel = 0

local terminal = Instance.new("TextBox", frame)
terminal.Size = UDim2.new(1, -20, 1, -20)
terminal.Position = UDim2.new(0, 10, 0, 10)
terminal.BackgroundColor3 = Color3.fromRGB(25,25,25)
terminal.TextColor3 = Color3.new(0,1,0)
terminal.TextXAlignment = Enum.TextXAlignment.Left
terminal.TextYAlignment = Enum.TextYAlignment.Top
terminal.ClearTextOnFocus = false
terminal.MultiLine = true
terminal.Font = Enum.Font.Code
terminal.TextSize = 14
terminal.TextWrapped = true
terminal.Text = "[SAFE REMOTE SCANNER - ANDROID]\nTekan F9 untuk scan remote di Tool.\nSalin manual dari TextBox ini (Tahan lalu Copy di Android)."

local function scanRemote()
    local tool = plr.Backpack:FindFirstChildOfClass("Tool") or plr.Character:FindFirstChildOfClass("Tool")
    local log = "[REMOTE SCAN]\n"

    if tool then
        for _,v in pairs(tool:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                log = log .. "[Remote]: "..v.Name.." ("..v.ClassName..")\n"
            end
        end
    else
        log = log.."> Tidak ada Tool aktif.\n"
    end

    terminal.Text = log.."\nTekan F9 untuk scan ulang.\nSalin manual dengan tahan TextBox di Android."
end

-- Tekan F9 buat refresh
UIS.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.F9 then
        scanRemote()
    end
end)

scanRemote()

end

