if (isDedicated || isServer) then {
	sleep 10;
	while {true} do {
		_sel = 0;
		{
			(carMarks select _sel) setMarkerPos (getPos _x);
			_sel = _sel + 1;
		} forEach cars;
		_sel = 0;
		while {_sel < 3} do {
			_ptt = (markedForDeath select _sel);
			{
				_nameOfUnit = name _x;
				if (_nameOfUnit == _ptt) then {
					format["md%1", _sel] setMarkerPos getPos _x;
				};
			} foreach allUnits;
			_sel = _sel + 1;
		};
		sleep 1.5;
	};
};