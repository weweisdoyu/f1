if game.PlaceId == 121864768012064 then
    local plr = game.Players.LocalPlayer
    local RS = game:GetService("RunService")

    -- Ambil Remote langsung
    local remoteStart = game.ReplicatedStorage:WaitForChild("RF"):WaitForChild("RequestFishingMinigameStarted")
    local remoteCatch = game.ReplicatedStorage:WaitForChild("RE"):WaitForChild("FishingCompleted")

    -- Buat UI ON/OFF
    local gui = Instance.new("ScreenGui", plr.PlayerGui)
    gui.Name = "FishItAutoHardcoded"

    local btn = Instance.new("TextButton", gui)
    btn.Size = UDim2.new(0, 150, 0, 50)
    btn.Position = UDim2.new(0.05, 0, 0.05, 0)
    btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20
    btn.Text = "Start Auto Fish"

    local auto = false

    btn.MouseButton1Click:Connect(function()
        auto = not auto
        btn.Text = auto and "Stop Auto Fish" or "Start Auto Fish"
    end)

    -- Auto Mancing Loop
    task.spawn(function()
        while true do
            if auto then
                pcall(function()
                    remoteStart:FireServer()
                    task.wait(1.5) -- Tunggu sedikit biar proses mancing jalan
                    remoteCatch:FireServer()
                end)
            end
            task.wait(2.5)
        end
    end)
end
