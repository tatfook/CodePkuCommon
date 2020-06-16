local CodePkuUsersApi = NPL.load("(gl)Mod/CodePkuCommon/api/Codepku/Users.lua")
local MockLogin = NPL.export()

function MockLogin:login()
    if System.User.codepkuToken then
        return true;
    end
    local codepkuMobile = ParaEngine.GetAppCommandLineByParam("codepkuuser", nil)
    local codepkuPasswd = ParaEngine.GetAppCommandLineByParam("codepkupasswd", nil)
    if type(codepkuMobile) ~= 'string' or type(codepkuPasswd) ~= 'string' then
        return true;
    end
    echo("CodePkuUsersApi")
    echo(CodePkuUsersApi)    
    local function HandleCallback(response, err)
        echo(response)        
        if err == 400 or err == 422 or err == 500 then
            local errMsg = response.message or "用户名或密码错误"
            GameLogic.AddBBS(nil, L"自动登录-" .. errMsg, 3000, "255 0 0", 21)
            return false
        end

        if type(response.data) ~= "table" then            
            GameLogic.AddBBS(nil, L"自动登录-服务器连接失败", 3000, "255 0 0", 21)
            return false
        end

        local token = response.data.token or System.User.codepkuToken
        local userId = response.data.id or 0
        local nickname = response.data.nickname or ""
        local mobile = response.data.mobile or ""

        commonlib.setfield("System.User.codepkuToken", token)
        commonlib.setfield("System.User.mobile", mobile)
        commonlib.setfield("System.User.username", mobile)
        commonlib.setfield('system.User.id', userId)            
        commonlib.setfield("System.User.nickName", nickname)

        GameLogic.AddBBS(nil, L"自动登录成功，当前账号：" .. codepkuMobile, 3000, "255 0 0", 21)
    end
    CodePkuUsersApi:Login(codepkuMobile, codepkuPasswd, HandleCallback, HandleCallback)
end