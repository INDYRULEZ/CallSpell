-- CallSpell — Hinweis, wenn dich jemand um einen Zauber bittet
-- Eigenstaendiges Addon, keine Abhaengigkeiten.

local ADDON = "CallSpell"
local VERSION = "1.7"

-- Feste Eigenschaften je Zauber. Alles Einstellbare steht in DB.spells.
local ZIELE = {
    {
        key = "rescue",
        name = "Rescue",
        spellID = 370665,
        phrase = "rescue me",
        sound = "Interface\\AddOns\\CallSpell\\Sounds\\rescue.ogg",
    },
}

-- Mitgelieferte Standard-Ansage (liegt im Addon selbst)
local STANDARD_SOUND = "Interface\\AddOns\\CallSpell\\Sounds\\assist.ogg"

local TEXTE = {
    de = {
        zauber = "Zauber",
        kanaele = "Kanäle",
        verhalten = "Verhalten",
        whitelist = "Wer darf auslösen",
        sprache = "Sprache",
        sprache_auto = "automatisch",
        sprache_de = "Deutsch",
        sprache_en = "Englisch",
        col_name = "Name", col_spellid = "SpellID", col_symbol = "Symbol",
        col_phrase = "Flüstertext", col_voice = "Stimme", col_target = "Standard Ziel",
        cb_whisper = "Flüstern", cb_party = "Gruppe", cb_raid = "Raid",
        cb_sound = "Ton abspielen", cb_debug = "Debug-Meldungen im Chat",
        slider = "Anzeigedauer",
        btn_add = "hinzufügen", btn_remove = "entfernen",
        btn_macro = "Macro erstellen", btn_new = "+ Zauber hinzufügen",
        hint_spells = "Symbol leer = Zauber-Symbol · Stimme leer = \"Assist me\". × entfernt die Zeile.",
        hint_list = "Leere Liste = jeder. Sonst nur die eingetragenen Namen (ohne Realm).",
        list_empty = "— noch niemand eingetragen, jeder darf auslösen —",
        new_spell = "Neuer Zauber", spell_icon = "Zauber-Symbol",
        geladen = "CallSpell %s geladen — /cs für Befehle",
        test = "Testhinweis gezeigt",
        an = "ist AN", aus = "ist AUS",
        ton_an = "Ton: an", ton_aus = "Ton: aus",
        kanal_unbekannt = "unbekannter Kanal: %s", kanal_gesetzt = "Kanal %s: %s",
        an_kurz = "an", aus_kurz = "aus",
        name_fehlt = "Name fehlt", steht_schon = "steht schon drauf: %s",
        hinzugefuegt = "hinzugefügt: %s", entfernt = "entfernt: %s",
        nicht_in_liste = "nicht in der Liste: %s",
        liste_leer = "Liste ist leer — jeder darf auslösen",
        liste_geleert = "Liste geleert — jeder darf auslösen",
        phrase_fehlt = "Text fehlt", zahl_fehlt = "Zahl fehlt",
        phrase_gesetzt = "%s: Flüstertext = %q",
        icon_gesetzt = "%s: Symbol-ID = %s",
        zauber_unbekannt = "unbekannter Zauber: %s",
        neu_fehlt = "SpellID fehlt: /cs neu <SpellID> [Name]",
        neu_gemacht = "hinzugefügt: %s (ID %d) — Flüstertext jetzt mit /cs phrase %d <Text> setzen",
        weg_fehlt = "Zeile gibt es nicht",
        debug_an = "Debug: an", debug_aus = "Debug: aus",
        makro_angelegt = "Makro angelegt (charakterspezifisch): %s",
        kein_platz = "kein freier Makro-Platz",
        ankam = "ankam: %s von %s: %q (Kampf=%s)",
        treffer = "Treffer %s von %s: %q",
        kein_treffer = "kein Treffer: %q von %s",
        ignoriert = "ignoriert (nicht auf der Liste): %s",
        ton_fehler = "Ton nicht abspielbar: %s",
        unbekannt = "unbekannter Befehl: %s",
        hilfe_titel = "— Befehle:",
        erlaubt = "erlaubt: %s",
        zeile_falsch = "Zeilennummer fehlt oder falsch: /cs %s <Zeile> <Wert>",
        hilfe = [[
  /cs config                Einstellungen (auch: Optionen -> Addons -> Call Spell)
  /cs test                  beide Hinweise zeigen
  /cs an | /cs aus          Addon ein/aus
  /cs ton an|aus            Ton ein/aus
  /cs wer <Name>            Namen zur Liste hinzufuegen
  /cs ohne <Name>           Namen entfernen
  /cs liste                 erlaubte Namen zeigen
  /cs alle                  Liste leeren (jeder darf)
  /cs neu <SpellID> [Name]  neue Zeile in der Tabelle
  /cs weg <Zeile>           Zeile entfernen
  /cs phrase <Zeile> <Text> Fluestertext setzen
  /cs icon <Zeile> <ID>     eigenes Symbol (0 = Zauber-Symbol)
  /cs kanal fluester|gruppe|raid an|aus
  /cs debug                 zeigt, was ankommt]],
    },
    en = {
        zauber = "Spells",
        kanaele = "Channels",
        verhalten = "Behaviour",
        whitelist = "Who may trigger",
        sprache = "Language",
        sprache_auto = "automatic",
        sprache_de = "German",
        sprache_en = "English",
        col_name = "Name", col_spellid = "SpellID", col_symbol = "Icon",
        col_phrase = "Whisper text", col_voice = "Voice", col_target = "Default target",
        cb_whisper = "Whisper", cb_party = "Party", cb_raid = "Raid",
        cb_sound = "Play sound", cb_debug = "Debug messages in chat",
        slider = "Display duration",
        btn_add = "add", btn_remove = "remove",
        btn_macro = "Create macro", btn_new = "+ Add spell",
        hint_spells = "Icon empty = spell icon · Voice empty = \"Assist me\". × removes the row.",
        hint_list = "Empty list = everyone. Otherwise only the listed names (without realm).",
        list_empty = "— nobody listed, everyone may trigger —",
        new_spell = "New spell", spell_icon = "spell icon",
        geladen = "CallSpell %s loaded — /cs for commands",
        test = "Test hint shown",
        an = "is ON", aus = "is OFF",
        ton_an = "Sound: on", ton_aus = "Sound: off",
        kanal_unbekannt = "unknown channel: %s", kanal_gesetzt = "Channel %s: %s",
        an_kurz = "on", aus_kurz = "off",
        name_fehlt = "name missing", steht_schon = "already listed: %s",
        hinzugefuegt = "added: %s", entfernt = "removed: %s",
        nicht_in_liste = "not in the list: %s",
        liste_leer = "List is empty — everyone may trigger",
        liste_geleert = "List cleared — everyone may trigger",
        phrase_fehlt = "text missing", zahl_fehlt = "number missing",
        phrase_gesetzt = "%s: whisper text = %q",
        icon_gesetzt = "%s: icon ID = %s",
        zauber_unbekannt = "unknown spell: %s",
        neu_fehlt = "SpellID missing: /cs neu <SpellID> [Name]",
        neu_gemacht = "added: %s (ID %d) — set the whisper text with /cs phrase %d <text>",
        weg_fehlt = "no such row",
        debug_an = "Debug: on", debug_aus = "Debug: off",
        makro_angelegt = "macro created (character specific): %s",
        kein_platz = "no free macro slot",
        ankam = "received: %s from %s: %q (combat=%s)",
        treffer = "match %s from %s: %q",
        kein_treffer = "no match: %q from %s",
        ignoriert = "ignored (not on the list): %s",
        ton_fehler = "sound not playable: %s",
        unbekannt = "unknown command: %s",
        hilfe_titel = "— commands:",
        erlaubt = "allowed: %s",
        zeile_falsch = "row number missing or wrong: /cs %s <row> <value>",
        hilfe = [[
  /cs config                settings (also: Options -> AddOns -> Call Spell)
  /cs test                  show both hints
  /cs an | /cs aus          addon on/off
  /cs ton an|aus            sound on/off
  /cs wer <Name>            add a name to the list
  /cs ohne <Name>           remove a name
  /cs liste                 show the list
  /cs alle                  clear the list (everyone may trigger)
  /cs neu <SpellID> [Name]  add a row to the table
  /cs weg <row>             remove a row
  /cs phrase <row> <text>   set the whisper text
  /cs icon <row> <ID>       custom icon (0 = spell icon)
  /cs kanal fluester|gruppe|raid an|aus
  /cs debug                 show what arrives]],
    },
}

