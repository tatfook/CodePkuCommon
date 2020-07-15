local ApiServiceRegister = NPL.export();

function ApiServiceRegister.init()
    NPL.load('./Codepku/Users.lua');
    NPL.load('./Codepku/Questions.lua');
    NPL.load('./Codepku/Game.lua')
end