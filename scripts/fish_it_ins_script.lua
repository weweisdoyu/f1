-- FishIt Auto Fishing Full Version (Open Source Clean UI) -- Dibuat ulang dari versi asli (bisa dimodifikasi bebas)

if game.PlaceId == 121864768012064 then local plr = game.Players.LocalPlayer local UIS = game:GetService("UserInputService") local RS = game:GetService("RunService") local TweenService = game:GetService("TweenService")

-- SETTINGS
local config = {
    AutoFish = false,
    AutoSell = false,
    AlwaysPerfect = false,
    InstantCatch = false,
    AutoThrow = false,
    WalkSpeed = 16,
}

-- UI
local ScreenGui = Instance.new("ScreenGui", plr.PlayerGui)
ScreenGui.Name = "FishItUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 300)
Frame.Position = UDim2.new(0.05, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0

local function createToggle(name, posY, callback)
    local toggle = Instance.new("TextButton", Frame)
    toggle.Size = UDim2.new(0, 230, 0, 25)
    toggle.Position = UDim2.new(0, 10, 0, posY)
    toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
    toggle.TextColor3 = Color3.new(1,1,1)
    toggle.Text = "[OFF] "..name
    toggle.MouseButton1Click:Connect(function()
        local state = not callback()
        toggle.Text = (state and "[ON] " or "[OFF] ")..name
    end)
end

local function createSlider(name, posY, min, max, callback)
    local label = Instance.new("TextLabel", Frame)
    label.Size = UDim2.new(0, 230, 0, 20)
    label.Position = UDim2.new(0, 10, 0, posY)
    label.TextColor3 = Color3.new(1,1,1)
    label.BackgroundTransparency = 1
    label.Text = name..": "..config.WalkSpeed

    local slider = Instance.new("TextButton", Frame)
    slider.Size = UDim2.new(0, 230, 0, 15)
    slider.Position = UDim2.new(0, 10, 0, posY+20)
    slider.BackgroundColor3 = Color3.fromRGB(80,80,80)
    slider.Text = ""

    slider.MouseButton1Down:Connect(function()
        local con
        con = RS.RenderStepped:Connect(function()
            local mouseX = UIS:GetMouseLocation().X
            local relX = math.clamp((mouseX - slider.AbsolutePosition.X)/slider.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max-min)*relX)
            callback(value)
            label.Text = name..": "..value
        end)
        UIS.InputEnded:Wait()
        con:Disconnect()
    end)
end

-- Create Toggles
createToggle("Auto Fish", 10, function()
    config.AutoFish = not config.AutoFish
    return config.AutoFish
end)

createToggle("Auto Sell", 40, function()
    config.AutoSell = not config.AutoSell
    return config.AutoSell
end)

createToggle("Always Perfect", 70, function()
    config.AlwaysPerfect = not config.AlwaysPerfect
    return config.AlwaysPerfect
end)

createToggle("Instant Catch", 100, function()
    config.InstantCatch = not config.InstantCatch
    return config.InstantCatch
end)

createToggle("Auto Throw", 130, function()
    config.AutoThrow = not config.AutoThrow
    return config.AutoThrow
end)

createSlider("WalkSpeed", 160, 16, 100, function(val)
    config.WalkSpeed = val
end)

-- Functionality
local function autoSell()
    local sellPart = workspace:FindFirstChild("SellArea")
    if sellPart and (plr.Character.HumanoidRootPart.Position - sellPart.Position).Magnitude < 10 then
        firetouchinterest(plr.Character.HumanoidRootPart, sellPart, 0)
        wait(0.1)
        firetouchinterest(plr.Character.HumanoidRootPart, sellPart, 1)
    end
end

local function autoFish()
    local gui = plr.PlayerGui:FindFirstChild("FishItUI")
    if gui then
        local bar = gui:FindFirstChild("Bar")
        if bar then
            if config.AlwaysPerfect then
                keypress(0x45)
                wait(0.1)
                keyrelease(0x45)
            end
        else
            if config.AutoThrow then
                keypress(0x45)
                wait(0.1)
                keyrelease(0x45)
            end
        end
    end
end

local function instantCatch()
    local tool = plr.Character:FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("FishModule") then
        local event = tool.FishModule:FindFirstChild("CatchFish")
        if event and event:IsA("RemoteEvent") then
            event:FireServer()
        end
    end
end

-- Run loops
RS.RenderStepped:Connect(function()
    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.WalkSpeed = config.WalkSpeed
    end
end)

while task.wait(0.5) do
    pcall(function()
        if config.AutoFish then
            autoFish()
        end
        if config.InstantCatch then
            instantCatch()
        end
        if config.AutoSell then
            autoSell()
        end
    end)
end

end

