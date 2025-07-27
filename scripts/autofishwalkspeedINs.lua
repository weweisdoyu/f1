if game.PlaceId == 121864768012064 then
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local VirtualInput = game:GetService("VirtualInputManager")
    local UserInputService = game:GetService("UserInputService")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")

    local active = false
    local thread

    -- GUI
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "INS_AnomalyAutoFish"

    local frame = Instance.new("Frame", gui)
    frame.Position = UDim2.new(0.5, -150, 0.4, 0)
    frame.Size = UDim2.new(0, 300, 0, 210)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true

    local toggleButton = Instance.new("TextButton", frame)
    toggleButton.Size = UDim2.new(1, 0, 0, 40)
    toggleButton.Position = UDim2.new(0, 0, 0, 0)
    toggleButton.Text = "⏺️ Mulai Anomaly AutoFish"
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextSize = 16
    toggleButton.TextColor3 = Color3.new(1, 1, 1)
    toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    local statusLabel = Instance.new("TextLabel", frame)
    statusLabel.Size = UDim2.new(1, 0, 0, 30)
    statusLabel.Position = UDim2.new(0, 0, 0, 45)
    statusLabel.Text = "Status: Nonaktif"
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 14
    statusLabel.TextColor3 = Color3.new(1, 1, 1)
    statusLabel.BackgroundTransparency = 1

    local wsLabel = Instance.new("TextLabel", frame)
    wsLabel.Size = UDim2.new(1, -20, 0, 25)
    wsLabel.Position = UDim2.new(0, 10, 0, 80)
    wsLabel.Text = "🏃 WalkSpeed: " .. Humanoid.WalkSpeed
    wsLabel.TextColor3 = Color3.new(1, 1, 1)
    wsLabel.BackgroundTransparency = 1
    wsLabel.TextSize = 14

    local wsBox = Instance.new("TextBox", frame)
    wsBox.Size = UDim2.new(1, -20, 0, 25)
    wsBox.Position = UDim2.new(0, 10, 0, 110)
    wsBox.Text = tostring(Humanoid.WalkSpeed)
    wsBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    wsBox.TextColor3 = Color3.new(1, 1, 1)
    wsBox.ClearTextOnFocus = false
    wsBox.Font = Enum.Font.Gotham
    wsBox.TextSize = 14

    local applyBtn = Instance.new("TextButton", frame)
    applyBtn.Size = UDim2.new(1, -20, 0, 30)
    applyBtn.Position = UDim2.new(0, 10, 0, 145)
    applyBtn.Text = "✅ Terapkan WalkSpeed"
    applyBtn.TextColor3 = Color3.new(1, 1, 1)
    applyBtn.Font = Enum.Font.GothamBold
    applyBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 0)

    local closeBtn = Instance.new("TextButton", frame)
    closeBtn.Size = UDim2.new(1, -20, 0, 25)
    closeBtn.Position = UDim2.new(0, 10, 1, -30)
    closeBtn.Text = "❌ Tutup UI"
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    closeBtn.Font = Enum.Font.GothamBold

    -- Cek ikan tertangkap
    local function checkFishCaught()
        local inv = LocalPlayer:FindFirstChild("Backpack") or LocalPlayer:FindFirstChild("Character")
        if not inv then return false end
        for _, v in pairs(inv:GetChildren()) do
            if v.Name:lower():find("fish") then
                return true
            end
        end
        return false
    end

    -- Fungsi utama AutoFishing
    local function fullFishing()
        while active do
            -- Lempar
            VirtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            task.wait(0.08)
            VirtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 0)

            task.wait(0.25)

            -- Klik cepat tarik (kuat lawan ikan besar)
            for _ = 1, 40 do
                VirtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait(0.02)
                VirtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                task.wait(0.02)
            end

            task.wait(0.4)
        end
    end

    -- Toggle ON/OFF
    local function toggleAutoFish()
        active = not active
        toggleButton.Text = active and "⏹️ Stop AutoFish" or "⏺️ Mulai Anomaly AutoFish"
        statusLabel.Text = "Status: " .. (active and "Aktif" or "Nonaktif")
        if active then
            thread = coroutine.create(fullFishing)
            coroutine.resume(thread)
        elseif thread then
            thread = nil
        end
    end

    toggleButton.MouseButton1Click:Connect(toggleAutoFish)

    -- WalkSpeed Apply
    applyBtn.MouseButton1Click:Connect(function()
        local val = tonumber(wsBox.Text)
        if val then
            Humanoid.WalkSpeed = val
            wsLabel.Text = "🏃 WalkSpeed: " .. val
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        active = false
        thread = nil
        gui:Destroy()
    end)

    RunService.Heartbeat:Connect(function()
        if active and checkFishCaught() then
            active = false
            thread = nil
            toggleButton.Text = "⏺️ Mulai Anomaly AutoFish"
            statusLabel.Text = "Status: Nonaktif"
        end
    end)

    -- 🔥 HOTKEY: Tekan F6 untuk toggle
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.F6 then
            toggleAutoFish()
        end
    end)
end
