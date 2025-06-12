clear; close all;
rng(1);
[vertices,faces] = equilateral_grid(10,10);
vertices(1:2,:) = vertices(1:2,:) + 0.1*rand(size(vertices(1:2,:)));
eje = [0.5,1,0.25,0.75];

plotMesh(vertices,faces);
view([0,90])
axis equal;
axis(eje);

make_draw('outputs/regular_nonuniform',vertices,faces,eje);