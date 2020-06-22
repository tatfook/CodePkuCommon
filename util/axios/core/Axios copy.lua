--[[
Title: Axios Core 
Author(s): John Mai
Date: 2020-06-18 11:53:57
Desc: Axios Core
Example:
------------------------------------------------------------
    local AxiosCore = NPL.load("(gl)Mod/CodePkuCommon/util/Axios/core/axios.lua");
-------------------------------------------------------
]]
local Axios = commonlib.inherit(nil, NPL.export());
local Log = NPL.load("(gl)Mod/CodePkuCommon/util/axios/util/Log.lua");
local Table = NPL.load("(gl)Mod/CodePkuCommon/util/Table.lua");
local Promise = NPL.load("(gl)Mod/CodePkuCommon/util/axios/util/Promise.lua");


Axios.default = {};

-- function Axios:ctor(instanceConfig)
--     self.default = instanceConfig or {};
--     self.__index = self;
--     return self;
-- end

function Axios:new(instanceConfig)
    self.default = instanceConfig or {};
    -- self.__index = self;
    return self;
end

function Axios:mergeConfig(config)
    local newConfig = self.default;

    for k,v in pairs(config) do
        newConfig[k] = v 
    end

    return newConfig;
end

function Axios.request(self,...)
    local arguments = {...};

    Table:toString(arguments);

    if type(arguments[1]) == "string" then
        config = arguments[2] or {};
        config.url = arguments[1];
    else
        config = config or {};
    end

    config = self:mergeConfig(config);

    if config.baseUrl then
        config.url = string.format("%s%s",config.baseUrl,config.url);
    end

    if config.method then
        config.method = string.upper(config.method);
    elseif Axios.default.method then
        config.method = string.upper(self.default.method);
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

    local request = nil;

    if config.sync then
        return System.os.GetUrl(config,nil,arguments[3]);
    else
        request = Promise:new();
        System.os.GetUrl(config,function(code,message,data)
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
        end,arguments[3]);
    end

    return request;
end



-- function Axios.__index(self, method)
--     if contains({'delete', 'get', 'head', 'options'},method) then

--     elseif contains({'post', 'put', 'patch'},method) then

--     end
-- end

function contains(table, value)
    for i=1,#table do
       if table[i] == value then 
          return true;
       end
    end
    return false;
end