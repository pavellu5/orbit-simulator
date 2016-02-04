function [objects,names, selected,colors,lineStyle] = loadObjects(filePath)
%%  LoadObjects loads space object's data from file
%   filepath ... path to file with data
%
%   objects ... output - cell with orbital elements and orbit period 
%               of all objects
%   names ... output - cell with names of all objects
%   selected ... output - vector with binary information of selection
%                whether view object at the start of app
%   color ... output - cell with rgb colors of planets orbits 
%             and planets itself
%   lineStyle ... output - cell of line styles of orbits

    fid = fopen(filePath);
% skip comments    
    for k = 1:10
        fgetl(fid);
    end
%load data    
    index = 1;
    while ~feof(fid)
        
        name = fgetl(fid);
        names{index} = name;
        
        line = fgetl(fid);
        elements = str2num(line);
        objects{index}{1} = elements;
        
        line = fgetl(fid);
        period = str2num(line);
        objects{index}{2} = period;
        
        line = fgetl(fid);
        isSelected = str2num(line);
        selected(index) = isSelected;
        
        line = fgetl(fid);
        color = str2num(line);
        colors{index} = color;
        
        style = fgetl(fid);
        lineStyle{index} = style;
        
        index = index + 1;
        fgetl(fid);
    end
    fclose(fid);
end

