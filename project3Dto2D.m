function [vertices2D] = project3Dto2D(vertices, caz, cel)
    % PROJECT3DTO2D Projects 3D vertices to 2D coordinates based on azimuth and elevation angles.
    %   vertices: Nx3 matrix of 3D coordinates
    %   caz: azimuth angle in degrees
    %   cel: elevation angle in degrees
    %   vertices2D: Nx2 matrix of 2D coordinates

    % Convert angles from degrees to radians
    caz = deg2rad(-caz);
    cel = deg2rad(cel);

    % Rotation matrix for azimuth
    Rz = [cos(caz) -sin(caz) 0;
          sin(caz)  cos(caz) 0;
          0         0        1];

    % Rotation matrix for elevation
    Rx = [1 0          0;
          0 cos(cel) -sin(cel);
          0 sin(cel)  cos(cel)];

    % Combined rotation matrix
    R = Rx * Rz;

    % Apply rotation to vertices
    vertices2D = (R * vertices);
    vertices2D = vertices2D([1,3],:);
end