if game.PlaceId == 121864768012064 then
    local plr = game.Players.LocalPlayer
    local UIS = game:GetService("UserInputService")
    local RS = game:GetService("RunService")
    local RF = game.ReplicatedStorage:WaitForChild("RF")
    local RE = game.ReplicatedStorage:WaitForChild("RE")

    local remoteStart = RF:WaitForChild("RequestFishingMinigameStarted")
    local remoteCatch = RE:WaitForChild("FishingCompleted")
    local remoteBypass = RE:WaitForChild("UpdateAutoFishingState")

    local config = {
        AutoFish = false,
        WalkSpeed = 16,
    }

    -- Create GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "FishItAutoFishUI"
    gui.ResetOnSpawn = false
    gui.Parent = plr.PlayerGui

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 250, 0, 200)
    frame.Position = UDim2.new(0.05, 0, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 25)
    title.Text = "FishIt AutoFishing [HP Fix]"
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18

    local toggle = Instance.new("TextButton", frame)
    toggle.Size = UDim2.new(0, 230, 0, 30)
    toggle.Position = UDim2.new(0, 10, 0, 40)
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.Text = "[OFF] Auto Fish"

    toggle.MouseButton1Click:Connect(function()
        config.AutoFish = not config.AutoFish
        toggle.Text = (config.AutoFish and "[ON] " or "[OFF] ") .. "Auto Fish"
    end)

    local wsLabel = Instance.new("TextLabel", frame)
    wsLabel.Size = UDim2.new(0, 230, 0, 20)
    wsLabel.Position = UDim2.new(0, 10, 0, 80)
    wsLabel.BackgroundTransparency = 1
    wsLabel.TextColor3 = Color3.new(1, 1, 1)
    wsLabel.Text = "WalkSpeed: " .. config.WalkSpeed

    local wsSlider = Instance.new("TextButton", frame)
    wsSlider.Size = UDim2.new(0, 230, 0, 15)
    wsSlider.Position = UDim2.new(0, 10, 0, 100)
    wsSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    wsSlider.Text = ""

    wsSlider.MouseButton1Down:Connect(function()
        local con
        con = RS.RenderStepped:Connect(function()
            local mouseX = UIS:GetMouseLocation().X
            local relX = math.clamp((mouseX - wsSlider.AbsolutePosition.X) / wsSlider.AbsoluteSize.X, 0, 1)
            local value = math.floor(16 + (100 - 16) * relX)
            config.WalkSpeed = value
            wsLabel.Text = "WalkSpeed: " .. value
        end)
        UIS.InputEnded:Wait()
        con:Disconnect()
    end)

    -- Loop AutoFish
    task.spawn(function()
        while task.wait(2.5) do
            if config.AutoFish then
                pcall(function()
                    remoteStart:FireServer()
                    task.wait(0.5)
                    remoteBypass:FireServer(true) -- Bypass minigame + hoki 100%
                    task.wait(1.2)
                    remoteCatch:FireServer()
                end)
            end
        end
    end)

    -- WalkSpeed Control
    RS.RenderStepped:Connect(function()
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = config.WalkSpeed
        end
    end)

    print("FishIt AutoFishing HP Fix Loaded.")
end
