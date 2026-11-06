# Installatie en migratie naar ts_hostage 1.2.3

Deze versie bundelt de bestanden in mappen. De gameplay en instellingen zijn niet gewijzigd. Het configschema blijft `1.1.9`.

## Bestaande installatie bijwerken

1. Maak een back-up van de volledige bestaande map `ts_hostage`, inclusief eigen instellingen en webhook-URL's.
2. Wacht tot er geen actieve gijzelingen zijn en stop `ts_hostage`.
3. Vervang de oude resourcemap door het volledige nieuwe pakket. De mapnaam blijft `ts_hostage`; plaats de back-up buiten de actieve resources-map.
4. Neem je bestaande `config.lua` over naar **`config/config.lua`** en `server_config.lua` naar **`config/server_config.lua`**. Bij een bestaande configversie `1.1.9` zijn geen nieuwe velden nodig. Neem bij een oudere configuratie je waarden over in de meegeleverde config en controleer de configwaarschuwing.
5. Neem eigen vertalingen over in `locales/`. Behoud het nieuwe `fxmanifest.lua`, zodat de nieuwe paden en de laadvolgorde worden gebruikt.
6. Start `ts_bridge` vóór `ts_hostage`. De bestaande vereisten blijven gelden: OneSync, ox_lib en een compatibele ts_bridge; ESX/ox_target/screenshot-basic volgens de gebruikte functies.
7. Start `ts_hostage` en controleer serverconsole en F8 op ontbrekende bestanden of configfouten.

```cfg
ensure ox_lib
ensure screenshot-basic
ensure ts_bridge
ensure ts_hostage
```

Dit fragment toont de onderlinge startvolgorde voor screenshots. Start daarnaast je framework en overige geconfigureerde dependencies volgens hun eigen installatie-instructies.

**Alleen bestanden overschrijven in de oude hoofdmap is niet voldoende.** Gebruik het nieuwe manifest met de volledige mappenstructuur. Webhook-URL's horen uitsluitend in `config/server_config.lua` of de server-side webhookconfig van ts_bridge; plaats ze niet in gedeelde config- of clientbestanden.

## Laadvolgorde

- Shared: ox_lib, taalbestanden, `shared/locale.lua`, `config/config.lua`, `shared/bridge_check.lua`, `shared/config_check.lua`.
- Client: `client/bridge.lua`, `client/handsup.lua`, `client/main.lua`, `client/radial.lua`, `client/blade_pose.lua`, `client/diagnostics.lua`.
- Server: `config/server_config.lua`, `server/webhooks.lua`, `server/main.lua`, `server/update_check.lua`.

`client/police_alert.lua` is een bewaard, ongebruikt compatibiliteitsbestand. De bridge verwerkt politiemeldingen; dit bestand hoeft niet aan het manifest te worden toegevoegd.

## Electron AntiCheat

Gebruik je Electron met resourceProtection, whitelist dan `ts_hostage`, `ts_bridge` en `screenshot-basic` voor de screenshotketen. Volg [de Electron-handleiding](electron-anticheat.md). Electron is geen dependency van het script.

## Controle na installatie

- Test handen omhoog, gijzelen te voet, vrijlaten en opnieuw je wapen pakken.
- Test gijzelen in een voertuig en herstel van de camera.
- Controleer radialmenu, politiemelding en webhook met afbeelding.
- Controleer de bridge/configcontrole en het opstartversienummer `1.2.3`.

## Ontwikkeltests

Plaats de actuele `ts_bridge` naast `ts_hostage` en voer vanuit de hoofdmap van `ts_hostage` uit:

```sh
for test in tests/*_spec.lua; do lua "$test" || exit 1; done
```

Gebruik Lua 5.4, of `luatex --luaonly` per test. Dit zijn gesimuleerde tests; controle op een FiveM-server blijft nodig.

## Terugzetten

Stop `ts_hostage` en herstel de volledige back-up, inclusief het bijbehorende oude manifest. Combineer geen oud manifest met de nieuwe mappenstructuur.

De eerdere installatie-instructie voor 1.2.0 staat in [het archief](archive/UPDATE-INSTALLATIE-1.2.0.md).
