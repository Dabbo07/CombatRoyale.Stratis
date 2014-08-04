_killed = _this select 0;
_killer = _this select 1;
if (_killer != player && !isNull _killer) then {
	killerScored = _killer;
	publicVariableServer "killerScored";
};
