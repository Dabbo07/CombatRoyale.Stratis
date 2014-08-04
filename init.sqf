// TODO:
// - Overlay not showing bug - not found cause yet

// Global Variables
EAST setFriend [WEST, 0];
EAST setFriend [RESISTANCE, 0];
EAST setFriend [CIVILIAN, 0];
EAST setFriend [EAST, 0];

VERSION = "v1.6.32";
ZONELIMIT = (paramsArray select 0);
ZONECREEP = (paramsArray select 1);
TRACKINTERVAL = (paramsArray select 2);
CRATESIZE = (paramsArray select 3);
CRATEINTERVAL = (paramsArray select 4);
ZONEBOMB = (paramsArray select 5);
ZONEBOMBDELAY = (paramsArray select 6);
ALLOWCARS = (paramsArray select 7);
SHIELDCARS = (paramsArray select 8);
PLACECARS = (paramsArray select 9);
AIENABLE = (paramsArray select 10);
STARTGUN = (paramsArray select 11);

killerScored = objNull;
aiMarks = [];
aiLife = [];
aiM = 0;
while {aiM < 50} do {
	_pre = "0";
	if (aiM > 9) then {
		_pre = "";
	};
	aiMarks = aiMarks + [ format["aim%1%2", _pre, aiM] ];
	aiLife = aiLife + [ 0 ];
	aiM = aiM + 1;
};

CombatPlayerScore = 0;
marks = ["pl01m", "pl02m", "pl03m", "pl04m", "pl05m", "pl06m", "pl07m", "pl08m", "pl09m", "pl10m", "pl11m", "pl12m", "pl13m", "pl14m", "pl15m", "pl16m", "pl17m", "pl18m", "pl19m", "pl20m", "pl21m", "pl22m", "pl23m", "pl24m", "pl25m", "pl26m", "pl27m", "pl28m", "pl29m", "pl30m", "pl31m", "pl32m", "pl33m", "pl34m", "pl35m", "pl36m", "pl37m", "pl38m", "pl39m", "pl40m"];
carMarks = ["carm1","carm2","carm3","carm4","carm5","carm6","carm7","carm8","carm9","carm10","carm11","carm12"];
zones = [
	"zone01", "zone02", "zone03", "zone04", "zone05", "zone06", "zone07", "zone08", "zone09", "zone10",
	"zone11", "zone12", "zone13", "zone14", "zone15", "zone16", "zone17", "zone18", "zone19", "zone20",
	"zone21", "zone22", "zone23", "zone24", "zone25", "zone26", "zone27", "zone28", "zone29", "zone30",
	"zone31", "zone32", "zone33", "zone34", "zone35", "zone36", "zone37", "zone38", "zone39", "zone40",
	"zone41"
];

SAFEZONE = 6;
introText = format["Welcome to Combat Royale on Stratis\nVersion %1\n\nBy Darren 'Dabbo' Edmonds.", VERSION];
ZoneDialogMessage = "Zone Status...";
ZoneDialogAlert = 0;
zonesRemainUpdate = 0;
EndGameUpdate = 0;
if (isNil "ServerReady") then {
	ServerReady = 0;
};
if (isNil "MissionEndTrigger") then {
	MissionEndTrigger = 0;
};
if (isNil "Score1") then {
	Score1 = "1st : ---------- 0 Kills";
};
if (isNil "Score2") then {
	Score2 = "2nd : ---------- 0 Kills";
};
if (isNil "Score3") then {
	Score3 = "3rd : ---------- 0 Kills";
};
if (isNil "Score4") then {
	Score4 = "4th : ---------- 0 Kills";
};
if (isNil "Score5") then {
	Score5 = "5th : ---------- 0 Kills";
};

obj_guns = [
	"hgun_ACPC2_F",									// Hand Guns
	"hgun_P07_F",
	"hgun_Rook40_F",
	"hgun_Pistol_heavy_01_F",
	"hgun_Pistol_heavy_02_F",
	"SMG_01_F",										// SMGs
	"SMG_02_F",
	"hgun_PDW2000_F",
	"arifle_Katiba_F",								// Assault Rifles
	"arifle_Katiba_C_F",
	"arifle_Mk20_F",
	"arifle_MX_F",
	"arifle_MX_Black_F",
	"arifle_MXC_F",
	"arifle_MXC_Black_F",
	"arifle_MXM_F",
	"arifle_MXM_Black_F",
	"arifle_SDAR_F",
	"arifle_TRG20_F",
	"arifle_TRG21_F",
	"arifle_MX_SW_F",								// LMGs
	"LMG_Mk200_F",
	"LMG_Zafir_F",
	"srifle_EBR_F",									// Sniper Rifles
	"srifle_GM6_F",
	"srifle_LRR_F",
	"srifle_DMR_01_F",
	"arifle_Katiba_GL_F",							// Grenade Launchers
	"arifle_MX_GL_F",
	"arifle_Mk20_GL_F",
	"arifle_MX_GL_Black_F",
	"arifle_TRG21_GL_F",
	"launch_NLAW_F",								// Launchers
	"launch_RPG32_F"
];

