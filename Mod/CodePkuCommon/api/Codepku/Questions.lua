--[[
Title: Questions Api Service
Author(s): John Mai
Date: 2020-06-22 17:57:10
Desc: Questions Api Service
Example:
------------------------------------------------------------
NPL.load("(gl)Mod/CodePkuCommon/api/Questions.lua");
local service = commonlib.gettable("Mod.CodePkuCommon.Service");
service.getQuestions(1):next(funciton(response)
    -- handle response
end);
-------------------------------------------------------
]]

local request = NPL.load("../BaseRequest.lua");
local ApiService = commonlib.gettable("Mod.CodePkuCommon.ApiService");
local EntityManager = commonlib.gettable("MyCompany.Aries.Game.EntityManager")
function ApiService.getQuestions(ids,sync)
    if type(ids) == "table" then
        ids = table.concat(ids, ',')
        return request:get('/questions?id=' .. ids,nil,{sync = sync})
    elseif type(ids) == "number" then
        return request:get('/questions/' .. ids,nil,{sync = sync});
    end

    return nil;
end

function ApiService.submitAnswers(courseware_id,question_id,answer,answer_time)
    if answer then
        is_right = 1
    else
        is_right = 0
    end
    data = {
        is_right = is_right,
        courseware_id = tonumber(courseware_id),
        question_id = tonumber(question_id),
        answer_duration = tonumber(answer_time)
    }
    return request:post('/answers/',data,{sync = true})
end


function ApiService.getCourseware(courseware_id,sync)
    return request:get('/coursewares/' .. courseware_id,nil,{sync = sync});
end

function ApiService.getLearnRecords(courseware_id,sync)
    return request:get('/learn-records/last/' .. courseware_id,nil,{sync = sync});
end

function ApiService.setLearnRecords(courseware_id,category,current_node,total_node)
    if (current_node == total_node) then
        -- 触发任务系统计数
        local updateTask = {
            type = "course",
            courseware_id = courseware_id,
            category = System.Codepku.Coursewares and System.Codepku.Coursewares.course.category
        }

        local GameLogic = commonlib.gettable("MyCompany.Aries.Game.GameLogic")
        GameLogic.GetFilters():apply_filters("TaskSystemList", updateTask);
        GameLogic.GetFilters():apply_filters("Schoolyard.IncreaseVitality", updateTask);        -- 上完课触发活跃度系统
    end

    local pos_x, pos_y, pos_z = EntityManager.GetPlayer():GetPosition()
    data = {
        world_position = {x=pos_x,y=pos_y,z=pos_z},
        category = tonumber(category),
        courseware_id = tonumber(courseware_id),
        current_node = tonumber(current_node),
        total_node = tonumber(total_node),
    }
    return request:post('/learn-records/' ,data,{sync = true});
end

function ApiService.setBehaviors(courseware_id,behavior_action,behavior_type)
    local pos_x, pos_y, pos_z = EntityManager.GetPlayer():GetPosition()
    data = {
        position = {x=pos_x,y=pos_y,z=pos_z},
        behavior_type = tonumber(behavior_type),
        courseware_id = tonumber(courseware_id),
        behavior_action = tonumber(behavior_action),
        ext_data= {}
    }
    return request:post('/behaviors' ,data,{sync = true});
end