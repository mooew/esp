-- file: setup.lua
local module = {}

function module.start()
  print("Configuring Wifi ...")
  -- Put radio into station mode to connect to network
  wifi.setmode(wifi.STATION);
  --wifi.sta.getap(wifi_start)
  station_cfg={}
  station_cfg.ssid="mooze"
  station_cfg.pwd="koriander"
  wifi.sta.config(station_cfg)
    
    -- Count how many times you tried to connect to the network
  local wifi_counter = 0

  tmr.alarm(0, 1000, 1, function()
  if wifi.sta.getip() == nil then
        print("Connecting to AP...\n")
        
        -- Rotate through RGB colors while waiting
        wifi_counter = wifi_counter + 1;
        --rgb_solid(wifi_counter % 3)
    else
        ip, nm, gw = wifi.sta.getip()
        
        -- Debug info
        print("\n\nIP Info: \nIP Address: ",ip)
        print("Netmask: ",nm)
        print("Gateway Addr: ",gw,'\n')
        
        tmr.stop(0)     -- Stop the polling loop
        --rgb_solid(4)    -- Turn LED white to indicate success
        
        -- Continue to main function after network connection
        app.start()
    end
  end)
  
  
end

return module