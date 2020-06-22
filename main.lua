--[[
Title: 
Author(s):  
Date: 
Desc: 
use the lib:
------------------------------------------------------------
NPL.load("(gl)Mod/CodePku/main.lua");
local CodePku = commonlib.gettable("Mod.CodePku");
------------------------------------------------------------
]]
NPL.load('(gl)Mod/CodePkuCommon/code/command/CommandManager.lua');
NPL.load('(gl)Mod/CodePkuCommon/code/blockly/BlocklyManager.lua');

-- local axios = NPL.load('(gl)Mod/CodePkuCommon/util/axios/Axios.lua');

local BlocklyManager = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.BlocklyManager");
local CommandManager = commonlib.gettable("Mod.CodePkuCommon.Code.Command.CommandManager");
local MockLogin = NPL.load('(gl)Mod/CodePkuCommon/mock/MockLogin.lua')
local CodePkuCommon = commonlib.inherit(commonlib.gettable("Mod.ModBase"),commonlib.gettable("Mod.CodePkuCommon"));
local Log = NPL.load("(gl)Mod/CodePkuCommon/util/Log.lua");
local Table = NPL.load("(gl)Mod/CodePkuCommon/util/Table.lua");
CodePkuCommon:Property({"Name", "CodePkuCommon", "GetName", "SetName", { auto = true }})

function CodePkuCommon:ctor()
	
end

-- virtual function get mod name

function CodePkuCommon:GetName()
    return "CodePkuCommon"
end

-- virtual function get mod description 

function CodePkuCommon:GetDesc()
end

function CodePkuCommon:init()

    -- Log.debug("trace log info");

    

    -- local server = axios.create({baseUrl = "https://codepku.com"});

    -- server:request("/course"):next(function(response)
    --     Log.debug("codepku success");
    --     -- echo(response);
    -- end);

    -- Log.debug(server)
    -- Log.debug(axios)
    -- local response = server:request("/course",{sync=true});

    -- Log.debug(response);
    -- Log.debug(response.code);
    -- Log.debug(response.message);
    -- Log.debug(response.data);

    -- axios:request("https://baidu.com"):next(function(response)
    --         Log.debug("success");
    --         -- echo(response);
    -- end);

    CommandManager:init();    
    MockLogin:login();    
end

function CodePkuCommon:OnLogin()
end
-- called when a new world is loaded. 

function CodePkuCommon:OnWorldLoad()
    BlocklyManager:init();
end

function CodePkuCommon:OnLeaveWorld()
end

function CodePkuCommon:OnDestroy()
end

function CodePkuCommon:OnInitDesktop()

end

