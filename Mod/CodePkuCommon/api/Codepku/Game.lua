--[[
Title: Questions Api Service
Author(s): John Mai
Date: 2020-06-22 17:57:10
Desc: Questions Api Service
Example:
------------------------------------------------------------
NPL.load("(gl)Mod/CodePkuCommon/api/Game.lua");
local service = commonlib.gettable("Mod.CodePkuCommon.Service");
service.getQuestions(1):next(funciton(response)
    -- handle response
end);
-------------------------------------------------------
]]

local request = NPL.load("../BaseRequest.lua");
local ApiService = commonlib.gettable("Mod.CodePkuCommon.ApiService");

function ApiService.addExperience(courseware_id,experience,type)
    data = {        
        game_id = courseware_id,        
        exp=experience,
        exp_type = type
    }
    return request:post('/users/exps/' ,data,{sync = true});
end

function ApiService.saveScore(courseware_id,gscore)
    data = {
        game_id = courseware_id,
        score=gscore
    }
    return request:post('/game-scores/' ,data,{sync = true});
end

function ApiService.awardUser(id,w,s)
    data = {
        courseware_id = id,
        weight = w,
        sort = s
    }

    return request:post('/user-awards/' ,data,{sync = true});
end

function ApiService.getMaxScore(courseware_id,syncs)
    return request:get('/game-scores/max/' .. courseware_id,nil,{sync = syncs});
end
