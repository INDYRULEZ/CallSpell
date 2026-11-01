# Call Spell

Ein kleines WoW-Addon: Es meldet sich, wenn dich jemand per Flüstern um einen Zauber bittet —
Symbol mittig auf dem Bildschirm, eigene Ansage, fünf Sekunden. Gedacht für Zauber, die man
auf einen Mitspieler wirkt und die man im Kampftrubel schon mal überhört (Rescue, Spatial
Paradox, Innervate, Power Infusion, …).

## Warum es das gibt

Die üblichen WeakAura-Lösungen für so etwas laufen im Kampf in eine Sperre von Blizzard:
Aura-Code wird dynamisch geladen und ist dadurch „tainted", und im Kampf darf er den
Flüstertext nicht mehr lesen. Ergebnis: außerhalb des Kampfes geht es, im Kampf passiert
nichts. Ein normales Addon hat dieses Problem nicht — es liest `CHAT_MSG_WHISPER` direkt.

## Installation

**Mit WowUp** (empfohlen, dann gibt es auch Updates):

1. In WowUp: *Addons* → *Install from URL* (bzw. *Repository hinzufügen*)
2. `https://github.com/INDYRULEZ/CallSpell` eintragen
3. Installieren — WowUp nimmt das neueste Release

**Von Hand:**

1. [Neuestes Release](https://github.com/INDYRULEZ/CallSpell/releases/latest) herunterladen
2. ZIP entpacken, Ordner `CallSpell` nach `World of Warcraft\_retail_\Interface\AddOns\`
3. Spiel starten (oder `/reload`)

Danach im Chat `/cs` eingeben — dann steht da, wie es weitergeht.

## Einrichten

**Optionen → Addons → Call Spell** oder `/cs config`.

Die Tabelle hat eine Zeile pro Zauber:

| Spalte | Bedeutung |
|---|---|
| Name | Anzeigename, frei wählbar |
| SpellID | ID des Zaubers (Symbol und Makro kommen von hier) |
| Symbol | optional: eigene Icon-ID, leer = Symbol des Zaubers |
| Flüstertext | was man dir schreiben muss (Groß/Klein und Leerzeichen egal) |
| Stimme | Pfad zur Tondatei, leer = kein Ton |
| Standard Ziel | Name fürs Makro, leer = du targetest selbst |
| Macro erstellen | legt ein charakterspezifisches Makro an |

Darunter: Kanäle (Flüstern/Gruppe/Raid), Anzeigedauer, Ton an/aus und die Whitelist
(leer = jeder darf auslösen).

Mit **+ Zauber hinzufügen** kommt eine Zeile dazu, mit **×** fliegt sie raus.

### Befehle

```
/cs config                 Einstellungen öffnen
/cs test                   beide Hinweise sofort zeigen
/cs an | /cs aus           Addon ein/aus
/cs ton an|aus             Ton ein/aus
/cs wer <Name>             Namen zur Whitelist
/cs ohne <Name>            Namen entfernen
/cs liste                  Whitelist zeigen
/cs alle                   Whitelist leeren
/cs neu <SpellID> [Name]   Zauber hinzufügen
/cs weg <Zeile>            Zeile entfernen
/cs phrase <Zeile> <Text>  Flüstertext setzen
/cs icon <Zeile> <ID>      eigenes Symbol
/cs kanal fluester|gruppe|raid an|aus
/cs debug                  zeigt, was ankommt
```

## Eigene Ansage (Voice Line) — von Hand

Das Addon liefert **keine** Tondateien mit. Du kannst jede `.ogg` (Vorbis) oder `.mp3`
nehmen, die du selbst erzeugt hast.

**1. Datei ablegen**

```
World of Warcraft\_retail_\Interface\AddOns\CustomSounds\meinezauber.ogg
```

Der Ordner `CustomSounds` ist Absicht: kein Addon, keine `.toc` — dadurch fasst ihn kein
Addon-Manager an, und die Dateien überleben jedes Update. (Ein Ordner *innerhalb* eines
Addons würde beim nächsten Update überschrieben.)

**2. Pfad im Addon eintragen**

In der Spalte „Stimme" diesen Pfad eintragen — einfache Backslashes:

```
Interface\AddOns\CustomSounds\meinezauber.ogg
```

**3. Stimme selbst erzeugen — Beispiel mit freier TTS**

```bash
# Windows/macOS/Linux, Python 3
pip install edge-tts
edge-tts --voice en-US-ChristopherNeural --text "Rescue!" --write-media rescue.mp3

# nach .ogg (Vorbis) wandeln — WoW spielt kein Opus
ffmpeg -i rescue.mp3 -c:a libvorbis -q:a 6 rescue.ogg
```

Kürzen und auf Lautstärke bringen (Anfang/Ende ohne Stille wirkt deutlich knackiger):

```bash
ffmpeg -i rescue.mp3 -af "silenceremove=start_periods=1:start_threshold=-50dB,\
areverse,silenceremove=start_periods=1:start_threshold=-50dB,areverse,\
speechnorm=e=16:r=0.0001:l=1,alimiter=limit=0.80" -c:a libvorbis -q:a 6 rescue.ogg
```

Ginge auch mit jeder Aufnahme-App — wichtig ist nur: **`.ogg` (Vorbis) oder `.mp3`**, kurz,
und nicht übersteuert.

**4. Wichtig beim Austauschen**

WoW hält Tondateien im Speicher. Wenn du eine **bestehende** Datei ersetzt, hört man die alte
Fassung weiter, bis der Client **komplett neu gestartet** wurde — `/reload` reicht nicht.
Bei einem **neuen Dateinamen** ist das kein Thema.

## Grenzen

- Die Optionsseite **scrollt nicht**. Ab etwa sieben Zaubern läuft sie unten aus dem Fenster.
- Die Töne werden nur abgespielt, nicht auf eine bestimmte Lautstärke normiert.
- Getestet auf deutschem Client, Interface 120100 (Retail). Andere Versionen: `## Interface`
  in der `.toc` anpassen.
- Fehlt der Zauber oder ist die SpellID falsch, wird kein Symbol gefunden — das Addon bleibt
  dann still.

## Ideen, Fehler, Wünsche

Ich freue mich über Rückmeldungen — schreib mir einfach:

- als **GitHub-Issue** in diesem Repository, oder
- per Mail an **jonas@jagerke.de**

Wenn du eine Idee hast, die mehr als ein Einzeiler ist, setze ich mich auch gern mit dir in
einen **Discord-Call** und wir besprechen das direkt — schlag einfach einen Termin vor.

## Lizenz

MIT — siehe [LICENSE](LICENSE). Nimm es, ändere es, gib es weiter.