local function spracheWahl()
    local quelle = CallSpellDB or DB
    local wahl = (quelle and quelle.sprache) or "auto"
    if wahl == "de" or wahl == "en" then return wahl end
    local spiel = GetLocale and GetLocale() or "enUS"
    if string.sub(spiel, 1, 2) == "de" then return "de" end
    return "en"
end

local function T(schluessel, ...)
    local sprache = spracheWahl()
    local texte = TEXTE[sprache] or TEXTE.en
    local wert = texte[schluessel] or TEXTE.en[schluessel] or schluessel
    if select("#", ...) > 0 then
        return string.format(wert, ...)
    end
    return wert
end

local VORGABEN = {
    sprache = "auto",      -- "auto" | "de" | "en"
    aktiv = true,
    fluestern = true,
    gruppe = false,
    raid = false,
    ton = true,
    fallback = true,      -- im Kampf ist der Flüstertext gesperrt → Fragezeichen-Alarm
    dauer = 5,
    spamSekunden = 3,
    debug = false,
    whitelist = {},
    spells = {},
}

local DB

-- ---------------------------------------------------------------- Hilfen

local function kopiere(t)
    local neu = {}
    for k, v in pairs(t) do
        neu[k] = type(v) == "table" and kopiere(v) or v
    end
    return neu
end

