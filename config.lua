-- file : config.lua
local module = {}

module.SSID = {}
module.SSID["mooze"] = "koriander"

module.HOST = "192.168.2.220"
module.PORT = 1883
module.ID = node.chipid()

module.ENDPOINT = "nodemcu/"
return module

