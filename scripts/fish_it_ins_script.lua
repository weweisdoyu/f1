if game.PlaceId == 121864768012064 then
    local plr = game.Players.LocalPlayer
    local RS = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local HttpService = game:GetService("HttpService")

    local RF = game.ReplicatedStorage:WaitForChild("RF")
    local RE = game.ReplicatedStorage:WaitForChild("RE")

    local remoteStart = RF:WaitForChild("RequestFishingMinigameStarted")
    local remoteCatch = RE:WaitForChild("FishingCompleted")
    local remoteBypass = RE:WaitForChild("UpdateAutoFishingState")

    -- Cari fungsi OnClick buat spam klik
    local onClickFunc = nil
    for i,v in pairs(getgc(true)) do
        if typeof(v) == "function" then
            local info = debug.getinfo(v)
            if info.name == "OnClick" then
                onClickFunc = v
            end
        end
    end

    -- UI
    local gui = Instance.new("ScreenGui", plr.PlayerGui)
    gui.Name = "FishItUltimateUI"
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 200, 0, 150)
    frame.Position = UDim2.new(0.5, -100, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.Active = true
    frame.Draggable = true

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.8, 0, 0.4, 0)
    btn.Position = UDim2.new(0.1, 0, 0.4, 0)
    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    btn.Text = "Auto-Fish: OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18

    local close = Instance.new("TextButton", frame)
    close.Size = UDim2.new(0, 20, 0, 20)
    close.Position = UDim2.new(1, -25, 0, 5)
    close.BackgroundColor3 = Color3.fromRGB(150,0,0)
    close.Text = "X"
    close.TextColor3 = Color3.new(1,1,1)
    close.Font = Enum.Font.SourceSansBold
    close.TextSize = 14

    local auto = false

    btn.MouseButton1Click:Connect(function()
        auto = not auto
        btn.Text = auto and "Auto-Fish: ON" or "Auto-Fish: OFF"
        btn.BackgroundColor3 = auto and Color3.fromRGB(150,0,0) or Color3.fromRGB(0,150,0)
    end)

    close.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    -- Loop auto fish
    task.spawn(function()
        while true do
            if auto then
                pcall(function()
                    remoteStart:FireServer()
                    task.wait(0.5)

                    -- Spam OnClick biar kaya manual klik
                    if onClickFunc then
                        for i=1,5 do
                            pcall(onClickFunc)
                            task.wait(0.05)
                        end
                    end

                    -- Bypass minigame (langsung auto sukses)
                    remoteBypass:FireServer(true)

                    task.wait(1.2)
                    remoteCatch:FireServer()
                end)
            end
            task.wait(2.5)
        end
    end)

    print("FishIt Ultimate Auto-Fish Loaded (Bypass + OnClick + UI Geser + Close).")
end
