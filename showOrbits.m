function showOrbits(orbits)
%%  ShowOrbits plots orbits of all selected objects
%
%   orbits ... data of all objects orbits

% save previous view elevation and azimut
    [az,el] = view;
    hold off
    
% display Sun      
    plot3(0,0,0,'o','MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
    hold on;
  	
    fig = findobj('Tag', 'simulator');
    backgroundCol = getappdata(fig,'backgroundCol');
    selected = getappdata(fig,'selected');
    colors = getappdata(fig,'colors');
    style = getappdata(fig,'lineStyle');
    for k = 1:length(orbits)
        if selected(k) == 1
            col = colors{k};
            sty = style{k};
            plot3(orbits{k}{1},orbits{k}{2},orbits{k}{3},'Color',col,'LineWidth',0.75,'LineStyle',sty);
        end
    end
    %ax = gca;
    ax = getappdata(fig,'axes');
    ax.Color = backgroundCol;
    axis(ax,'equal');
    ax.Visible = 'off';
    view(az,el);

% create legend
    allNames = getappdata(fig,'names');
    names = allNames(nonzeros(selected.*(1:length(selected))));
    legend(['Sun',names],'Location', 'northwest')
end
