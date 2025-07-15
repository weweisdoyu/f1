if game.PlaceId == 121864768012064 then
    local plr = game.Players.LocalPlayer
    local RS = game:GetService("RunService")

    -- Buat UI log + tombol ON OFF
    local gui = Instance.new("ScreenGui", plr.PlayerGui)
    gui.Name = "FishItAutoClicker"

    local label = Instance.new("TextLabel", gui)
    label.Size = UDim2.new(0, 400, 0, 100)
    label.Position = UDim2.new(0.05, 0, 0.05, 0)
    label.BackgroundColor3 = Color3.fromRGB(20,20,20)
    label.TextColor3 = Color3.new(0,1,0)
    label.Font = Enum.Font.Code
    label.TextSize = 14
    label.Text = "[FishIt Auto Fishing]\nLempar pancing dulu..."

    local remoteCatch = nil
    local remoteClick = nil

    -- Hook sekali buat tangkep Remote
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        if not checkcaller() then
            local method = getnamecallmethod()
            if method == "FireServer" or method == "InvokeServer" then
                local n = self.Name:lower()
                if n:find("catch") or n:find("fish") then
                    remoteCatch = self
                    label.Text = label.Text.."\n[Catch Remote]: "..self.Name
                elseif n:find("click") then
                    remoteClick = self
                    label.Text = label.Text.."\n[Click Remote]: "..self.Name
                end
            end
        end
        return old(self, ...)
    end)

    -- Tombol ON/OFF
    local btn = Instance.new("TextButton", gui)
    btn.Size = UDim2.new(0, 100, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0.2, 0)
    btn.Text = "Start"
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14

    local auto = false

    btn.MouseButton1Click:Connect(function()
        auto = not auto
        if auto then
            btn.Text = "Stop"
        else
            btn.Text = "Start"
        end
    end)

    -- Loop Auto Mancing + Auto Click
    task.spawn(function()
        while true do
            if auto then
                if remoteCatch then
                    pcall(function()
                        remoteCatch:FireServer()
                    end)
                end
                if remoteClick then
                    pcall(function()
                        remoteClick:FireServer()
                    end)
                end
            end
            task.wait(0.3)
        end
    end)
end
