--[[
Title: Users Api Service
Author(s): John Mai
Date: 2020-06-22 17:57:10
Desc: Users Api Service
Example:
------------------------------------------------------------

NPL.load("(gl)Mod/CodePkuCommon/service/Users.lua");
local service = commonlib.gettable("Mod.CodePkuCommon.Service");

service.Login(mobile,password):next(funciton(response)
    -- handle response
end);

-------------------------------------------------------
]]
local request = NPL.load("../BaseRequest.lua");
local ApiService = commonlib.gettable("Mod.CodePkuCommon.ApiService");


function ApiService.CreateUser(tnickname,tgender)

    data = {        
        nickname = tnickname,        
        gender=tgender
    }
    return request:put('/users/profile' ,data,{sync = true});
end

function ApiService.Login(mobile,password)
    if type(mobile) ~= "string" or type(password) ~= "string" then
        return false
    end

    return request:post("/users/authorizations",{
        mobile = mobile,
        password = password
    });
end

function ApiService.Profile(token)
    if type(token) ~= "string" and #token == 0 then
        return false
    end

    local headers = { Authorization = format("Bearer %s", token) }

    return request:get("/users/profile",nil,{
        headers = headers
    });
end

function ApiService.retained(mobile, age, username, courseware_id)
    local data = {
        mobile=mobile,
        age=age,
        username=username,
        courseware_id = courseware_id
    }
    return request:post("/retained-logs",data,{sync = true})
end