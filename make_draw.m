function make_draw(filename,vertices_cell,faces_cell,eje)
    
    if ~iscell(vertices_cell)
        vertices_cell = {vertices_cell};
    end
    if ~iscell(faces_cell)
        faces_cell = {faces_cell};
    end
    assert(length(vertices_cell) == length(faces_cell), 'The number of vertices and faces must be the same');
    
    if nargin < 4
        vv = [vertices_cell{:}];
        mini = min(vv(1:2,:),[],2);
        width = max(vv(2,:)) - min(vv(2,:));
        width = max(1e-8,width);
    else
        mini = eje([1,3])';
        width = eje(4)-eje(3);
    end
    
    dashed_lines = [];
    for icell = 1:length(vertices_cell)
        if size(faces_cell{icell},1) == 2
            dashed_lines = faces_cell{icell}(1,:);
        end
    end
    
    fileID = fopen([filename,'.txt'],'w');
    fprintf(fileID,'\\begin{tikzpicture}\n');
    if nargin>=4
        eje = (eje-mini([1,1,2,2])')/width;
        fprintf(fileID,'\\clip (0,0) rectangle + (%f,%f);\n',eje(2)-eje(1),eje(4)-eje(3));
    end
    
    for icell = 1:length(vertices_cell)
        vertices = vertices_cell{icell};
        faces = faces_cell{icell};
        
        vertices = vertices(1:2,:);
        vertices = (vertices-mini)/width;
        
        if iscell(faces) % then, they are labels
            for i=1:length(faces)
                vertices(:,i) = vertices(:,i) + [faces{i}{2}]';
                fprintf(fileID,'\\node[scale=0.2] at (%f,%f) {%s};\n',vertices(1,i),vertices(2,i),faces{i}{1});
            end
            continue;
        end
        
        if size(faces,1) == 3
            order = [1:size(faces,1),1];
            edges = '\\draw[line width=0.05mm,   black] (%f,%f) -- (%f,%f);\n';
            for i=1:size(faces,2)
                for j=1:size(faces,1)
                    fprintf(fileID,edges,...
                    vertices(1,faces(order(j),i)),...
                    vertices(2,faces(order(j),i)),...
                    vertices(1,faces(order(j+1),i)),...
                    vertices(2,faces(order(j+1),i)));
                end
            end
        elseif size(faces,1) == 2
            dashed_lines = faces;
            edges = '\\draw[densely dotted, line width=0.05mm,   black] (%f,%f) -- (%f,%f);\n';
            for i=1:size(faces,2)
                fprintf(fileID,edges,...
                vertices(1,faces(1,i)),...
                vertices(2,faces(1,i)),...
                vertices(1,faces(2,i)),...
                vertices(2,faces(2,i)));
            end
        end
        points_black = '\\filldraw[black] (%f,%f) circle (0.1pt);\n';
        points_red = '\\filldraw[red] (%f,%f) circle (0.1pt);\n';
        for i=1:size(vertices,2)
            if ismember(i,dashed_lines)
                fprintf(fileID,points_black,...
                vertices(1,i),vertices(2,i));
            else
                fprintf(fileID,points_red,...
                vertices(1,i),vertices(2,i));
            end
        end
    end
    
    fprintf(fileID,'\\end{tikzpicture}');
    fclose(fileID);