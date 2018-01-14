-- file : application.lua
local module = {}
m = nil

-- Holds dispatching keys to different topics. Serves as a makeshift callback
-- function dispatcher based on topic and message content
m_dis = {}

-- Standard counter variable. Used for modulo arithmatic
local count = 0

local function send_ping()
    m:publish(config.ENDPOINT .. "ping","hallo id=" .. config.ID,0,0)
end

local function mqtt_start()
    m = mqtt.Client(config.ID, 60)

    m:on("connect", function(m) 
        -- Serial status message
        print ("\n\n", module.ID, " connected to MQTT host ", 
        module.HOST, " on port ", module.PORT, "\n\n")

        -- Subscribe to the topic where the ESP8266 will get commands from
        m:subscribe("/mcu/cmd/#", 0,
        function(m) print("Subscribed to CMD Topic") end)

    end)

    
    -- on publish message receive event
    m:on("message", function(client, topic, data) 
        print("message received!!!!!!!!!!!")
        print("message received!!!")
        print(topic .. ": " .. data)
        send_ping()
        
        --if data ~= nil and m_dis[topic] then
       -- It allows different functions to be run based on the message topic
            --m_dis[topic](client, data)
        -- do something, we have received a message
        
            
     
    end)
    
    -- Connect to broker 
    -- config.HOST -> pi
    -- config.PORT -> 1883
    -- secure = false
    -- autoreconnect = true - deprecated!!

    m:connect(config.HOST, config.PORT, 0, 1)

end

function module.start()
  print("application is started")
  mqtt_start()

  
  
end

return module
