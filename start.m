function start
%% Start Starts simulator of space objects
%   Starts simulator and creates GUI.
    
%%  Load orbit elements and specifitations of space objects
    [objects,names,selected,colors,lineStyle] = loadObjects('objectsinfo.txt');

%%  Creating GUI of app
    r = groot;
    monitor = r.ScreenSize(3:end);
    backgroundCol = [0.95, 0.95, 0.95];
    spaceCol = [0, 0, 0];
    fig = figure('units','pixels','Name','Space objects'' orbit simulator','Position',...
                [monitor(1)/6, monitor(2)/8,2*monitor(1)/3,4*monitor(2)/6],'Tag','simulator', ...
                'Color', spaceCol, 'NumberTitle', 'off','KeyPressFcn',@keyControl);
    fig.CloseRequestFcn = @closeAction;        
% app data
    setappdata(fig,'objects',objects);
    setappdata(fig,'backgroundCol',backgroundCol);
    setappdata(fig,'spaceCol',spaceCol);
    setappdata(fig,'selected',selected);
    setappdata(fig,'names',names);
    setappdata(fig,'colors',colors);
    setappdata(fig,'lineStyle',lineStyle);

% radio button to change color of background
    figColor = uicontrol(fig, 'Units','Normalized', ...
                        'Position',[0.62 0.94 0.12 0.03], ...
                       'Style','check', 'String','Black background', 'Tag','figColor', ...
                       'BackgroundColor',backgroundCol,'TooltipString', 'Change color of background', ...
                       'Value',1); 
    figColor.Callback = @changeColor;
% panel with set time ui   
    timePanel = uipanel('Units', 'normalized', 'Position', [0.75 0.85 0.225 0.15],...
                        'BackgroundColor', backgroundCol, 'BorderType','none',...
                        'Tag', 'timePanel');
    
            uicontrol(timePanel, 'Style', 'text', 'Units', 'normalized', 'Position',...
                      [0.2 0.5 0.6 0.35], 'String', 'Set Date', ...
                      'FontSize',12,'FontWeight','bold','BackgroundColor', backgroundCol);


            uicontrol(timePanel, 'Style', 'text','String', 'Date:',...
                      'Units', 'normalized','Position', [0 0.4 0.3 0.2], 'Tag', 'timeLabel',...
                      'FontSize',12,'FontWeight','bold','BackgroundColor', backgroundCol);

            uicontrol(timePanel, 'Style', 'text','String', '',...
                      'Units', 'normalized','Position', [0.3 0.4 0.5 0.2], 'Tag', 'timeText',...
                      'FontSize',12,'FontWeight','default','BackgroundColor', backgroundCol);                        

            day = uicontrol(timePanel,'Style', 'popup','Units', 'normalized','Position', [0.05 0.1 0.25 0.2],...
                           'String', {1:31}, 'Tag', 'day','Value',1,'Callback',@checkDate);

            month = uicontrol(timePanel,'Style', 'popup','Units', 'normalized','Position', [0.35 0.1 0.3 0.2],...
                      'String', {'January','February','March','April','May','June', ...
                      'July','August','September','October','November','December'}, 'Tag', 'month',...
                      'Value',1,'Callback',@checkDate);

            year = uicontrol(timePanel,'Style', 'popup','Units', 'normalized','Position', [0.7 0.1 0.25 0.2],...
                      'String', {1980:2030}, 'Tag', 'year', 'Value',37,'Callback',@checkDate);

