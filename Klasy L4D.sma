#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <fun>
#include <hamsandwich>
#include <engine>
#include <fakemeta>
#include <colorchat>

#define PLUGIN "Klasy Ludzi"
#define VERSION "1.0"
#define AUTHOR ".minD"

#define TASK_SHOWMENU 12000


new Speed220[33]
new Speed280[33]
new Speed300[33]
new Speed330[33]
new gMyMenu
new Klasy:gPlayerClass[33];


enum Klasy{
    Zadna,
    Billy,
    Francis,
    Louis,
    Zoey
}



public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)

	register_clcmd("say /ludzie","mymenu");
	
	gMyMenu=menu_create("Klasy Ludzi","cbMyMenu");
	
	menu_additem(gMyMenu,"Bill");
	menu_additem(gMyMenu,"Francis");
	menu_additem(gMyMenu,"Louis");
	menu_additem(gMyMenu,"Zoey");
	
	register_event("CurWeapon","Speed220a","be", "1=1")
	register_event("CurWeapon","Speed280a","be", "1=1")
	register_event("CurWeapon","Speed300a","be", "1=1")
	register_event("CurWeapon","Speed330a","be", "1=1")
}
/*
public plugin_precache()
{ 
	precache_model("models/models/player/billy/billy.mdl")
	precache_model("models/models/player/francis/francis.mdl")
	precache_model("models/models/player/louis/louis.mdl")
	precache_model("models/models/player/zoey/zoey.mdl")
}
*/
public mymenu(id)
{
	menu_display(id, gMyMenu,0);
	return PLUGIN_HANDLED;
}


public cbMyMenu(id, menu, item)
{
	switch(item)
	{
		case 0:
		{ // Billy
			give_item ( id, "weapon_xm1014")
			cs_set_user_bpammo( id, CSW_XM1014, 32 );
			give_item ( id, "weapon_deagle")
			cs_set_user_bpammo( id, CSW_DEAGLE, 35 );
			give_item ( id, "weapon_hegrenade")
			set_user_armor (id, 50)
			set_user_health (id, 150)
			//cs_set_user_model(id, billy)
			gPlayerClass[id] = Billy
			Speed280[id] = 1
			Speed280[id] = 1
			ColorChat(id,  GREEN, "^x01[^x04Ludzie^x01]^x01 Twoja nowa klasa to ^x03 Billy")
		}
		
		case 1:
		{ // Francis
			give_item ( id, "weapon_m4a1")
			cs_set_user_bpammo( id, CSW_M4A1, 90 );
			give_item ( id, "weapon_deagle")
			cs_set_user_bpammo( id, CSW_DEAGLE, 35 );
			give_item ( id, "weapon_flashbang")
			set_user_armor (id, 25)
			set_user_health (id, 130)
			//cs_set_user_model(id, francis)
			gPlayerClass[id] = Francis
			Speed300[id] = 1
			Speed300[id] = 1
			ColorChat(id,  GREEN, "^x01[^x04Ludzie^x01]^x01 Twoja nowa klasa to ^x03 Francis")
		}
		
		case 2:
		{ // Louis
			give_item ( id, "weapon_ak47")
			cs_set_user_bpammo( id, CSW_AK47, 90 );
			give_item ( id, "weapon_deagle")
			cs_set_user_bpammo( id, CSW_DEAGLE, 35 );
			give_item ( id, "weapon_smokegrenade")
			set_user_armor (id, 75)
			set_user_health (id, 180)
			//cs_set_user_model(id, louis)
			gPlayerClass[id] = Louis
			Speed220[id] = 1
			Speed220[id] = 1
			ColorChat(id,  GREEN, "^x01[^x04Ludzie^x01]^x01 Twoja nowa klasa to ^x03 Louis")
		}
		
		case 3:
		{ // Zoey
			give_item ( id, "weapon_mac10")
			cs_set_user_bpammo( id, CSW_MAC10, 90 );
			give_item ( id, "weapon_deagle")
			cs_set_user_bpammo( id, CSW_DEAGLE, 35 );
			give_item ( id, "weapon_smokegrenade")
			set_user_armor (id, 10)
			set_user_health (id, 80)
			//cs_set_user_model(id, zoey)
			gPlayerClass[id] = Zoey
			Speed330[id] = 1
			Speed330[id] = 1
			ColorChat(id,  GREEN, "^x01[^x04Ludzie^x01]^x01 Twoja nowa klasa to ^x03 Louis")
		}
		
		
		
}
}


// FUNKCJE SZYBKOSCI
public Speed330a(id)
{
	if(Speed330[id])
	{
		set_user_maxspeed(id, 330.0)   
	}
}
public Speed300a(id)
{
	if(Speed300[id])
	{
		set_user_maxspeed(id, 300.0)  
	}
}
public Speed220a(id)
{
	if(Speed220[id])
	{
		set_user_maxspeed(id, 220.0)   
	}
}
public Speed280a(id)
{
	if(Speed280[id])
	{
		set_user_maxspeed(id, 280.0)   
	}
}

public client_putinserver(id)
{
	set_task(1.0, "pokaz_menu", id+TASK_SHOWMENU);
	gPlayerClass[id] = Zadna;
}
public pokaz_menu(tid){
	new id=tid-TASK_SHOWMENU;
	new iTeam=get_user_team(id);

	new menu_id, keys;
	new menuUp = player_menu_info( id, menu_id, keys );

	if ( iTeam && (menuUp <= 0 || menu_id < 0) )
		//Tu pokazujemy menu
		mymenu(id);
	else
		set_task(1.0, "pokaz_menu", tid);
}