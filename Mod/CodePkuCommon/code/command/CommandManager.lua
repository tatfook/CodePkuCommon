local CommandManager = commonlib.gettable("Mod.CodePkuCommon.Code.Command.CommandManager");
local SlashCommand = commonlib.gettable("MyCompany.Aries.SlashCommand.SlashCommand");
local CmdParser = commonlib.gettable("MyCompany.Aries.Game.CmdParser");	
local BlockEngine = commonlib.gettable("MyCompany.Aries.Game.BlockEngine")
local block_types = commonlib.gettable("MyCompany.Aries.Game.block_types")
local block = commonlib.gettable("MyCompany.Aries.Game.block")
local GameLogic = commonlib.gettable("MyCompany.Aries.Game.GameLogic")
local EntityManager = commonlib.gettable("MyCompany.Aries.Game.EntityManager");
local Commands = commonlib.gettable("MyCompany.Aries.Game.Commands");
local GameLogic = commonlib.gettable("MyCompany.Aries.Game.GameLogic")

function ParseOption(cmd_text)
	local value, cmd_text_remain = cmd_text:match("^%s*%-([%w_]+%S+)%s*(.*)$");
	if(value) then
		return value, cmd_text_remain;
	end
	return nil, cmd_text;
end

function ParseOptions(cmd_text)
	local options = {};
	local option, cmd_text_remain = nil, cmd_text;
	while(cmd_text_remain) do
		option, cmd_text_remain = ParseOption(cmd_text_remain);
		if(option) then
			key, value = option:match("([%w_]+)=?(%S*)");
			if (value == "true" or key == option) then 
				options[key] = true;
			elseif (value == "false") then 
				options[key] = false;
			else
				options[key] = value;
			end
		else
			break;
		end
	end
	return options, cmd_text_remain;
end

function CommandManager:init()
    GameLogic.GetFilters():add_filter("register_command", function()        

Commands["openeditor"] = {
	name="openeditor", 
	quick_ref="/openeditor 19130 5 19216 -mode=blockly", 
	desc="", 
	handler = function(cmd_name, cmd_text, cmd_params)
		local x, y, z, cmd_text = CmdParser.ParsePos(cmd_text);
		echo(x)
		echo(y)
		echo(z)
		echo(cmd_text)
		if (not x or not y or not z) then return end
		local options, cmd_text = ParseOptions(cmd_text);
		echo(options)

		local blocklyMode = false;
		if options.mode and options.mode == "blockly" then
			blocklyMode = true;
		end	
		
		echo("blocklyMode")
		echo(blocklyMode)
		NPL.load("(gl)script/apps/Aries/Creator/Game/Code/CodeBlockWindow.lua");
		local CodeBlockWindow = commonlib.gettable("MyCompany.Aries.Game.Code.CodeBlockWindow");
		CodeBlockWindow.Show(true);
		local codeEntity = CodeBlockWindow.GetCodeEntity(x, y, z);		
		CodeBlockWindow.SetCodeEntity(codeEntity);
				
		if blocklyMode then 
			codeEntity:SetBlocklyEditMode(true);
			CodeBlockWindow.UpdateCodeEditorStatus();
			CodeBlockWindow.OpenBlocklyEditor(true);
		else			
			-- CodeBlockWindow.UpdateCodeToEntity();
			codeEntity:SetBlocklyEditMode(false);
			CodeBlockWindow.UpdateCodeEditorStatus();
		end
		
	end,
};


    end);
end