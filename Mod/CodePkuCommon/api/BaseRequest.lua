--[[
Title: 请求基类
Author(s): John Mai
Date: 2020-06-22 17:57:10
Desc: 请求基类
Example:
------------------------------------------------------------
local Request = NPL.load("(gl)Mod/CodePkuCommon/service/BaseRequest.lua");

Request:request(url,[config]);
Request:request(config);

Request:get(url,[query],[config]);
Request:options(url,[query],[config]);
Request:head(url,[query],[config]);
Request:delete(url,[query],[config]);

Request:post(url,[data],[config]);
Request:put(url,[data],[config]);
Request:patch(url,[data],[config]);

-------------------------------------------------------
]]

local request = NPL.export();
local axios = NPL.load('(gl)Mod/CodePkuCommon/util/axios/Axios.lua');
local Config = NPL.load("(gl)Mod/CodePkuCommon/config/Config.lua")

local _request = axios.create({baseUrl = Config.defaultCodepkuServer})
-- 请求拦截器
_request.interceptors.request:use(function(config)

    if System.User.codepkuToken and not config.headers['Authorization'] then
        config.headers['Authorization'] = format("Bearer %s", System.User.codepkuToken);
    end

    return config;
end,function(error)
    return error;
end);

-- 响应拦截器
_request.interceptors.response:use(function(response)
    return response;
end,function(error)
    return error;
end);

setmetatable(request,{__index= _request});