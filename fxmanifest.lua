fx_version 'cerulean'
game 'gta5'

author 'TroyScripts'
description 'Speler-gijzelingen met toetsen/target; vereist ts_bridge 0.0.5'
version '1.2.3'

shared_scripts { '@ox_lib/init.lua', 'locales/*.lua', 'shared/locale.lua', 'config/config.lua', 'shared/bridge_check.lua', 'shared/config_check.lua' }
client_scripts { 'client/bridge.lua', 'client/handsup.lua', 'client/main.lua', 'client/radial.lua', 'client/blade_pose.lua', 'client/diagnostics.lua' }
server_scripts { 'config/server_config.lua', 'server/webhooks.lua', 'server/main.lua', 'server/update_check.lua' }
dependency '/onesync'
dependency 'ox_lib'

dependency 'ts_bridge'

-- Verplicht: centrale bridge inclusief GetStatus API 1, zie docs/UPDATE-INSTALLATIE.md.
ts_bridge_min_version '0.0.5'

