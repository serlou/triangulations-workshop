function make_projected_figure(filename, vertices, faces, varargin)
    
    v_floor = vertices;
    v_floor(3,:) = 0;
    
    caz = 25;
    cel = 65;
    
    % get the 2D coordinates associated with the 3D coordinates of the vertices.
    vertices = project3Dto2D(vertices,caz,cel);
    vertices(3,:) = 0;
    v_floor = project3Dto2D(v_floor,caz,cel);
    v_floor(3,:) = 0;
    
    vertices_lines = [vertices,v_floor];
    faces_lines = [1:size(vertices,2); size(vertices,2)+1:2*size(vertices,2)];
    
    vertices_label = [vertices(:,2), v_floor(:,2), 0.6*vertices(:,2)+0.4*v_floor(:,2)];
    vertices_label(3,:) = 0;

    dashed_lines = [];
    if nargin >= 4
        dashed_lines = varargin{1};
    end
    
    faces_label = {};
    % Set faces_label based on input
    if nargin >= 5
        faces_label = varargin{2};
    end
    
    % Pass the actual label text and positions to make_figure
    make_figure(vertices, faces, v_floor, dashed_lines, faces_label);
    
    make_draw(filename,{vertices,v_floor,vertices_lines, vertices_label},{faces,faces,faces_lines(:,dashed_lines), faces_label});
end