% panel with set visible objects ui 
    settingsPanel = uipanel('Units', 'normalized', 'Position', [0.75 0.20 0.225 0.6508],...
                            'BackgroundColor', backgroundCol, 'BorderType','none',...
                            'tag', 'timePanel');
        
            uicontrol(settingsPanel, 'Style', 'text', 'Units', 'normalized', 'Position',...
                                [0.0 0.75 1 0.2], 'String', 'Select Space Objects', ...
                                'FontSize',12,'FontWeight','bold','BackgroundColor', backgroundCol);
                    
            n = length(names);
            col = 11;
            for k = 1:n
                % in case of 9 plus objects creates two columns 
                %of check box
                if (k < col)
                    uicontrol(settingsPanel, 'Units','Normalized', ...
                        'Position',[0.1,0.9-k/(n+4), 0.4, 1/(n+4)], ...
                       'Style','check', 'String',names{k}, 'Tag',['select',num2str(k)], ...
                       'BackgroundColor',backgroundCol,'TooltipString', 'select to vizualize', ...
                       'Value',selected(k),'Callback', @selectObject); 
                else 
                    uicontrol(settingsPanel, 'Units','Normalized',...
                        'Position',[0.5,0.9-(k-col+1)/(n+4), 0.4, 1/(n+4)], ...
                       'Style','check', 'String',names{k}, 'Tag',['select',num2str(k)], ...
                       'BackgroundColor',backgroundCol,'TooltipString', 'select to vizualize', ...
                       'Value',selected(k),'Callback', @selectObject);  
                    
                end    
                       
            end    
    
            uicontrol(settingsPanel,'Style', 'pushbutton','Units', 'normalized','Position', [0.3 0.17 0.4 0.08],...
                              'String', 'Simulate', 'Tag', 'setTimeButton','FontWeight','bold', ...
                              'CallBack', {@setDate});
            uicontrol(settingsPanel,'Style', 'pushbutton','Units', 'normalized','Position', [0.1 0.12 0.4 0.05],...
                              'String', 'Minus week', 'Tag', 'prev','CallBack', @prev);
            uicontrol(settingsPanel,'Style', 'pushbutton','Units', 'normalized','Position', [0.5 0.12 0.4 0.05],...
                              'String', 'Plus week', 'Tag', 'next','CallBack', @next);
            
% autorun simulation panel
            autoRunPanel = uipanel(settingsPanel,'Units', 'normalized', 'Position', [0 0 1 0.12],...
                            'BackgroundColor', backgroundCol, 'BorderType','none',...
                            'tag', 'autoRunPanel');
                uicontrol(autoRunPanel, 'Style', 'text', 'Units', 'normalized', 'Position',...
                                [0 0.5 0.7 0.3], 'String', 'Autorun simulation', ...
                                'FontSize',10,'FontWeight','bold','BackgroundColor', backgroundCol); 
                uicontrol(autoRunPanel,'Style', 'pushbutton','Units', 'normalized','Position', [0.1 0 0.20 0.5],...
                              'String', 'Stop', 'Tag', 'stop','CallBack', @(~,~)stopSim);
                uicontrol(autoRunPanel,'Style', 'pushbutton','Units', 'normalized','Position', [0.3 0 0.30 0.5],...
                              'String', 'Run','FontWeight','bold', 'Tag', 'autorun','CallBack', @(~,~)runSim);
                uicontrol(autoRunPanel,'Style', 'popup','Units', 'normalized','Position', [0.6 0 0.3 0.43],...
                           'String', {'day/sec','week/sec','month/sec'}, 'Tag', 'speed','Value',1);          
            
 % panel with camera settings buttons                         
    buttonsPanel = uipanel('Units', 'normalized', 'Position', [0.75 0 0.225 0.202],...
                            'BackgroundColor', backgroundCol, 'BorderType','none',...
                            'tag', 'buttonsPanel');
           
            uicontrol(buttonsPanel, 'Style', 'text', 'Units', 'normalized', 'Position',...
                                [0.05 0.64 0.9 0.2], 'String', 'Fast Camera Settings', ...
                                'FontSize',12,'FontWeight','bold','BackgroundColor', backgroundCol);           
                        
            uicontrol(buttonsPanel,'Style', 'pushbutton','Units', 'normalized','Position', [0.1 0.4 0.4 0.3],...
                              'String', 'Default view', 'Tag', 'view1','CallBack', 'view(322.5,30)');
            uicontrol(buttonsPanel,'Style', 'pushbutton','Units', 'normalized','Position', [0.5 0.4 0.4 0.3],...
                              'String', 'YZ-axis view', 'Tag', 'view2','CallBack', 'view(90,180)');
            uicontrol(buttonsPanel,'Style', 'pushbutton','Units', 'normalized','Position', [0.1 0.1 0.4 0.3],...
                              'String', 'XY-axis view', 'Tag', 'view3','CallBack', 'view(0,90)');
            uicontrol(buttonsPanel,'Style', 'pushbutton','Units', 'normalized','Position', [0.5 0.1 0.4 0.3],...
                              'String', 'XZ-axis view', 'Tag', 'view4','CallBack', 'view(0,180)');              


