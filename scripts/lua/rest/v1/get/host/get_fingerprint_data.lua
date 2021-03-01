--
-- (C) 2013-21 - ntop.org
--

local dirs = ntop.getDirs()
package.path = dirs.installdir .. "/scripts/lua/modules/?.lua;" .. package.path

require "lua_utils"
local graph_utils = require "graph_utils"
require "flow_utils"
require "historical_utils"
local fingerprint_utils = require "fingerprint_utils"
local rest_utils = require("rest_utils")

local available_fingerprints = {
   ja3 = {
      stats_key = "ja3_fingerprint",
      href = function(fp) return '<A HREF="https://sslbl.abuse.ch/ja3-fingerprints/'..fp..'" target="_blank">'..fp..'</A>  <i class="fas fa-external-link-alt"></i>' end
   },
   hassh = {
      stats_key = "hassh_fingerprint",
      href = function(fp) return fp end
   }
}

sendHTTPContentTypeHeader('text/html')

-- Parameters used for the rest answer --
local rc
local res = {}

local ifid = _GET["ifid"]
local host_info = url2hostinfo(_GET)
local fingerprint_type = _GET["fingerprint_type"]


-- #####################################################################

local stats
local table = {}

if isEmptyString(fingerprint_type) then
    rc = rest_utils.consts.err.invalid_args
    rest_utils.answer(rc)
    return
 end

if isEmptyString(ifid) then
   rc = rest_utils.consts.err.invalid_interface
   rest_utils.answer(rc)
   return
end

if isEmptyString(host_info["host"]) then
   rc = rest_utils.consts.err.invalid_args
   rest_utils.answer(rc)
   return
end

if(host_info["host"] ~= nil) then
   stats = interface.getHostInfo(host_info["host"], host_info["vlan"])
end

if stats == nil then
    rest_utils.answer(rest_utils.consts.err.not_found)
    return
end

table = stats.ja3_fingerprint

for key, value in pairs(table) do
   res[#res + 1] = value
   res[#res]["ja3_fingerprint"] = key
end

tprint(res)

rc = rest_utils.consts.success.ok
rest_utils.answer(rc, res)