function dbInit()
    CallSpellDB = CallSpellDB or {}
    DB = CallSpellDB
    for k, v in pairs(VORGABEN) do
        if DB[k] == nil then
            DB[k] = type(v) == "table" and kopiere(v) or v
        end
    end
    -- Zauber als LISTE fuehren (Reihenfolge = Tabellenreihenfolge)
    local liste = DB.spells
    -- Altform (Schluessel rescue/paradox) uebernehmen
    if type(liste) == "table" and (liste.rescue or liste.paradox) then
        local migriert = {}
        for _, z in ipairs(ZIELE) do
            local e = liste[z.key]
            table.insert(migriert, {
                name = (e and e.name) or z.name,
                spellID = (e and e.spellID) or z.spellID,
                icon = (e and e.icon) or 0,
                phrase = (e and e.phrase) or z.phrase,
                sound = (e and e.sound) or z.sound,
                ziel = (e and e.ziel) or "",
            })
        end
        DB.spells = migriert
        liste = migriert
    end
    if type(liste) ~= "table" or #liste == 0 then
        liste = {}
        for _, z in ipairs(ZIELE) do
            table.insert(liste, { name = z.name, spellID = z.spellID, icon = 0,
                                  phrase = z.phrase, sound = z.sound, ziel = "" })
        end
        DB.spells = liste
    end
    if type(DB.naechsteID) ~= "number" then DB.naechsteID = 1 end
    for _, e in ipairs(liste) do
        if e.name == nil then e.name = T("zauber") end
        if e.spellID == nil then e.spellID = 0 end
        if e.icon == nil then e.icon = 0 end
        if e.phrase == nil then e.phrase = "" end
        if e.sound == nil then e.sound = "" end
        if e.ziel == nil then e.ziel = "" end
        if e.id == nil then
            e.id = DB.naechsteID
            DB.naechsteID = DB.naechsteID + 1
        end
    end
    -- Altbestand (phrasen/icons) verwerfen
    DB.phrasen = nil
    DB.icons = nil
end

local function istDa()
    if not DB then dbInit() end
end

local function normalisiere(text)
    if type(text) ~= "string" then return "" end
    text = string.lower(text)
    text = string.gsub(text, "^%s+", "")
    text = string.gsub(text, "%s+$", "")
    return text
end

local function kurzName(name)
    if type(name) ~= "string" then return "" end
    local ohneRealm = string.match(name, "^([^%-]+)")
    return string.lower(ohneRealm or name)
end

local function istErlaubt(name)
    local liste = DB.whitelist
    if not liste or #liste == 0 then return true end
    local wer = kurzName(name)
    for _, eintrag in ipairs(liste) do
        if eintrag == wer then return true end
    end
    return false
end

local function passt(text, ziel)
    -- 🔴 Im Kampf kann der Flüstertext ein "secret string" sein: jede String-Funktion
    -- darauf wirft einen Lua-Fehler. Deshalb hier kapseln statt den Handler sterben zu lassen.
    local ok, t = pcall(normalisiere, text)
    if not ok then return false, true end
    local p = normalisiere(ziel.phrase)
    if #p == 0 then return false end
    local ok2, treffer = pcall(string.find, t, p, 1, true)
    if not ok2 then return false, true end
    return treffer ~= nil
end

local letzterTreffer = {}

-- ---------------------------------------------------------------- Anzeige
-- Nur das Symbol: kein Text, kein Rahmen.

local anzeige = CreateFrame("Frame", "CallSpellAnzeige", UIParent)
anzeige:SetSize(56, 56)
anzeige:SetPoint("CENTER", UIParent, "CENTER", 0, 110)
anzeige:SetFrameStrata("HIGH")
anzeige:Hide()

local icon = anzeige:CreateTexture(nil, "ARTWORK")
icon:SetAllPoints(anzeige)
icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

local blendeTimer = 0
local puls = 0
anzeige:SetScript("OnUpdate", function(_, dt)
    blendeTimer = blendeTimer - dt
    puls = puls + dt
    anzeige:SetScale(1 + 0.08 * math.sin(puls * 7))
    if blendeTimer <= 0 then
        anzeige:Hide()
    end
end)

local function zeige(ziel, wer)
    if ziel.icon and ziel.icon > 0 then
        icon:SetTexture(ziel.icon)
    else
        local texture = C_Spell.GetSpellTexture(ziel.spellID)
        if texture then icon:SetTexture(texture) end
    end

    blendeTimer = DB.dauer
    puls = 0
    anzeige:Show()

    if DB.ton then
        local pfad = ziel.sound
        if not pfad or #pfad == 0 then pfad = STANDARD_SOUND end
        if pfad and #pfad > 0 then
            local gespielt = PlaySoundFile(pfad, "Master")
            if not gespielt and DB.debug then
                print("|cffff8080CallSpell|r " .. T("ton_fehler", pfad))
            end
        end
    end
end

-- ---------------------------------------------------------------- Ereignisse

local rahmen = CreateFrame("Frame")

local letzterErsatz = {}
local FRAGEZEICHEN = 134400   -- INV_Misc_QuestionMark (ID, kein Pfad: zeige() vergleicht mit > 0)

-- Im Kampf ist der Flüstertext ein "secret string" — dann bleibt nur: Alarm ohne Zauber.
local function zeigeErsatz(wer)
    local jetzt = GetTime()
    local werKurz = kurzName(wer or "")
    if letzterErsatz[werKurz] and (jetzt - letzterErsatz[werKurz]) < DB.spamSekunden then return end
    letzterErsatz[werKurz] = jetzt
    zeige({ name = "?", icon = FRAGEZEICHEN, spellID = 0, sound = "" }, wer)
end

