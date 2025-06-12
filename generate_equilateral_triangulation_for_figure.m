clear; close all;
[vertices,faces] = equilateral_grid(11,11);
vertices = vertices - vertices(:,(end+1)/2);
vertices = vertices*10;
[vertices,faces] = crop(vertices,faces,1,-2,3.5);
[vertices,faces] = crop(vertices,faces,2,-2,3);


plotMesh(vertices,faces);
view([0,90])
axis equal;

save('datasets/equilateral_for_figure.mat', 'vertices', 'faces');