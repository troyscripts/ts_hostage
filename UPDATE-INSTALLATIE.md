# Update ts_hostage 1.1.8 → 1.1.9

Deze ZIP bevat alleen gewijzigde/nieuwe bestanden voor een bestaande 1.1.8-installatie.
Kopieer de map ts_hostage over de bestaande map; laat overige bestanden staan.
Er hoeven geen bestanden verwijderd te worden.

1. Maak een backup en stop ts_hostage wanneer niemand in een gijzeling zit.
2. Werk de bridge bij naar 0.0.5 volgens de gezamenlijke stop/startvolgorde.
3. Kopieer deze update over de bestaande ts_hostage-resource.
4. Neem eigen instellingen over in de nieuwe config.lua. Nieuwe velden:
   Config.Camera en Config.AntipunchCompatibility. Config.Version wordt '1.1.9'.
   Neem eigen aanpassingen aan locales/nl.lua over met behoud van de nieuwe sleutel.
5. Installeer ook antipunch 1.8.2 voor de samenwerking, als je antipunch gebruikt.
6. Start eerst providers/ox_lib, dan ts_bridge, ts_antipunch en ts_hostage.

server_config.lua blijft staan: webhooks en politie-instellingen wijzigen niet.
Geen databasewijziging. Handen-omhoog, wapens en de mespose blijven behouden.

Standaard blijft de dader tijdens een actieve gijzeling in first person:
- Config.Camera.ForceFirstPersonOnFoot = true
- Config.Camera.ForceFirstPersonInVehicle = true
- Config.AntipunchCompatibility = true (pauzeert alleen de melee-noodrem)

De bestaande Config.Vehicle.RequireFirstPerson blijft de camera bij starten
controleren: de dader kiest vóór het starten zelf first person in de auto.
Config.Camera regelt het vasthouden van die camera tijdens een actieve sessie.
Het slachtoffer krijgt geen nieuwe cameraforcering.

Live testen met twee spelers: te voet/auto, met/zonder vastgehouden richtknop,
loslaten en omleggen, cameraherstel, herladen/melee na loslaten en resource-stop.
Controller en de gebruikte ambulance-/animatiescripts ook meenemen.

Upload voor GitHub ook version.json met 1.1.9 en het nieuwe manifest, samen met
alle gewijzigde resourcebestanden. Deze ZIP publiceert niets automatisch.
