if game.PlaceId == 121864768012064 then
    local plr = game.Players.LocalPlayer
    local RS = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local HttpService = game:GetService("HttpService")

    -- Buat UI TextBox buat nampung log (bisa di-copy)
    local gui = Instance.new("ScreenGui", plr.PlayerGui)
    gui.Name = "FishItInspectorCopy"

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 400, 0, 300)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundTransparency = 0.3
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true

    local logBox = Instance.new("TextBox", frame)
    logBox.Size = UDim2.new(1, -20, 1, -20)
    logBox.Position = UDim2.new(0, 10, 0, 10)
    logBox.BackgroundColor3 = Color3.fromRGB(25,25,25)
    logBox.TextColor3 = Color3.new(1,1,1)
    logBox.TextXAlignment = Enum.TextXAlignment.Left
    logBox.TextYAlignment = Enum.TextYAlignment.Top
    logBox.ClearTextOnFocus = false
    logBox.MultiLine = true
    logBox.Font = Enum.Font.Code
    logBox.TextSize = 14
    logBox.TextEditable = true
    logBox.TextWrapped = true
    logBox.Text = "[FishIt Inspector Aktif]\nTahan text ini untuk salin log manual di Android.\n\n"

    -- Fungsi log ke TextBox
    local function log(text)
        logBox.Text = logBox.Text .. text .. "\n"
    end

    -- Hook __namecall
    local old; old = hookmetamethod(game, "__namecall", function(self, ...)
        if not checkcaller() then
            local method = getnamecallmethod()
            if method == "FireServer" or method == "InvokeServer" then
                local msg = "[Remote]: "..self:GetFullName()
                log(msg)
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

    log("[Inspector Ready] Coba mancing untuk lihat event & function keluar di sini.")
end
