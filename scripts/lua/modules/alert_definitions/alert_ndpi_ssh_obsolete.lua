--
-- (C) 2019-21 - ntop.org
--

-- ##############################################

local alert_keys = require "alert_keys"
package.path = dirs.installdir .. "/scripts/lua/modules/?.lua;" .. package.path
local status_keys = require "status_keys"
-- Import the classes library.
local classes = require "classes"
-- Make sure to import the Superclass!
local alert = require "alert"

-- ##############################################

local alert_ndpi_ssh_obsolete = classes.class(alert)

-- ##############################################

alert_ndpi_ssh_obsolete.meta = {
   status_key = status_keys.ntopng.status_ndpi_ssh_obsolete,
   alert_key  = alert_keys.ntopng.alert_ndpi_ssh_obsolete,
   i18n_title = "alerts_dashboard.ndpi_ssh_obsolete_title",
   icon = "fas fa-exclamation",
}

-- ##############################################

-- @brief Prepare an alert table used to generate the alert
-- @return A table with the alert built
function alert_ndpi_ssh_obsolete:init()
   -- Call the parent constructor
   self.super:init()

   self.alert_type_params = {}
end

-- #######################################################

function alert_ndpi_ssh_obsolete.format(ifid, alert, alert_type_params)
   if alert_type_params["risk_id"] == 18 then
      return i18n("flow_risk.ndpi_ssh_obsolete_client_version_or_cipher")
   else
      return i18n("flow_risk.ndpi_ssh_obsolete_server_version_or_cipher")
   end
end

-- #######################################################

return alert_ndpi_ssh_obsolete
