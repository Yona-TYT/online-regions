//
			
sizmap <- [{x=0,y=0}]	//Tamaño del mapa

region_bool <- {
    region_sw = false   //para activar o desactivar el modo region
    region_new = false   //para crear la nueva region
    region_waygate = false //Activa la creacion de los waygate

    cl1_active = true  //Activa / desactiva la edicion de climas
    cl2_active = true  //Activa / desactiva la edicion de climas
}

player_list <- "" //Lista de todos los jugadores activos con sus regiones

curent_pl <-  0  //numero del jugador activado

sign_name <- ""  // Nombre del waygate (se obtine al iniciar)
sign_cost <- 0    // Costo del waygate

sign_pass <- array(12) // Guarda los valores de waygate para cada jugador

c_way_gate <- array(12) //Coordenadas de las waygates

gui_open <- false  //Abre la ventan de scenario al iniciar la partida


c_res <- [{a = coord(0,0), b = coord(0,0), c = coord(0,0)}, {a = coord(0,0), b = coord(0,0), c = coord(0,0)}, {a = coord(0,0), b = coord(0,0), c = coord(0,0)}, {a = coord(0,0), b = coord(0,0), c = coord(0,0)}, {a = coord(0,0), b = coord(0,0), c = coord(0,0)}, {a = coord(0,0), b = coord(0,0), c = coord(0,0)}, {a = coord(0,0), b = coord(0,0), c = coord(0,0)}, {a = coord(0,0), b = coord(0,0), c = coord(0,0)}, {a = coord(0,0), b = coord(0,0), c = coord(0,0)}, {a = coord(0,0), b = coord(0,0), c = coord(0,0)}, {a = coord(0,0), b = coord(0,0), c = coord(0,0)}, {a = coord(0,0), b = coord(0,0), c = coord(0,0)}, {a = coord(0,0), b = coord(0,0), c = coord(0,0)}]
//--------------------------------------------------------------------------

all_pl <- [0]	//Numero de jugadores por regiones (2,4,6,8,12)
curent_cl <- [cl_desert, cl_mediterran] //Clima seleccionado
cl_name <- array(8)
cl_name[cl_water] = translate("Water")
cl_name[cl_desert] = translate("desert")
cl_name[cl_tropic] = translate("tropic")
cl_name[cl_mediterran] = translate("mediterran")
cl_name[cl_temperate] = translate("temperate")
cl_name[cl_tundra] = translate("tundra")
cl_name[cl_rocky] = translate("rocky")
cl_name[cl_arctic] = translate("arctic")

//Regiones de jugadores ---------------------------------------------------------------------------------------------------------
c1_region <- [
	{x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1},

]

c2_region <- [
	{x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1}, {x1=0, y1=0, x2=1, y2=1},
]


c_max <- [{x = 0, y = 0}]
//-----------------------------------------------------------------------------------------------------------------------


shared_name <- [array(12), array(12), array(12), array(12), array(12), array(12), array(12), array(12), array(12), array(12), array(12), array(12)]  //Se activa si la compañias comparten region


//Coordenadas para eliminar construcciones
r_coord <-	[{x=0, y=0, z=0}, {x=0, y=0, z=0}, {x=0, y=0, z=0}, {x=0, y=0, z=0}, {x=0, y=0, z=0}, {x=0, y=0, z=0}, {x=0, y=0, z=0}, {x=0, y=0, z=0}, {x=0, y=0, z=0}, {x=0, y=0, z=0}, {x=0, y=0, z=0}, {x=0, y=0, z=0}]


dele_sw <- false  //Se activa para eliminar un objeto

// Guarda todos los datos necesarios
region_data_all <- {

    //Guada las regiones
	c1_region = c1_region
    c2_region = c2_region
    //-------------------
    all_pl = all_pl
    curent_cl = curent_cl
    region_bool = region_bool
    c_max = c_max
}