local function pruefe(event, text, wer)
    istDa()
    if not DB.aktiv then return end

    if DB.debug then
        print("|cff8080ffCallSpell|r " .. T("ankam",
            event, tostring(wer), tostring(text), tostring(InCombatLockdown())))
    end

    if event == "CHAT_MSG_WHISPER" and not DB.fluestern then return end
    if (event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER") and not DB.gruppe then return end
    if (event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER") and not DB.raid then return end

    if not istErlaubt(wer) then
        if DB.debug then
            print("|cffff8080CallSpell|r " .. T("ignoriert", tostring(wer)))
        end
        return
    end

    local gesperrt = false
    for _, ziel in ipairs(DB.spells) do
        local treffer, blockiert = passt(text, ziel)
        if blockiert then gesperrt = true end
        if treffer then
            local jetzt = GetTime()
            if DB.debug then
                print("|cff80ff80CallSpell|r " .. T("treffer",
                    ziel.name, tostring(wer), tostring(text)))
            end
            if not letzterTreffer[ziel.id] or (jetzt - letzterTreffer[ziel.id]) >= DB.spamSekunden then
                letzterTreffer[ziel.id] = jetzt
                zeige(ziel, wer)
            end
            return
        end
    end

    if gesperrt and DB.fallback then
        if DB.debug then
            print("|cffffcc00CallSpell|r " .. T("text_gesperrt", tostring(wer)))
        end
        zeigeErsatz(wer)
        return
    end

    if DB.debug then
        print("|cffffcc00CallSpell|r " .. T("kein_treffer", tostring(text), tostring(wer)))
    end
end

rahmen:RegisterEvent("ADDON_LOADED")
rahmen:RegisterEvent("PLAYER_LOGIN")
rahmen:RegisterEvent("CHAT_MSG_WHISPER")
rahmen:RegisterEvent("CHAT_MSG_PARTY")
rahmen:RegisterEvent("CHAT_MSG_PARTY_LEADER")
rahmen:RegisterEvent("CHAT_MSG_RAID")
rahmen:RegisterEvent("CHAT_MSG_RAID_LEADER")

rahmen:SetScript("OnEvent", function(_, event, arg1, arg2, ...)
    if event == "ADDON_LOADED" then
        if arg1 ~= ADDON then return end
        dbInit()
        print("|cff00ff00CallSpell|r " .. T("geladen", VERSION))
        return
    end
    if event == "PLAYER_LOGIN" then
        C_Timer.After(1, function() baueOptionen() end)
        return
    end
    pruefe(event, arg1, arg2)
end)

-- ---------------------------------------------------------------- Befehle

local function hilfe()
    print("|cff00ff00CallSpell|r " .. T("hilfe_titel"))
    for zeile in string.gmatch(T("hilfe"), "[^\n]+") do
        print(zeile)
    end
end


local function befehl(rest)
    istDa()
    local wort, reste = string.match(rest or "", "^(%S*)%s*(.-)$")
    wort = string.lower(wort or "")

    if wort == "" or wort == "hilfe" or wort == "help" then
        hilfe()
    elseif wort == "test" then
        for _, ziel in ipairs(DB.spells) do
            zeige(ziel, "Test")
        end
        print("|cff00ff00CallSpell|r " .. T("test"))
    elseif wort == "an" then
        DB.aktiv = true
        print("|cff00ff00CallSpell|r " .. T("an"))
    elseif wort == "aus" then
        DB.aktiv = false
        print("|cff00ff00CallSpell|r " .. T("aus"))
    elseif wort == "ton" then
        DB.ton = (string.lower(reste) ~= "aus")
        print("|cff00ff00CallSpell|r " .. (DB.ton and T("ton_an") or T("ton_aus")))
    elseif wort == "kanal" then
        local kanal, zustand = string.match(reste, "^(%S+)%s*(%S*)$")
        kanal = string.lower(kanal or "")
        local an = string.lower(zustand or "") ~= "aus"
        if kanal == "fluester" or kanal == "flüstern" then DB.fluestern = an
        elseif kanal == "gruppe" then DB.gruppe = an
        elseif kanal == "raid" then DB.raid = an
        else print("|cffff8080CallSpell|r " .. T("kanal_unbekannt", kanal)) return end
        print("|cff00ff00CallSpell|r " .. T("kanal_gesetzt", kanal, an and T("an_kurz") or T("aus_kurz")))
    elseif wort == "wer" then
        local name = kurzName(reste)
        if #name == 0 then print("|cffff8080CallSpell|r " .. T("name_fehlt")) return end
        for _, e in ipairs(DB.whitelist) do
            if e == name then print("|cff00ff00CallSpell|r " .. T("steht_schon", name)) return end
        end
        table.insert(DB.whitelist, name)
        print("|cff00ff00CallSpell|r " .. T("hinzugefuegt", name))
    elseif wort == "ohne" then
        local name = kurzName(reste)
        for i, e in ipairs(DB.whitelist) do
            if e == name then
                table.remove(DB.whitelist, i)
                print("|cff00ff00CallSpell|r " .. T("entfernt", name))
                return
            end
        end
        print("|cffff8080CallSpell|r " .. T("nicht_in_liste", name))
    elseif wort == "liste" then
        if #DB.whitelist == 0 then
            print("|cff00ff00CallSpell|r " .. T("liste_leer"))
        else
            print("|cff00ff00CallSpell|r " .. T("erlaubt", table.concat(DB.whitelist, ", ")))
        end
    elseif wort == "alle" then
        DB.whitelist = {}
        print("|cff00ff00CallSpell|r " .. T("liste_geleert"))
    elseif wort == "neu" then
        local nr, name = string.match(reste, "^(%S*)%s*(.-)$")
        local spellID = tonumber(nr)
        if not spellID then print("|cffff8080CallSpell|r " .. T("neu_fehlt")) return end
        DB.naechsteID = (DB.naechsteID or 1) + 1
        table.insert(DB.spells, {
            id = DB.naechsteID,
            name = (#name > 0) and name or ("Zauber " .. spellID),
            spellID = math.floor(spellID),
            icon = 0,
            phrase = "",
            sound = "",
            ziel = "",
        })
        print("|cff00ff00CallSpell|r " .. T("neu_gemacht",
            (#name > 0) and name or ("Zauber " .. spellID), math.floor(spellID), #DB.spells))
    elseif wort == "weg" then
        local nr = tonumber(reste)
        if not nr or not DB.spells[nr] then print("|cffff8080CallSpell|r " .. T("weg_fehlt")) return end
        local name = DB.spells[nr].name
        table.remove(DB.spells, nr)
        print("|cff00ff00CallSpell|r " .. T("entfernt", tostring(name)))
    elseif wort == "phrase" or wort == "icon" then
        local nr, wert = string.match(reste, "^(%S*)%s*(.-)$")
        local e = DB.spells[tonumber(nr) or 0]
        if not e then print("|cffff8080CallSpell|r " .. T("zeile_falsch", wort)) return end
        if wort == "phrase" then
            if wert and #wert > 0 then
                e.phrase = wert
                print("|cff00ff00CallSpell|r " .. T("phrase_gesetzt", e.name, wert))
            else
                print("|cffff8080CallSpell|r " .. T("phrase_fehlt")) return
            end
        else
            local n = tonumber(wert)
            if not n then print("|cffff8080CallSpell|r " .. T("zahl_fehlt")) return end
            e.icon = (n > 0) and math.floor(n) or 0
            print("|cff00ff00CallSpell|r " .. T("icon_gesetzt", e.name,
                (e.icon > 0) and tostring(e.icon) or T("spell_icon")))
        end
    elseif wort == "config" or wort == "optionen" or wort == "einstellungen" then
        oeffneOptionen()
    elseif wort == "debug" then
        DB.debug = not DB.debug
        print("|cff00ff00CallSpell|r " .. (DB.debug and T("debug_an") or T("debug_aus")))
    else
        print("|cffff8080CallSpell|r " .. T("unbekannt", wort))
        hilfe()
    end
end

SLASH_CALLSPELL1 = "/cs"
SLASH_CALLSPELL2 = "/callspell"
SlashCmdList["CALLSPELL"] = befehl

-- ---------------------------------------------------------------- Makro

local function makroErstellen(eintrag)
    if InCombatLockdown() then return end          -- im Kampf gesperrt: still nichts tun

    local name = "CS" .. tostring(eintrag.name or "Zauber")
    if #name > 16 then name = string.sub(name, 1, 16) end

    local ziel = (eintrag.ziel and #eintrag.ziel > 0) and eintrag.ziel or nil

    local spellName = eintrag.name
    local texture = (eintrag.icon and eintrag.icon > 0) and eintrag.icon or nil
    if eintrag.spellID and eintrag.spellID > 0 then
        local info = C_Spell.GetSpellInfo(eintrag.spellID)
        if info then
            if info.name and #info.name > 0 then spellName = info.name end
            if not texture and info.iconID then texture = info.iconID end
        end
    end
    texture = texture or 134400

    local koerper
    if ziel then
        koerper = string.format("#showtooltip %s\n/cast [@%s,help,nodead][] %s", spellName, ziel, spellName)
    else
        koerper = string.format("#showtooltip %s\n/cast %s", spellName, spellName)
    end

    -- Vorhandenes Makro gleichen Namens entfernen (sonst bleibt es "allgemein")
    local index = GetMacroIndexByName and GetMacroIndexByName(name) or 0
    if index and index > 0 then
        DeleteMacro(index)
    end

    local neu = CreateMacro(name, texture, koerper, true)   -- true = charakterspezifisch
    if neu then
        print("|cff00ff00CallSpell|r " .. T("makro_angelegt", name))
    else
        print("|cffff8080CallSpell|r " .. T("kein_platz"))
    end
end

-- ---------------------------------------------------------------- Einstellungen (Spiel-Optionen)

local optionenPanel
local inhaltFrame
local aufbauZaehler = 0

local function ueberschrift(eltern, text, y)
    local fs = eltern:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    fs:SetPoint("TOPLEFT", eltern, "TOPLEFT", 12, y)
    fs:SetText(text)
    return fs
end

local function hinweis(eltern, text, y, breite)
    local fs = eltern:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    fs:SetPoint("TOPLEFT", eltern, "TOPLEFT", 12, y)
    fs:SetWidth(breite or 420)
    fs:SetJustifyH("LEFT")
    fs:SetText(text)
    return fs
end

local function kaestchen(eltern, beschriftung, x, y, lesen, schreiben)
    local cb = CreateFrame("CheckButton", nil, eltern, "UICheckButtonTemplate")
    cb:SetPoint("TOPLEFT", eltern, "TOPLEFT", x, y)
    cb:SetSize(26, 26)
    if cb.Text then cb.Text:SetText(beschriftung) end
    cb:SetScript("OnClick", function(self) schreiben(self:GetChecked() and true or false) end)
    cb.aktualisiere = function() cb:SetChecked(lesen() and true or false) end
    cb.aktualisiere()
    return cb
end

-- Schlichtes Eingabefeld (kein InputBoxTemplate: das verschiebt den Textbereich)
local function feld(eltern, x, y, breite, lesen, schreiben)
    local eb = CreateFrame("EditBox", nil, eltern)
    eb:SetSize(breite, 20)
    eb:SetPoint("TOPLEFT", eltern, "TOPLEFT", x, y)
    eb:SetAutoFocus(false)
    eb:SetMaxLetters(80)
    eb:SetFontObject(GameFontHighlight)
    eb:SetTextColor(1, 1, 1)
    eb:SetJustifyH("LEFT")
    eb:SetTextInsets(4, 4, 0, 0)
    eb:EnableMouse(true)
    local bg = eb:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(1, 1, 1, 0.08)
    eb:SetText(tostring(lesen() or ""))
    eb:SetCursorPosition(0)
    local function sichern(self) schreiben(self:GetText() or "") end
    eb:SetScript("OnEnterPressed", function(self) sichern(self); self:ClearFocus() end)
    eb:SetScript("OnEditFocusLost", sichern)
    eb:SetScript("OnEscapePressed", function(self) self:SetText(tostring(lesen() or "")); self:ClearFocus() end)
    eb.aktualisiere = function() eb:SetText(tostring(lesen() or "")) end
    return eb
end

-- letzte Spalte (Makro-Knopf) hat absichtlich keine Ueberschrift
local SPALTEN = { { "col_name", 8, 70 }, { "col_spellid", 82, 56 }, { "col_symbol", 142, 56 },
                  { "col_phrase", 202, 86 }, { "col_voice", 292, 108 }, { "col_target", 404, 76 } }

-- Baut den gesamten Inhalt neu auf (nach Hinzufuegen/Entfernen eines Zaubers)
local function aufbauen()
    if inhaltFrame then
        inhaltFrame:Hide()
        inhaltFrame = nil
    end
    aufbauZaehler = aufbauZaehler + 1
    local c = CreateFrame("Frame", nil, optionenPanel)
    c:SetAllPoints(optionenPanel)
    inhaltFrame = c

    local y = -16

    -- ---------------- Zauber-Tabelle
    ueberschrift(c, T("zauber"), y)
    y = y - 30

    for _, spalte in ipairs(SPALTEN) do
        local fs = c:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        fs:SetPoint("TOPLEFT", c, "TOPLEFT", spalte[2], y)
        fs:SetText(T(spalte[1]))
    end

    local linie = c:CreateTexture(nil, "ARTWORK")
    linie:SetColorTexture(1, 1, 1, 0.15)
    linie:SetPoint("TOPLEFT", c, "TOPLEFT", 12, y - 14)
    linie:SetSize(596, 1)

    local felder = {}
    local zeilenY = y - 22

    for i, eintrag in ipairs(DB.spells) do
        local idx = i          -- wichtig: eigene Kopie je Zeile (Lua 5.1 teilt die Laufvariable)
        local zy = zeilenY - (i - 1) * 28
        felder[i] = {
            name = feld(c, 8, zy, 70,
                function() return DB.spells[idx] and DB.spells[idx].name end,
                function(t) local e = DB.spells[idx]; if e and #t > 0 then e.name = t end end),
            spellID = feld(c, 82, zy, 56,
                function() local e = DB.spells[idx]; return e and tostring(e.spellID) end,
                function(t) local e = DB.spells[idx]; local n = tonumber(t)
                    if e and n and n > 0 then e.spellID = math.floor(n) end end),
            icon = feld(c, 142, zy, 56,
                function() local e = DB.spells[idx]; return (e and e.icon and e.icon > 0) and tostring(e.icon) or "" end,
                function(t) local e = DB.spells[idx]; local n = tonumber(t)
                    if e then e.icon = (n and n > 0) and math.floor(n) or 0 end end),
            phrase = feld(c, 202, zy, 86,
                function() local e = DB.spells[idx]; return e and e.phrase end,
                function(t) local e = DB.spells[idx]; if e then e.phrase = t end end),
            sound = feld(c, 292, zy, 108,
                function() local e = DB.spells[idx]; return e and e.sound end,
                function(t) local e = DB.spells[idx]; if e then e.sound = t end end),
            ziel = feld(c, 404, zy, 76,
                function() local e = DB.spells[idx]; return e and e.ziel end,
                function(t) local e = DB.spells[idx]; if e then e.ziel = t end end),
        }
        local makro = CreateFrame("Button", nil, c, "UIPanelButtonTemplate")
        makro:SetSize(104, 20)
        makro:SetPoint("TOPLEFT", c, "TOPLEFT", 486, zy)
        makro:SetText(T("btn_macro"))
        makro:SetScript("OnClick", function()
            makroErstellen(DB.spells[idx])
        end)
        felder[i].makro = makro

        local weg = CreateFrame("Button", nil, c, "UIPanelButtonTemplate")
        weg:SetSize(18, 18)
        weg:SetPoint("TOPLEFT", c, "TOPLEFT", 594, zy + 1)
        weg:SetText("×")
        weg:SetScript("OnClick", function()
            table.remove(DB.spells, idx)
            aufbauen()
            if optionenPanel.aktualisiere then optionenPanel.aktualisiere() end
        end)
        felder[i].weg = weg
    end

    y = zeilenY - math.max(1, #DB.spells) * 28 - 6

    local neuerKnopf = CreateFrame("Button", nil, c, "UIPanelButtonTemplate")
    neuerKnopf:SetSize(150, 22)
    neuerKnopf:SetPoint("TOPLEFT", c, "TOPLEFT", 12, y)
    neuerKnopf:SetText(T("btn_new"))
    neuerKnopf:SetScript("OnClick", function()
        DB.naechsteID = (DB.naechsteID or 1) + 1
        table.insert(DB.spells, { id = DB.naechsteID, name = T("new_spell"), spellID = 0,
                                  icon = 0, phrase = "", sound = "", ziel = "" })
        aufbauen()
        if optionenPanel.aktualisiere then optionenPanel.aktualisiere() end
    end)

    y = y - 28
    hinweis(c, T("hint_spells"), y, 520)

    -- ---------------- Kanaele
    y = y - 26
    ueberschrift(c, T("kanaele"), y)
    y = y - 30
    kaestchen(c, T("cb_whisper"), 16, y, function() return DB.fluestern end, function(w) DB.fluestern = w end)
    kaestchen(c, T("cb_party"), 170, y, function() return DB.gruppe end, function(w) DB.gruppe = w end)
    kaestchen(c, T("cb_raid"), 300, y, function() return DB.raid end, function(w) DB.raid = w end)

    -- ---------------- Verhalten
    y = y - 40
    ueberschrift(c, T("verhalten"), y)
    y = y - 30
    kaestchen(c, T("cb_sound"), 16, y, function() return DB.ton end, function(w) DB.ton = w end)

    local dauerWert = c:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    dauerWert:SetPoint("TOPLEFT", c, "TOPLEFT", 330, y - 6)
    dauerWert:SetText(string.format("%d s", DB.dauer))

    local sliderName = "CallSpellDauerSlider" .. aufbauZaehler
    local slider = CreateFrame("Slider", sliderName, c, "OptionsSliderTemplate")
    slider:SetPoint("TOPLEFT", c, "TOPLEFT", 16, y - 34)
    slider:SetSize(280, 16)
    slider:SetMinMaxValues(1, 15)
    slider:SetValueStep(1)
    slider:SetObeyStepOnDrag(true)
    if _G[sliderName .. "Text"] then _G[sliderName .. "Text"]:SetText(T("slider")) end
    if _G[sliderName .. "Low"] then _G[sliderName .. "Low"]:SetText("1") end
    if _G[sliderName .. "High"] then _G[sliderName .. "High"]:SetText("15") end
    slider:SetValue(DB.dauer)
    slider:SetScript("OnValueChanged", function(_, wert)
        wert = math.floor((wert or 5) + 0.5)
        DB.dauer = wert
        dauerWert:SetText(string.format("%d s", wert))
    end)

    -- ---------------- Whitelist
    y = y - 72
    ueberschrift(c, T("whitelist"), y)
    hinweis(c, T("hint_list"), y - 22, 430)

    local eingabe = CreateFrame("EditBox", nil, c)
    eingabe:SetSize(200, 22)
    eingabe:SetPoint("TOPLEFT", c, "TOPLEFT", 18, y - 44)
    eingabe:SetAutoFocus(false)
    eingabe:SetMaxLetters(40)
    eingabe:SetFontObject(GameFontHighlight)
    eingabe:SetTextColor(1, 1, 1)
    eingabe:SetTextInsets(4, 4, 0, 0)
    eingabe:EnableMouse(true)
    local ebBg = eingabe:CreateTexture(nil, "BACKGROUND")
    ebBg:SetAllPoints()
    ebBg:SetColorTexture(1, 1, 1, 0.08)

    local hinzu = CreateFrame("Button", nil, c, "UIPanelButtonTemplate")
    hinzu:SetSize(110, 24)
    hinzu:SetPoint("LEFT", eingabe, "RIGHT", 8, 0)
    hinzu:SetText(T("btn_add"))

    local listeRahmen = CreateFrame("Frame", nil, c)
    listeRahmen:SetPoint("TOPLEFT", c, "TOPLEFT", 18, y - 74)
    listeRahmen:SetSize(420, 78)

    local scrollName = "CallSpellListeScroll" .. aufbauZaehler
    local scroll = CreateFrame("ScrollFrame", scrollName, listeRahmen, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 0, 0)
    scroll:SetSize(396, 78)

    local inhalt = CreateFrame("Frame", nil, scroll)
    inhalt:SetSize(380, 1)
    scroll:SetScrollChild(inhalt)

    local zeilen = {}
    local leerText

    local function zeichneListe()
        table.sort(DB.whitelist)
        local anzahl = #DB.whitelist

        if anzahl == 0 then
            if not leerText then
                leerText = inhalt:CreateFontString(nil, "ARTWORK", "GameFontDisable")
                leerText:SetPoint("TOPLEFT", inhalt, "TOPLEFT", 2, -4)
                leerText:SetText(T("list_empty"))
            end
            leerText:Show()
        elseif leerText then
            leerText:Hide()
        end

        for i, name in ipairs(DB.whitelist) do
            local zeile = zeilen[i]
            if not zeile then
                zeile = CreateFrame("Frame", nil, inhalt)
                zeile:SetSize(370, 24)
                zeile:SetPoint("TOPLEFT", inhalt, "TOPLEFT", 2, -(i - 1) * 26)
                zeile.namensText = zeile:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
                zeile.namensText:SetPoint("LEFT", zeile, "LEFT", 0, 0)
                zeile.namensText:SetWidth(220)
                zeile.namensText:SetJustifyH("LEFT")
                zeile.weg = CreateFrame("Button", nil, zeile, "UIPanelButtonTemplate")
                zeile.weg:SetSize(100, 22)
                zeile.weg:SetPoint("LEFT", zeile, "LEFT", 240, 0)
                zeile.weg:SetText(T("btn_remove"))
                zeilen[i] = zeile
            end
            zeile.namensText:SetText(name)
            zeile.weg:SetScript("OnClick", function()
                for k, e in ipairs(DB.whitelist) do
                    if e == name then
                        table.remove(DB.whitelist, k)
                        break
                    end
                end
                zeichneListe()
            end)
            zeile:Show()
        end

        for i = anzahl + 1, #zeilen do zeilen[i]:Hide() end
        inhalt:SetSize(380, math.max(1, anzahl * 26))
    end

    local function hinzufuegen()
        local name = kurzName(eingabe:GetText() or "")
        if #name == 0 then return end
        for _, e in ipairs(DB.whitelist) do
            if e == name then eingabe:SetText("") return end
        end
        table.insert(DB.whitelist, name)
        eingabe:SetText("")
        zeichneListe()
    end

    hinzu:SetScript("OnClick", hinzufuegen)
    eingabe:SetScript("OnEnterPressed", function(self) hinzufuegen(); self:ClearFocus() end)

    zeichneListe()

    y = y - 74 - 78 - 6
    kaestchen(c, T("cb_debug"), 16, y, function() return DB.debug end,
        function(w) DB.debug = w end)

    -- Sprache
    y = y - 36
    ueberschrift(c, T("sprache"), y)
    y = y - 30
    local sprachKnopf = CreateFrame("Button", nil, c, "UIPanelButtonTemplate")
    sprachKnopf:SetSize(220, 22)
    sprachKnopf:SetPoint("TOPLEFT", c, "TOPLEFT", 12, y)
    local function sprachText()
        local w = DB.sprache or "auto"
        if w == "de" then return T("sprache_de") end
        if w == "en" then return T("sprache_en") end
        return T("sprache_auto")
    end
    sprachKnopf:SetText(sprachText())
    sprachKnopf:SetScript("OnClick", function()
        local w = DB.sprache or "auto"
        if w == "auto" then DB.sprache = "de"
        elseif w == "de" then DB.sprache = "en"
        else DB.sprache = "auto" end
        aufbauen()
        if optionenPanel.aktualisiere then optionenPanel.aktualisiere() end
    end)

    optionenPanel.aktualisiere = function()
        for _, satz in ipairs(felder) do
            for _, f in pairs(satz) do
                if type(f) == "table" and f.aktualisiere then f:aktualisiere() end
            end
        end
        dauerWert:SetText(string.format("%d s", DB.dauer))
        slider:SetValue(DB.dauer)
        zeichneListe()
    end

    return c
end

function baueOptionen()
    if optionenPanel then return optionenPanel end

    local p = CreateFrame("Frame", "CallSpellOptionen")
    p.name = "Call Spell"
    optionenPanel = p

    aufbauen()

    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        local kat = Settings.RegisterCanvasLayoutCategory(p, "Call Spell")
        if kat then
            Settings.RegisterAddOnCategory(kat)
            p.kategorie = kat
        end
    end

    if not p.kategorie then
        p:SetSize(600, 560)
        p:SetPoint("CENTER")
        p:SetFrameStrata("DIALOG")
        p:EnableMouse(true)
        p:SetMovable(true)
        p:RegisterForDrag("LeftButton")
        p:SetScript("OnDragStart", p.StartMoving)
        p:SetScript("OnDragStop", p.StopMovingOrSizing)
        local bg = p:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(0.05, 0.05, 0.07, 0.92)
        local t = p:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        t:SetPoint("TOP", 0, -10)
        t:SetText("Call Spell")
        local zu = CreateFrame("Button", nil, p, "UIPanelCloseButton")
        zu:SetPoint("TOPRIGHT", -4, -4)
        tinsert(UISpecialFrames, "CallSpellOptionen")
    end

    return p
end

function oeffneOptionen()
    istDa()
    local p = baueOptionen()
    if p.aktualisiere then p.aktualisiere() end
    if p.kategorie and Settings and Settings.OpenToCategory then
        Settings.OpenToCategory(p.kategorie:GetID())
    else
        p:Show()
    end
end
