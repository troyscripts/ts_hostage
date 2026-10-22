dofile('locales/nl.lua'); dofile('locale.lua')
TSBridgeGuard = { Await = function() return true end, IsReady = function() return true end }
local commands, notices, requests, events, public = {}, {}, {}, {}, {}
local now, aiming = 10000, false
local weapon, distance, vehicle, camera = 0, 1, false, 0
local vec = {}; vec.__sub = function() return setmetatable({}, { __len = function() return distance end }) end
function GetHashKey(name) if name == 'WEAPON_KNIFE' then return -1716189206 elseif name == 'WEAPON_UNARMED' then return 0 else return name end end
function PlayerPedId() return 1 end
function PlayerId() return 1 end
function GetActivePlayers() return {1,2} end
function GetPlayerPed(id) return id end
function GetPlayerServerId(id) return id end
function NetworkGetPlayerIndexFromPed(id) return id end
function GetEntityCoords() return setmetatable({}, vec) end
function GetSelectedPedWeapon() return weapon end
function GetVehiclePedIsIn() return vehicle and 10 or 0 end
function GetEntitySpeed() return 0 end
function GetPedInVehicleSeat(_, seat) return seat == 0 and 1 or 2 end
function GetFollowVehicleCamViewMode() return camera end
function GetGameTimer() return now end
function IsPlayerFreeAiming() return aiming end
function IsControlPressed() return false end
function IsDisabledControlPressed() return false end
function IsPedAPlayer() return true end
function IsEntityDead() return false end
function IsPedRagdoll() return false end
function IsPedSwimming() return false end
function IsPedFalling() return false end
function IsPedCuffed() return false end
function HasEntityClearLosToEntity() return true end
function IsPedInAnyVehicle() return vehicle end
function CreateThread() end
function RegisterCommand(n, fn) commands[n] = fn end
function RegisterKeyMapping() end
function RegisterNetEvent(n, fn) events[n] = fn end
function AddEventHandler() end
function TriggerServerEvent(...) requests[#requests+1] = {...} end
exports = setmetatable({ ts_bridge = { GetTargetResource = function() return 'ox_target' end } }, { __call = function(_, name, fn) public[name] = fn end })
Bridge = { IsDead = function() return false end, Notify = function(s) notices[#notices+1] = s end,
 VehicleFirstPerson = function() return camera == 4 end }
dofile('config.lua'); dofile('client.lua')
local function action() commands['+ts_hostage_action']() end
local function advance() now = now + 6000 end
action(); assert(#notices == 0 and #requests == 0, 'E without aiming is silent')
aiming = true; action(); assert(notices[#notices]:find('Neem eerst'))
action(); assert(#notices == 1, 'failed attempts have request cooldown')
advance(); weapon = 999; action(); assert(notices[#notices]:find('Config.Weapons'))
advance(); weapon = 2578778090; action(); assert(#requests == 1, 'signed knife allowed')
local token = requests[#requests][3]
source = 65535; aiming = false
local before = #notices
events['ts_hostage:notify']('late', token); assert(#notices == before, 'late key rejection hidden after releasing aim')
aiming = true; events['ts_hostage:notify']('wrong token', token+1); assert(#notices == before)
events['ts_hostage:notify']('current', token); assert(notices[#notices] == 'current')
advance(); vehicle = true; camera = 0; before = #notices
local n = #requests; action(); assert(#notices == before and #requests == n, 'third person car is silent')
camera = 4; aiming = false; action(); assert(#requests == n+1, 'first person car needs no aim')
advance(); vehicle = false; public.TakeHostage(); assert(#requests == n+2, 'radial needs no aim')
events['ts_hostage:notify']('radial rejection', requests[#requests][3]); assert(notices[#notices] == 'radial rejection')
advance(); public.ExecuteHostage(); public.ReleaseHostage(); assert(#requests == n+2, 'idle execute/release cannot start hostage')
-- Start a real local session, then release aim; action/release remain usable.
function GetPlayerFromServerId(id) return id end
function RequestAnimDict() end
function HasAnimDictLoaded() return true end
function SetTimeout() end
function TaskPlayAnim() end
Bridge.BusyChanged = function() end
local cameraSession
Bridge.UpdateCamera = function(s) cameraSession=s end
source = 65535; vehicle = false; aiming = false
local hash = 2578778090
events['ts_hostage:prepare'](99, 'captor', 2, 'blade', hash, false)
events['ts_hostage:begin'](99)
advance(); public.ExecuteHostage()
assert(requests[#requests][1] == 'ts_hostage:action' and requests[#requests][3] == 'execute')
public.ReleaseHostage(); assert(requests[#requests][3] == 'release')
print('PASS: active hostage execute/release without aiming')

assert(cameraSession and cameraSession.active and cameraSession.role == "captor")
-- Regression: finish clears owned pose; ox_inventory stays in charge of weapons.
local pose, clears, secondary, disarms, nativeRestores = true,0,0,0,0
function IsEntityPlayingAnim() return pose end
function StopAnimTask() pose=false end
function ClearPedSecondaryTask() secondary=secondary+1 end
function ClearPedTasks() clears=clears+1 end
function ClearPedTasksImmediately() end
function DetachEntity() end
function AttachEntityToEntity() end
function HasPedGotWeapon() return true end
function SetCurrentPedWeapon() nativeRestores=nativeRestores+1 end
function GetResourceState() return 'started' end
function TriggerEvent(name,noAnim) if name=='ox_inventory:disarm' then assert(noAnim);disarms=disarms+1 end end
HandsUp={Lower=function() end}
Bridge.HandsUp=function() return true end
Bridge.Kill=function() end
function TaskPlayAnim() pose=true end
events['ts_hostage:finish'](99,false)
assert(not public.IsBusy())
local beforeClear=clears
for id=100,101 do
 events['ts_hostage:offer'](id,2,hash,false)
 events['ts_hostage:prepare'](id,'victim',2,'blade',hash,false)
 events['ts_hostage:begin'](id)
 assert(public.IsBusy())
 events['ts_hostage:finish'](id,false)
 assert(not public.IsBusy())
end
assert(disarms==2 and nativeRestores==0,'ox weapon must not be restored with native')
assert(clears==beforeClear+2,'owned victim foot task cleared')
-- A different animation that took over must not be wiped by cleanup.
events['ts_hostage:offer'](102,2,hash,false)
events['ts_hostage:prepare'](102,'victim',2,'blade',hash,false)
events['ts_hostage:begin'](102);pose=false
beforeClear=clears
events['ts_hostage:finish'](102,false);assert(clears==beforeClear)
print('PASS: victim repeated release, inventory disarm, no native weapon restore, owned-task cleanup')
