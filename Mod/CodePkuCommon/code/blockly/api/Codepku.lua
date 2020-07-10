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
local ApiService = commonlib.gettable("Mod.CodePkuCommon.ApiService");

local Log = commonlib.gettable("Mod.CodePkuCommon.Utils.Log");
local Share = NPL.load("(gl)Mod/CodePkuCommon/util/Share.lua");

-- 加载显示指定id的题目. 
-- @param id: 题目id
-- @param duration: in seconds. if nil, it means forever
-- @return table
function CodeApi.loadQuestion(id)
    local response = ApiService.getQuestions(id, true);
    if response.data.code == 404 then
        return {'该題目不存在'}
    end
    local data = response.data.data
    options_list = {}
    for i = 1,#data.options do
        table.insert(options_list,data.options[i].option_title)
    end
    local return_data = {
        question = data.content,
        options= options_list,
        answer_analysis =data.answer_analysis,
        answer_tips = data.answer_tips,
        knowledge = data.knowledge,
        }
    return return_data;
end

-- 提交指定id的题目. 
-- @param id: 题目id
-- @param duration: in seconds. if nil, it means forever
-- @return table
function CodeApi.submitAnswer(courseware_id,question_id,answer,answer_time)
    local response = ApiService.submitAnswers(courseware_id,question_id,answer,answer_time)
    if response.status == 200 then
        return true
    else
        return false
    end
end


-- 进度埋点
-- @param total: 总进度
-- @param current: 当前进度
-- @param type: 进度类型
-- @return boolean
function CodeApi.setProgress(total, current, type)
    return {total,current,type}
end

-- 获取课件信息
-- @param courseware_id: 课件id
-- @return table
function CodeApi.getCourseware(courseware_id)
    local response = ApiService.getCourseware(courseware_id,true)
    if response.status == 200 then 
        local data = response.data.data
        response_data = {
            description = data.description,
            name = data.name,
            course_unit = data.course_unit,
            course_id = data.course_id,
            course_unit_id = data.course_unit_id,
        }
        return response_data
    end
    return '课件不存在'
end

-- 分享
-- @param shareType: 分享类型
-- @param options: 分享参数
function CodeApi.share(...)
    Share:new():fire(...);
end

-- 获取用户上次学习信息
-- @param courseware_id: 课件id
-- @return table
function CodeApi.getLearnRecords(courseware_id)
    local response = ApiService.getLearnRecords(courseware_id,true)
    if response.status == 200 then 
        local data = response.data.data
        response_data = {
            category = data.category,
            world_position = data.world_position,
            current_node = data.current_node,
            total_node = data.total_node,
        }
        return response_data
    end
    return '课件不存在'
end

-- 上传上次学习进度
-- @param courseware_id: 课件id
-- @param category: 类别
-- @param current_node: 当前节点
-- @param total_node: 总结点
-- @return table
function CodeApi.setLearnRecords(courseware_id,category,current_node,total_node)
    local response = ApiService.setLearnRecords(courseware_id,category,current_node,total_node,true)
    if response.status == 200 then
        return true
    end
    return false
end

-- 上传用户行为
-- @param courseware_id: 课件id
-- @return table
function CodeApi.setBehaviors(courseware_id,behavior_action,behavior_type)
    local response = ApiService.setBehaviors(courseware_id,behavior_action,behavior_type,true)   
    return response.status == 200
end
