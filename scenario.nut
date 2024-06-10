/**
 * Script to add achievements in-game. Player who reaches first XX points wins.
 */

/// load current game
map.file = "<attach>"

/// short description to be shown in finance window
/// and in standard implementation of get_about_text
scenario.short_description = "Regions"
scenario.author = "Yona-TYT"
scenario.version = "1.0"
scenario.translation  <- "Yona-TYT"

const save_version = 1

include("regions")

persistent <- {
    //Para Guardar los datos del script -----------------------
	region_data_all = region_data_all
    //-------------------------------------
}

function get_info_text(pl)
{
	local info = ttextfile("info.txt")
	local text = ""

    info.reg = region_get_info_text(pl) //Regions
	return info.tostring()
}
function get_rule_text(pl)
{
	local num = all_pl[0]
	
	local rule = ttextfile("rule.txt")
	if (pl==1) {rule = ttextfile("rule_pub.txt")} 

    rule.reg = region_get_rule_text(pl).rg //Regions Selec
    rule.clm = region_get_rule_text(pl).cl //Regions Climate
    rule.wga = region_get_rule_text(pl).wg //Regions Climate
	return rule.tostring()
}

function get_result_text(pl)
{
	local result = ttextfile("result.txt")

	return result.tostring()
}
function get_goal_text(pl)
{
	local goal = ttextfile("goal.txt")   
    goal.reg = region_get_goal_text(pl) //Regions
	return goal.tostring()
}

function is_scenario_completed(pl)
{
    //Para las regiones -------------------------------
    region_is_scenario_completed(pl)
    //--------------------------------------------------
	return 1
}

function is_work_allowed_here(pl, tool_id, pos)
{
    local result = region_is_work_allowed_here(pl, tool_id, pos) //Para las regiones

	return result
}

function start()
{
	region_start() //Para las regiones
}

function is_tool_allowed(pl, tool_id, wt)
{
	return true
}

function resume_game()
{
    region_resume_game() //regions Funtion
}
