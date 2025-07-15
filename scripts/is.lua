-- FishIt Inspector UI dengan Terminal Log & Copy Button -- Menampilkan function & event lalu bisa dicopy

if game.PlaceId == 121864768012064 then local plr = game.Players.LocalPlayer local UIS = game:GetService("UserInputService") local RS = game:GetService("RunService") local HttpService = game:GetService("HttpService") local Clipboard = setclipboard or toclipboard or (Clipboard and Clipboard.set)

-- UI Terminal
local gui = Instance.new("ScreenGui", plr.PlayerGui)
gui.Name = "FishItTerminal"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 500, 0, 400)
frame.Position = UDim2.new(0.05, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BorderSizePixel = 0

local terminal = Instance.new("TextBox", frame)
terminal.Size = UDim2.new(1, -20, 1, -60)
terminal.Position = UDim2.new(0, 10, 0, 10)
terminal.BackgroundColor3 = Color3.fromRGB(25,25,25)
terminal.TextColor3 = Color3.new(0,1,0)
terminal.TextXAlignment = Enum.TextXAlignment.Left
terminal.TextYAlignment = Enum.TextYAlignment.Top
terminal.ClearTextOnFocus = false
terminal.MultiLine = true
terminal.Font = Enum.Font.Code
terminal.TextSize = 14
terminal.Text = "[FishIt Terminal Active]\n"

local copyBtn = Instance.new("TextButton", frame)
copyBtn.Size = UDim2.new(0, 100, 0, 30)
copyBtn.Position = UDim2.new(1, -110, 1, -40)
copyBtn.Text = "Copy Log"
copyBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
copyBtn.TextColor3 = Color3.new(1,1,1)
copyBtn.Font = Enum.Font.SourceSansBold
copyBtn.TextSize = 14

copyBtn.MouseButton1Click:Connect(function()
    if Clipboard then
        Clipboard(terminal.Text)
        copyBtn.Text = "Copied!"
        wait(1)
        copyBtn.Text = "Copy Log"
    else
        terminal.Text = terminal.Text.."\n[Clipboard Error: Tidak didukung]"
    end
end)

local function log(text)
    terminal.Text = terminal.Text..text.."\n"
end

log("[Terminal Ready] Coba mancing atau gunakan fitur lain.")

-- Hook __namecall
local old; old = hookmetamethod(game, "__namecall", function(self, ...)
    if not checkcaller() then
        local method = getnamecallmethod()
        if method == "FireServer" or method == "InvokeServer" then
            local args = {...}
            log("[Remote]: "..self:GetFullName())
        end
    end
    return old(self, ...)
end)

-- Scan getgc
task.spawn(function()
    for i,v in pairs(getgc(true)) do
        if typeof(v) == "function" then
            local info = debug.getinfo(v)
            if info.name and info.name ~= "" then
                log("[Function]: "..info.name)
            end
        end
    end
end)

end