// Se obtienen lo valores de coordenadas y los nr de jugadores
class data_region {
	//Guada las regiones 
	function get_c1_region() {return region_data_all.c1_region}
    function get_c2_region() {return region_data_all.c2_region}
    //-------------------------------------------------------

    function get_all_pl() {return region_data_all.all_pl }
    function get_curent_cl() {return region_data_all.curent_cl }
    function get_region_bool() {return region_data_all.region_bool }
    function get_c_max() {return region_data_all.c_max }

	// Se guardan los datos
	function _save() { return "data_region()"; }
}


function region_start()
{
    find_waygate_desc() 
    return null
}

//------------------------------------------------------------------------

function region_resume_game()
{
    // Datos guardados para las regiones
    //-----------------------------------------------------		
	// copy it piece by piece otherwise the reference 
	foreach(key,value in persistent.region_data_all){
		region_data_all.rawset(key,value)
	}
	persistent.region_data_all = region_data_all

	// Se obtienen los datos guardados

    //Guada las regiones
	c1_region  = data_region().get_c1_region()   // Coordenadas
    c2_region  = data_region().get_c2_region()   // Coordenadas
    //----------------------------------------

	all_pl = data_region().get_all_pl()            //Maximo numero de jugadores seleccionados
    curent_cl = data_region().get_curent_cl()      //Clima seleccionado
    region_bool = data_region().get_region_bool()   //Banderas para las regiones
    c_max = data_region().get_c_max()

//-------------------------------------------------------


    player_list = get_player_text(0) //Carga la lista de jugadores
    find_waygate_desc() //Carga el nombre del waygate

    gui_open = true  //activa la ventana

    return null
}

plregions	<- [{x1=0 , y1=0 , x2=0, y2=0}, {x1=0 , y1=0 , x2=0, y2=0}, {x1=0 , y1=0 , x2=0, y2=0}, {x1=0 , y1=0 , x2=0 , y2=0}, {x1=0 , y1=0 , x2=0, y2=0}, {x1=0 , y1=0 , x2=0, y2=0}, {x1=0 , y1=0 , x2=0, y2=0}, {x1=0 , y1=0 , x2=0, y2=0}, {x1=0 , y1=0 , x2=0, y2=0}, {x1=0 , y1=0 , x2=0, y2=0}, {x1=0 , y1=0 , x2=0, y2=0}, {x1=0 , y1=0 , x2=0, y2=0}]



//Calcula y guarda las cordenadas de las regiones
function calc_coord()
{
	get_mapsiz()
    if (region_bool.region_new) {
        local pl_nr = all_pl[0]

        local max_sizx = sizmap[0].x -1 //Tamaño del mapa en x menos el valor null
        local max_sizy = sizmap[0].y -1 //Tamaño del mapa en y menos el valor null

        local diy = 0
        local dix = 0


        if (pl_nr == 2){
            diy = 1
            dix = 2
        }

        if (pl_nr == 4){
            diy = pl_nr /(pl_nr/2) 
            dix = (pl_nr/2)
        }

        if (pl_nr == 6){
            diy = pl_nr / (pl_nr/3) 
            dix = (pl_nr/3)
        }

        if (pl_nr == 8){
            diy = pl_nr / (pl_nr/3) 
            dix = (pl_nr/3)
        }

        if (pl_nr == 10){
            diy = pl_nr / (pl_nr/4) 
            dix = (pl_nr/4)
        }

        if (pl_nr == 12){
            diy = pl_nr / (pl_nr/3) 
            dix = (pl_nr/3)
        }

        local pl_limx = (max_sizx ) / dix
        local pl_limy = (max_sizy ) / diy


        local c1_start = coord(0,0)
        local c2_start = coord(pl_limx,pl_limy)

        c_max[0] = {x = pl_limx/2, y = pl_limy/2}
        for(local j=0;j< pl_nr;j++)
	        {
		        local player = player_x(j+2)
		        local playercuadro  //= calc(j,opt)
		        if (j==12)continue

                plregions[j] = {x1 = c1_start.x, y1 = c1_start.y, x2 = c2_start.x, y2 = c2_start.y} //***

                c1_region[j] = {x1=c1_start.x, y1=c1_start.y, x2=c2_start.x, y2=c1_start.y }
                c2_region[j] = {x1=c2_start.x, y1=c2_start.y, x2=c2_start.x, y2=c1_start.y }

                //-----------------------------------------Climate setting for fronteras
                local cl = curent_cl[0]
                set_climate(j,cl)

                if (c2_start.x < max_sizx){
                    c1_start.x += pl_limx
                    c2_start.x += pl_limx

                    if (c2_start.x > max_sizx){
                        c1_start.x = 0
                        c2_start.x = pl_limx
                        if (c2_start.y < max_sizy){
                            c1_start.y += pl_limy
                            c2_start.y += pl_limy
                        }
                    }
                }
		    }
        }

    region_bool.region_new = false //desactiva la creacion de regiones

	return null
}

