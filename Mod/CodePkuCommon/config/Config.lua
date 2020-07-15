--[[
Title: Config
Author(s):  big
Date: 2018.10.18
place: Foshan
Desc: 
use the lib:
------------------------------------------------------------
local Config = NPL.load("(gl)Mod/CodePkuCommon/config/Config.lua")
------------------------------------------------------------
]]

local Config = NPL.export();

Config.env = {
  RELEASE = "RELEASE",
  STAGING = "STAGING",
  DEV = "DEV",
  LOCAL = "LOCAL"
};

Config.defaultEnv = (ParaEngine.GetAppCommandLineByParam("codepkuenv", nil) or Config.env.RELEASE);
--Config.courseware_id = (ParaEngine.GetAppCommandLineByParam("courseware_id", nil));

Config.codepkuServer = {
  RELEASE = "https://game.codepku.com/api/game",
  STAGING = "https://game.staging.codepku.com/api/game",
  DEV = "https://game.dev.codepku.com/api/game",
  LOCAL = "http://game.local.codepku.com/api/game"
};

Config.codepkuHost = {
  RELEASE = "https://game.codepku.com",
  STAGING = "https://game.staging.codepku.com",
  DEV = "https://game.dev.codepku.com",
  LOCAL = "http://game.local.codepku.com"
};

Config.defaultCodepkuServer  = Config.codepkuServer[Config.defaultEnv];
Config.defaultCodepkuHost = Config.codepkuHost[Config.defaultEnv];
