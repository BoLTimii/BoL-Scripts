--    _         ___       _                    ___  _    _        _           --
--   /_\   ___ | _ ) __ _| |__ _ _ _  __ ___  |   \(_)__| |_ __ _| |_ ___ ___ --
--  / _ \ (_-< | _ \/ _` | / _` | ' \/ _/ -_) | |) | / _|  _/ _` |  _/ -_|_-< --
-- /_/ \_\/__/ |___/\__,_|_\__,_|_||_\__\___| |___/|_\__|\__\__,_|\__\___/__/ --
--                                                                            --

--Script Information--
local Script_Author = "Timii"
local Script_Version = "0.02"

--Champion Check--
if myHero.charName ~= "Akali" then return end

--Message Broadcast Function--
function Broadcast(Msg)
	print("<font color =\"#000000\">[</font><font color=\"#31B404\">Akali</font><font color =\"#000000\">]</font><font color =\"#BDBDBD\"> "..Msg..".</font>")
end

--Auto Update Variables--
local AutoUpdate = true
local ServerData
local UPDATE_FILE_PATH = SCRIPT_PATH.."Akali - As Balance Dictates.lua"
local UPDATE_NAME = "Akali - As Balance Dictates"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/BoLTimii/BoL-Scripts/master/Akali%20-%20As%20Balance%20Dictates.lua?chunk="..math.random(1, 1000)
local UPDATE_FILE_PATH = SCRIPT_PATH.."Akali - As Balance Dictates.lua"
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

--Auto Update Function--
function AutoUpdt()
	if AutoUpdate then
		ServerData = GetWebResult(UPDATE_HOST, UPDATE_PATH)
		if ServerData then
			local ServerVersion = string.match(ServerData, "ScriptVersion = \"%d.%d%d\"")
			ServerVersion = string.match(ServerVersion and ServerVersion or "", "%d.%d%d")
			if ServerVersion then
				if ScriptVersion ~= ServerVersion then
					Messages("<font color=\"#848484\"> Script is not updated. Current Version: </font> <font color=\"#8A0808\">"..ScriptVersion.."</font> <font color=\"#848484\">Latest Version: </font> <font color=\"#8A0808\">"..ServerVersion.."</font><font color=\"#848484\">.</font>")
					Messages("<font color=\"#848484\">Now Updating Script to </font><font color=\"#8A0808\">v."..ServerVersion.."</font><font color=\"#848484\">. Do not press [F9].</font>")
					DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function ()
					Messages("<font color=\"#848484\">Succesfully Updated </font><font color=\"#FFBF00\">"..UPDATE_NAME.."</font> <font color=\"#848484\"> to </font><font color=\"#8A0808\">v."..ServerVersion.."</font><font color=\"#848484\">.</font>") end) end, 3)
					Messages("<font color=\"#848484\">Please reload the script for changes to take effect.</font>")
				else 
					Messages("<font color=\"#848484\">Your script is updated to the latest version</font> <font color=\"#8A0808\">v"..ScriptVersion.."</font><font color=\"#848484\">.</font>")
				end
			end
		else
			Messages("<font color=\"#848484\">An error occured while checking version information.</font>")
		end
	end
end

--On Load Function--
function OnLoad()
	AutoUpdt()
end