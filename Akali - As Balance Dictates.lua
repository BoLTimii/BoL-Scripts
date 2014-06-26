--    _         ___       _                    ___  _    _        _           --
--   /_\   ___ | _ ) __ _| |__ _ _ _  __ ___  |   \(_)__| |_ __ _| |_ ___ ___ --
--  / _ \ (_-< | _ \/ _` | / _` | ' \/ _/ -_) | |) | / _|  _/ _` |  _/ -_|_-< --
-- /_/ \_\/__/ |___/\__,_|_\__,_|_||_\__\___| |___/|_\__|\__\__,_|\__\___/__/ --
--                                                                            --


--Script Information--
local Script_Author = "Timii"
local Script_Version = "0.02"
local Script_UpdateDate = "06/26/2014"

--Champion Check--
if myHero.charName ~= "Akali" then return end

--Auto Update Variables--
local AutoUpdate = true
local UPDATE_FILE_PATH = SCRIPT_PATH.."Akali - As Balance Dictates.lua"
local UPDATE_NAME = "Akali - As Balance Dictates"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/BoLTimii/BoL-Scripts/master/Akali%20-%20As%20Balance%20Dictates.lua?chunk="..math.random(1, 1000)
local UPDATE_FILE_PATH = SCRIPT_PATH.."Akali - As Balance Dictates.lua"
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

--Auto Libraries Variables--
local AutoLibs = true
local Downloaded = 0
local VIP_LIBS = {
	["VPrediction"] = "https://raw.github.com/Hellsing/BoL/master/common/VPrediction.lua",
	["Collision"] = "https://bitbucket.org/Klokje/public-klokjes-bol-scripts/raw/master/Common/Collision.lua",
	["Prodiction"] = "https://bitbucket.org/Klokje/public-klokjes-bol-scripts/raw/master/Common/Prodiction.lua"
}
local NORMAL_LIBS = {
	["VPrediction"] = "https://raw.github.com/Hellsing/BoL/master/common/VPrediction.lua",
}
local DOWNLOADING_LIBS = false
local DOWNLOAD_COUNT = 0
local SELF_NAME = GetCurrentEnv() and GetCurrentEnv().FILE_NAME or ""

--Message Broadcast Function--
function Broadcast(Msg)
	print("<font color =\"#000000\">[</font><font color=\"#31B404\">Akali</font><font color =\"#000000\">]</font><font color =\"#BDBDBD\"> "..Msg..".</font>")
end

--Auto Update Function--
function AUpdate()
	if AutoUpdate then
		local ServerInfo = GetWebResult(UPDATE_HOST, UPDATE_PATH)
		Broadcast("Starting auto-update check..")
		if ServerInfo then
			local ServerVersion = string.match(ServerInfo, "local Script_Version = \"%d+.%d+\"")
			ServerVersion = string.match(ServerVersion and ServerVersion or "", "%d+.%d+")
			if ServerVersion then
				ServerVersion = tonumber(ServerVersion)
				if ServerVersion ~= tonumber(Script_Version) then
					local ServerUpdateTime = string.match(ServerInfo, "local Script_UpdateDate = \"%d+/%d+/%d+\"")
					ServerUpdateTime = string.match(ServerUpdateTime and ServerUpdateTime or "", "%d+/%d+/%d+")
					Broadcast("Your script is outdated. The script is automatically updating, please wait..")
					Broadcast("New Script Info - Date: <font color = \"#B40404\">"..ServerUpdateTime.."</font> Version: <font color = \"#B40404\">v"..ServerVersion.."</font>")
					DelayAction(
						function() 
							DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, 
							function ()
								Broadcast("Successfully updated. Please reload the script for changes to take effect") 
							end) 
						end, 
					3)
				 else
					Broadcast("Your script is already updated to <font color = \"#B40404\">v"..ServerVersion.."</font>")
				end
			else
				Broadcast("An error has occurred while attempting to download version info")
			end
		end
	end
	DelayAction(
		function()
			if AutoLibs then
				Broadcast("Starting auto-libraries check.")
				function AfterDownload()
					DOWNLOAD_COUNT = DOWNLOAD_COUNT - 1
					if DOWNLOAD_COUNT == 0 then
						DOWNLOADING_LIBS = false
						Broadcast("All required libraries have been downloaded successfully, please reload for changes to take effect")
					end
				end
				function AlreadyDownloaded()
					if VIP_USER then
						if Downloaded == 3 then
							Broadcast("All required libraries are already downloaded.")
						end
					else
						if Downloaded == 1 then
							Broadcast("All required libraries are already downloaded.")
						end
					end
				end
				if VIP_USER then
					for DOWNLOAD_LIB_NAME, DOWNLOAD_LIB_URL in pairs(VIP_LIBS) do
						if FileExist(LIB_PATH .. DOWNLOAD_LIB_NAME .. ".lua") then
							require(DOWNLOAD_LIB_NAME)
							Downloaded = Downloaded + 1
							AlreadyDownloaded()
						else
							DOWNLOADING_LIBS = true
							DOWNLOAD_COUNT = DOWNLOAD_COUNT + 1

							Broadcast("Not all required libraries are installed. Now downloading <font color=\"#B40404\">"..DOWNLOAD_LIB_NAME.."</font>")
							DownloadFile(DOWNLOAD_LIB_URL, LIB_PATH .. DOWNLOAD_LIB_NAME..".lua", AfterDownload)
						end
					end
					if DOWNLOADING_LIBS then return end
				else
					for DOWNLOAD_LIB_NAME, DOWNLOAD_LIB_URL in pairs(NORMAL_LIBS) do
						if FileExist(LIB_PATH .. DOWNLOAD_LIB_NAME .. ".lua") then
							require(DOWNLOAD_LIB_NAME)
						else
							DOWNLOADING_LIBS = true
							DOWNLOAD_COUNT = DOWNLOAD_COUNT + 1

							Broadcast("Not all required libraries are installed. Now downloading <font color=\"#B40404\">"..DOWNLOAD_LIB_NAME.."</font>")
							DownloadFile(DOWNLOAD_LIB_URL, LIB_PATH .. DOWNLOAD_LIB_NAME..".lua", AfterDownload)
						end
					end
					if DOWNLOADING_LIBS then return end
				end
			end
		end,
	5)
end

--On Load Function--
function OnLoad()
	Broadcast(UPDATE_NAME.."<font color = \"#B40404\"> v"..Script_Version.."</font> successfully loaded")
	DelayAction(
		function()
			AUpdate()
		end,
	2)
end