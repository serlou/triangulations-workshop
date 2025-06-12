function make_figure(vertices, faces, v_floor, dashed_lines, labels)
    figure;
    hold on;
    plotMesh(vertices,faces,3);
    plotMesh(v_floor,faces,3);
    view([0,90])

    % show dots at the vertices
    vv = 1:size(vertices,2);
    % remove dashed_lines from vv
    vv(dashed_lines) = [];
    plot(vertices(1,vv),vertices(2,vv),'r.','MarkerSize',20);
    plot(v_floor(1,vv),v_floor(2,vv),'r.','MarkerSize',20);
    plot(vertices(1,dashed_lines),vertices(2,dashed_lines),'k.','MarkerSize',20);
    plot(v_floor(1,dashed_lines),v_floor(2,dashed_lines),'k.','MarkerSize',20);


    % dashed lines connecting the vertices with the floor
    for i = dashed_lines
        plot([vertices(1,i),v_floor(1,i)],[vertices(2,i),v_floor(2,i)],'k--');
    end
    
    if ~isempty(labels)
        % Process labels to remove $ symbols for display in figure
        plain_labels = cell(size(labels));
        for i = 1:length(labels)
            label_text = labels{i}{1};
            % Remove $ symbols for plain text display
            plain_text = strrep(label_text, '$', '');
            plain_labels{i} = {plain_text, labels{i}{2}};
        end
        
        % Use processed labels without $ symbols
        % label for vertex point (index 1)
        text(1.05*vertices(1,2),0.95*vertices(2,2),plain_labels{1}{1});
        
        % label for floor point (index 2)
        text(1.05*v_floor(1,2),1.05*v_floor(2,2),0,plain_labels{2}{1});
        
        % label for line between points (index 3)
        text(0.52*(vertices(1,2)+v_floor(1,2)),0.52*(vertices(2,2)+v_floor(2,2)),plain_labels{3}{1});
        axis equal;
    end
end