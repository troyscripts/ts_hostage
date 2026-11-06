-- Vereiste configversie blijft gelijk zolang het configuratieschema gelijk blijft.
local required = '1.1.9'
if not TSBridgeGuard.Await() then return end
exports['ts_bridge']:CheckConfigVersion(Config.Version, required)
if Config.RequireAimOnFoot == nil then Config.RequireAimOnFoot = true end
if Config.NotificationCooldownMs == nil then Config.NotificationCooldownMs = 5000 end
if Config.Radial == nil then Config.Radial = { Enabled = true } end

-- Nieuwe velden werken ook met een oude config; die krijgt wel een versie-melding.
local cameraDefaults = { ForceFirstPersonOnFoot = true, ForceFirstPersonInVehicle = true,
    Restore = true, RestoreDelayMs = 50 }
if type(Config.Camera) ~= 'table' then Config.Camera = {} end
for key, default in pairs(cameraDefaults) do
    local value = Config.Camera[key]
    local valid = type(value) == type(default)
    if type(default) == 'number' then
        valid = valid and value == value and value % 1 == 0 and value >= 0 and value <= 60000
    end
    if not valid then
        Config.Camera[key] = default
        if IsDuplicityVersion() then print(TSL('camera_invalid_setting'):format(key, tostring(default))) end
    end
end
if type(Config.AntipunchCompatibility) ~= 'boolean' then Config.AntipunchCompatibility = true end
