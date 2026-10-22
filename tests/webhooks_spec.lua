-- Hostage owns event content; bridge tests/webhook_lanes_spec.lua and
-- screenshot_upload_spec.js cover transport, queues, fallback and binary upload.
dofile('locales/nl.lua'); dofile('locale.lua')
local ready, sent = true, {}
TSBridgeGuard = { Await = function() return true end, IsReady = function() return ready end }
function GetHashKey(x) return x end
function GetPlayerName(id) return 'Speler ' .. id end
exports = { ts_bridge = { SendWebhook = function(_, route, url, payload, options)
    sent[#sent + 1] = { route=route, url=url, payload=payload, options=options }
    return true
end } }
dofile('config.lua'); dofile('server_config.lua'); dofile('webhooks.lua')
WebhookConfig.Enabled = true
WebhookConfig.Start = 'https://discord.com/api/webhooks/123/start_token'
WebhookConfig.Actions = 'https://discord.com/api/webhooks/456/action_token'
WebhookConfig.Screenshots = true
local s = { id=7, captor=1, victim=2, weapon='WEAPON_KNIFE', vehicle=0 }
HostageLog.Snapshot(s)
HostageLog.Event(s, 'start')
assert(#sent == 1 and sent[1].route == 'start' and sent[1].url == WebhookConfig.Start)
local p = sent[1].payload
assert(#p.allowed_mentions.parse == 0)
assert(p.embeds[1].fields[1].value == 'Speler 1 (ID: 1)')
assert(p.embeds[1].fields[2].value == 'Speler 2 (ID: 2)')
assert(p.embeds[1].fields[3].value == 'WEAPON_KNIFE')
assert(sent[1].options.screenshot and sent[1].options.playerId == 1)
HostageLog.Event(s, 'release', 'Loslaten')
assert(sent[2].route == 'actions' and sent[2].url == WebhookConfig.Actions)
assert(sent[2].payload.embeds[1].title == 'Gijzelaar losgelaten')
assert(sent[2].payload.embeds[1].fields[6].value == 'Loslaten')
HostageLog.Event(s, 'execute')
assert(sent[3].payload.embeds[1].title == 'Gijzelaar omgelegd')
WebhookConfig.Screenshots = false
HostageLog.Event(s, 'start'); assert(not sent[4].options.screenshot)
WebhookConfig.LogAutomaticRelease = false
HostageLog.Event(s, 'automatic'); assert(#sent == 4)
WebhookConfig.Enabled = false
HostageLog.Event(s, 'start'); assert(#sent == 4)
WebhookConfig.Enabled = true; ready = false
HostageLog.Event(s, 'start'); assert(#sent == 4)
print('PASS: hostage webhook content, routes, identities, reasons, screenshot options and disabled guards; transport tested in bridge')
