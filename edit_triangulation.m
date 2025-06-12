function [vertices,faces] = edit_triangulation(vertices,faces)
% edit_triangulation: allows to create and edit a triangulation interactively
% Usage:
%   [vertices,faces] = edit_triangulation(vertices,faces)
%   If vertices and faces are not provided, a default triangle is created.
%   Left-click on an empty space to add a vertex, left-click near a vertex to remove it, and right-click on three vertices to create a face.
%   The function returns the updated vertices and faces.

    if nargin<2
        vertices = [0 0 0
        1 1 0
        0 1 0]';
        faces = [1 2 3]';
    end
    
    close all;
    f=figure(1);
    plot3(vertices(1,:),vertices(2,:),vertices(3,:)+1,'o','LineWidth',2);
    hold on;
    plotMesh(vertices,faces)
    width = [max(vertices(1,:))-min(vertices(1,:)),max(vertices(2,:))-min(vertices(2,:))];
    limites = [min(vertices(1,:))-0.5*width(1),max(vertices(1,:))+0.5*width(1),min(vertices(2,:))-0.5*width(2),max(vertices(2,:))+0.5*width(2)];
    axis(limites);
    view([0,90]);
    
    set(f,'WindowButtonDownFcn', @alPulsar)
    uiwait(f);
    
    function dist = distance(vertices,p)
        dist = sum((vertices(1:2,:) - p(1:2)).^2,1);
    end
    
    function alPulsar(src,~)
        persistent p_der
        tipo = strcmp(src.SelectionType,'normal');
        pt = get(gca,'CurrentPoint');
        p = pt(1,1:2)';
        dist = distance(vertices,p);
        [dist3,ind] = mink(dist,3);
        if tipo
            p_der = [];
        end
        if tipo && dist3(1)<0.1*dist3(2)
            bool = any(faces == ind(1),1);
            vertices(:,ind(1)) = [];
            faces(:,bool) = [];
            bool = faces > ind(1);
            faces(bool) = faces(bool) - 1;
        elseif tipo
            vertices(:,end+1) = vertices(:,ind(1));
            vertices(1:2,end) = p; 
        elseif ~tipo && dist3(1)<0.1*dist3(2) % && distance(mean(vertices(:,ind),2),p) < 0.1*distance(vertices(:,ind(1)),vertices(:,ind(2)))
            p_der(end+1) = ind(1);
            if size(p_der,2)>=3
                if size(faces,2)<3
                    faces(:,end+1) = p_der;
                else
                    ind = sort(p_der)';
                    faces_sort = sort(faces,1);
                    bool = all(faces_sort == ind,1);
                    if any(bool)
                        faces(:,bool) = [];
                    else
                        faces(:,end+1) = p_der;
                    end
                end
                p_der = [];
            end
        end
        
        clf;
        hold on;
        plot3(vertices(1,:),vertices(2,:),vertices(3,:)+1,'ob','LineWidth',2);
        plot3(vertices(1,p_der),vertices(2,p_der),vertices(3,p_der)+1,'*r','LineWidth',2);
        plotMesh(vertices,faces)
        limites = [min(vertices(1,:))-0.5*width(1),max(vertices(1,:))+0.5*width(1),min(vertices(2,:))-0.5*width(2),max(vertices(2,:))+0.5*width(2)];
        axis(limites);
        view([0,90]);
        axis equal;
        axis off;
        drawnow;
    end
    
    
end