obj_mags = [
	"9Rnd_45ACP_Mag",								// Hand Guns
	"30Rnd_9x21_Mag",
	"30Rnd_9x21_Mag",
	"11Rnd_45ACP_Mag",
	"6Rnd_45ACP_Cylinder",
	"30Rnd_45ACP_Mag_SMG_01_tracer_green",			// SMGs
	"30Rnd_9x21_Mag",
	"30Rnd_9x21_Mag",
	"30Rnd_65x39_caseless_green_mag_Tracer",		// Assault Rifles
	"30Rnd_65x39_caseless_green_mag_Tracer",
	"30Rnd_556x45_Stanag_Tracer_Yellow",
	"30Rnd_65x39_caseless_mag_Tracer",
	"30Rnd_65x39_caseless_mag_Tracer",
	"30Rnd_65x39_caseless_mag_Tracer",
	"30Rnd_65x39_caseless_mag_Tracer",
	"30Rnd_65x39_caseless_mag_Tracer",
	"30Rnd_65x39_caseless_mag_Tracer",
	"30Rnd_556x45_Stanag_Tracer_Yellow",
	"30Rnd_556x45_Stanag_Tracer_Yellow",
	"30Rnd_556x45_Stanag_Tracer_Yellow",
	"100Rnd_65x39_caseless_mag_Tracer",				// LMGs
	"200Rnd_65x39_cased_Box_Tracer",
	"150Rnd_762x51_Box_Tracer",
	"20Rnd_762x51_Mag",								// Sniper Rifles
	"5Rnd_127x108_APDS_Mag",
	"7Rnd_408_Mag",
	"10Rnd_762x51_Mag",
	"30Rnd_65x39_caseless_green_mag_Tracer",		// Grenade Launchers
	"30Rnd_65x39_caseless_mag_Tracer",
	"30Rnd_556x45_Stanag_Tracer_Yellow",
	"30Rnd_65x39_caseless_mag_Tracer",
	"30Rnd_556x45_Stanag_Tracer_Yellow",
	"NLAW_F",										// Launchers
	"RPG32_HE_F"
];


/*
obj_guns = [
	"hgun_ACPC2_F",
	"hgun_P07_F",
	"hgun_Pistol_heavy_01_F",
	"hgun_Pistol_heavy_02_F",
	"hgun_Rook40_F",
	"hgun_PDW2000_F",
	"SMG_01_F",
	"SMG_02_F",
	"arifle_Katiba_F",
	"arifle_Mk20_F",
	"arifle_MX_F",
	"arifle_SDAR_F",
	"arifle_TRG20_F",
	"arifle_TRG21_F",
	"arifle_MXC_F",
	"arifle_MXM_F",
	"LMG_Zafir_F",
	"LMG_Mk200_F",
	"srifle_DMR_01_F",
	"srifle_EBR_F",
	"srifle_GM6_F",
	"srifle_LRR_F"
];
obj_mags = [
	"9Rnd_45ACP_Mag",
	"16Rnd_9x21_Mag",
	"11Rnd_45ACP_Mag",
	"6Rnd_45ACP_Cylinder",
	"16Rnd_9x21_Mag",
	"30Rnd_9x21_Mag",
	"30Rnd_45ACP_Mag_SMG_01",
	"30Rnd_9x21_Mag",
	"30Rnd_65x39_caseless_green",
	"30Rnd_556x45_Stanag",
	"30Rnd_65x39_caseless_mag",
	"20Rnd_556x45_UW_mag",
	"30Rnd_556x45_Stanag",
	"30Rnd_556x45_Stanag",
	"30Rnd_65x39_caseless_mag",
	"30Rnd_65x39_caseless_mag",
	"150Rnd_762x51_Box_Tracer",
	"200Rnd_65x39_cased_Box_Tracer",
	"10Rnd_762x51_Mag",
	"20Rnd_762x51_Mag",
	"5Rnd_127x108_Mag",
	"7Rnd_408_Mag"
];
*/

obj_backpacks = [ 
	"B_AssaultPack_Base",
	"B_AssaultPack_blk",
	"B_FieldPack_khk",
	"B_AssaultPack_cbr",
	"B_AssaultPack_dgtl",
	"B_AssaultPack_khk",
	"B_AssaultPack_mcamo",
	"B_AssaultPack_ocamo",
	"B_AssaultPack_rgr",
	"B_AssaultPack_sgg",
	"B_Bergen_Base",
	"B_Bergen_sgg",
	"B_Carryall_Base",
	"B_Carryall_ocamo"
];

