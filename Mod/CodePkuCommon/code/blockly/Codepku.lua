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
data = loadQuestion(12)
question = data.question
options= data.options
answer_analysis =data.answer_analysis
answer_tips = data.answer_tips
knowledge = data.knowledge
]]
            }
        },
    },
    --      答案选项
    {
        type = "answerType",
        message0 = "%1",
        arg0 = {
            {
                name = "value",
                type = "field_dropdown",
                options = {
                    { L "正确", true },
                    { L "错误", false},
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
    --    提交答案
    {
        type = "submitAnswer",
        message0 = L "课件 %1 题目 %2 答案 %3 ",
        message1 = L "时间 %1",
        arg0 = {
            {
                name = "courseware_id",
                type = "input_value",
                shadow = { type = "math_number", value = 1 },
                text = 1,
            },
            {
                name = "question_id",
                type = "input_value",
                shadow = { type = "math_number", value = 1 },
                text = 1,
            },
            {
                name = "answer",
                type = "input_value",
                shadow = { type = "answerType", value = true },
                text = true,
            },
        },
        arg1 = {
            {
                name = "answer_time",
                type = "input_value",
                shadow = { type = "math_number", value = 10 },
                text = 10,
            },
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "submitAnswer",
        func_description = 'submitAnswer(%d,%d,%s,%d)',
        ToNPL = function(self)
            return string.format('submitAnswer(%d,%d,%s,%d)\n', self:getFieldValue('courseware_id'), self:getFieldValue('question_id'), self:getFieldValue('answer'), self:getFieldValue('answer_time'));
        end,
        examples = {
            {
                desc = L "提交制定id的答题时间 返回上传是否成功",
                canRun = true,
                code = [[
            submitAnswer(1,1,true,10)
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
                    { L "起始", 1 },
                    { L "结束", 2 },
                    { L "学习", 3 },
                    { L "练习", 4 },
                    { L "闯关", 5},
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

--     --    进度设置
--     {
--         type = "setProgress",
--         message0 = L "总进度%1 当前进度%2 类型%3",
--         arg0 = {
--             {
--                 name = "total",
--                 type = "input_value",
--                 shadow = { type = "math_number", value = 2 },
--                 text = 2,
--             },
--             {
--                 name = "current",
--                 type = "input_value",
--                 shadow = { type = "math_number", value = 1 },
--                 text = 1,
--             },
--             {
--                 name = "type",
--                 type = "input_value",
--                 shadow = { type = "progressType", value = 'start' },
--                 text = "start",
--             },
--         },
--         category = "Codepku",
--         helpUrl = "",
--         canRun = false,
--         previousStatement = true,
--         nextStatement = true,
--         funcName = "setProgress",
--         func_description = 'setProgress(%d,%d,%s)',
--         ToNPL = function(self)
--             return string.format('setProgress(%d,%d,"%s")\n', self:getFieldValue('total'), self:getFieldValue('current'), self:getFieldAsString('type'));
--         end,
--         examples = {
--             {
--                 desc = L "记录总进度，当前进度，进度类型",
--                 canRun = false,
--                 code = [[
--                     setProgress(4,2,"start")
-- ]]
--             }
--         },
--     },

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
-- 如果课件id不存在 data = '课件不存在'
data = getCourseware(4)
description = data.description,
name = data.name,
course_unit = data.course_unit,
course_id = data.course_id,
course_unit_id = data.course_unit_id,

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
    --    获取用户上一次学习
    {
        type = "getLearnRecords",
        message0 = L "加载上次学习情况 %1",
        arg0 = {
            {
                name = "id",
                type = "input_value",
                shadow = { type = "math_number",value = 1},
                text = 1,
            },
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "getLearnRecords",
        func_description = 'getLearnRecords(%d)',
        ToNPL = function(self)
            return string.format('getLearnRecords(%d)\n', self:getFieldValue('id'));
        end,
        examples = {
            {
                desc = L "加载用户指定课件id的上次学习情况",
                canRun = false,
                code = [[
            data = getLearnRecords(4)
            category = data.category
            pos= data.world_position
            current_node = data.current_node
            total_node = data.total_node
]]
            }
        },
    },

     --    提交用户学习进度
     {
        -- courseware_id,category,current_node,total_node
        type = "setLearnRecords",
        message0 = L " 上传课件 %1 类别 %2 学习进度 当前节点 %3 总结点 %4",
        arg0 = {
            {
                name = "courseware_id",
                type = "input_value",
                shadow = { type = "math_number",value = 1},
                text = 1,
            },
            {
                name = "category",
                type = "input_value",
                shadow = { type = "progressType",value = 1},
                text = 1,
            },
            {
                name = "current_node",
                type = "input_value",
                shadow = { type = "math_number",value = 1},
                text = 1,
            },
            {
                name = "total_node",
                type = "input_value",
                shadow = { type = "math_number",value = 1},
                text = 1,
            },
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "setLearnRecords",
        func_description = 'setLearnRecords(%d)',
        ToNPL = function(self)
            return string.format('setLearnRecords(%d,%d,%d,%d)\n', self:getFieldValue('courseware_id'), self:getFieldValue('category'), self:getFieldValue('current_node'), self:getFieldValue('total_node'));
        end,
        examples = {
            {
                desc = L "上传用户的学习进度",
                canRun = false,
                code = [[
-- 返回是否提交成功
data = setLearnRecords(4,1,3,4)
]]
            }
        },
    },

    {
        type = "behavior_action_type",
        message0 = "%1",
        arg0 = {
            {
                name = "value",
                type = "field_dropdown",
                options = {
                    { L "开始", 1 },
                    { L "结束", 2 },
                    { L "分享", 3 },
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
    {
        type = "behavior_type1",
        message0 = "%1",
        arg0 = {
            {
                name = "value",
                type = "field_dropdown",
                options = {
                    { L "动画", 1},
                    { L "位置", 2},
                    { L "答题", 3},
                    { L "微信", 4},
                    { L "QQ", 5},
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
     --    提交用户行为
     {
        -- courseware_id,category,current_node,total_node
        type = "setBehaviors",
        message0 = L " 种类 %1 行为 %2 行为类别 %3",
        arg0 = {
            {
                name = "courseware_id",
                type = "input_value",
                shadow = { type = "math_number",value = 1},
                text = 1,
            },
            {
                name = "behavior_action",
                type = "input_value",
                shadow = { type = "behavior_action_type",value = 1},
                text = 1,
            },
            {
                name = "behavior_type",
                type = "input_value",
                shadow = { type = "behavior_type1",value = 1},
                text = 1,
            },

        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "setBehaviors",
        func_description = 'setBehaviors(%d)',
        ToNPL = function(self)
            return string.format('setBehaviors(%d,%d,%d)\n', self:getFieldValue('courseware_id'), self:getFieldValue('behavior_action'), self:getFieldValue('behavior_type'));
        end,
        examples = {
            {
                desc = L "上传用户行为返回是否上传成功",
                canRun = false,
                code = [[
                    setBehaviors(3,2,3)
]]
            }
        },
    },
    -- 给用户增加经验值
    {
        type = "addExperience",
        message0 = L "给用户增加经验值 %1",
        arg0 = {
            {
                name = "exp",
                type = "input_value",
                shadow = { type = "math_number" },
                text = 99,
            },
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "addExperience",
        func_description = 'addExperience(%d)',
        ToNPL = function(self)
            return string.format('addExperience(%d)\n', self:getFieldValue('exp'));
        end,
        examples = {
            {
                desc = L "给用户增加经验值",
                canRun = false,
                code = [[
response = addExperience(99)
]]
            }
        },
    },

    -- 保存游戏得分
    {
        type = "saveScore",
        message0 = L "保存游戏得分 %1",
        arg0 = {
            {
                name = "score",
                type = "input_value",
                shadow = { type = "math_number" },
                text = 99,
            },
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "saveScore",
        func_description = 'saveScore(%d)',
        ToNPL = function(self)
            return string.format('saveScore(%d)\n', self:getFieldValue('score'));
        end,
        examples = {
            {
                desc = L "保存游戏得分",
                canRun = false,
                code = [[
response = saveScore(99)
]]
            }
        },
    },
}
function Codepku.GetCmds()
    return cmds
end