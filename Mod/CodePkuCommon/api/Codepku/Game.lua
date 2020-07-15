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
local EntityManager = commonlib.gettable("MyCompany.Aries.Game.EntityManager")


function ApiService.addExperience(courseware_id,experience)
    data = {
        game_id = courseware_id,
        exp=experience
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
