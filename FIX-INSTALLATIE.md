# ts_hostage 1.2.1 — vrijlaten en wapens

Vereist de bestaande 1.2.0-installatie. Vervang alleen meegeleverde bestanden.
Herstart wanneer niemand gegijzeld is: restart ts_hostage
Geen configwijziging of bridge-update nodig.

Bij gijzelen wordt het wapen nu via ox_inventory:disarm opgeborgen. Bij vrijlaten
wordt het niet buiten de inventory om met een GTA-native teruggezet.
PAK NA VRIJLATEN JE WAPEN OPNIEUW UIT JE INVENTORY / SNELTOETS.
De eigen gijzelingsanimatie en bijbehorende secundaire taak worden opgeruimd.
Andere animaties die inmiddels zijn gestart worden niet volledig gewist.

Test: handen omhoog, laat iemand jou gijzelen en vrijlaten, pak je wapen opnieuw,
richt en schiet. Herhaal dit een tweede keer en test ook vrijlaten in een voertuig.
Lokale tests voor herhaalde vrijlating, inventory-disarm, taakopruiming en handen
omlaag slagen. Er is geen live FiveM-test gedaan; de precieze oorzaak op jouw server
is nog niet bewezen. Als richten nog blokkeert: stuur F8-fouten en geef aan of je
wel kunt richten na opnieuw equippen en welk handen-omhoogscript je gebruikt.

API-referentie: https://overextended.dev/docs/ox_inventory/Events/Client
