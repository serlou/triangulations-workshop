clear; close all;
clear; close all;
load('datasets/nonregular.mat')
vertices(3,:) = 0;
eje = [-0.9,1.3,-Inf,-0.5];
eje(3) = eje(4) - (eje(2)-eje(1));

plotMesh(vertices,faces);
view([0,90])
axis equal;
axis(eje);
make_draw('outputs/irregular',vertices,faces,eje);