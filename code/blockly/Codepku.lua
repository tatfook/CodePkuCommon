--[[
Title: 编玩边学定制指令
Author(s): John Mai
Date: 2020-06-18 11:53:57
Desc: 编玩边学定制指令
Example:
------------------------------------------------------------
NPL.load("(gl)Mod/CodePkuCommon/code/blockly/Codepku.lua");
local Codepku = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.Codepku")
local cmds = Codepku.GetCmds();
-------------------------------------------------------
]]
local Codepku = commonlib.gettable("Mod.CodePkuCommon.Code.Blockly.Codepku")

local cmds = {
    {
        type = "loadQuestion",
        message0 = L "加载题目 %1",
        arg0 = {
            {
                name = "id",
                type = "input_value",
                shadow = { type = "math_number"},
                text = 1,
            },
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "loadQuestion",
        func_description = 'loadQuestion(%d)',
        ToNPL = function(self)
            return string.format('loadQuestion(%d)\n', self:getFieldValue('id'));
        end,
        examples = { { desc = L "加载显示指定id的题目", canRun = true, code = [[
            loadQuestion(1)
]] } },
    },    
    {
        type = "submitAnswer",
        message0 = L "提交答案 %1",
        arg0 = {
            {
                name = "id",
                type = "input_value",
                shadow = { type = "math_number", value = 1},
                text = 1,
            },
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "submitAnswer",
        func_description = 'submitAnswer(%d)',
        ToNPL = function(self)
            return string.format('submitAnswer(%d)\n', self:getFieldValue('id'));
        end,
        examples = { { desc = L "提交指定id的答案", canRun = true, code = [[
            submitAnswer(1)
]] } },
    },
}
function Codepku.GetCmds()
    return cmds
end