if (isDedicated || isServer) then {
	sleep 5;
	
	while {true} do {
		sleep ZONEBOMBDELAY;
		
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
		
		_rx = -420 + floor(random 420);
		_ry = -420 + floor(random 420);
		
		_co = 0;
		while {_co < 4} do {
			_acx = -40 + floor(random 81);
			_acy = -40 + floor(random 81);

			_rh = floor(random 750);

			_ax = _px + (_rx + _acx);
			_ay = _py + (_ry + _acy);

			_bomb = "Bo_Mk82" createVehicle [_ax, _ay, 300 + _rh];
			_co = _co + 1;
		};
	};
};