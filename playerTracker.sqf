if (isDedicated || isServer) then {
	sleep 5;
	while {true} do {
		
		// Human Player Tracking Placement
		{
			if (alive _x) then {
				format["%1m", _x] setMarkerColor "ColorPink";
			} else {
				format["%1m", _x] setMarkerColor "ColorKhaki";
			};
			format["%1m", _x] setMarkerPos getPos _x;
		} forEach playableUnits;
		
		if (AIENABLE > 0) then {
			// AI Player Tracking Placement
			_sel = 0;
			{
				if (alive _x) then {
					aiMarks select _sel setMarkerColor "ColorBlue";
				} else {
					aiMarks select _sel setMarkerColor "ColorKhaki";
				};
				aiMarks select _sel setMarkerPos getPos _x;
				_sel = _sel + 1;
			} forEach aiUnits;
		};
		positionUpdate = 1;
		publicVariable "positionUpdate";
		sleep (TRACKINTERVAL);
	};
};