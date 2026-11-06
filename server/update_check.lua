-- Transport, versievergelijking en foutafhandeling worden centraal beheerd.
if not TSBridgeGuard.Await() then return end
CreateThread(function()
    local ok, accepted = pcall(function()
        return exports.ts_bridge:CheckForUpdates({
            Enabled = true, Repository = 'troyscripts/ts_hostage', File = 'version.json'
        })
    end)
    if not ok or not accepted then
        print(TSL('update_check_troyscripts') .. TSL('update_check_bridge_failed'))
    end
end)
