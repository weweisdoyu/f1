if game.PlaceId == 121864768012064 then
    local plr = game.Players.LocalPlayer
    local UIS = game:GetService("UserInputService")
    local RS = game:GetService("RunService")
    local RF = game.ReplicatedStorage:WaitForChild("RF")
    local RE = game.ReplicatedStorage:WaitForChild("RE")

    local remoteStart = RF:WaitForChild("RequestFishingMinigameStarted")
    local remoteCatch = RE:WaitForChild("FishingCompleted")
    local remoteBypass = RE:WaitForChild("UpdateAutoFishingState")

    -- Cari OnClick function
    local onClickFunc = nil
    for i,v in pairs(getgc(true)) do
        if typeof(v) == "function" and debug.getinfo(v).name == "OnClick" then
            onClickFunc = v
        end
    end

    -- Config
    local config = {
        AutoFish = false,
        WalkSpeed = 16,
    }

    -- UI
    local ScreenGui = Instance.new("ScreenGui", plr.PlayerGui)
    ScreenGui.Name = "FishItAutoUI"
    ScreenGui.ResetOnSpawn = false

    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 250, 0, 200)
    Frame.Position = UDim2.new(0.05, 0, 0.1, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Frame.BackgroundTransparency = 0.1
    Frame.BorderSizePixel = 0
    Frame.Active = true
    Frame.Draggable = true

    local title = Instance.new("TextLabel", Frame)
    title.Size = UDim2.new(1,0,0,25)
    title.Text = "FishIt AutoFishing"
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(1,1,1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18

    local autoFishToggle = Instance.new("TextButton", Frame)
    autoFishToggle.Size = UDim2.new(0,230,0,30)
    autoFishToggle.Position = UDim2.new(0,10,0,40)
    autoFishToggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
    autoFishToggle.TextColor3 = Color3.new(1,1,1)
    autoFishToggle.Text = "[OFF] Auto Fish"

    autoFishToggle.MouseButton1Click:Connect(function()
        config.AutoFish = not config.AutoFish
        autoFishToggle.Text = (config.AutoFish and "[ON] " or "[OFF] ").."Auto Fish"
    end)

    local wsLabel = Instance.new("TextLabel", Frame)
    wsLabel.Size = UDim2.new(0,230,0,20)
    wsLabel.Position = UDim2.new(0,10,0,80)
    wsLabel.BackgroundTransparency = 1
    wsLabel.TextColor3 = Color3.new(1,1,1)
    wsLabel.Text = "WalkSpeed: "..config.WalkSpeed

    local wsSlider = Instance.new("TextButton", Frame)
    wsSlider.Size = UDim2.new(0,230,0,15)
    wsSlider.Position = UDim2.new(0,10,0,100)
    wsSlider.BackgroundColor3 = Color3.fromRGB(80,80,80)
    wsSlider.Text = ""

    wsSlider.MouseButton1Down:Connect(function()
        local con
        con = RS.RenderStepped:Connect(function()
            local mouseX = UIS:GetMouseLocation().X
            local relX = math.clamp((mouseX - wsSlider.AbsolutePosition.X)/wsSlider.AbsoluteSize.X, 0, 1)
            local value = math.floor(16 + (100-16)*relX)
            config.WalkSpeed = value
            wsLabel.Text = "WalkSpeed: "..value
        end)
        UIS.InputEnded:Wait()
        con:Disconnect()
    end)

    -- Auto Fish Loop
    task.spawn(function()
        while task.wait(2.5) do
            pcall(function()
                if config.AutoFish then
                    remoteStart:FireServer()
                    task.wait(0.5)

                    if onClickFunc then
                        for i=1,5 do
                            pcall(onClickFunc)
                            task.wait(0.05)
                        end
                    end

                    remoteBypass:FireServer(true)
                    task.wait(1.2)
                    remoteCatch:FireServer()
                end
            end)
        end
    end)

    -- WalkSpeed Control
    RS.RenderStepped:Connect(function()
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = config.WalkSpeed
        end
    end)

    print("FishIt AutoFishing UI Loaded (Clean UI + OnClick + Bypass).")
end
