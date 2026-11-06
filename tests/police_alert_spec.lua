dofile('locales/nl.lua'); dofile('shared/locale.lua')
local ownLocale = Locales.nl
 dofile('../ts_bridge/locales/nl.lua')
 for key, value in pairs(ownLocale) do Locales.nl[key] = value end
TSBridgeGuard = { Await = function() return true end, IsReady = function() return true end }
local event, shown, waypoint
local commands = {}
local function command() commands.ts_bridge_waypoint() end
function RegisterNUICallback(_, fn) fn({}, function() end) end
function SendNUIMessage(data) if data.action == "show" then shown = data end end
function GetResourceState() return "stopped" end
function AddEventHandler() end
function SetTimeout(ms, fn) if ms == 0 then fn() end end
local now = 1000
function RegisterNetEvent(_, fn) event = fn end
function RegisterCommand(name, fn) commands[name] = fn end
function RegisterKeyMapping(_, _, _, key) assert(key == 'G' or key == 'BACK') end
function GetGameTimer() return now end
function GetStreetNameAtCoord() return 1, 2 end
function GetStreetNameFromHashKey(hash) return hash == 1 and 'Main Street' or 'Cross Street' end
function GetNameOfZone() return 'CITY' end
function GetLabelText() return 'Centrum' end
lib = { notify = function(data) shown = data end }
function SetNewWaypoint(x, y) waypoint = { x, y } end
dofile('../ts_bridge/config/config.lua'); TSBridgeConfig.AlertBlip = false; TSBridgeConfig.AlertLocation.ShowStreet = true
dofile('../ts_bridge/client/alerts.lua')
command(); assert(not waypoint)
source = 65535
event({ description = 'Gijzeling' }, { x=120, y=240, z=30 }, 60)
assert(shown.location:find('Centrum', 1, true) and shown.location:find('Main Street', 1, true) and shown.location:find('Cross Street', 1, true))
assert(shown.acceptKey == 'G' and shown.dismissKey == 'Backspace')
command(); assert(waypoint[1] == 120 and waypoint[2] == 240)
waypoint = nil; command(); assert(not waypoint, 'consumed waypoint')
event({}, { x=10, y=20, z=30 }, 60)
now = now + 60001; command(); assert(not waypoint, 'expired alert')
event({}, { x=10, y=20, z=30 }, 60)
event({}, { x=50, y=60, z=30 }, 60)
command(); assert(waypoint[1] == 50, 'latest alert wins')
waypoint = nil; source = 1
event({}, { x=90, y=90, z=30 }, 60); command(); assert(not waypoint)
print('PASS: location text, G waypoint, expiry, latest alert, server-only event')