function remove_region()
{
    local pl_nr = all_pl[0]
    for(local j=0;j< pl_nr;j++){
        local player = player_x(j+2)
	    if (player.is_active()){
            local tile1 = square_x(c_res[j].a.x, c_res[j].a.y).get_ground_tile()
            local tile2 = square_x(c_res[j].b.x, c_res[j].b.y).get_ground_tile()
            local tile3 = square_x(c_res[j].c.x, c_res[j].c.y).get_ground_tile()

            //Tools --------------------------------
            local t_rem = command_x(tool_remover)

            tile1.remove_object(player_x(j+2), mo_label)

            t_rem.work(player_x(1), tile2, "")  //Elimina waygate
            t_rem.work(player_x(1), tile2, "")   //Elimina rails
            t_rem.work(player_x(1), tile3, "")    //Elimina rails
        }
        //-----------------------------------------Climate setting for fronteras
        local cl = curent_cl[1]
        set_climate(j,cl)
        
    } 
    return null
}

function region_get_info_text(pl)
{
    curent_pl = pl
    return player_list.tostring()
}

function region_get_rule_text(pl)
{
    local rg_text = ""
    local cl_text = ""
    local wg_text = ""
    //Traducciones de texto
    local t_ok = translate("Ok")
    local t_canc = translate("Cancel")
    local t_clim = translate("Climate")
    local t_sele = translate("Selec")
    //---------------------------------
    if (pl==1){
        if (!region_bool.region_sw){
            for(local j = 2; j<=12; j+=2){
                rg_text += "<em>-> </em><a href='script:script_text("+j+")'>"+ translate("Number of regions")+"</a> = <em>["+(j)+"]</em><br>"
            }
        }
        else {
            rg_text = "<em>-> </em><a href='script:script_cancel()'><st>"+ t_canc +"</a> = <em>["+(all_pl[0])+"]</st></em><br>"
        }
        for(local j = 0; j<8; j++){
            if (j == curent_cl[0]) {cl_text += "<st>-> "+ t_clim +" [1]: "+cl_name[curent_cl[0]]+"</st><br>"; continue}
            if (j == curent_cl[1]) {cl_text += "<st>-> "+ t_clim +" [2]: "+cl_name[curent_cl[1]]+"</st><br>"; continue}

            if (region_bool.cl1_active){
               cl_text += "<em>-- </em><a href='script:script_climate("+j+","+curent_cl[1]+")'>"+ t_sele +": "+cl_name[j]+"</a><br>"
            }
            else{
                cl_text += "<em>-- </em><a href='script:script_climate("+curent_cl[0]+","+j+")'>"+ t_sele +": "+cl_name[j]+"</a><br>"
            }
        }
    }
    else if ((pl>1) && (pl < all_pl[0])){
        if (region_bool.region_sw) {
            wg_text = "<a href=\"("+c_way_gate[pl-2].x+","+c_way_gate[pl-2].y+")\">"+translate(""+sign_name+"")+" ("+c_way_gate[pl-2].tostring()+")</a>"
        }
    }
    else 
         wg_text = "<em>("+translate(""+sign_name+"")+")</em>"
    local result = {rg = rg_text, cl = cl_text , wg = wg_text }
    return result
}

