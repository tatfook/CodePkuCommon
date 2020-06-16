--[[
Title: Keepwork Users API
Author(s):  big
Date:  2019.11.8
Place: Foshan
use the lib:
------------------------------------------------------------
local KeepworkUsersApi = NPL.load("(gl)Mod/WorldShare/api/Keepwork/Users.lua")
------------------------------------------------------------
]]

local CodePkuBaseApi = NPL.load('./BaseApi.lua')

local CodePkuUsersApi = NPL.export()

-- url: /users/authorizations
-- method: POST
-- params:
--[[
    mobile	string 必须 用户名	
    password string 必须 密码
]]
-- return: object
function CodePkuUsersApi:Login(mobile, password, success, error)
    if type(mobile) ~= "string" or type(password) ~= "string" then
        return false
    end

    local params = {
        mobile = mobile,
        password = password
    }

    CodePkuBaseApi:Post("/users/authorizations", params, nil, success, error, { 503, 400 })
end

-- url: /users/profile
-- method: POST
-- params:
--[[
    token string 必须 token
]]
-- return: object
function CodePkuUsersApi:Profile(token, success, error)
    if type(token) ~= "string" and #token == 0 then
        return false
    end

    local headers = { Authorization = format("Bearer %s", token) }

    CodePkuBaseApi:Get("/users/profile", nil, headers, success, error, 401)
end

