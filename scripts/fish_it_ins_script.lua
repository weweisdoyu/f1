-- Fish It Delta Executor Script (Basic)

-- Disclaimer: Penggunaan skrip pihak ketiga dapat melanggar TOS Roblox dan berpotensi menyebabkan banned.
-- Gunakan dengan risiko Anda sendiri.

-- Fungsi untuk menunggu (delay)
local function wait(seconds)
    local start = tick()
    repeat task.wait() until tick() - start >= seconds
end

-- Fungsi Auto-Fish dasar
local function autoFish()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local fishingRod = character:FindFirstChild("FishingRod") -- Sesuaikan nama pancing jika berbeda

    if humanoid and fishingRod then
        print("Mulai Auto-Fish...")
        while true do
            -- Cek apakah pancing sudah dipegang
            if fishingRod.Parent == character then
                -- Klik untuk melempar pancing (simulasi)
                -- Ini adalah bagian yang paling sulit disimulasikan tanpa akses ke event internal game.
                -- Biasanya melibatkan event mouse.Button1Down/Up atau RemoteEvent.
                -- Contoh placeholder (mungkin tidak berfungsi tanpa reverse engineering game):
                -- game:GetService("ContextActionService"):BindAction("ThrowRod", function() return Enum.ContextActionResult.Pass end, false, Enum.UserInputType.MouseButton1)
                -- wait(0.1)
                -- game:GetService("ContextActionService"):UnbindAction("ThrowRod")

                -- Untuk tujuan demonstrasi, kita akan berasumsi pancing sudah dilempar dan menunggu ikan.
                print("Pancing dilempar, menunggu ikan...")
                wait(math.random(5, 15)) -- Tunggu antara 5-15 detik untuk ikan menggigit

                -- Simulasi menggulung pancing (jika ada event khusus)
                -- Ini juga memerlukan reverse engineering. Contoh placeholder:
                -- game:GetService("ContextActionService"):BindAction("ReelFish", function() return Enum.ContextActionResult.Pass end, false, Enum.UserInputType.MouseButton1)
                -- wait(0.1)
                -- game:GetService("ContextActionService"):UnbindAction("ReelFish")

                print("Mencoba menggulung pancing...")
                wait(2) -- Tunggu proses menggulung

                -- Cek apakah ikan tertangkap (ini sangat bergantung pada bagaimana game menangani inventaris/notifikasi)
                -- Ini adalah bagian yang sangat sulit untuk diimplementasikan secara generik.
                -- Skrip yang lebih canggih akan memantau perubahan di Player.Backpack atau Player.leaderstats.
                print("Ikan mungkin tertangkap.")
            else
                print("Pancing tidak ditemukan atau tidak dipegang. Pastikan Anda memegang pancing.")
                wait(5)
            end
            wait(1) -- Jeda sebelum mencoba lagi
        end
    else
        print("Pemain atau pancing tidak ditemukan.")
    end
end

-- UI sederhana untuk mengaktifkan/menonaktifkan Auto-Fish
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Name = "FishItScriptGUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

ToggleButton.Size = UDim2.new(0.8, 0, 0.4, 0)
ToggleButton.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ToggleButton.Text = "Auto-Fish: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 20
ToggleButton.Parent = Frame

local isAutoFishing = false
local autoFishThread = nil

ToggleButton.MouseButton1Click:Connect(function()
    isAutoFishing = not isAutoFishing
    if isAutoFishing then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        ToggleButton.Text = "Auto-Fish: ON"
        autoFishThread = task.spawn(autoFish)
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        ToggleButton.Text = "Auto-Fish: OFF"
        if autoFishThread then
            task.cancel(autoFishThread)
            autoFishThread = nil
        end
    end
end)

print("Skrip Fish It Delta Executor dimuat. Klik tombol untuk mengaktifkan Auto-Fish.")


