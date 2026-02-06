-- ==========================================
-- CONFIGURATION BY @reza new
-- ==========================================
local PASSWORD = "reza new"
local EXPIRED_DATE = "2026-02-01" -- Format: YYYY-MM-DD
local CURRENT_DATE = os.date("%Y-%m-%d")

-- 1. CEK EXPIRED
if CURRENT_DATE > EXPIRED_DATE then
    gg.alert("❌ SCRIPT SUDAH KADALUARSA!\n\nExpired: " .. EXPIRED_DATE .. "\nHubungi: @reza new")
    os.exit()
end

-- 2. CEK PASSWORD
local ask_pw = gg.prompt({"🔑 MASUKKAN PASSWORD:"}, nil, {"text"})
if not ask_pw then os.exit() end

if ask_pw[1] ~= PASSWORD then
    gg.alert("❌ PASSWORD SALAH!\nHubungi @reza new untuk mendapatkan akses.")
    os.exit()
else
    gg.toast("✅ LOGIN BERHASIL! WELCOME @reza new")
end

-- ==========================================
-- START SCRIPT UTAMA
-- ==========================================
gg.setVisible(false)

local S_FIRE = false

-- Fungsi Helper untuk Patch Lib
local function patch(offset, hex)
    local lib = "libil2cpp.so"
    local ranges = gg.getRangesList(lib)
    if #ranges == 0 then return end
    local addr = ranges[1].start + tonumber(offset, 16)
    gg.setValues({{address = addr, flags = gg.TYPE_BYTE, value = "h" .. hex}})
end

function F_BYPASS()
    local r_off = {"0x1429aec", "0x34eb93c", "0x4210494", "0x1431b64", "0x5363ef0", "0x5362800", "0x53627d8", "0x52a42b8", "0x4064314", "0x143adc0", "0x143b1d4"}
    for _, o in ipairs(r_off) do patch(o, "00 00 A0 E3 1E FF 2F E1") end
    
    local d_off = {"0x676e5f8", "0x671542c", "0x671564c", "0x6715d5c", "0x6715b70", "0x4fc0f98"}
    for _, o in ipairs(d_off) do patch(o, "00 00 A0 E3 1E FF 2F E1") end
    
    gg.toast("🛡️ BYPASS ACTIVE | BY @reza new")
end

function F_SPEED()
    gg.clearResults()
    if not S_FIRE then
        gg.searchNumber("h00 00 80 40 33 33 93 40 3D 0A F7 3F", 1)
        if gg.getResultsCount() > 0 then gg.getResults(100) gg.editAll("h00 00 80 40 00 00 80 40 CB D2 4D 3E", 1) end
        gg.clearResults()
        gg.searchNumber("h02 2B 07 3D 02 2B 07 3D 02 2B 07 3D", 1)
        if gg.getResultsCount() > 0 then gg.getResults(100) gg.editAll("h08 39 60 3B 08 39 60 3B 08 39 60 3B", 1) end
        S_FIRE = true
        gg.toast("🚀 SPEED FIRE: ON | BY @reza new")
    else
        gg.searchNumber("h00 00 80 40 00 00 80 40 CB D2 4D 3E", 1)
        if gg.getResultsCount() > 0 then gg.getResults(100) gg.editAll("h00 00 80 40 33 33 93 40 3D 0A F7 3F", 1) end
        gg.clearResults()
        gg.searchNumber("h08 39 60 3B 08 39 60 3B 08 39 60 3B", 1)
        if gg.getResultsCount() > 0 then gg.getResults(100) gg.editAll("h02 2B 07 3D 02 2B 07 3D 02 2B 07 3D", 1) end
        S_FIRE = false
        gg.toast("❌ SPEED FIRE: OFF | BY @reza new")
    end
    gg.clearResults()
end

while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        local menu = gg.choice({
            "1. 🚀 SPEED FIRE [" .. (S_FIRE and "ON" or "OFF") .. "]",
            "2. 🛡️ FULL BYPASS",
            "❌ EXIT"
        }, nil, "CREATED BY @reza new\nEXPIRED: " .. EXPIRED_DATE)

        if menu == 1 then F_SPEED() end
        if menu == 2 then F_BYPASS() end
        if menu == 3 then os.exit() end
    end
    gg.sleep(100)
end
