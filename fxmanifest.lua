fx_version "cerulean"
use_fxv2_oal "yes"
lua54 "yes"
game "gta5"
version "1.0.0"
description "A simple idcard system"
name 'krs_idcard'
author "karos7804"

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

client_script {
    'client/*.lua'
}

ui_page 'html/index.html'

files {
    'html/*.html',
	'html/assets/js/*.js',
    'html/assets/css/*.css',
    'html/assets/images/*.png',
}

dependency {
    'ox_lib',
    'ox_inventory',
    'screenshot-basic'
}
