--[[
Title: 指令管理 
Author(s): John Mai
Date: 2020-06-18 11:53:57
Desc: 指令操作管理类
Example:
------------------------------------------------------------
NPL.load("(gl)Mod/CodePkuCommon/code/blockly/BlocklyManager.lua");
local BlocklyManager = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.BlocklyManager");
BlocklyManager:init();
-------------------------------------------------------
]]

NPL.load("(gl)Mod/CodePkuCommon/code/blockly/Codepku.lua");
NPL.load("(gl)script/apps/Aries/Creator/Game/Code/CodeCoroutine.lua");
local CodeCoroutine = commonlib.gettable("MyCompany.Aries.Game.Code.CodeCoroutine");
local BlocklyManager = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.BlocklyManager");
local api = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.Api");
local Log = NPL.load("(gl)Mod/CodePkuCommon/util/Log.lua");
local Table = NPL.load("(gl)Mod/CodePkuCommon/util/Table.lua");

function BlocklyManager:init()

    GameLogic.GetFilters():add_filter(
        "ParacraftCodeBlocklyAppendDefinitions",
        function(ParacraftCodeBlockly)
            NPL.load("(gl)Mod/CodePkuCommon/code/blockly/Codepku.lua");
            local Codepku = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.Codepku");
            ParacraftCodeBlockly.AppendDefinitions(Codepku.GetCmds());

        end
    );

    GameLogic.GetFilters():add_filter(
			"ParacraftCodeBlocklyCategories",
			function(categories)
				categories[#categories + 1]={name = "Codepku", text = L"定制", colour="#459197", };
                return categories;
			end
    );

    -- 注入指令函数api
    GameLogic.GetFilters():add_filter(
			"CodeAPIInstallMethods",
            function(CodeEnv)
                for k,v in pairs(api) do
                    local f = function(...)
                        return api[k](CodeEnv, ...);
                    end
                    CodeEnv[k] = f;
                end
			end
    );
end