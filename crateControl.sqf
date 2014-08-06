if (isDedicated || isServer) then {

	crateTicker = -1;

	clearMagazineCargoGlobal specCrate;
	clearWeaponCargoGlobal specCrate;
	clearItemCargoGlobal specCrate;
	clearBackpackCargoGlobal specCrate;
	clearMagazineCargoGlobal crate01;
	clearWeaponCargoGlobal crate01;
	clearItemCargoGlobal crate01;
	clearBackpackCargoGlobal crate01;
	clearMagazineCargoGlobal crate02;
	clearWeaponCargoGlobal crate02;
	clearItemCargoGlobal crate02;
	clearBackpackCargoGlobal crate02;
	clearMagazineCargoGlobal crate03;
	clearWeaponCargoGlobal crate03;
	clearItemCargoGlobal crate03;
	clearBackpackCargoGlobal crate03;

	// SpecCrate Setup
	specCrate addMagazineCargoGlobal ["20Rnd_762x51_Mag", 2];
	specCrate addWeaponCargoGlobal ["srifle_EBR_SOS_F", 1];
	
	specCrate addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 4];
	specCrate addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell", 6];
	specCrate addMagazineCargoGlobal ["UGL_FlareGreen_F", 2];
	specCrate addMagazineCargoGlobal ["UGL_FlareRed_F", 2];
	specCrate addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 2];
	specCrate addWeaponCargoGlobal ["arifle_TRG21_GL_F", 1];
	
	specCrate addMagazineCargoGlobal ["200Rnd_65x39_cased_Box", 2];
	specCrate addWeaponCargoGlobal ["LMG_Mk200_F", 1];

	specCrate addItemCargoGlobal ["U_B_GhillieSuit", 2];
	specCrate addBackpackCargoGlobal ["B_AssaultPack_Base", 2];

	specCrate addMagazineCargoGlobal ["RPG32_F", 4];
	specCrate addWeaponCargoGlobal ["launch_RPG32_F", 1];
	specCrate addMagazineCargoGlobal ["NLAW_F", 4];
	specCrate addWeaponCargoGlobal ["launch_NLAW_F", 1];
	
	_cx = getMarkerPos "specMark" select 0;
	_cy = getMarkerPos "specMark" select 1;
	_xr = -125 + floor(random 251);
	_yr = -125 + floor(random 251);
	specCrate setPos [_cx + _xr, _cy + _yr, 0];
	"specMark" setMarkerPos [_cx + _xr, _cy + _yr];
	
	crateBroadcast = 0;
	crateMessage = "";

	explodeCrate = {
		_crate = _this select 0;
		_offset = _this select 1;
		_ox = (position _crate) select 0;
		_oy = (position _crate) select 1;
		
		_crate setPos [_offset, 0, 0];
		_bomb = "Bo_Mk82" createVehicle [_ox, _oy, 1];
	};
	
	resetCrateContent = {
		_crate = _this select 0;
		_marker = _this select 1;
		_cx = 0;
		_cy = 0;
		_randSel = 25;
		while {_randSel > 0} do {
			_randZoneSel = 10;
			_zr = SAFEZONE;
			while {_randZoneSel > 0} do {
				_zr = floor(random (count zones));
				if ((zoneStatus select _zr) == 100) then {
					_zr = SAFEZONE;
					_randZoneSel = _randZoneSel - 1;
				} else {
					_randZoneSel = 0;
				};
			};

			_zone = zones select _zr;
			_cx = getMarkerPos _zone select 0;
			_cy = getMarkerPos _zone select 1;

			_xr = -200 + floor(random 401);
			_yr = -200 + floor(random 401);
			_cx = _cx + _xr;
			_cy = _cy + _yr;
			
			if (surfaceIsWater [_cx, _cy]) then {
				_randSel = _randSel - 1;
			} else {
				_randSel = 0;
			};
		};
		
		_crateSz = floor(CRATESIZE / 2);
		_ox = -_crateSz + floor(random (_crateSz * 2));
		_oy = -_crateSz + floor(random (_crateSz * 2));
		
		_marker setMarkerPos [_cx + _ox, _cy + _oy];
		//_crate setPos [_cx, _cy, 0];	
		
		_para = createVehicle ["B_Parachute_02_F", [0,0,100], [], 0, ""];
		_para setPosATL [_cx, _cy, 350];
		_crate attachTo [_para, [0,0,0]]; 

		// Land safely
		WaitUntil {((((position _crate) select 2) < 1) || (isNil "_para"))};
		detach _crate;
		_crate SetVelocity [0,0,-5];           
		sleep 0.3;
		_cx = (position _crate) select 0;
		_cy = (position _crate) select 1;
		_crate setPos [_cx, _cy, 0.6];  
		
		_marker setMarkerPos [_cx + _ox, _cy + _oy];
		
		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearItemCargoGlobal _crate;
		clearBackpackCargoGlobal _crate;

		// Add 1 to 3 random weapons with 1 or 2 mags each.
		_itemAdd = 1 + floor(random 3);
		while { _itemAdd > 0 } do {
			_weap = floor(random (count obj_guns));
			_crate addWeaponCargoGlobal [obj_guns select _weap, 1];
			_crate addMagazineCargoGlobal [obj_mags select _weap, 1 + floor(random 2)];
			_itemAdd = _itemAdd - 1;
			//plr globalChat format["DEBUG: Added weapon [%1] to [%2]", (obj_mags select _weap), _crate];
		};
		// Add some random magazines in cargo container.
		_mags = floor(random (count obj_guns));
		_crate addMagazineCargoGlobal [obj_mags select _mags, floor(random 3)];

		// 55% chance of a FirstAid Kit
		if (floor(random 100) > 45) then {
			_crate addItemCargoGlobal ["FirstAidKit", 1];
		};
		// 10% chance of Binoculars
		if (floor(random 100) > 90) then {
			_crate addItemCargoGlobal ["Binocular", 1];
		};
		// 2% chance of NVGoggles
		if (floor(random 100) > 98) then {
			_crate addItemCargoGlobal ["NVGoggles", 1];
		};
		// 15% chance of GPS
		if (floor(random 100) > 85) then {
			_crate addItemCargoGlobal ["ItemGPS", 1];
		};
		// Add 1-4 random items
		_itemAdd = 1 + floor(random 4);
		while { _itemAdd > 0 } do {
			_randItem = floor(random (count obj_items));
			_crate addItemCargoGlobal [obj_items select _randItem, 1];
			_itemAdd = _itemAdd - 1;
		};
		// 40% chance to add a backpack.
		if (floor(random 100) > 60) then {
			_randBag = floor(random (count obj_backpacks));
			_crate addBackpackCargoGlobal [obj_backpacks select _randBag, 1];
		};
	};

	sleep 15;
	
	while {true} do {

		_h1 = [crate01, "crate01m"] spawn resetCrateContent;
		_h2 = [crate02, "crate02m"] spawn resetCrateContent;
		_h3 = [crate03, "crate03m"] spawn resetCrateContent;
		
		sleep 15;
		WaitUntil { ((((position crate01) select 2) < 4) || (((position crate02) select 2) < 4) || (((position crate03) select 2) < 4))};
		detach crate01; // Ensure we dont have any crates stuck in a tree somewhere.
		detach crate02;
		detach crate03;
		
		x = CRATEINTERVAL;
		while {x > 0} do {
		    crateTicker = x;
			publicVariable "crateTicker";
			x = x - 1;
			sleep 1;
		};
		
	    crateTicker = -1;
		publicVariable "crateTicker";

		_h4 = [crate01, 0] spawn explodeCrate;
		_h5 = [crate02, 20] spawn explodeCrate;
		_h6 = [crate03, 40] spawn explodeCrate;
		
		sleep 10;
	};
};