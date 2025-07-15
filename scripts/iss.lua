-- Auto Mancing FishIt + Loop Scan + Copyable TextBox + ON/OFF (Delta Android Friendly)

if game.PlaceId == 121864768012064 then local plr = game.Players.LocalPlayer local RS = game:GetService("RunService") local UIS = game:GetService("UserInputService")

-- UI Log di Layar (TextBox biar bisa di copy manual)
local gui = Instance.new("ScreenGui", plr.PlayerGui)
gui.Name = "FishItAutoFishLoopUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 500, 0, 300)
frame.Position = UDim2.new(0.05, 0, 0.05, 0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local logBox = Instance.new("TextBox", frame)
logBox.Size = UDim2.new(1, -20, 1, -60)
logBox.Position = UDim2.new(0, 10, 0, 10)
logBox.BackgroundColor3 = Color3.fromRGB(25,25,25)
logBox.TextColor3 = Color3.new(0,1,0)
logBox.TextXAlignment = Enum.TextXAlignment.Left
logBox.TextYAlignment = Enum.TextYAlignment.Top
logBox.ClearTextOnFocus = false
logBox.MultiLine = true
logBox.Font = Enum.Font.Code
logBox.TextSize = 14
logBox.TextWrapped = true
logBox.TextEditable = true
logBox.Text = "[Auto Mancing LOOP Scan]\nTekan tombol ON untuk mulai. Bisa di-copy manual.\n"

local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(0, 100, 0, 30)
toggleBtn.Position = UDim2.new(1, -110, 1, -40)
toggleBtn.Text = "ON"
toggleBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 14

local CatchFishRemote = nil
local autoFishing = false

toggleBtn.MouseButton1Click:Connect(function()
    autoFishing = not autoFishing
    if autoFishing then
        toggleBtn.Text = "OFF"
        logBox.Text = logBox.Text.."[Auto Mancing ON]\n"
    else
        toggleBtn.Text = "ON"
        logBox.Text = logBox.Text.."[Auto Mancing OFF]\n"
    end
end)

-- Loop Scan Remote tiap 5 detik
task.spawn(function()
    while true do
        if not CatchFishRemote then
            for i,v in pairs(getgc(true)) do
                if typeof(v) == "function" then
                    local info = debug.getinfo(v)
                    if info.name == "" and info.source:lower():find("fish") then
                        for k,uv in pairs(debug.getupvalues(v)) do
                            if typeof(uv) == "Instance" and uv:IsA("RemoteEvent") then
                                CatchFishRemote = uv
                                logBox.Text = logBox.Text.."[Detected Remote]: "..uv.Name.."\n"
                            end
                        end
                    end
                end
            end
        end
        task.wait(5)
    end
end)

-- Loop Auto Mancing
task.spawn(function()
    while true do
        if autoFishing and CatchFishRemote then
            pcall(function()
                CatchFishRemote:FireServer()
            end)
        end
        task.wait(1)
    end
end)

end

