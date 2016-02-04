function showPosition(objects,time)
%%  ShowPosition plots positions of all selected objects in specified time
%
%   orbits ... data of all objects orbits
%   time ... specified time in Julian Date[JD]
    fig = findobj('Tag', 'simulator');
    selected = getappdata(fig,'selected');
    colors = getappdata(fig,'colors');
    for k = 1:length(objects)
        if selected(k) == 1
            elements = objects{k}{1};
            [x,y,z] = simulator(elements,time);
            col = colors{k};
            plot3(x,y,z,'o','Color',col,'MarkerEdgeColor',col,'MarkerFaceColor',col);
        end    
    end 

end