function region_get_result_text(pl)
{
    return ""
}

function region_get_goal_text(pl)
{
    local text = ""

    return text
}

function region_is_scenario_completed(pl)
{
    calc_coord()
    player_list = get_player_text(curent_pl)

    if (gui_open){
        gui.open_info_win_at("rules")
        gui_open = false
    }

    if (region_bool.region_waygate){
        for(local j = 0; j<all_pl[0]; j++){
        local player = player_x(j+2)
		    if (player.is_active()) {
                local tile1 = square_x(c1_region[j].x1 + (1), c1_region[j].y1 + (1)).get_ground_tile()
                local tile2 = square_x(c1_region[j].x1 + (2), c1_region[j].y1 + (1)).get_ground_tile()
                local tile3 = square_x(c1_region[j].x1 + (3), c1_region[j].y1 + (1)).get_ground_tile()

                //Guarda las coordenadas reservadas
                c_res[j].a = coord(tile3.x, tile3.y)
                c_res[j].b = coord(tile1.x, tile1.y)
                c_res[j].c = coord(tile2.x, tile2.y)

                local slope1 = tile1.get_slope()
                local slope2 = tile2.get_slope()

                local way = tile1.find_object(mo_way)
                local sing = tile1.find_object(mo_roadsign)
                local label = tile3.find_object(mo_label)
                local build = tile3.find_object(mo_building)
                //Tools --------------------------------
                local t_rem = command_x(tool_remover)
                local t_way = command_x(tool_build_way)
                local t_sing = command_x(tool_build_roadsign)
                //--------------------------------------

                if(!sing){
                    if(!way){
                        if (tile1.is_water()){
                            command_x.set_slope(player_x(1), tile1, slope.all_up_slope)
                            command_x.set_slope(player_x(1), tile2, slope.all_up_slope)
                            return 0
                        }
                        else if (!tile1.is_empty()){
                            t_rem.work(player_x(1), tile1, "")
                            t_rem.work(player_x(1), tile2, "")
                            return 0
                        }
                        else if (slope1 != 0) {
                            command_x.set_slope(player_x(1), tile1, slope.all_up_slope)
                            command_x.set_slope(player_x(1), tile2, slope.all_up_slope)
                            return 0
                        }
                        
                        if (tile1.z < tile2.z){command_x.set_slope(player_x(1), tile1, slope.all_up_slope)}

                        if (tile2.z < tile1.z){command_x.set_slope(player_x(1), tile2, slope.all_up_slope)}

                        
                        t_way.work(player_x(1), tile1, tile2, ""+wt_rail)
                    }
                    else {
                        t_sing.work(player, tile1, ""+sign_name+"")
                        player_x(j+2).book_cash(sign_cost-25000)
                        
                    }                  
                }
                else{

                    if(!label){
                       if (build) { t_rem.work(player_x(1), tile3, "")}
                       label_x.create(c_res[j].a, player, ""+player.get_name()+"")
                       player_x(j+2).book_cash(10000)
                    }

                    c_way_gate[j] = coord(tile1.x, tile1.y)
                    sign_pass[j] =  sing
                    
                }
            }
        }   
    }
    if (dele_sw){
        local tile = tile_x(r_coord.x, r_coord.y, r_coord.z)
        local t = command_x(tool_remover)
		local err = t.work(player_x(1), tile, "")
        dele_sw = false
    }

    return 1
}
function region_is_work_allowed_here(pl, tool_id, pos)
{
    local tile = tile_x(pos.x, pos.y, pos.z)
    local label = tile.find_object(mo_label)
    local build = tile.find_object(mo_building)
    local way = tile.find_object(mo_way)
    local sign = tile.find_object(mo_roadsign)

    local result = translate("This region belongs to another player!.")  	// set standard error message
    if (pl == 0 || pl == 1) {return null}

    if ((pl-2) > all_pl[0]) {return result}

    if (tool_id == tool_set_marker) {return null}

    //Areas reservadas en las regiones -----------------------------
    if(tool_id != 4096){
        if (pos.x == c_res[pl-2].a.x && pos.y == c_res[pl-2].a.y)
            return translate("Reserved Area")+" ("+pos.tostring()+")."

        if (pos.x == c_res[pl-2].b.x && pos.y == c_res[pl-2].b.y)
            return translate("Reserved Area")+" ("+pos.tostring()+")."

        if (pos.x == c_res[pl-2].c.x && pos.y == c_res[pl-2].c.y)
            return translate("Reserved Area")+" ("+pos.tostring()+")."
    }
    //-----------------------------------------------------------------

    if (tool_id == 4096 || tool_id == tool_remover || tool_id == tool_remove_way){
        //Elimina un marcador de posicion si el jugador es el propietario
        if (label && label.get_owner().nr == pl) {return null}

        //Elimina una estacion/construccion si el jugador es el propietario
        if (build && build.get_owner().nr == pl) {return null}

        //Elimina caminos/vias si el jugador es el propietario
        if (way && way.get_owner().nr == pl) {return null}
    }

    if (pos.x >= c1_region[pl-2].x1 && pos.y >= c1_region[pl-2].y1 && pos.x <= c2_region[pl-2].x1 && pos.y<= c2_region[pl-2].y1){
        if (tool_id == tool_remover){
            //Elimina textos de otros jugadores execto del servicio publico dentro de tu region
            if (label &&  label.get_owner().nr != 1){
                r_coord = {x = pos.x, y = pos.y, z = pos.z}
                dele_sw = true
                return translate("The text was deleted.")
            }
            //Elimina estaciones de otros jugadores dentro de tu region
            if (build && build.get_halt() && !build.get_factory()){
                r_coord = {x = pos.x, y = pos.y, z = pos.z}
                dele_sw = true
                return translate("You have eliminated the station another player.")
            }
        }
        return null
    }
    else {
        local c = coord(c1_region[pl-2].x1, c1_region[pl-2].y1)
        local c_m = coord(c_max[0].x, c_max[0].y)
        local region_center = {x = (c.x + c_m.x), y = (c.y + c_m.y)} 
        result = translate("You can only use this tool in your region!")+" ("+coord(region_center.x, region_center.y).tostring()+")."
        result = region_shared(pl, tool_id, pos, result)
    }
   
    return result
}

