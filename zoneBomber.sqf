playerBombID = DebugPlr;

if (isDedicated || isServer) then {
	sleep 30;
	publicVariable "playerBombID";
	
	_selPlr = 0;
	while {true} do {
		_co = 0;
		{
			_obj = _x;
			if (alive _obj) then {
				_sel = 0;
				{
					if ((zoneStatus select _sel) == 100 && _sel != SAFEZONE) then {
						_zx = getMarkerPos (zones select _sel) select 0;
						_zy = getMarkerPos (zones select _sel) select 1;
						_px = getPos _obj select 0;
						_py = getPos _obj select 1;
						_dx = _px - _zx;
						_dy = _py - _zy;
						if ((_dx > -400) && (_dx < 400)) then {
							if ((_dy > -400) && (_dy < 400)) then {
								_nades = 3;
								while {_nades > 0} do {
									_rx = -15 + floor(random 30);
									_ry = -15 + floor(random 30);
									_ax = _px + _rx;
									_ay = _py + _ry;
									_bomb = "Grenade" createVehicle [_ax, _ay, 60];
									_nades = _nades - 1;
									sleep .05;
								};
							};
						};
					};
					_sel =_sel + 1;
				} forEach zones;
			};
			_co = _co + 1;
		} forEach playableUnits;
		sleep 0.5;
	};
};
