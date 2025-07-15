-- Auto Detect RemoteEvent dari getgc + Auto Mancing Loop

if game.PlaceId == 121864768012064 then local plr = game.Players.LocalPlayer local RS = game:GetService("RunService")

local CatchFishRemote = nil

-- Cari RemoteEvent dari getgc
for i,v in pairs(getgc(true)) do
    if typeof(v) == "function" then
        local info = debug.getinfo(v)
        if info.name == "" and info.source:lower():find("fish") then
            for k,uv in pairs(debug.getupvalues(v)) do
                if typeof(uv) == "Instance" and uv:IsA("RemoteEvent") then
                    print("[DETECTED REMOTE]:", uv.Name)
                    CatchFishRemote = uv
                end
            end
        end
    end
end

-- Kalau ketemu remotenya, auto mancing loop
if CatchFishRemote then
    print("[AUTO MANCING STARTED]")
    while task.wait(1) do
        pcall(function()
            CatchFishRemote:FireServer()
        end)
    end
else
    warn("[REMOTE CATCH FISH TIDAK DITEMUKAN]")
end

end

