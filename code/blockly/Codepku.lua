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
    --    加载题目
    {
        type = "loadQuestion",
        message0 = L "加载题目 %1",
        arg0 = {
            {
                name = "id",
                type = "input_value",
                shadow = { type = "math_number" },
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
        examples = {
            {
                desc = L "加载显示指定id的题目",
                canRun = false,
                code = [[
            loadQuestion(1)
]]
            }
        },
    },

    --    提交答案
    {
        type = "submitAnswer",
        message0 = L "提交答案 %1",
        arg0 = {
            {
                name = "id",
                type = "input_value",
                shadow = { type = "math_number", value = 1 },
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
        examples = {
            {
                desc = L "提交指定id的答案",
                canRun = true,
                code = [[
            submitAnswer(1)
]]
            }
        },
    },

    -- 进度类型
    {
        type = "progressType",
        message0 = "%1",
        arg0 = {
            {
                name = "value",
                type = "field_dropdown",
                options = {
                    { L "起始", "start" },
                    { L "结束", "end" },
                    { L "学习", "leaning" },
                    { L "练习", "exercising" },
                    { L "闯关", "passing" },
                },
            },
        },
        hide_in_toolbox = true,
        category = "Codepku",
        output = { type = "null", },
        helpUrl = "",
        canRun = false,
        func_description = '"%s"',
        ToNPL = function(self)
            return self:getFieldAsString('value');
        end,
        examples = {
            {
                desc = "",
                canRun = true,
                code = [[
    ]]
            }
        },
    },

    --    进度设置
    {
        type = "setProgress",
        message0 = L "总进度%1 当前进度%2 类型%3",
        arg0 = {
            {
                name = "total",
                type = "input_value",
                shadow = { type = "math_number", value = 2 },
                text = 2,
            },
            {
                name = "current",
                type = "input_value",
                shadow = { type = "math_number", value = 1 },
                text = 1,
            },
            {
                name = "type",
                type = "input_value",
                shadow = { type = "progressType", value = 'start' },
                text = "start",
            },
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "setProgress",
        func_description = 'setProgress(%d,%d,%s)',
        ToNPL = function(self)
            return string.format('setProgress(%d,%d,"%s")\n', self:getFieldValue('total'), self:getFieldValue('current'), self:getFieldAsString('type'));
        end,
        examples = {
            {
                desc = L "记录总进度，当前进度，进度类型",
                canRun = false,
                code = [[
                    setProgress(4,2,"start")
]]
            }
        },
    },

    --    获取课件信息
    {
        type = "getCourseware",
        message0 = L "获取课件 %1",
        arg0 = {
            {
                name = "id",
                type = "input_value",
                shadow = { type = "math_number", value = 1 },
                text = 1,
            }
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "getCourseware",
        func_description = 'getCourseware(%d)',
        ToNPL = function(self)
            return string.format('getCourseware(%d)\n', self:getFieldValue('id'));
        end,
        examples = {
            {
                desc = L "获取对应id课件信息",
                canRun = false,
                code = [[
                    setProgress(4,2,"start")
]]
            }
        },
    },

    -- 进度类型
    {
        type = "shareType",
        message0 = "%1",
        arg0 = {
            {
                name = "value",
                type = "field_dropdown",
                options = {
                    { L "文本", "text" },
                    { L "图片", "image" }
                },
            },
        },
        hide_in_toolbox = true,
        category = "Codepku",
        output = { type = "null", },
        helpUrl = "",
        canRun = false,
        func_description = '"%s"',
        ToNPL = function(self)
            return self:getFieldAsString('value');
        end,
        examples = {
            {
                desc = "",
                canRun = true,
                code = [[
    ]]
            }
        },
    },

    --    分享功能
    {
        type = "share",
        message0 = L "分享 %1 %2",
        arg0 = {
            {
                name = "shareType",
                type = "input_value",
                shadow = { type = "shareType", value = "text" },
                text = "text",
            },
            {
                name = "options",
                type = "input_value",
                shadow = { type = "text", value = "text" },
                text = "text",
            }
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "share",
        func_description = 'share(%s,%s)',
        ToNPL = function(self)
            return string.format('share("%s","%s")\n', self:getFieldValue('shareType'), self:getFieldValue('options'));
        end,
        examples = {
            {
                desc = L "分享功能",
                canRun = false,
                code = [[
                    share("text","分享内容")
]]
            }
        },
    },
}
function Codepku.GetCmds()
    return cmds
end