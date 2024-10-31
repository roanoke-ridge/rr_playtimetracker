AddEventHandler("vorp:SelectedCharacter", SelectedCharacterHandler)
AddEventHandler("vorp:initNewCharacter", SelectedCharacterHandler)
AddEventHandler("playerDropped", PlayerDroppedHandler)
AddEventHandler("onResourceStart", ResourceStartHandler)
AddEventHandler("onResourceStop", ResourceStopHandler)

if Config.PlaytimeCommandEnabled then
  RegisterCommand(Config.PlaytimeCommand, PlaytimeCommandHandler, false)
end
