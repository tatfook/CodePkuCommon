local CodePkuBaseApi = NPL.load('./BaseApi.lua')

local CodePkuQuestionsApi = NPL.export()

function CodePkuQuestionsApi:GetOne(questionId, success, error)
    if not questionId then
        return false
    end

    questionId = tonumber(questionId)

    CodePkuBaseApi:Get('/questions/' .. questionId, nil, { notTokenRequest = false }, success, error, { 500, 400 })
end

function CodePkuQuestionsApi:Get(questionIds, success, error)
    if (type(questionIds) ~= 'table') then
        return false
    end

    local qids = table.concat(questionIds, ',')
    CodePkuBaseApi:Get('/questions?id=' .. qids, nil, { notTokenRequest = false }, success, error, { 500, 400 })
end