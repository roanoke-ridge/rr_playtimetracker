AddEventHandler("vorp:SelectedCharacter", SelectedCharacterHandler)
AddEventHandler("vorp:initNewCharacter", SelectedCharacterHandler)
AddEventHandler("playerDropped", PlayerDroppedHandler)
AddEventHandler("onResourceStart", ResourceStartHandler)
AddEventHandler("onResourceStop", ResourceStopHandler)

if Config.PlaytimeCommand then
  RegisterCommand("playtime", PlaytimeCommandHandler, false)
end
