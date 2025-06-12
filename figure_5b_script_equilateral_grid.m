clear; close all;
[vertices,faces] = equilateral_grid(10,10);
eje = [0.5,1,0.25,0.75];

plotMesh(vertices,faces);
view([0,90])
axis equal;
axis(eje);
make_draw('outputs/equilateral_grid',vertices,faces,eje);