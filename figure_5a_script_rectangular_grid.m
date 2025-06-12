clear; close all;
nx = 10; ny = 10;
eje = [0.25,0.75,0.25,0.75];

[vertices,faces] = rectangular_grid(nx,ny);

plotMesh(vertices,faces);
view([0,90])
axis equal;
axis(eje)
make_draw('outputs/rectangular_grid',vertices,faces,eje);