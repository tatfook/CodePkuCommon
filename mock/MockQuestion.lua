local CodePkuQuestionsApi = NPL.load("(gl)Mod/CodePkuCommon/api/Codepku/Questions.lua")

local MockQuestion = NPL.export()

function MockQuestion:GetOne(questionId)
    local function HandleCallback(response, error)
        if error == 200 then
            local question = response.data
            echo("获取单个题目成功：")
            echo(question)
        else
            GameLogic.AddBBS(nil, L"获取题目失败", 3000, "255 0 0", 21)
        end

    end
    CodePkuQuestionsApi:GetOne(questionId, HandleCallback, HandleCallback)
end