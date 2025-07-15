-- Hook __namecall tetap aktif
local old; old = hookmetamethod(game, "__namecall", function(self, ...)
    if not checkcaller() then
        local method = getnamecallmethod()
        if method == "FireServer" or method == "InvokeServer" then
            print("[HOOK] Remote Dipanggil:", self:GetFullName())
            local args = {...}
            for i,v in pairs(args) do
                print("[Arg "..i.."]:", v)
            end
        end
    end
    return old(self, ...)
end)

print("✅ HookMetamethod aktif!")

-- Tambahan: Scan getgc untuk cari fungsi tersembunyi
for i,v in pairs(getgc(true)) do
    if typeof(v) == "function" then
        local info = debug.getinfo(v)
        if info.name ~= "" then
            print("[GC Function]:", info.name, info.source)
        end
    end
end

print("✅ Scan getgc selesai! Lihat fungsi yang dipanggil di console saat mancing.")
