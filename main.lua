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
NPL.load('(gl)Mod/CodePkuCommon/Command/CommandManager.lua')
local CommandManager = commonlib.gettable("Mod.CodePkuCommon.Command.CommandManager");

local CodePkuCommon = commonlib.inherit(commonlib.gettable("Mod.ModBase"),commonlib.gettable("Mod.CodePkuCommon"));

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
    CommandManager:init();
end

function CodePkuCommon:OnLogin()
end
-- called when a new world is loaded. 

function CodePkuCommon:OnWorldLoad()
end

function CodePkuCommon:OnLeaveWorld()
end

function CodePkuCommon:OnDestroy()
end

function CodePkuCommon:OnInitDesktop()

end

