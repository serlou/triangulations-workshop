function [V, F] = B111Subdivision(vertices, faces)
    vertices_update = zeros(size(vertices));
    newFaces = zeros(3, length(faces) * 4);
    countNewF = 0;
    newVertices = zeros(3, (length(vertices)^2));
    newVMatrix = zeros(length(vertices), length(vertices));
    countNewV = 0;
    countInitialV = length(vertices);
    [v_connections, v_degrees] = ButterflyPreprocessing(faces, length(vertices));
    
    order = [
    1 2 3
    3 1 2
    2 3 1];
    
    for f = 1 : size(faces,2)
        counter_temp = countNewF;
        v_new = zeros(1,3);
        for i= 1:3
            v(1) = faces(order(i,1), f);
            v(2) = faces(order(i,2), f);
            v(3) = faces(order(i,3), f);
            
            if newVMatrix(v(1), v(2)) == 0
                q = CalculateNewVertex(v, vertices);
                countNewV = countNewV + 1;
                newVertices( :, countNewV) = q;
                newVMatrix(v(1), v(2)) = countNewV;
                newVMatrix(v(2), v(1)) = countNewV;
                v_new(i) = countNewV;
                % update vertices
                vertices_update(:,v(1)) = vertices(:,v(1));
                vertices_update(:,v(2)) = vertices(:,v(2));
            else
                v_new(i) = newVMatrix(v(1), v(2));
            end
        end
        if all(v_new~=0)
            countNewF = countNewF + 1;
            newFaces(1, countNewF) = v(1);
            newFaces(2, countNewF) = v_new(1) + countInitialV;
            newFaces(3, countNewF) = v_new(3) + countInitialV;
            
            countNewF = countNewF + 1;
            newFaces(1, countNewF) = v(2);
            newFaces(2, countNewF) = v_new(2) + countInitialV;
            newFaces(3, countNewF) = v_new(3) + countInitialV;
            
            countNewF = countNewF + 1;
            newFaces(1, countNewF) = v(3);
            newFaces(2, countNewF) = v_new(1) + countInitialV;
            newFaces(3, countNewF) = v_new(2) + countInitialV;
            
            countNewF = countNewF + 1;
            newFaces(1, countNewF) = v_new(1) + countInitialV;
            newFaces(2, countNewF) = v_new(2) + countInitialV;
            newFaces(3, countNewF) = v_new(3) + countInitialV;
        end
    end
    
    newVertices(:, countNewV + 1 :end) = [];
    newFaces(:, countNewF + 1 :end) = [];
    V = [vertices_update newVertices];
    F = newFaces;
end

%returns an index
function p_Ext = GiveMeExtP(v, v_connections)
    if (v_connections(v(1),v(2)) == v(3))
        p_Ext = v_connections(v(2),v(1));
    else
        p_Ext = v_connections(v(1),v(2));
    end
end

%returns a vector [x, y, z]
function q = CalculateNewVertex(v, vertices)
    q = mean(vertices(:,v(1:2)),2);
end

function [v_connections, v_degrees] = ButterflyPreprocessing(faces, lengthVert)
    v_connections = zeros(lengthVert);
    v_degrees = zeros(1,lengthVert);
    
    for f = 1: size(faces,2)
        v(1) = faces(1, f);
        v(2) = faces(2, f);
        v(3) = faces(3, f);
        for i= 1:3
            if(v_connections(v(1), v(2)) == v(3) || v_connections(v(2), v(1)) == v(3))
                temp = v(3);
                v(3) = v(2);
                v(2) = v(1);
                v(1) = temp;
                continue % this is posible a
            end
            if(v_connections(v(1), v(2)) == 0 && v_connections(v(2), v(1)) == 0)
                v_connections(v(1), v(2)) = v(3);
                v_degrees(v(1)) = v_degrees(v(1)) + 1;
                v_degrees(v(2)) = v_degrees(v(2)) + 1;
            elseif(v_connections(v(1), v(2)) == 0)
                v_connections(v(1),v(2)) = v(3);
            else
                v_connections(v(2),v(1)) = v(3);
            end
            temp = v(3);
            v(3) = v(2);
            v(2) = v(1);
            v(1) = temp;
        end
    end
end

function neigh = find_neighbours(v, v_connections,syme)
    
    
    if nargin<3
        syme = true;
    end
    neigh = [v(2),v(3),v(4)];
    vlast1 = v(3);
    vlast2 = v(5);
    while v(6) ~= vlast2 && vlast2 ~= 0
        neigh(end+1) = vlast2;
        tmp = vlast2;
        vlast2 = GiveMeExtP([v(1), vlast2, vlast1], v_connections);
        vlast1 = tmp;
    end
    neigh(end+1) = v(6);
    if syme
        neigh = [neigh, find_neighbours(v([1,2,4,3,5:end]), v_connections,false) ];
    end
    neigh = unique(neigh);
end