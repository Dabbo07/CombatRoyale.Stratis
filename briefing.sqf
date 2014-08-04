player createDiaryRecord ["Diary", 
["How to play",
format["
<img image='LoadingImage.jpg' width='400'/><br/>
Welcome to Combat Royale MP %1<br/>
<br/>
The aim of this game mode is to find other players (or AI units) and kill them. Other players will be doing the same so you will need to keep 
an eye on their positions as you move through the map. You will always spawn in with a random weapon and 1 magazine into a
halo drop.<br/>
<br/>
- ITEM CRATES -<br/>
<img image='crate.jpg'/><br/>
You can locate weapons/gear by finding randomly spawned crates around the map, usually every 5 minutes 
(Host may change this value).  Their location is tracked on the map with an estimated location (red circle):<br/>
<img image='crateMarker.jpg'/><br/>
Inside each crate you will find random items; weapons, bags, clothing, health kits etc.  All randomised
every time they spawn.  Be on the look out for other players that maybe camping out for unsuspecting players!
Time between crate spawns will be displayed at the top of your screen.  Note that when the crate spawn timer reaches
zero it'll explode.  It will kill you if you are too close to it!<br/>
<br/>
Crate Contents:<br/>
- 1-3 random weapons with 1-2 magazines each<br/>
- 0-2 random magazines<br/>
- 55&#37; chance of Medkit<br/>
- 10&#37; chance of Binoculars<br/>
- 2&#37; chance of Night Vision Goggles<br/>
- 15&#37; chance of GPS Device<br/>
- 1-4 random items (clothes, helmets, attachments, equipment)<br/>
- 40&#37; change of a random backpack<br/>
<br/>
- PLAYER TRACKING -<br/>
<img image='markers.jpg' width='400'/><br/>
Player and AI unit positions are updated every 4 minutes (Host defined), player positions will be pink and AI units will be in blue. Note
that AI units will hunt the nearest marker (including AI). Vehicles are updated on the map every second, so be aware that you position will be given
away as you use transport. If you are 1 of the top 3 players on the server, you will be 'marked for death' which results in a yellow skull revealing your position
every second, so there will be no place to hide!<br/>
<br/>
- ZONES -<br/>
<img image='zones.jpg' width='400'/><br/>
Zones are coloured from blue, green, yellow and red.  Red zones are lethal and will result in localised bombing (grenades), you could 
survive by driving through but you are unlikely to run through a red zone.  Green zones are safe, but will eventually turn yellow over time.
Yellow zones are due to turn Red shortly and you must evacuate as soon as possible.  Blue zone, there is only one on the map and this zone does not
degrade - it's a 'safe zone' but be prepared to see other players trying to get to a safe zone too!<br/>
<br/>
The status of each zone will be revealed to you  as you enter the zone.  The UI label of the top of the screen will reveal your current zone
location and it's current decay state.<br/>
<br/>
- RANDOM ZONE BOMBING -<br/>
<img image='bombing.jpg'/><br/>
Random bombs will fall from the sky at random zones around the map.  The odds of them hitting you are quite rare unless the Host increases the
interval between spawns. These will add to the tension to the map.<br/>
", VERSION]]];
player createDiaryRecord ["Diary", 
["Credits",
"Mission Design and Scripts created by Darren 'Dabbo' Edmonds.<br/>
<br/>
Twitter: www.twitter.com/Dabbo07<br/>
<br/>
Changed name of game mode from 'Battle Royale' to 'Combat Royale' to avoid confusion
with popular mod DayZ Battle Royale, http://dayzbattleroyale.com made by PlayerUnknown<br/>
<br/>
A very BIG thank you to the Gaming Republic community for their support and hosting of this game mode.<br/>
<rr/>
Also thank you to the 25th ARIAG (GEN M. Brown) community for hosting and providing lots of feedback on the
mission features.<br/>
<br/>
Finally, thank you for playing and I hope you enjoyed my loose interpretation of the Battle Royale (the movie).
"]];
	