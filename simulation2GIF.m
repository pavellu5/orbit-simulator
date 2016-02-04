function simulation2GIF
%%  Simulation2GIF create gif from running simulation
%   Run this script during autorun simulation to make gif of simulation.

    tim = timer;
    tim.ExecutionMode = 'fixedRate';
    tim.TimerFcn = @takePic;
    tim.Period = 1;
    tim.TasksToExecute = 13;
    tim.UserData = 1;
    start(tim);
end

function takePic(scr,~)
    filename = 'test.gif';
          n = scr.UserData;
          frame = getframe(1);
          im = frame2im(frame);
          [imind,cm] = rgb2ind(im,256);
          if n == 1;
              imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
          else
              imwrite(imind,cm,filename,'gif','WriteMode','append');
          end
          scr.UserData = n+1;
end