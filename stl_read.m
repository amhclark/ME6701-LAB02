function [F V]=stl_read(filename)
%filename='sprocket.stl'   %the name of the file 

fid=fopen(filename, 'r');   % this command opens a file. fid points to the file
                            % the first in put is filename, 
                            % the second input specifies the file permision (read)
                            % type "help fopen for a complete desciption of the command"

if fid == -1               % fid is -1 if we cannot open
    error('File could not be opened, check name or path.')
    % this command stops the program and prints an error message
end

facet_index=0;    % this counts the faces
vertex_index=0;   % this counts the vertices
facev_count=0;    % this counts the vertices in a face
while feof(fid) == 0
    tline = fgetl(fid);               %gets the next line in the text file
    nospace = sscanf(tline, '%s');    %scans the whole line 
    if strcmp(nospace(1:5),'facet')   %identifies the start of new face
        facet_index=facet_index+1;
    end
    if strcmp(nospace(1:5),'endfa')   %identifies the end of current face
        facev_count=0;
    end
    if strcmp(nospace(1:5),'verte')   %identifies the each vertex
        vertex_index =vertex_index+1;
        facev_count=facev_count+1;
        V(vertex_index,:) = sscanf(tline,'%*s %f %f %f'); %sscanf reads the formatted string
        F(facet_index,facev_count) = vertex_index;        % fill the face list
    end
end

fclose(fid);                      % closes the file
end