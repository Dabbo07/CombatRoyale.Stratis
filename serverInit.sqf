// Global Server Variables
	killScores = [];
	killObjects = [];
	killNames = [];
	markedForDeath = [ "", "", "", "", "" ];
	cars = [car1,car2,car3,car4,car5,car6,car7,car8,car9,car10,car11,car12];
	aiUnits = [ 
		ai00, ai01, ai02, ai03, ai04, ai05, ai06, ai07, ai08, ai09, 
		ai10, ai11, ai12, ai13, ai14, ai15, ai16, ai17, ai18, ai19,
		ai20, ai21, ai22, ai23, ai24, ai25, ai26, ai27, ai28, ai29,
		ai30, ai31, ai32, ai33, ai34, ai35, ai36, ai37, ai38, ai39,
		ai40, ai41, ai42, ai43, ai44, ai45, ai46, ai47, ai48, ai49
	];
	zoneStatus = [
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0
	];

// Zone Setup	
	_zoneSel = 0;
	while {_zoneSel < (count zones)} do {
		if (_zoneSel > ZONELIMIT) then {
			zoneStatus set [_zoneSel, 100];
			(zones select _zoneSel) setMarkerColor "ColorRed";
		} else {
			if (_zoneSel != SAFEZONE) then {
				if (ZONECREEP >= 90) then {
					zones select _zoneSel setMarkerColor "ColorYellow";
				};
				zoneStatus set [_zoneSel, ZONECREEP];
			};
		};
		format["%1txt", zones select _zoneSel] setMarkerPos getMarkerPos (zones select _zoneSel);
		_zoneSel =_zoneSel + 1;
	};
	"crate01m" setMarkerSize [CRATESIZE, CRATESIZE];
	"crate02m" setMarkerSize [CRATESIZE, CRATESIZE];
	"crate03m" setMarkerSize [CRATESIZE, CRATESIZE];

// Special Processes
	specialCrateSmoke = {
		while {true} do {
			if (floor(random 5) > 3) then {
				_smoke = "SmokeshellRed" createVehicle [getPos specCrate select 0, getPos specCrate select 1, 1];
			} else {
				if (floor(random 5) > 3) then {
					_smoke = "SmokeshellBlue" createVehicle [getPos specCrate select 0, getPos specCrate select 1, 1];
				} else {
					if (floor(random 5) > 3) then {
						_smoke = "SmokeshellGreen" createVehicle [getPos specCrate select 0, getPos specCrate select 1, 1];
					} else {
						_smoke = "SmokeshellYellow" createVehicle [getPos specCrate select 0, getPos specCrate select 1, 1];
					};
				};
			};
			sleep 110;
		};
	};

// Main Processing
	if (ALLOWCARS > 0) then {
		// Move cars to marker positions
		if (PLACECARS == 1) then {
			// Randomize Vehicle Start Positions
			{
				_cx = 0;
				_cy = 0;
				_randSel = 10;
				while {_randSel > 0} do {
					_randZoneSel = 5;
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
					_px = getMarkerPos _zone select 0;
					_py = getMarkerPos _zone select 1;

					_rx = -200 + floor(random 401);
					_ry = -200 + floor(random 401);
					_cx = _px + _rx;
					_cy = _py + _ry;
					
					if (surfaceIsWater [_cx, _cy]) then {
						_randSel = _randSel - 1;
					} else {
						_randSel = 0;
					};
				};
				_x setMarkerPos [_cx, _cy, 0];
			} foreach carMarks;
		};
		_co = 0;
		{
			if (_co > ALLOWCARS) then {
				 _x setMarkerPos getPos (cars select _co);
			} else {
				_mx = getMarkerPos _x select 0;
				_my = getMarkerPos _x select 1;
				(cars select _co) setPos [_mx, _my, 0];
			};
			_co =_co + 1;
		} foreach carMarks;
		execVM "carTracker.sqf"; 
	} else {
		// Move markers to car positions (island)
		_co = 0;
		{
			_x setMarkerPos getPos (cars select _co);
			_co =_co + 1;
		} foreach carMarks;
	};

// Publish variables out to clients
	publicVariable "cars";
	publicVariable "zones";
	publicVariable "zoneStatus";

	"playerScoreFetch" addPublicVariableEventHandler {
		_pcid = owner (_this select 1 select 0);
        _unit = _this select 1 select 0;
		_score = _this select 1 select 1;
		_co = 0;
		_killer = name _unit;
		{
			if (_x == _killer) then {
				_score = (killScores select _co);
			};
		} foreach killNames;
		playerScoreReturn = _score;
		_pcid publicVariableClient "playerScoreReturn";
	};
	
	"killerScored" addPublicVariableEventHandler {
		_killerObj = (_this select 1);
		_killer = name _killerObj;
		if (!(isPlayer _killerObj)) then {
			_killer = format["{AI} %1", _killer];
		};
		_co = 0;
		_found = false;
		{
			if (_x == _killer) then {
				_found = true;
				_score = (killScores select _co) + 1;
				killScores set [_co, _score];
				killObjects set [_co, name _killerObj];
			};
			_co = _co + 1;
		} foreach killNames;
		if (!_found) then {
			killObjects set [count killNames, name _killerObj];
			killNames set [count killNames, _killer];
			killScores set [count killScores, 1];
		};
		
		Score1 = "1st : ---------- 0 Kills";
		Score2 = "2nd : ---------- 0 Kills";
		Score3 = "3rd : ---------- 0 Kills";
		Score4 = "4th : ---------- 0 Kills";
		Score5 = "5th : ---------- 0 Kills";
		
		_co = 0;
		_max = -1;
		_tmpScores = [] + killScores;
		while {_co < 5} do {
			_sel = -1;
			_lp = 0;
			_top = 0;
			{
				if (_x > _top) then {
					if (_co == 0 || _max == -1 || _x <= _max) then {
						_sel = _lp;
					};
					_top = _x;
				};
				_lp = _lp + 1;
			} foreach _tmpScores;
			_info = "---------- 0 Kills";
			if (_sel > -1) then {
				_info = format["%1 - %2 Kills", killNames select _sel, killScores select _sel];
				_max = _tmpScores select _sel;
				_tmpScores set [_sel, -1];
				markedForDeath set [ _co, killObjects select _sel];
			};
			if (_co == 0) then {
				Score1 = format["1st : %1", _info];
			};
			if (_co == 1) then {
				Score2 = format["2nd : %1", _info];
			};
			if (_co == 2) then {
				Score3 = format["3rd : %1", _info];
			};
			if (_co == 3) then {
				Score4 = format["4th : %1", _info];
			};
			if (_co == 4) then {
				Score5 = format["5th : %1", _info];
			};
			_co = _co + 1;
		};
		publicVariable "Score1";
		publicVariable "Score2";
		publicVariable "Score3";
		publicVariable "Score4";
		publicVariable "Score5";
	};
	
	specCrate spawn specialCrateSmoke;
	execVM "crateControl.sqf"; 
	execVM "playerTracker.sqf"; 
	execVM "zoneControl.sqf"; 
	execVM "zoneBomber.sqf"; 
	if (AIENABLE > 0) then {
		execVM "aiPlayer.sqf";
	};
	if (ZONEBOMB == 1) then {
		execVM "bombDropper.sqf";
	};
	ServerReady = 1;
	publicVariable "ServerReady";
	
	