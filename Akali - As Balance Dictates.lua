--    _   _        _ _           _         ___       _                    ___  _    _        _           --
--   /_\ | |____ _| (_)  ___    /_\   ___ | _ ) __ _| |__ _ _ _  __ ___  |   \(_)__| |_ __ _| |_ ___ ___ --
--  / _ \| / / _` | | | |___|  / _ \ (_-< | _ \/ _` | / _` | ' \/ _/ -_) | |) | / _|  _/ _` |  _/ -_|_-< --
-- /_/ \_\_\_\__,_|_|_|       /_/ \_\/__/ |___/\__,_|_\__,_|_||_\__\___| |___/|_\__|\__\__,_|\__\___/__/ --
--                                                                                                       --

--Script Information--
local Script_Author = "Timii"
local Script_Version = "0.02"
local Script_UpdateDate = "06/25/2014"

--Champion Check--
if myHero.charName ~= "Akali" then return end

--Message Broadcast Function--
function Broadcast(Msg)
	print("<font color =\"#000000\">[</font><font color=\"#31B404\">Akali</font><font color =\"#000000\">]</font><font color =\"#424242\">"..Msg..".</font>"
end

--Auto Update Variables--
local AutoUpdate = true
local Update_FilePath = SCRIPT_PATH.."Akali - As Balance Dictates.lua"
local Update_ScriptName = "Akali - As Balance Dictates"
local Update_WebHost = "raw.github.com"
local Update_HostPath = "/BoLTimii/BoL-Scripts/master/Akali%20-%20As%20Balance%20Dictates.lua?chunk="..math.random(1, 1000)
local Update_FilePath = SCRIPT_PATH.."Akali - As Balance Dictates.lua"
local Update_URL = "https://"..Update_WebHost..Update_HostPath

--Auto Update Function--
if AutoUpdate then
	local ServerInfo = GetWebResult(Update_WebHost, Update_HostPath)
	if ServerInfo then
		local ServerVersion = string.match(ServerInfo, "local Script_Version = \"%d+.%d+\"")
		ServerVersion = string.match(ServerVersion and ServerVersion or "", "%d+.%d+")
		if ServerVersion then
			ServerVersion = tonumber(ServerVersion)
			if ServerVersion ~= tonumber(Script_Version) then
				local ServerUpdateTime = string.match(ServerInfo, "local Script_UpdateDate = \"%d+/%d+/%d+\"")
				ServerUpdateTime = string.match(ServerUpdateTime and ServerUpdateTime or "", "%d+/%d+/%d+")
				Broadcast("Your script is outdated. The script is automatically updating, please wait...")
				Broadcast("New Script Info - Date: <font color = \"#B40404\">"..ServerUpdateTime.."</font> Version: <font color = \"#B40404\">v"..ServerVersion.."</font>")
				DelayAction(function() DownloadFile(Update_URL, Update_FilePath, function ()
				Broadcast("Successfully updated Please reload the script for changes to take effect.") end) end, 3)
			 else
                Broadcast("Your script is updated. <font color = \"#B40404\">v"..ServerVersion.."</font>.")
			end
		else
			Broadcast("An error has occurred while attempting to download version info.")
		end
	end
end