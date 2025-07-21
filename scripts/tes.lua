if game.PlaceId == 121864768012064 then
    local Players = game:GetService("Players")
    local VirtualInput = game:GetService("VirtualInputManager")
    local LocalPlayer = Players.LocalPlayer

    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "INSDev_Brutal80x"

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 300, 0, 140)
    frame.Position = UDim2.new(0.5, -150, 0.7, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,40)
    frame.Active = true
    frame.Draggable = true
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 25)
    title.Text = "INS Dev Brutal 80x Pull (NO JEDA)"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.BackgroundTransparency = 1

    local startBtn = Instance.new("TextButton", frame)
    startBtn.Size = UDim2.new(1, -20, 0, 40)
    startBtn.Position = UDim2.new(0, 10, 0, 40)
    startBtn.Text = "🎣 Start Brutal 80x"
    startBtn.Font = Enum.Font.GothamBold
    startBtn.TextSize = 14
    startBtn.TextColor3 = Color3.fromRGB(255,255,255)
    startBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
    Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0,8)

    local stopBtn = Instance.new("TextButton", frame)
    stopBtn.Size = UDim2.new(1, -20, 0, 40)
    stopBtn.Position = UDim2.new(0, 10, 0, 90)
    stopBtn.Text = "🛑 Stop"
    stopBtn.Font = Enum.Font.GothamBold
    stopBtn.TextSize = 14
    stopBtn.TextColor3 = Color3.fromRGB(255,255,255)
    stopBtn.BackgroundColor3 = Color3.fromRGB(255,100,100)
    Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0,8)

    local running = false

    local function brutalFish()
        while running do
            -- Lempar (E)
            VirtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.75)
            VirtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game)

            -- 80x klik TANPA JEDA
            for i=1,80 do
                VirtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                VirtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                -- NO task.wait() here
            end

            -- Langsung lanjut ke loop berikutnya tanpa nunggu
        end
    end

    startBtn.MouseButton1Click:Connect(function()
        if not running then
            running = true
            task.spawn(brutalFish)
            startBtn.Text = "✅ Brutal 80x Aktif"
        end
    end)

    stopBtn.MouseButton1Click:Connect(function()
        running = false
        startBtn.Text = "🎣 Start Brutal 80x"
    end)
end
