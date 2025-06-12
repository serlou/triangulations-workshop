function plotMesh(vertices, faces,op)
    vertices=double(vertices);
    hold on;
    if nargin < 3
        op = 1;
    end
    switch op
        case 1
            s=trisurf(faces', vertices(1,:), vertices(2,:), vertices(3,:));
%             light('Position',[1 1 1])
%             s.EdgeColor = 'none';
            s.EdgeColor = [0,0,0];
            s.FaceColor = 'interp';
            s.LineWidth = 2;
%             colormap gray(1);
            colormap default
        case 2
            trimesh(faces', vertices(1,:), vertices(2,:), vertices(3,:));
            colormap default
            %     colormap gray(1);
        case 3 % transparent faces
            s = trisurf(faces', vertices(1,:), vertices(2,:), vertices(3,:));
            s.EdgeColor = [0,0,0];
            s.LineWidth = 2;
            s.FaceColor = 'none';
    end
    axis tight;
    axis square;
    axis off;
%     axis equal;
    view(3);
end