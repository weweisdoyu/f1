if game.PlaceId == 121864768012064 then
    local plr = game.Players.LocalPlayer
    local RS = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local HttpService = game:GetService("HttpService")

    -- Buat UI buat nampung log hook
    local gui = Instance.new("ScreenGui", plr.PlayerGui)
    gui.Name = "FishItInspector"

    local frame = Instance.new("ScrollingFrame", gui)
    frame.Size = UDim2.new(0, 400, 0, 300)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundTransparency = 0.3
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.BorderSizePixel = 0
    frame.CanvasSize = UDim2.new(0,0,5,0)

    local layout = Instance.new("UIListLayout", frame)
    layout.Padding = UDim.new(0,5)

    local function log(text)
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, -10, 0, 20)
        label.TextColor3 = Color3.new(1,1,1)
        label.BackgroundTransparency = 1
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
