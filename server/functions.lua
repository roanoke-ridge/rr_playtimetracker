local Core = exports.vorp_core:GetCore()
local times = {}

local function init_sql()
  local query = [[
  IF NOT EXISTS( SELECT NULL FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'characters' AND COLUMN_NAME = 'rr_playtime' ) THEN
    ALTER TABLE `characters`
    ADD COLUMN `rr_playtime` BIGINT UNSIGNED NOT NULL DEFAULT '0' AFTER `meta`;
  END IF;
  ]]

  MySQL.query.await(query)
end

local function log_playtime(charIdentifier)
  if not times[tostring(charIdentifier)] then return end
  local playtime = GetGameTimer() - times[tostring(charIdentifier)]

  local query = "UPDATE `characters` SET `rr_playtime` = `rr_playtime` + ? WHERE `charIdentifier` = ?"
  MySQL.update.await(query, { playtime, charIdentifier})

  times[tostring(charIdentifier)] = GetGameTimer()
end

local function log_all_players()
  for _, player in pairs(GetPlayers()) do
    if Player(player).state.IsInSession then
      local user = Core.getUser(player)
      local character = user.getUsedCharacter
      log_playtime(character.charIdentifier)
    end
  end
end

function SelectedCharacterHandler(src, character)
  times[tostring(character.charIdentifier)] = GetGameTimer()
end

function PlayerDroppedHandler()
  local src = source

  local user = Core.getUser(src)
  if not user then return end

  local character = user.getUsedCharacter
  log_playtime(character.charIdentifier)
end

function ResourceStartHandler(resourceName)
  if resourceName ~= GetCurrentResourceName() then return end
  init_sql()

  for _, player in pairs(GetPlayers()) do
    if Player(player).state.IsInSession then
      local user = Core.getUser(player)
      local character = user.getUsedCharacter
      times[tostring(character.charIdentifier)] = GetGameTimer()
    end
  end

  CreateThread(function()
    while true do
      Wait(Config.AutoSaveInterval * 60 * 1000)
      print("Saving playtime...")
      log_all_players()
    end
  end)
end

function ResourceStopHandler(resourceName)
  if resourceName ~= GetCurrentResourceName() then return end
  log_all_players()
end
