if game.PlaceId == 121864768012064 then
    local plr = game.Players.LocalPlayer
    local RS = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local HttpService = game:GetService("HttpService")

    -- Buat UI untuk nampung log
    local gui = Instance.new("ScreenGui", plr.PlayerGui)
    gui.Name = "FishItInspectorSafe"

    local frame = Instance.new("ScrollingFrame", gui)
    frame.Size = UDim2.new(0, 400, 0, 300)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundTransparency = 0.3
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.BorderSizePixel = 0
    frame.CanvasSize = UDim2.new(0,0,5,0)
    frame.ScrollBarThickness = 8

    local layout = Instance.new("UIListLayout", frame)
    layout.Padding = UDim.new(0,5)

    -- Batas log maksimal
    local logCount = 0
    local maxLogs = 200

    local function log(text)
        if logCount >= maxLogs then return end
        logCount = logCount + 1

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, -10, 0, 20)
        label.TextColor3 = Color3.new(1,1,1)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.Code
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Text = text
    end

    log("[FishIt Inspector Aktif]")

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

    -- Scan getgc dengan delay biar aman
    task.spawn(function()
        local count = 0
        for i,v in pairs(getgc(true)) do
            if typeof(v) == "function" then
                local info = debug.getinfo(v)
                if info.name and info.name ~= "" then
                    log("[Function]: "..info.name)
                end
            end
            count = count + 1
            if count % 100 == 0 then
                task.wait() -- supaya tidak freeze
            end
        end
    end)

    log("[Inspector Ready] Coba mancing untuk lihat event & function keluar di sini.")
end
