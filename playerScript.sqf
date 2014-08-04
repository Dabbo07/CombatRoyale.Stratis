waitUntil {!(isNull player)};

player addEventHandler [
	"Respawn",
	{
		private ["_unit"];
		_unit = _this select 0;
		_unit call resetPlayerStart;
	}
];

player call resetPlayerStart;
player spawn playerZoneMonitor;

zoneBroadcast = 0;
zoneMessage = "";
trackBroadcast = 0;
timeBroadcast = 0;
zoneStatusUpdate = 0;
playerBombID = DebugPlr;
positionUpdate = 0;

sleep 5;
cutText [introText, "BLACK IN", 3];

_ping = 4;
while {MissionEndTrigger == 0} do {

	_dist = player distance getMarkerPos "resetTrack";
	if (_dist < 200) then {
		player call resetPlayerStart;
	};
	if (_ping > 0) then {
		_ping = _ping - 1;
	};
	if (zoneBroadcast == 1) then {
		hint zoneMessage;
		zoneBroadcast = 0;
	};
	if (EndGameUpdate > 0) then {
		zonesRemainUpdate = EndGameUpdate - 6;
		126 cutRsc ["EndGameDialog", "Plain"];
		EndGameUpdate = 0;
	};
	if (positionUpdate == 1) then {
		titleText ["Player positions have been updated on the map!", "PLAIN DOWN", 1];
		positionUpdate = 0;
	};
	if (playerBombID == player && _ping < 1) then {
		titleText ["!! DANGER !! - CHECK MAP, Near RED ZONE! - !! DANGER !!", "PLAIN DOWN", 1];
		playerBombID = DebugPlr;
		_ping = 2;
	};
	sleep 1;
};
endMission "END1";
forceEnd;