function script_text(opt)
{
    if (region_bool.region_sw) {return null}

    switch (opt) {
		case 2:
            all_pl[0] = opt
		    break;

		case 4:
            all_pl[0] = opt
		    break;

		case 6:
            all_pl[0] = opt
		    break;

		case 8:
            all_pl[0] = opt
		    break;

		case 10:
            all_pl[0] = opt
		    break;

		case 12:
            all_pl[0] = opt
		    break;
    }

    region_bool.region_sw = true    //bandera que desactiva los enlaces de generacion de regiones
    region_bool.region_new = true   //bandera que activa el generador de regiones
    region_bool.region_waygate = true //bandera que activa la creacion de waygates

    return null
}

function script_cancel()
{
    region_bool.region_waygate = false
    region_bool.region_sw = false    //bandera que activa los enlaces de generacion de regiones
    remove_region() // Elimina los text label y waypass y cubre las fronteras
    
    return null
}

function script_climate(opt1, opt2)
{
    if (region_bool.cl1_active) {
        region_bool.cl1_active = false
        region_bool.cl2_active = true
    }
    else {
        region_bool.cl2_active = false
        region_bool.cl1_active = true
    }

    switch (opt1) {
		case 0:
            curent_cl[0] = opt1
		    break;

		case 1:
            curent_cl[0] = opt1
		    break;

		case 2:
            curent_cl[0] = opt1
		    break;

		case 3:
            curent_cl[0] = opt1
		    break;

		case 4:
            curent_cl[0] = opt1
		    break;

		case 5:
            curent_cl[0] = opt1
		    break;

		case 6:
            curent_cl[0] = opt1
		    break;

		case 7:
            curent_cl[0] = opt1
		    break;

    }

    switch (opt2) {
		case 0:
            curent_cl[1] = opt2
		    break;

		case 1:
            curent_cl[1] = opt2
		    break;

		case 2:
            curent_cl[1] = opt2
		    break;

		case 3:
            curent_cl[1] = opt2
		    break;

		case 4:
            curent_cl[1] = opt2
		    break;

		case 5:
            curent_cl[1] = opt2
		    break;

		case 6:
            curent_cl[1] = opt2
		    break;

		case 7:
            curent_cl[1] = opt2
		    break;

    }
}

