--[[
Title: Keepwork Base API
Author(s):  big
Date:  2019.11.8
Place: Foshan
use the lib:
------------------------------------------------------------
local KeepworkBaseApi = NPL.load("(gl)Mod/WorldShare/api/Keepwork/BaseApi.lua")
------------------------------------------------------------
]]

local Config = NPL.load('(gl)Mod/CodePkuCommon/config/Config.lua')
local BaseApi = NPL.load('../BaseApi.lua')

local CodePkuBaseApi = NPL.export()

-- private
function CodePkuBaseApi:GetApi()
    return Config.codepkuServerList[BaseApi:GetEnv()] or ""
end

-- private
function CodePkuBaseApi:GetHeaders(headers)
    headers = type(headers) == 'table' and headers or {}

    local token = Mod.CodePku.Store:Get("user/token")

    if not headers.notTokenRequest and token and not headers["Authorization"] then
        headers["Authorization"] = format("Bearer %s", token)
    end

    headers.notTokenRequest = nil

    return headers
end

-- public
function CodePkuBaseApi:Get(url, params, headers, success, error, noTryStatus)
    url = self:GetApi() .. url

    BaseApi:Get(url, params, self:GetHeaders(headers), success, self:ErrorCollect("GET", url, error), noTryStatus)
end

-- public
function CodePkuBaseApi:Post(url, params, headers, success, error, noTryStatus)
    url = self:GetApi() .. url

    BaseApi:Post(url, params, self:GetHeaders(headers), success, self:ErrorCollect("Post", url, error), noTryStatus)
end

-- public
function CodePkuBaseApi:Put(url, params, headers, success, error, noTryStatus)
    url = self:GetApi() .. url

    BaseApi:Put(url, params, self:GetHeaders(headers), success, self:ErrorCollect("Put", url, error), noTryStatus)
end

-- public
function CodePkuBaseApi:Delete(url, params, headers, success, error, noTryStatus)
    url = self:GetApi() .. url

    BaseApi:Delete(url, params, self:GetHeaders(headers), success, self:ErrorCollect("Delete", url, error), noTryStatus)
end

-- public
function CodePkuBaseApi:ErrorCollect(method, url, error)    

    return function(data, err)
        -- send directly        
        if type(error) == 'function' then
            error(data, err)
        end
    end
end
