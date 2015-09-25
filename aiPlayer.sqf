if (isDedicated || isServer) then {

	SEARCH_RANGE = 800;
	aiGroups = [];

	aiDeath = {
		_killed = _this select 0;
		_killer = _this select 1;
		if (_killer != _killed && !isNull _killer) then {
			killerScored = _killer;
			publicVariableServer "killerScored";
		};
	};
	
	respawnAIFunc = {
		private ["_unit"];
		_unit = _this select 0;
		_sel = _this select 1;
		
		_grp = aiGroups select _sel;
		_grp setBehaviour "COMBAT";
		_grp setCombatMode "RED";
		_grp setSpeedMode "FULL";

		_newUnit = _grp createUnit ["C_man_1_3_F", (getmarkerpos "respawn_civilian"),[],20,"FORM"];
		deleteVehicle _unit;
		
		aiUnits set [_sel, _newUnit];

		removeAllWeapons _newUnit;
		_rg = floor(random STARTGUN);
		_newUnit addMagazine (obj_mags select _rg);
		_newUnit addMagazine (obj_mags select _rg);
		_newUnit addWeapon (obj_guns select _rg);
		_newUnit addBackpack "B_Parachute";

		_randSel = 10;
		_zr = SAFEZONE;
		while {_randSel > 0} do {
			_zr = floor(random(count zones));
			if ((zoneStatus select _zr) == 100) then {
				_zr = SAFEZONE;
				_randSel = _randSel - 1;
			} else {
				_randSel = 0;
			};
		};
		_zone = zones select _zr;
		_px = getMarkerPos _zone select 0;
		_py = getMarkerPos _zone select 1;
		
		_randSel = 10;
		_rx = -300 + floor(random 601);
		_ry = -300 + floor(random 601);
		while {_randSel > 0} do {
			if (surfaceIsWater [_px + _rx, _py + _ry]) then {
				_rx = -300 + floor(random 601);
				_ry = -300 + floor(random 601);
				_randSel = _randSel - 1;
			} else {
				_randSel = 0;
			};
		};
			
		_newUnit setPos [_px + _rx, _py + _ry, 180];
		sleep .2;
		_newUnit action ["OpenParachute", _newUnit];
		_newUnit addMPEventHandler ["mpkilled", {_this spawn aiDeath}];
	};

	// Initialisation
	_validUnitTypes = [ "B_Pilot_F", "CAManBase", "O_Soldier_F", "B_Soldier_F", "SoldierWB", "C_Quadbike_01_F", "Steerable_Parachute_F", "Civilian", "C_man_1", "C_man_1_1_F", "C_man_1_2_F", "C_man_1_3_F", "C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F" ];
	_sel = 0;
	while {_sel < AIENABLE} do {
	
		_cnt = createCenter EAST;
		_grp = createGroup EAST;
		_grp setBehaviour "COMBAT";
		_grp setCombatMode "RED";

		aiGroups set [_sel, _grp];		
	
		_unit = aiUnits select _sel;
		[_unit, _sel] call respawnAIFunc;
		_sel = _sel + 1;
	};

	_sel = 0;
	while {true} do {
		_unit = aiUnits select _sel;

		// Unit landed/over? in the water, might as well kill it off.
		if (alive _unit && surfaceIsWater position _unit) then {
			//player globalChat format["%1 on water, killed.", _sel];
			_unit setDamage 1;
		} else {
			// Ensure unit is alive and on the ground.
			if (alive _unit && isTouchingGround _unit) then {
				// Hunter section START
				_targArray = _unit nearTargets 175;
				_co = count _targArray;
				_moveMode = true;
				//player globalChat format["%1 targets: %2", _sel, _co];
				
				if (_co > 0) then {
					_closest = 200;
					_selTarg = 0;
					_targInfo = _unit;
					{
						_targInfo = _x;
						_pos = _targInfo select 0;
						_dist = _unit distance _pos;
						_ty = _targInfo select 1;
						_tt = _targInfo select 4;
						
						//player globalChat format["%1 Is can see a : %2", _sel, _ty];
						
						_validTarget = {_x == _ty} count _validUnitTypes;
						if (_validTarget > 0) then {
							if ({alive _x} count crew _tt == 0) then {
								//player globalChat format["%1 No crew in target type : %2", _sel, _ty];
							} else {
								if (_dist < _closest) then {
									_closest = _dist;
									_selTarg = _targInfo;
								};	
							};
						};
					} foreach _targArray;
					
					_fireAtTarget = false;
					
					if (_closest != 200) then {
						_tt = _selTarg select 4;
						_ts = _selTarg select 2;
						_ty = _selTarg select 1;
						_unit doWatch _tt;
						_unit doTarget _tt;
						if ((random 100) > 90) then {
							_unit doMove position _tt;
							//player globalChat format["%1 Moving to target, type: %2", _sel, _ty];
						} else {
							sleep .2;
							_unit doFire _tt;
							//player globalChat format["%1 Shooting at target, type: %2", _sel, _ty];
						};
						_moveMode = false;
					//} else {
						//player globalChat format["%1 No targets in range", _sel];
					};
				};
				// Hunter section END
				
				// MOVE MODE START
				if (_moveMode) then {
					// Move to unit marker or crate position code here!
					_pos = position _unit;
					_closest = SEARCH_RANGE; // Maximum tracking range!
					// Player scan.
					{
						_mark = format["%1m", _x];
						// TODO: Add check to make sure marker is not khaki colours (human killed/discon)
						_dist = floor(_unit distance (getMarkerPos _mark));
						if (_dist < _closest) then {
							_closest = _dist;
							_pos = getMarkerPos _mark;
						};
					} foreach playableUnits;
					// AI Player scan.
					_co = 0;
					_target = _unit;
					while {_co < AIENABLE} do {
						_dist = floor(_unit distance (getMarkerPos (aiMarks select _co)));
						_tempUnit = aiUnits select _co;
						if (_dist < _closest && _tempUnit != _unit && alive _tempUnit) then {
							_closest = _dist;
							_pos = getMarkerPos (aiMarks select _co);
							_target = _tempUnit; 
						};
						_co = _co + 1;
					};
					if (_closest != SEARCH_RANGE) then {
						// Target within SEARCH_RANGE, move to last known position.
						//player globalChat format["%1 moving to target, range: %2m", _sel, _closest];
						_unit doMove _pos;
					} else {	
						// Move to blue safe zone.
						//player globalChat format["%1 moving to Blue zone.", _sel];
						_unit doMove (getMarkerPos "zone07");
					};
				};
				// MOVE MODE END
			};
		};
		
		if (!alive _unit) then {
			_life = aiLife select _sel;
			_life = _life + 1;
			if (_life > 15) then {
				_life = 0;
				//player globalChat format["%1 respawning...", _sel];
				[_unit, _sel] call respawnAIFunc;
			};
			aiLife set [_sel, _life];
		};
		
		_sel = _sel + 1;
		if (_sel >= AIENABLE) then {
			_sel = 0;
			sleep 5;
		};
	};
	
};