//Muestra la lista de regiones en la info
function get_player_text(pl)
{
	local text = ""
    local t_play = translate("Player")
    local t_reg = translate("Region")
    local t_inac = translate("Inactive")

	for(local j=0;j<all_pl[0];j++){
		local player = player_x(j+2)
        local c = coord(c1_region[j].x1, c1_region[j].y1)
        local c_m = coord(c_max[0].x, c_max[0].y)
        local region_center = {x = (c.x + c_m.x), y = (c.y + c_m.y)}
		if (player.is_active()) {           
            text += format(translate("<em>[%s %d] %s:</em>"),t_play,(j+1),t_reg) + "<a href=\"("+region_center.x+","+region_center.y+")\"> "+player.get_name()+" ("+region_center.x+","+region_center.y+")</a><br>"									
		}
        else{
            text += format(translate("<st>[%s %d] %s:</st>"),t_play,(j+1),t_inac) + "<st><a href=\"("+region_center.x+","+region_center.y+")\"> "+t_inac+" ("+ region_center.x+","+region_center.y+")</st></a><br>"
        }
	}						 
	return text.tostring()
}

function set_climate(j,cl) //-----------------------------------------Climate setting for fronteras
{    
    local tool = command_x(tool_set_climate)
    local tile1 = square_x( c1_region[j].x1, c1_region[j].y1 ).get_ground_tile()
    local tile2 = square_x( c1_region[j].x2, c1_region[j].y1 +2 ).get_ground_tile()	
    local err = tool.work(player_x(1), tile1, tile2, ""+cl)

    tile1 = square_x( c2_region[j].x1 +1, c2_region[j].y1 ).get_ground_tile()

    tile2 = square_x( c2_region[j].x1 -1, c2_region[j].y2 ).get_ground_tile()
    err = tool.work(player_x(1), tile1, tile2, ""+cl)
    
    return null
}

function find_waygate_desc()
{
    local sign_list =  sign_desc_x.get_available_signs(wt_rail)
    local name = ""
    local cost
    foreach(sign in sign_list){
        if (sign.is_private_way())
             name = sign.get_name()
             cost = sign.get_cost()
        }
    sign_name = name
    sign_cost = cost
    
    return null
}

function region_shared(pl, tool_id, pos, result)
{
    local pl_nr = all_pl[0]
    for (local j=0;j<pl_nr;j++) {
        if (j == (pl-2))
          continue

        local player = player_x(j+2)
        if (player.is_active()) {
            local sign = sign_pass[j].can_pass(player_x(pl))
            if(sign){
                if (pos.x >= c1_region[j].x1 && pos.y >= c1_region[j].y1 && pos.x <= c2_region[j].x1 && pos.y<= c2_region[j].y1){
                  return null
                }
            }
        }
    }
    return result
}

function start_array()
{
    for(local j = 0; j<12; j++){
        c_way_gate[j] = coord(0,0)
    }
}
	
function get_mapsiz()
{
	local ws = world.get_size()
	sizmap[0].x = ws.x
	sizmap[0].y = ws.y

	return 0
}


