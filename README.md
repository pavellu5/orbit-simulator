##Matlab Orbit Simulator
Orbit simulator allow you to simulate orbits and positions of space objects
in solar system at specific time. Positions of all objects are cumputed
from orbital elements. Simulator loads data from external txt file
which allows to add new objects (object must be orbiting the Sun).
Orbit simulator is written in matlab.

###How to add new objects
To add a new object just insert six orbital elements, orbit period
and some aditional settings (like color and style of orbit line)
to file *objectsinfo.txt*.

**Format of data in file:**
* name
* orbital elements (all 6 in 1 line - separeted with space)
 * semi-major axis [AU]
 * Excentricity [deg]
 * Inclination [deg]
 * Longitude of ascending node [deg]
 * Longitude of perihelion [deg]
 * Mean Longitude [deg]
* orbital period [days]
* show planet on startup (1-yes; 0-no)
* color of orbit line (in matlab RGB)
* style of orbit line (- or -- or : or -.)
* %%% (data of one objects endings)

**Example - Earth**  
Earth  
1.00000011 0.01671022 0.00005 -11.26064 102.94719 100.46435  
365.2  
1  
0 0 1  
\-  
%%%  
