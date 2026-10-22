# Update naar 1.2.0 vanaf 1.1.9

1. Maak een backup van ts_hostage.
2. Zorg dat er geen actieve gijzelingen zijn en stop ts_hostage.
3. Overschrijf uitsluitend de meegeleverde bestanden in de bestaande ts_hostage-map.
4. Start ts_hostage opnieuw. De stop ruimt ook eventuele oude camera-aanvragen op.

Geen config vervangen: configversie blijft 1.1.9. ts_bridge en ts_antipunch blijven ongewijzigd.
De bestaande voertuigcontrole bij het starten blijft gelden.

Controleer in-game: richten, gijzelen, richtknop loslaten, opnieuw richten en vrijlaten.
Zonder richtknop hoort je vorige camerastand terug te komen (Camera.Restore = true).
Controleer daarna ook handmatig wisselen van camera en een tweede gijzeling.

Validatie: Lua-syntax en gesimuleerde regressietests geslaagd voor richtinvoer,
geblokkeerde invoer, voertuigcamera, slachtoffer en beëindiging tijdens Wait.
Niet live op een FiveM-server getest.
