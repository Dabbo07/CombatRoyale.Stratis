player createDiaryRecord ["Diary", 
["Combat Royale MP",
format["Welcome to Combat Royale MP %1<br/>
<br/>
Multiplayer DeathMatch, Hunt and Survive!<br/>
<br/>
Each player will spawn into the world with a single (random) gun, and in free fall from 1000 meters.  You
will have a parachute which you can choose when to deploy.  Dangers are all around you from other enermy AI
players as well as any other human players on the same server.  You can kill to get better weapons or hunt down
1 of 3 crates spawned randomily on the map.  They'll be paradropped initially and thier rough location marked
on the map by a purple circle.  There are also random bombings, vehicles for fast transport around the island
and each zone is likely to become restricted over time (red areas) whereby you'll be bombed directly if you enter
these red zones!<br/>
<br/>
CRATES<br/>
<br/>
There are 3 randomily spawned crates to find. Their estimated position is marked on the map by a purple circle. There
is also a special ammo crate that is always located on the airfield runway.  When the 3 random crates time has expired,
they'll explode killing anyone foolish enough to be near them!  All items are randomized as follows:<br/>
<br/>
- 1-3 random weapons with 1-2 magazines each<br/>
- 0-2 random magazines<br/>
- 55%% chance of Medkit<br/>
- 10%% chance of Binoculars<br/>
- 2%% chance of Night Vision Goggles<br/>
- 15%% chance of GPS Device<br/>
- 1-4 random items (clothes, helmets, attachments, equipment)<br/>
- 40%% change of a random backpack<br/>
<br/>
ZONES<br/>
<br/>
There are 41 zones, 1 blue (safe zone) and the others will change state from green, yellow and red.  Green and Yellow
zones are safe to traverse.  However, red zones are dangerous and entering them will result in being killed by bombs until
you exit the red zone.  Over time these zones will turn red, except form the safe, blue zone.  The game will end once there are
less than 3 zones remaining.<br/>
<br/>
ARTILLERY<br/>
<br/>
Artillary bombs will be randomily dropped throughout the island to add danger to all players.  The odds of being hit by them
is pretty low, however as the zones become red over time, the chances of being hit should increase!<br/>
<br/>
PLAYER TRACKING<br/>
<br/>
All AI Players and Human players are tracked and regular intervals. You will recieve an onscreen message when the map has been updated.
Blue dots represent AI players and pink are human players.  AI players will only be able to hunt each other/humans by last known position
or if they have visually spotted you.<br/>
<br/>
Have fun and happy hunting!
", VERSION]]];
player createDiaryRecord ["Diary", 
["Credits",
"Mission Design and Scripts created by Darren 'Dabbo' Edmonds.<br/>
<br/>
Twitter: www.twitter.com/Dabbo07<br/>
<br/>
Changed mission file from Battle Royale to Combat Royale to avoid confusion
with popular mod DayZ Battle Royale, http://dayzbattleroyale.com made by PlayerUnknown<br/>
<br/>
- Version History -<br/>
v1.0	- Initial Build, Conversion from Arma 2 version.<br/>
v1.1	- Special Arms Crate setup, reduced zone creep from 25sec to 15sec.<br/>
v1.2	- Removed sone zone bugs, random number bugs, mission parameters added.<br/>
v1.3	- Bugs fixed, zone permimeter warnings working, extra mission parameters added, vehcicles added, tweaked settings, added addAction to allow
player to check the zone ID they are in and status.<br/>
v1.4	- Increase vehicle count from 8 - 12, 4 offroads. Adjusted spawn zones to map size and added random placement parameter for host.<br/>
v1.4.5	- Added zone id for map reference. Crate zone marker instead of exact position on map, size of zone adjustable by host. First pass of 
AI opponents, disabled by default - upto AI players. Just rifle, 2 clips and hunt - no crate hunting or weapon upgrading yet. Various UI tweeks for player messages.<br/>
v1.4.6	- Made all crates indestructable, fixing a bug where destroyed crates couldn't be used (interaction broken). Added option to set cars to destructable or not 
(players can still be killed on them) with the default option being indestructable.<br/>
v1.4.20 - UI Components added. GPS item reference fixed.
"]];
	