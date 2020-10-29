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
local WorldCommon = commonlib.gettable("MyCompany.Aries.Creator.WorldCommon")
local Config = NPL.load("(gl)Mod/WorldShare/config/Config.lua")

local Log = commonlib.gettable("Mod.CodePkuCommon.Utils.Log");
local Share = NPL.load("(gl)Mod/CodePkuCommon/util/Share.lua");

local BlockEngine = commonlib.gettable("MyCompany.Aries.Game.BlockEngine")

NPL.load("(gl)Mod/CodePku/cellar/Common/CommonFunc/CommonFunc.lua")
local CommonFunc = commonlib.gettable("Mod.CodePku.Common.CommonFunc")

-- 获取课件id
-- @return table
function CodeApi.getCoursewareID()

    if System.Codepku and System.Codepku.Coursewares then 
        return System.Codepku.Coursewares.id
    else
        return ParaEngine.GetAppCommandLineByParam("courseware_id", nil)
    end
end
    
-- 加载显示指定id的题目. 
-- @param id: 题目id
-- @return table
function CodeApi.loadQuestion(id)
    local response = ApiService.getQuestions(id, true);
    if response.status == 404 then
        return_data = {
            type="404",
            msg="找不到题号为" .. id .. "的问题"
            }
    else
        local data = response.data.data
        local question_type = "choice"
        if #data.options == 0 then
            question_type = "essay"
        end

        options_list = {}
        for i = 1,#data.options do
            table.insert(options_list,{data.options[i].option_title,data.options[i].is_correct})
        end

        return_data = {
            type = question_type,
            question = data.content,
            answer = data.answer,
            options= options_list,
            answer_analysis =data.answer_analysis,
            answer_tips = data.answer_tips,
            knowledge = data.knowledge,
            }
    end
    return return_data;
end


-- 提交指定id的题目. 
-- @param question_id: 题目id
-- @param answer: 答案
-- @param answer: 回答时间
-- @return table
function CodeApi.submitAnswer(question_id,answer,answer_time)

    local courseware_id = CodeApi.getCoursewareID()
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
-- @return table
function CodeApi.getCourseware()

    local courseware_id = CodeApi.getCoursewareID()
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
    else
        response_data = {
            description = '课件不存在',
            name = '课件不存在',
            course_unit = '课件不存在',
            course_id = '课件不存在',
            course_unit_id = '课件不存在',
        }
     
    end
    return response_data
end

-- 分享
-- @param shareType: 分享类型
-- @param options: 分享参数
function CodeApi.share(...)
    Share:new():fire(...);
end

-- 获取用户上次学习信息
-- @return table
function CodeApi.getLearnRecords()
    local courseware_id = CodeApi.getCoursewareID()
    local response = ApiService.getLearnRecords(courseware_id,true)

    if response.status == 200 then 

        local data = response.data.data
        -- local pos = response_data = {};
        world_position = data.world_position

        if world_position then

            pos = {}
            pos.x,pos.y,pos.z = BlockEngine:block_float(world_position.x,world_position.y,world_position.z)
            pos.x = math.floor(pos.x)
            pos.y = math.floor(pos.y)
            pos.z = math.floor(pos.z)
        end

        response_data = {
            category = data.category or '课件不存在',
            world_position = pos or '课件不存在',
            current_node = data.current_node or '课件不存在',
            total_node = data.total_node or '课件不存在',
        }

    else
        response_data = {
            category = '课件不存在',
            world_position ='课件不存在',
            current_node = '课件不存在',
            total_node = '课件不存在',
        }
    end
    return response_data
end

-- 上传上次学习进度
-- @param category: 类别
-- @param current_node: 当前节点
-- @param total_node: 总结点
-- @return table
function CodeApi.setLearnRecords(category,current_node,total_node)
    local courseware_id = CodeApi.getCoursewareID()
    local response = ApiService.setLearnRecords(courseware_id,category,current_node,total_node,true)
    if response.status == 200 then
        -- 课程结束奖励结算
        -- category==2是结束, current_node==total_node是最后一个节点,or是因为可能可能有不规范的地方,满足任意一个都视为结束
        if category == 2 or current_node == total_node then 
            local GameLogic = commonlib.gettable("MyCompany.Aries.Game.GameLogic")
            GameLogic.GetFilters():apply_filters("codepkuTaskSettlement", data, true);
        end
        return true
    end
    return false
end

-- 上传用户行为
-- @param behavior_action: 行为
-- @param behavior_type: 行为类型
-- @return table
function CodeApi.setBehaviors(behavior_action,behavior_type)
    local courseware_id = CodeApi.getCoursewareID()
    local response = ApiService.setBehaviors(courseware_id,behavior_action,behavior_type,true)   
    return response.status == 200
