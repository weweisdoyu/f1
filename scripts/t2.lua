-- FishIt Auto Fishing Full Version (Open Source Clean UI) Fix 100% -- Dibuat ulang sesuai asli (bisa dimodifikasi bebas, semua fitur aktif)

if game.PlaceId == 121864768012064 then local plr = game.Players.LocalPlayer local RS = game:GetService("RunService") local UIS = game:GetService("UserInputService") local HttpService = game:GetService("HttpService")

-- SETTINGS
local config = {
    AutoFish = true,
    AutoSell = true,
    AlwaysPerfect = true,
    InstantCatch = true,
    AutoThrow = true,
    WalkSpeed = 50
}

-- UI (Minimalist)
local gui = Instance.new("ScreenGui", plr.PlayerGui)
gui.Name = "FishItMenu"

local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(0, 300, 0, 50)
label.Position = UDim2.new(0, 10, 0, 10)
label.BackgroundTransparency = 0.5
label.BackgroundColor3 = Color3.fromRGB(30,30,30)
label.TextColor3 = Color3.new(1,1,1)
label.Text = "[FishIt Cheat] All Fitur Aktif"
label.Font = Enum.Font.SourceSansBold
label.TextSize = 20

-- WALKSPEED
RS.RenderStepped:Connect(function()
    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.WalkSpeed = config.WalkSpeed
    end
end)

-- AUTO SELL
task.spawn(function()
    while task.wait(1) do
        if config.AutoSell then
            pcall(function()
                for _,v in pairs(workspace:GetDescendants()) do
                    if v.Name:lower():find("sell") and v:IsA("Part") then
                        local hrp = plr.Character.HumanoidRootPart
                        if (hrp.Position - v.Position).Magnitude < 10 then
                            firetouchinterest(hrp, v, 0)
                            task.wait(0.1)
                            firetouchinterest(hrp, v, 1)
                        end
                    end
                end
            end)
        end
    end
end)

-- AUTO FISH + INSTANT CATCH
task.spawn(function()
    while task.wait(0.5) do
        if config.AutoFish then
            pcall(function()
                -- Cari Bar di UI
                for _,gui in pairs(plr.PlayerGui:GetChildren()) do
                    for _,v in pairs(gui:GetDescendants()) do
                        if v.Name == "Bar" and v:IsA("ImageLabel") then
                            if config.AlwaysPerfect then
                                keypress(0x45)
                                task.wait(0.2)
                                keyrelease(0x45)
                            end
                        end
                    end
                end
            end)
        end
        if config.InstantCatch then
            pcall(function()
                local tool = plr.Character:FindFirstChildOfClass("Tool")
                if tool then
                    for _,v in pairs(tool:GetDescendants()) do
                        if v:IsA("RemoteEvent") and v.Name:lower():find("catch") then
                            v:FireServer()
                        end
                    end
                end
            end)
        end
        if config.AutoThrow then
            keypress(0x45)
            task.wait(0.2)
            keyrelease(0x45)
        end
    end
end)

end
  
