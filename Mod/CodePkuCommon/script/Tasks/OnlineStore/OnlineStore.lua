--[[
Title: OnlineStore
Author(s): LiXizhi
Date: 2019/8/13
Desc: online store at: https://keepwork.com/p/comp/system?port=8099

use the lib:
------------------------------------------------------------
NPL.load("(gl)script/apps/Aries/Creator/Game/Tasks/OnlineStore/OnlineStore.lua");
local OnlineStore = commonlib.gettable("MyCompany.Aries.Game.Tasks.OnlineStore");
local task = OnlineStore:new():Init();
task:Run();
-------------------------------------------------------
]]
local GameLogic = commonlib.gettable("MyCompany.Aries.Game.GameLogic")
local EntityManager = commonlib.gettable("MyCompany.Aries.Game.EntityManager")
local Config = NPL.load("(gl)Mod/CodePkuCommon/config/Config.lua")


-- local CodePkuOnlineStore = commonlib.inherit(commonlib.gettable("MyCompany.Aries.Game.Task"), commonlib.gettable("MyCompany.Aries.Game.Tasks.OnlineStore"));
local CodePkuOnlineStore = NPL.export()

-- this is always a top level task. 
CodePkuOnlineStore.is_top_level = true;
CodePkuOnlineStore.portNumber = "8099"


function CodePkuOnlineStore.CustomOnlineStoreUrl(name)
	local host = Config.defaultCodepkuHost;
	-- local token = System.User.keepworktoken or ''
    if System.os.GetPlatform() == 'mac' or System.os.GetPlatform() == 'android' then
        return format("%s/library#/"..name.."?type=protocol&port=%s", host, tostring(CodePkuOnlineStore.portNumber or 8099));
    else
        return format("%s/library#/"..name.."?port=%s", host, tostring(CodePkuOnlineStore.portNumber or 8099));
    end
end

function CodePkuOnlineStore.getPageParamUrl(name)
    return "Mod/CodePkuCommon/script/Tasks/OnlineStore/OnlineStore.html?name=" .. name;
end