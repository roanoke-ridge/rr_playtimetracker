fx_version 'cerulean'
lua54 'yes'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'discord:r0bbot'
repo 'https://github.com/roanoke-ridge/rr_playtimetracker'

shared_scripts {
	'shared/config.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
	'server/functions.lua',
  'server/events.lua',
}

dependencies {
  'oxmysql',
  'vorp_core'
}