end

-- 给用户增加经验值
-- @param experience: 经验值
-- @return table
function CodeApi.addExperience(experience,exp_type)
    local courseware_id = CodeApi.getCoursewareID()
    local response = ApiService.addExperience(courseware_id,experience,exp_type)
    return response.status == 200
end

-- 保存游戏得分
-- @param score: 游戏最终得分
-- @return table
function CodeApi.saveScore(score)
    local courseware_id = CodeApi.getCoursewareID()
    local response = ApiService.saveScore(courseware_id,score)

    if  response.status == 200 then
        return response.data
    end
end

-- 创建角色
-- @param nickname: 角色名
-- @param gender: 角色性别
-- @return table
function CodeApi.createUser(nickname,gender)    
    local response = ApiService.CreateUser(nickname,gender)
    return response.status == 200
end

-- 奖励用户经验/学科经验/道具
-- @param sort: 奖励点
-- @return table
function CodeApi.awardUser(sort)    
    local courseware_id = CodeApi.getCoursewareID()
    local response = ApiService.awardUser(courseware_id,sort)

    if response.status == 200 then 
        local data = response.data.data
        
        -- prop_list = {}
        
        -- for i = 1,#data.props do
        --     table.insert(prop_list,{data.props[i].prop_id,data.props[i].prop_name,data.props[i].prop_num})
        -- end

        -- exp = data.total_exp 

        -- response_data = {
        --     total_exp = data.total_exp,
        --     subject_exp = data.subject_exp or 0,
        --     props = prop_list
            
        -- }
        local GameLogic = commonlib.gettable("MyCompany.Aries.Game.GameLogic")
        -- 课程节点奖励消息至系统消息栏
        GameLogic.GetFilters():apply_filters("codepkuAwardUser", data);
        -- 课程节点奖励消息tip提示
        GameLogic.GetFilters():apply_filters("codepkuTaskSettlement", data);

        -- 刷新本地金币
        if data.props and next(data.props) then
            local wanxuebi = 0
            local wanxuequan = 0
            for _,prop in pairs(data.props) do
                if prop.prop_id == 1 then
                    wanxuebi = prop.prop_num
                elseif prop.prop_id == 2 then
                    wanxuequan = prop.prop_num
                end
            end
            CommonFunc.RefreshLocalMoney({{amount=wanxuebi,currency_id=1,},{amount=wanxuequan,currency_id=2,},})
        end

        return data
    else

        response_data = {           
            total_exp = -1,
            subject_exp = -1,
            props = response.status
        }
    end    
    
    return response_data
end

-- 获得用户最大游戏得分
-- @return 最大分数
function CodeApi.getMaxScore()
    local courseware_id = CodeApi.getCoursewareID()
    local response = ApiService.getMaxScore(courseware_id,true)

    if response.status == 200 then
        local data = response.data.data
        score = data.score or 0
    else
        score = -1
    end

    return score
end

-- 拾取道具
-- @return 最大分数
function CodeApi.pickProperty(prop_num,prop_id)

    local response = ApiService.pickProperty(prop_id,prop_num)

    if response.status == 200 then

        local data = response.data.data
        
        return data
    else
        return response
    end

end

-- 获取<站到最后>题目信息
-- @return 题目信息
function CodeApi.getSubjectsDataSTE(callbackData)
    ApiService.getSubjectsDataSTE(function (response)
        if response.status == 200 then
            callbackData.data = response.data and response.data.data or nil
        else
            callbackData.data = nil
        end
    end)
end

-- 获取<站到最后>最高关卡数
-- @return 最高关卡数
function CodeApi.getMaxRoundSTE(callbackData)
    ApiService.getMaxRoundSTE(function (response)
        if response.status == 200 then
            callbackData.data =  response.data and response.data.data and response.data .data.rounds or nil
        else
            callbackData.data =  nil
        end
    end)
end

-- 保存<站到最后>最高关卡数
-- @return response or nil
function CodeApi.saveMaxRoundSTE(max_level, callbackData)
    ApiService.saveMaxRoundSTE(max_level, function (response)
        if response.status == 200 then
            callbackData.data = response.data
        else
            callbackData.data = nil
        end
    end)
end

--获取<站到最后>相关函数
--@return 相关函数
function CodeApi.getFunsSTE()
    return {getSubjectsDataSTE=CodeApi.getSubjectsDataSTE, getMaxRoundSTE=CodeApi.getMaxRoundSTE, saveMaxRoundSTE=CodeApi.saveMaxRoundSTE}
end