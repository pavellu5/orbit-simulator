function orbits = calculateOrbits(objects)
%% CalculateOrbits - calculate orbit coordinates for all objects
%   Calculate coordinates of orbits for all objects.
%
%   objects ... cell of object's orbits elements and orbital period
%               format - {{[1.object's elements],orbital period 1},{..},...}    
%   orbits ... output cell of object's  orbits - cartesian coordinates for one period
%              format - {{[vector of x coors],[y coord],[z coords]},{[x],[y],[z]},...}
    for k = 1:length(objects)
        elements = objects{k}{1};
        t0 = 2451545.0;
        t = objects{k}{2};
        if t < 60000
            step = 3;
        elseif t < 120000
            step = 30;
        else
            step = 500;
        end   
        epoch = t0:step:t0+t+t/2;
        [x,y,z] = simulator(elements,epoch);
        xOrbit = x;
        yOrbit = y;
        zOrbit = z;
        orbits{k} = {xOrbit,yOrbit,zOrbit};
    end 

end

