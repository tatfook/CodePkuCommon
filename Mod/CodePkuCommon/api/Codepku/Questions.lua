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

function ApiService.getQuestions(ids,sync)
    if type(ids) == "table" then
        ids = table.concat(ids, ',')
        return request:get('/questions?id=' .. ids,nil,{sync = sync})
    elseif type(ids) == "number" then
        return request:get('/questions/' .. ids,nil,{sync = sync});
    end

    return nil;
end