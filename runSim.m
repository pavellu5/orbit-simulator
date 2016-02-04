function runSim
%%  Autorun simulation
%   function sets and start timer to autorun simulation

%   stops cuurent simulation
    stopSim;
    tim = timer;
    tim.Tag = 'autorunTimer';
    tim.ExecutionMode = 'fixedRate';
    tim.TimerFcn = @autorunSim;
    tim.Period = 1;
    
    fig = findobj('Tag', 'simulator');
    setappdata(fig,'autorunTimer', tim);
    start(tim);
end