%% Settings of current date a diplaying it to GUI                        
    date = clock;
    day.Value = date(3);
    month.Value = date(2);
    year.Value = date(1) - 1979;
                          
%% Settings of axes                    
    axs = axes('Position',[0,0,0.7,1], 'Tag', 'axes');
    grid off;
    rotate3d on;
    view(322.5,30);
    setappdata(fig,'axes',axs);
%%  Compute and save orbits of all objects                
    orbits = calculateOrbits(objects);
    setappdata(fig,'orbits',orbits);
%% Show object's orbits     
    setDate('non','non');          
end

%% CALLBACK FUNCTIONS
%%  Check Date
%   Check and correct entered date in dependacy to month and year 
%   (e.g. 31. Feb is corrected to 28. - or 29. if year is leap). 
function checkDate(~,~)
    day = findobj('Tag','day');
    d = day.Value;
    month = findobj('Tag','month');
    m = month.Value;
    year = findobj('Tag','year');
    y = year.Value + 1979;
    
    maxDay = eomday(y,m);
    if d > maxDay
        day.Value = maxDay;
    end
end
%% Run simulation with setted date.
function setDate(~,~)
    day = findobj('Tag','day');
    d = day.Value;
    month = findobj('Tag','month');
    m = month.Value;
    year = findobj('Tag','year');
    y = year.Value + 1979;
    t = date2JD(d,m,y);
    
    text = findobj('Tag', 'timeText');
    text.String = [num2str(d),'. ',num2str(m),'. ',num2str(y)];
    
    fig = findobj('Tag', 'simulator');
    spaceObjects = getappdata(fig,'objects');
    orbits = getappdata(fig,'orbits');
    
    showOrbits(orbits);  
    showPosition(spaceObjects,t);
end
%% Run simulation with the currently setted date minus week and set new date.
function prev(~,~)
    day = findobj('Tag','day');
    d = day.Value;
    month = findobj('Tag','month');
    m = month.Value;
    year = findobj('Tag','year');
    y = year.Value + 1979;
    t0 = date2JD(d,m,y);
    
    step = 7;
    t = t0 - step;
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
end
%% Run simulation with the currently setted date plus week and set new date.
function next(~,~)
    day = findobj('Tag','day');
    d = day.Value;
    month = findobj('Tag','month');
    m = month.Value;
    year = findobj('Tag','year');
    y = year.Value + 1979;
    t0 = date2JD(d,m,y);
    
    step = 7;
    t = t0 + step;
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
end
%% Changed vector of selected object if checkbox is changed.
function selectObject(scr, ~)
    fig = findobj('Tag', 'simulator');
    selected = getappdata(fig,'selected');
    id = scr.Tag(7:end);
    selected(str2double(id)) = scr.Value;
    setappdata(fig,'selected', selected);
end
%% Change color of background
function changeColor(scr,~)
    fig = findobj('Tag', 'simulator');
    spaceCol = getappdata(fig,'spaceCol');
    backgroundCol = getappdata(fig,'backgroundCol');
    if scr.Value == 0
        fig.Color = backgroundCol;
    else
        fig.Color = spaceCol;
    end
end
%% Close action of simulator
function closeAction(scr, ~)
    stopSim;
    delete(scr);
end
