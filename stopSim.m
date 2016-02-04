function stopSim
%%  Stop autorun
%   function stops timer of autorun simulation
    fig = findobj('Tag', 'simulator');
    try
        tim = getappdata(fig,'autorunTimer');
        stop(tim);
        delete(tim);
    catch   
    end    
end