obj_items = [	
	"Binocular",
	"ItemGPS",
	"H_Bandanna_camo",
	"H_Bandanna_khk",
	"H_Bandanna_surfer",
	"H_Bandanna_gry",
	"H_BandMask_reaper",
	"H_BandMask_demon",
	"H_Beret_brn_SF",
	"H_Beret_red",
	"H_Beret_ocamo",
	"H_Booniehat_dgtl",
	"H_Booniehat_dirty",
	"H_Booniehat_indp",
	"H_Booniehat_tan",
	"H_Cap_blk",
	"H_Cap_blu",
	"H_Cap_red",
	"H_Cap_tan_specops_US",
	"H_CrewHelmetHeli_B",
	"H_Hat_checker",
	"H_HelmetIA",
	"H_HelmetSpecB",
	"H_MilCap_blue",
	"H_StrawHat",
	"H_TurbanO_blk",
	"muzzle_snds_acp",
	"muzzle_snds_B",
	"muzzle_snds_H",
	"muzzle_snds_H_MG",
	"muzzle_snds_L",
	"muzzle_snds_M",
	"optic_Aco",
	"optic_Aco_grn",
	"optic_Aco_grn_smg",
	"optic_Aco_smg",
	"optic_Arco",
	"optic_Hamr",
	"optic_Holosight",
	"optic_Holosight_smg",
	"optic_MRCO",
	"optic_Nightstalker",
	"optic_NVS",
	"optic_SOS",
	"optic_tws",
	"optic_tws_mg",
	"U_B_CombatUniform_mcam",
	"U_B_CombatUniform_mcam_tshirt",
	"U_B_CombatUniform_mcam_vest",
	"U_B_CombatUniform_mcam_worn",
	"U_B_CombatUniform_sgg",
	"U_B_CombatUniform_sgg_tshirt",
	"U_B_CombatUniform_sgg_vest",
	"U_B_CombatUniform_wdl",
	"U_B_CombatUniform_wdl_tshirt",
	"U_B_CombatUniform_wdl_vest",
	"U_I_GhillieSuit",
	"U_B_HeliPilotCoveralls",
	"U_B_PilotCoveralls",
	"U_B_SpecopsUniform_sgg",
	"U_B_Wetsuit",
	"U_C_Commoner1_1",
	"U_C_Commoner1_2",
	"U_C_Commoner1_3",
	"U_C_Commoner2_1",
	"U_C_Commoner2_2",
	"U_C_Commoner2_3",
	"U_C_Farmer",
	"U_C_Fisherman",
	"U_C_FishermanOveralls",
	"U_C_HunterBody_brn",
	"U_C_HunterBody_grn",
	"U_C_Novak",
	"U_C_Poloshirt_blue",
	"U_C_Poloshirt_burgundy",
	"U_C_Poloshirt_redwhite",
	"U_C_Poloshirt_salmon",
	"U_C_Poloshirt_stripped",
	"U_C_Poloshirt_tricolour",
	"U_C_Poloshirt_burgundy",
	"U_C_Poor_1",
	"U_C_Poor_2",
	"U_C_Poor_shorts_1",
	"U_C_Poor_shorts_2",
	"U_C_PriestBody",
	"U_C_Scavenger_1",
	"U_C_Scavenger_2",
	"U_C_ShirtSurfer_shorts",
	"U_C_TeeSurfer_shorts_1",
	"U_C_TeeSurfer_shorts_2",
	"U_C_WorkerCoveralls",
	"U_C_WorkerOveralls",
	"U_I_CombatUniform",
	"U_I_CombatUniform_shortsleeve",
	"U_I_CombatUniform_tshirt",
	"U_I_GhillieSuit",
	"U_I_HeliPilotCoveralls",
	"U_I_OfficerUniform",
	"U_I_PilotCoveralls",
	"U_I_Wetsuit",
	"U_I_PilotCoveralls",
	"U_O_CombatUniform_ocamo",
	"U_O_CombatUniform_oucamo",
	"U_O_GhillieSuit",
	"U_O_OfficerUniform_ocamo",
	"U_O_PilotCoveralls",
	"U_O_SpecopsUniform_blk",
	"U_O_SpecopsUniform_ocamo",
	"U_O_Wetsuit",
	"V_BandollierB_blk",
	"V_BandollierB_cbr",
	"V_BandollierB_oli",
	"V_Chestrig_khk",
	"V_Chestrig_rgr",
	"V_HarnessO_brn",
	"V_HarnessOGL_gry",
	"V_PlateCarrier1_blk",
	"V_PlateCarrier1_rgr",
	"V_PlateCarrier2_rgr",
	"V_PlateCarrierGL_rgr",
	"V_PlateCarrierSpec_rgr",
	"V_TacVest_blk",
	"V_TacVest_blk_POLICE",
	"V_TacVest_brn",
	"V_TacVest_camo",
	"V_TacVestIR_blk"
];

// Server init
if (isServer) then {
	// Server specific tasks
	execVM "serverInit.sqf";
};
if (!isServer || !(isNull player)) then {
	// Listen Server + Client only tasks
	execVM "clientInit.sqf";
};

//END