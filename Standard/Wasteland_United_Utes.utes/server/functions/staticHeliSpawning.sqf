//	@file Version: 1.0
//	@file Name: staticHeliSpawning.sqf
//	@file Author: [404] Costlyy
//	@file Created: 20/12/2012 21:00
//	@file Description: Random static helis
//	@file Args:

if(!X_Server) exitWith {};

private ["_counter","_position","_markerName","_marker","_hint","_newPos","_countActual", "_i", "_doSpawnWreck"];
_counter = 0;
_countActual = 0;
_i = 0;

while {_counter < 2} do
{
	_selectedMarker = floor (random 24);
    _position = getMarkerPos format ["heliSpawn_%1", _selectedMarker];
	[0, _position] call staticHeliCreation;
    
	currentStaticHelis set [count currentStaticHelis, _selectedMarker];

    _counter = _counter + 1;
    _countActual = _countActual + 1;
};

//{diag_log format["Heli %1 = %2",_forEachIndex, _x];} forEach currentStaticHelis;

for "_i" from 1 to 2 do {
    _doSpawnWreck = true;
    
    { // Check if current iteration already exists as a live heli...
    	if (_i == _x) then {
			_doSpawnWreck = false;
        };
    } forEach currentStaticHelis;
    
    if (_doSpawnWreck) then {
    	_position = getMarkerPos format ["heliSpawn_%1", _i];
		[1, _position] call staticHeliCreation;
    };
};

diag_log format["WASTELAND SERVER - %1 Static helis Spawned",_countActual];