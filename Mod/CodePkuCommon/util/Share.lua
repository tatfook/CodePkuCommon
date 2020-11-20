--[[
Title: 友盟社会化分享 sdk
Author(s): John Mai
Date: 2020-06-18 11:53:57
Desc: 与Android或者iOS层友盟sdk进行通讯
Example:
------------------------------------------------------------
    local Share = NPL.load("(gl)Mod/CodePkuCommon/util/Share.lua");
    Share.fire("type",{});
-------------------------------------------------------
]]

local Share = commonlib.inherit(nil, NPL.export());
local platform = System.os.GetPlatform();
local isAndroid = platform == "android";
local isIOS = platform == "ios";

Share.callbacks = {}
function Share:ctor()
end

NPL.this(function()
    local spltPos = string.find(msg, "_");
    if spltPos then
        local params = string.sub(msg, spltPos + 1)
        local method = string.sub(msg, 1, spltPos - 1);
        if Share.callbacks and Share.callbacks[method] then
            Share.callbacks[method](params);
        end
    end
end);

-- @param string shareType 分享类型
-- @param string|table options 分享参数
-- @param table<function>{onStart,onResult,onError,onCancel} callback 分享回调
function Share:fire(shareType, options, callback)
    
    Share.callbacks = callback;

    local refCall = Share.callbacks.onResult
    
    Share.callbacks.onResult = function (e)
        if refCall then
            refCall(e)
        end
        GameLogic.GetFilters():apply_filters("TaskSystemList", {type = "share"}); -- 分享后，触发任务系统计数
    end
    
    if isAndroid then
    
        if LuaJavaBridge == nil then
            NPL.call("LuaJavaBridge.cpp", {});
        end

        if LuaJavaBridge then
            if shareType == "text" then
                if type(options) == 'string' then
                    options = { text = options };
                end
                LuaJavaBridge.callJavaStaticMethod("plugin/UMeng/UMengShare", "text", "(Ljava/lang/String;)V", options);
            elseif shareType == "url" then
                LuaJavaBridge.callJavaStaticMethod("plugin/UMeng/UMengShare", "url", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V", options);
            elseif shareType == "image" then
                LuaJavaBridge.callJavaStaticMethod("plugin/UMeng/UMengShare", "image", "(Ljava/lang/String;Ljava/lang/String;)V", options);
            end
        end

    elseif isIOS then

        if LuaObjcBridge == nil then
            NPL.call("LuaObjcBridge.cpp", {});
        end

        if LuaObjcBridge then
            local args = { luaPath = "(gl)Mod/CodePkuCommon/util/Share.lua" };
            local ok, ret = LuaObjcBridge.callStaticMethod("UMengShare", "registerLuaCall", args);
            if shareType == "text" then
                if type(options) == 'string' then
                    options = { text = options };
                end
                LuaObjcBridge.callStaticMethod("UMengShare", "text", options);
            elseif shareType == "url" then
                LuaObjcBridge.callStaticMethod("UMengShare", "url", options);
            elseif shareType == "image" then
                LuaObjcBridge.callStaticMethod("UMengShare", "image", options);
            end
        end
    end
end

--share("text", "分享的文本", {
--    onStart = function(e)
--        -- 开始分享
--    end,
--    onResult = function(e)
--        -- 分享结果
--    end,
--    onError = function(e)
--        -- 分享失败
--    end,
--    onCancel = function(e)
--        -- 取消分享
--    end
--});
--
--share("url", {
--    url = "https://www.codepku.com",
--    title = "编玩边学",
--    des = "描述",
--    thumb = "https://www.codepku.com/image.jpg"
--}, {
--    onStart = function(e)
--        -- 开始分享
--    end,
--    onResult = function(e)
--        -- 分享结果
--    end,
--    onError = function(e)
--        -- 分享失败
--    end,
--    onCancel = function(e)
--        -- 取消分享
--    end
--});
--
--share("image", {
--    image = "https://www.codepku.com/image.jpg",
--    title = "编玩边学"
--}, {
--    onStart = function(e)
--        -- 开始分享
--    end,
--    onResult = function(e)
--        -- 分享结果
--    end,
--    onError = function(e)
--        -- 分享失败
--    end,
--    onCancel = function(e)
--        -- 取消分享
--    end
--});
