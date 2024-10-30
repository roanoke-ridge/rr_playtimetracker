# rr_playtimetracker

## Purpose
This resource is useful for logging playtime of all characters. It saves playtime when a character disconnects or when the resource stops, and at specific intervals configured in `shared/config.lua`. In the config you can also enable a `/playtime` command that allows players to view their own characters' playtime themselves.

## SQL
The resource created a column in the `` `characters` `` table called `` `rr_playtime` ``. The column is prefixed with `rr_` to avoid any future issues if playtime tracking is reimplemented into VORP Core. Playtime is stored in milliseconds.
