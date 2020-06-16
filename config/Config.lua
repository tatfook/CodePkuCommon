--[[
Title: Config
Author(s):  big
Date: 2018.10.18
place: Foshan
Desc: 
use the lib:
------------------------------------------------------------
local Config = NPL.load("(gl)Mod/WorldShare/config/Config.lua")
------------------------------------------------------------
]]

local Config = NPL.export()

Config.env = {
  ONLINE = "ONLINE",
  STAGE = "STAGE",
  RELEASE = "RELEASE",
  LOCAL = "LOCAL"
}

Config.defaultEnv = (ParaEngine.GetAppCommandLineByParam("codepkuenv", nil) or Config.env.ONLINE)

Config.codepkuServerList = {
  ONLINE = "https://game.codepku.com/api/game",
  STAGE = "https://game.staging.codepku.com/api/game",
  RELEASE = "https://game.dev.codepku.com/api/game",
  LOCAL = "http://game.local.codepku.com/api/game"
}
