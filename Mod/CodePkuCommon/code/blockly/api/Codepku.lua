--[[
Title: 指令方块处理函数 
Author(s): John Mai
Date: 2020-06-18 11:53:57
Desc: 指令方块底层处理函数
Example:
------------------------------------------------------------
NPL.load("(gl)Mod/CodePkuCommon/code/blockly/api/Codepku.lua");
local api = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.Api");
/
-------------------------------------------------------
]]

local CodeApi = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.CodeApi");
local Log = NPL.load("(gl)Mod/CodePkuCommon/util/Log.lua");
local ApiService = commonlib.gettable("Mod.CodePkuCommon.ApiService");

-- 加载显示指定id的题目. 
-- @param id: 题目id
-- @param duration: in seconds. if nil, it means forever
function CodeApi.loadQuestion(id)
    local response = ApiService.getQuestions(id,true);
    return response;
end

function CodeApi.submitAnswer(text)
    echo("submitAnswer")
end