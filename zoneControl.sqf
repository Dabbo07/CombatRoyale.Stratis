if (isDedicated || isServer) then {

	zoneBroadcast = 0;
	zoneMessage = "";
	
	sleep 10;
	publicVariable "zoneID";
	publicVariable "zoneStatus";
	publicVariable "zoneBroadcast";
	publicVariable "zoneMessage";
	
	_runLoop = true;
	_zonesAliveLast = -1;
	
	while {_runLoop} do {
	
		_rZoneID = floor(random (count zones));
		_val = zoneStatus select _rZoneID;
		
		if (_rZoneID != SAFEZONE) then {
			if (_val < 100) then {
				_val = _val + 1;
				zoneStatus set [_rZoneID, _val];
				if (_val > 99) then {
					(zones select _rZoneID) setMarkerColor "ColorRed";
					zoneBroadcast = 1;
					zoneMessage = format["\nALERT\n\nZONE %1 is now DANGEROUS!\n ", (_rZoneID + 1)];
				} else {
					if (_val == 90) then {
						zones select _rZoneID setMarkerColor "ColorYellow";
						zoneBroadcast = 1;
						zoneMessage = format["\nWARNING\n\nZONE %1 will be a\nRESTRICTED area soon.\n\nEVACUATE THIS ZONE\n ", (_rZoneID + 1)];
					};
				};
				publicVariable "zoneID";
				publicVariable "zoneStatus";
				publicVariable "zoneBroadcast";
				publicVariable "zoneMessage";
				sleep (0.2 + floor(random 3));
			};
		};
		sleep 0.1;

		_zonesAlive = 0;
		_sel = 0;
		{
			_val = zoneStatus select _sel;
			if (_val < 100) then {
				_zonesAlive = _zonesAlive + 1;
			};
			_sel = _sel + 1;
		} forEach zones;
		if (_zonesAlive < 15 && _zonesAlive != _zonesAliveLast) then {
			EndGameUpdate = _zonesAlive;
			_zonesAliveLast = _zonesAlive;
			publicVariable "EndGameUpdate";
		};
		if (_zonesAlive < 7) then {
			MissionEndTrigger = 1;
			publicVariable "MissionEndTrigger";
			endMission "END1";
			forceEnd;
			_runLoop = false;
		};
	};
};
