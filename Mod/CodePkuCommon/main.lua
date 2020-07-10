--[[Title: 
Author(s):  
Date: 
Desc: 
use the lib:
------------------------------------------------------------
NPL.load("(gl)Mod/CodePku/main.lua");
local CodePku = commonlib.gettable("Mod.CodePku");
------------------------------------------------------------
]]
NPL.load("(gl)Mod/CodePkuCommon/util/Utils.lua");
NPL.load('(gl)Mod/CodePkuCommon/code/command/CommandManager.lua');
NPL.load('(gl)Mod/CodePkuCommon/code/blockly/BlocklyManager.lua');

local ApiRegister = NPL.load("(gl)Mod/CodePkuCommon/api/main.lua");

local BlocklyManager = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.BlocklyManager");
local CommandManager = commonlib.gettable("Mod.CodePkuCommon.Code.Command.CommandManager");
local MockLogin = NPL.load('(gl)Mod/CodePkuCommon/mock/MockLogin.lua')
local CodePkuCommon = commonlib.inherit(commonlib.gettable("Mod.ModBase"), commonlib.gettable("Mod.CodePkuCommon"));

CodePkuCommon:Property({ "Name", "CodePkuCommon", "GetName", "SetName", { auto = true } })

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
    ApiRegister.init();
    CommandManager:init();
    BlocklyManager:init();
    MockLogin:login();
    GameLogic.GetFilters():add_filter(
        "desktop_menu",
        function (menuItems)
            local isCodepku = ParaEngine.GetAppCommandLineByParam("isCodepku", "false") == "true"
            if (isCodepku) then
                return {};
            else
                for _, menuItem in ipairs(menuItems) do
                    if (menuItem.name == 'window') then
                        table.insert(menuItem.children, 4, {text = L"玩学世界元件库...",name = "window.component", cmd="/open component"});
                        table.insert(menuItem.children, 5, {text = L"题库...",name = "window.question", cmd="/open question"});
                    end
                end
                return menuItems;
            end
        end
    );
	GameLogic.GetFilters():add_filter(
		"OnlineStore.CustomOnlineStoreUrl",
        function (url, name)
            if (name == "component" or name == "question") then 
                local CodePkuOnlineStore = NPL.load("(gl)Mod/CodePkuCommon/script/Tasks/OnlineStore/OnlineStore.lua");
                return CodePkuOnlineStore.CustomOnlineStoreUrl(name);
            else
                return url;
            end
		end
    );
	GameLogic.GetFilters():add_filter(
		"OnlineStore.getPageParamUrl",
        function (defaultUrl, name)
            if (name == "component" or name == "question") then 
                local CodePkuOnlineStore = NPL.load("(gl)Mod/CodePkuCommon/script/Tasks/OnlineStore/OnlineStore.lua");
                return CodePkuOnlineStore.getPageParamUrl(name);
            else
                return defaultUrl;
            end
		end
    );
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