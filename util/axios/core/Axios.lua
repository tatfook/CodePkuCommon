--[[Title: Axios Core 
Author(s): John Mai
Date: 2020-06-18 11:53:57
Desc: Axios Core
Example:
------------------------------------------------------------
    local AxiosCore = NPL.load("(gl)Mod/CodePkuCommon/util/Axios/core/axios.lua");
-------------------------------------------------------
]]
local Axios = commonlib.inherit(nil, NPL.export({}));
local Log = NPL.load("(gl)Mod/CodePkuCommon/util/Log.lua");
local Table = NPL.load("(gl)Mod/CodePkuCommon/util/Table.lua");
local Promise = NPL.load("(gl)Mod/CodePkuCommon/util/axios/util/Promise.lua");
local InterceptorManager = NPL.load("(gl)Mod/CodePkuCommon/util/Axios/core/InterceptorManager.lua");

local os = commonlib.gettable("System.os");

-- local defaults = {};
function Axios:ctor()
    self.defaults = {};
    self.interceptors = {
        request = InterceptorManager:new(),
        response = InterceptorManager:new()
    };
end

function Axios:init(instanceConfig)
    self.defaults = instanceConfig or {};
    self.__index = self;
    -- self.__call = function (mytable, newtable)
    --     Log.debug(666);
    --     Log.debug(mytable);
    --     Log.debug(newtable);
    -- end;
    -- self = setmetatable(self, {
    --     __index = function(self, method,...)
    --         Log.debug(666);
    --         Log.debug(self);
    --         Log.debug(key);
    --         Log.debug(...);
    --         config.method = method;
    --         if method then
    --         end
    --         -- return self:request();
    --     end,
    --     __call = function (cls, ...)
    --         Log.debug(777);
    --         Log.debug(cls);
    --         Log.debug(newtable);
    --         -- return cls:request(...);
    --     end
    -- });
    return self;
end

function Axios:mergeConfig(config)
    local newConfig = self.defaults;

    for k, v in pairs(config) do
        newConfig[k] = v
    end

    return newConfig;
end

function Axios.request(self, ...)
    local arguments = { ... };

    if type(arguments[1]) == "string" then
        config = arguments[2] or {};
        config.url = arguments[1];
    else
        config = config or {};
    end

    config = self:mergeConfig(config);

    if config.baseUrl then
        config.url = string.format("%s%s", config.baseUrl, config.url);
    end

    if config.method then
        config.method = string.upper(config.method);
    elseif self.defaults.method then
        config.method = string.upper(self.defaults.method);
    else
        config.method = "GET";
    end

    if config.query then
        options.url = NPL.EncodeURLQuery(options.url, options.query);
        config.query = nil;
    elseif config.params then
        options.url = NPL.EncodeURLQuery(options.url, options.params);
        config.params = nil;
    end

    if config.data then
        config.form = config.data;
        config.data = nil;
    end

    self.interceptors.request:forEach(function(interceptor)
        config = interceptor.fulfilled(config);
    end);

    local request = nil;

    if config.sync then
        local code, message, data = System.os.GetUrl(config);

        request = {
            code = code,
            message = message,
            data = data
        };
    else
        request = Promise:new();

        System.os.GetUrl(config, function(code, message, data)
            local response = {
                code = code,
                message = message,
                data = data
            };

            if code >= 200 and code < 300 then
                request:resolve(response);
            else
                request:reject(response);
            end
        end, arguments[3]);
    end


    self.interceptors.response:forEach(function(interceptor)
        if request.type and request.type == 'promise' then
            request = request:next(interceptor.fulfilled,interceptor.rejected);
        else
            request = interceptor.fulfilled(request);
        end
    end);

    return request;
end

function Axios.get(self, url, query, config)
    config = config or {};
    config.url = url;
    config.query = query;
    return self:request(config);
end

function Axios.delete(self, url, query, config)
    config = config or {};
    config.url = url;
    config.query = query;
    config.method = 'DELETE';
    return self:request(config);
end

function Axios.head(self, url, query, config)
    config = config or {};
    config.url = url;
    config.query = query;
    config.method = 'HEAD';
    return self:request(config);
end

function Axios.options(self, url, query, config)
    config = config or {};
    config.url = url;
    config.query = query;
    config.method = 'OPTIONS';
    return self:request(config);
end

function Axios.post(self, url, data, config)
    config = config or {};
    config.url = url;
    config.data = data;
    config.method = 'POST';
    return self:request(config);
end

function Axios.put(self, url, data, config)
    config = config or {};
    config.url = url;
    config.data = data;
    config.method = 'PUT';
    return self:request(config);
end

function Axios.patch(self, url, data, config)
    config = config or {};
    config.url = url;
    config.data = data;
    config.method = 'PATCH';
    return self:request(config);
end

function Axios.resolve(data)
    local promise = Promise:new();
    promise:resolve(result);
    return promise;
end

function Axios.reject(data)
    local promise = Promise:new();
    promise:reject(result);
    return promise;
end

function Axios.useRequestInterceptors(self, fulfilled, rejected)

end

function Axios.useResponseInterceptors(self, fulfilled, rejected)

end

-- Axios.__index = function(self, method)
-- Log.debug(method);
-- if contains({'delete', 'get', 'head', 'options'},method) then
-- elseif contains({'post', 'put', 'patch'},method) then
-- end
-- end
function contains(table, value)
    for i = 1, #table do
        if table[i] == value then
            return true;
        end
    end
    return false;
end