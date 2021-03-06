--
-- (C) 2019-21 - ntop.org
--

-- ##############################################

local alert_keys = require "alert_keys"
local status_keys = require "status_keys"
-- Import the classes library.
local classes = require "classes"
-- Make sure to import the Superclass!
local alert = require "alert"

-- ##############################################

local alert_unexpected_dns_server = classes.class(alert)

-- ##############################################

alert_unexpected_dns_server.meta = {
   status_key = status_keys.ntopng.status_unexpected_dns_server,
   alert_key = alert_keys.ntopng.alert_unexpected_dns_server,
   i18n_title = "unexpected_dns.alert_unexpected_dns_title",
   icon = "fas fa-exclamation",
   has_victim = true,
   has_attacker = true,
}

-- ##############################################

-- @brief Prepare an alert table used to generate the alert
-- @param one_flow_param The first alert param
-- @param another_flow_param The second alert param
-- @return A table with the alert built
function alert_unexpected_dns_server:init(client_ip, server_ip)
   -- Call the parent constructor
   self.super:init()

   self.alert_type_params = {
    client_ip = client_ip,
    server_ip = server_ip
   }
end

-- #######################################################

-- @brief Format an alert into a human-readable string
-- @param ifid The integer interface id of the generated alert
-- @param alert The alert description table, including alert data such as the generating entity, timestamp, granularity, type
-- @param alert_type_params Table `alert_type_params` as built in the `:init` method
-- @return A human-readable string
function alert_unexpected_dns_server.format(ifid, alert, alert_type_params)
    return(i18n("unexpected_dns.status_unexpected_dns_description", { server=alert_type_params.server_ip} ))
end

-- #######################################################

return alert_unexpected_dns_server
