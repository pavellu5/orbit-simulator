function autorunSim(~,~)
%% AutorunSim - run simulation automaticly
%   callback function for timer to run simulation automaticly
%   simulation runs to the last date and then stop
    day = findobj('Tag','day');
    d = day.Value;
    month = findobj('Tag','month');
    m = month.Value;
    year = findobj('Tag','year');
    y = year.Value + 1979;
    t0 = date2JD(d,m,y);
    
    speed = findobj('Tag','speed');
    sp = speed.Value;
    switch sp
        case 1
            step = 1;
        case 2
            step = 7;
        case 3
            step = 30;
        otherwise
           step = 1;  
    end
    t = t0 + step;
    if t < 2462867.5
        [newD,newM,newY] = JD2date(t);
        text = findobj('Tag', 'timeText');
        text.String = [num2str(newD),'. ',num2str(newM),'. ',num2str(newY)];
        day.Value = newD;
        month.Value = newM;
        year.Value = newY-1979;

        fig = findobj('Tag', 'simulator');
        spaceObjects = getappdata(fig,'objects');
        orbits = getappdata(fig,'orbits');

        showOrbits(orbits);  
        showPosition(spaceObjects,t);
    else
        disp('end of sumulation');
        stopSim;
    end
    
end

