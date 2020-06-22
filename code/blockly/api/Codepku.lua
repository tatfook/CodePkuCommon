--[[
Title: 指令方块处理函数 
Author(s): John Mai
Date: 2020-06-18 11:53:57
Desc: 指令方块底层处理函数
Example:
------------------------------------------------------------
NPL.load("(gl)Mod/CodePkuCommon/code/blockly/api/Codepku.lua");
local api = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.Api");
-------------------------------------------------------
]]

local api = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.Api");
local Log = NPL.load("(gl)Mod/CodePkuCommon/util/Log.lua");

-- 加载显示指定id的题目. 
-- @param id: 题目id
-- @param duration: in seconds. if nil, it means forever
function api:loadQuestion(id)
    local QuestionsService = NPL.load("(gl)Mod/CodePkuCommon/api/Codepku/Questions.lua");
    local Table = NPL.load("(gl)Mod/CodePkuCommon/util/Table.lua");

    local err, msg, data = QuestionsService:GetOne(id);
    Log.debug(err);
    Log.debug(msg);
    Log.debug(data);
end