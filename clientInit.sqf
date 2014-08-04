// GUI Display
	cutText [introText, "BLACK", 0];

	mytime = diag_tickTime + 10;
	onEachFrame {
		if (mytime < diag_tickTime) then {
			100 cutRsc ["CrateStatusDialog", "Plain"];
			110 cutRsc ["ZoneStatusDialog", "Plain"];
			120 cutRsc ["PlayerScoreTitle", "Plain"];
			121 cutRsc ["PlayerScore1Dialog", "Plain"];
			122 cutRsc ["PlayerScore2Dialog", "Plain"];
			123 cutRsc ["PlayerScore3Dialog", "Plain"];
			124 cutRsc ["PlayerScore4Dialog", "Plain"];
			125 cutRsc ["PlayerScore5Dialog", "Plain"];
			126 cutRsc ["PlayerScoreMainDialog", "Plain"];
		};
	};

// Special processes

	"playerScoreReturn" addPublicVariableEventHandler {
		CombatPlayerScore = playerScoreReturn;
	};

	playerZoneMonitor = {
		while {true} do {
			_sel = 0;
			{
				_zx = getMarkerPos (zones select _sel) select 0;
				_zy = getMarkerPos (zones select _sel) select 1;
				_px = getPos player select 0;
				_py = getPos player select 1;
			
				_dx = _px - _zx;
				_dy = _py - _zy;
				
				if ((_dx > -400) && (_dx < 400)) then {
					if ((_dy > -400) && (_dy < 400)) then {
						_pr = zoneStatus select _sel;
						zoneDialogMessage = format["Zone #%1 Expiry Level [%2/100]", (_sel + 1), _pr];
						ZoneDialogAlert = _pr;
					};
				};
				if ((zoneStatus select _sel) > 99 && _sel != SAFEZONE) then {
					if ((_dx > -450) && (_dx < 450)) then {
						if ((_dy > -450) && (_dy < 450)) then {
							playerBombID = player;
							// Notify player there are near RED zone!
						};
					};
				};
				_sel =_sel + 1;
			} forEach zones;
			playerScoreFetch = [ player, 0 ];
			publicVariableServer "playerScoreFetch";
			sleep 2;
		};
	};

	resetPlayerStart = {
		private ["_unit"];
		_unit = _this;
		removeAllWeapons _unit;
		_unit addBackpack "B_Parachute";
		_rg = floor(random STARTGUN);
		_unit addMagazine (obj_mags select _rg);
		_unit addWeapon (obj_guns select _rg);
		if (floor(random 5) > 3) then {
			_unit addHandgunItem "muzzle_snds_L";
		};
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
		_randSel = 25;
		_rx = -200 + floor(random 401);
		_ry = -200 + floor(random 401);
		while {_randSel > 0} do {
			if (surfaceIsWater [_px + _rx, _py + _ry]) then {
				_rx = -200 + floor(random 401);
				_ry = -200 + floor(random 401);
				_randSel = _randSel - 1;
			} else {
				_randSel = 0;
			};
		};
		_unit setPos [_px + _rx, _py + _ry, 1000];
	};

// Main process
	// Car allowDamage is local, needs to be ran on all clients
	waitUntil { ServerReady == 1 };
	_co = 0;
	{
		if (SHIELDCARS == 0) then {
			(cars select _co) allowDamage false;
		} else {
			(cars select _co) allowDamage true;
		};
		_co =_co + 1;
	} foreach carMarks;
	execVM "briefing.sqf";
	execVM "playerScript.sqf";
