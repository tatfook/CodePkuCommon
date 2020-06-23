local ApiService = commonlib.gettable("Mod.CodePkuCommon.ApiService");

local MockQuestion = NPL.export()

function MockQuestion:GetOne(questionId)
    ApiService.getQuestions(questionId):next(function (response)
        local question = response.data;
        echo("获取单个题目成功：");
        echo(question);
    end):catch(function (error)
        GameLogic.AddBBS(nil, L"获取题目失败", 3000, "255 0 0", 21);
    end);
end