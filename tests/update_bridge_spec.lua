dofile('locales/nl.lua'); dofile('shared/locale.lua')
local ready, calls, logs = true, 0, {}
local realPrint = print
function print(message) logs[#logs + 1] = message end
TSBridgeGuard = { Await = function() return ready end }
function CreateThread(fn) fn() end
exports = { ts_bridge = { CheckForUpdates = function(_, settings)
    calls = calls + 1
    assert(settings.Repository == 'troyscripts/ts_hostage')
    assert(settings.File == 'version.json' and settings.Enabled == true)
    assert(settings.Branch == nil)
    return true
end } }
-- Geen eigen netwerkverzoek: de bridge bezit transport en foutafhandeling.
function PerformHttpRequest() error('Unexpected direct HTTP request') end
dofile('server/update_check.lua'); assert(calls == 1 and #logs == 0)
ready = false
dofile('server/update_check.lua'); assert(calls == 1)
ready = true
exports.ts_bridge.CheckForUpdates = function() return false end
dofile('server/update_check.lua'); assert(#logs == 1 and logs[1]:find('ts_bridge', 1, true))
exports.ts_bridge.CheckForUpdates = function() error('missing export') end
dofile('server/update_check.lua'); assert(#logs == 2)
realPrint('PASS: shared update request, default branch, guard refusal and export failure isolation')

