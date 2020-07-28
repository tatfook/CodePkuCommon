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
    --    获取课件id
    {
        type = "getCoursewareID",
        message0 = L "获取课件id",
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "getCoursewareID",
        func_description = 'getCoursewareID()',
        ToNPL = function(self)
            return string.format('getCoursewareID()\n');
        end,
        examples = {
            {
                desc = L "获取课件id",
                canRun = false,
                code = [[
local courseware_id = getCoursewareID()
]]
            }
        },
    },
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
type = data.type -- 题目类型essay表示问答题，choice表示单选题或者多选题，404表示找不到题目
question = data.question -- 题目描述
answer = data.answer -- 问答题或者填空题的参考答案
options= data.options -- 单选题或者多选题的所有选项，如果type为问答题，此处为一个空表{}
if type == 'choice' then
    annserA = options[1][1] -- 第一个选项的内容
    isA = options[1][2] -- 第一个选项是否为正确答案，正确为true，错误为false
end
answer_analysis =data.answer_analysis -- 题目分析
answer_tips = data.answer_tips -- 题目提示
knowledge = data.knowledge -- 涉及的知识点
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
        message0 = L "题目 %1 答案 %2 ",
        message1 = L "时间 %1",
        arg0 = {
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
        func_description = 'submitAnswer(%d,%s,%d)',
        ToNPL = function(self)
            return string.format('submitAnswer(%d,%s,%d)\n', self:getFieldValue('question_id'), self:getFieldValue('answer'), self:getFieldValue('answer_time'));
        end,
        examples = {
            {
                desc = L "提交制定id的答题时间 返回上传是否成功",
                canRun = true,
                code = [[
submitAnswer(1,true,10)
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
        message0 = L "获取课件",   
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "getCourseware",
        func_description = 'getCourseware()',
        ToNPL = function(self)
            return string.format('getCourseware()\n');
        end,
        examples = {
            {
                desc = L "获取课件信息",
                canRun = false,
                code = [[
-- 如果课件不存在 data = '课件不存在'
data = getCourseware()
description = data.description
name = data.name
course_unit = data.course_unit
course_id = data.course_id
course_unit_id = data.course_unit_id

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
        message0 = L "加载上次学习情况",
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "getLearnRecords",
        func_description = 'getLearnRecords()',
        ToNPL = function(self)
            return string.format('getLearnRecords()\n');
        end,
        examples = {
            {
                desc = L "加载用户指定课件id的上次学习情况",
                canRun = false,
                code = [[
data = getLearnRecords()
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
        message0 = L " 类别 %1 学习进度 当前节点 %2 总结点 %3",
        arg0 = {

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
            return string.format('setLearnRecords(%d,%d,%d)\n', self:getFieldValue('category'), self:getFieldValue('current_node'), self:getFieldValue('total_node'));
        end,
        examples = {
            {
                desc = L "上传用户的学习进度",
                canRun = false,
                code = [[
-- 返回是否提交成功
data = setLearnRecords(1,3,4)
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
        message0 = L "行为 %1 行为类别 %2",
        arg0 = {
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
            return string.format('setBehaviors(%d,%d)\n', self:getFieldValue('behavior_action'), self:getFieldValue('behavior_type'));
        end,
        examples = {
            {
                desc = L "上传用户行为返回是否上传成功",
                canRun = false,
                code = [[
setBehaviors(2,3)
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
    --    创建角色
    {
        type = "createUser",
        message0 = L "创建角色%1，性别 %2",
        arg0 = {
            {
                name = "nickname",
                type = "input_value",
                shadow = { type = "input_value", value = "9号机器人" },
                text = "9号机器人",
            },
            {
                name = "gender",
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
        funcName = "createUser",
        func_description = 'createUser(%s,%d)',
        ToNPL = function(self)
            return string.format('createUser("%s",%d)\n', self:getFieldValue('nickname'), self:getFieldValue('gender'));
        end,
        examples = {
            {
                desc = L "创建角色,0保密,1男,2女",
                canRun = false,
                code = [[
response = createUser("9号机器人",1)
]]
            }
        },
    },
    --    以权重w奖励用户经验/学科经验/道具
    {
        type = "awardUser",
        message0 = L "奖励点%1 以权重%2 奖励用户",
        arg0 = {
            {
                name = "order",
                type = "input_value",
                shadow = { type = "math_number", value = 1 },
                text = 1,
            },
            {
                name = "weight",
                type = "input_value",
                shadow = { type = "math_number", value = 40 },
                text = 40,
            },            
        },
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "awardUser",
        func_description = 'awardUser(%d,%d)',
        ToNPL = function(self)
            return string.format('awardUser(%d,%d)\n', self:getFieldValue('order'), self:getFieldValue('weight'));
        end,
        examples = {
            {
                desc = L "奖励点1 以权重40 奖励用户",
                canRun = false,
                code = [[
response_data = awardUser(1,40)
total_exp = response_data.total_exp -- 所有经验值，-1表示请求出错
subject_exp = response_data.subject_exp -- 学科经验值，-1表示请求出错

print(total_exp,subject_exp)

if total_exp ~= -1 then
    for i =1,#response_data.props do
            prop_id = response_data.props[i]['prop_id'] -- 道具id
            prop_num = response_data.props[i]['prop_num'] -- 道具名称
            prop_name = response_data.props[i]['prop_name'] -- 道具数量  
            print(prop_id, prop_num, prop_name)        
    end    
end
]]
            }
        },
    },
    -- 获得用户最大游戏得分
    {
        type = "getMaxScore",
        message0 = L "获得用户最大游戏得分",
        category = "Codepku",
        helpUrl = "",
        canRun = false,
        previousStatement = true,
        nextStatement = true,
        funcName = "getMaxScore",
        func_description = 'getMaxScore()',
        ToNPL = function(self)
            return string.format('getMaxScore()\n');
        end,
        examples = {
            {
                desc = L "获得用户最大游戏得分",
                canRun = false,
                code = [[
score = getMaxScore() -- score等于-1表示获取失败
]]
            }
        },
    },
}
function Codepku.GetCmds()
    return cmds
end