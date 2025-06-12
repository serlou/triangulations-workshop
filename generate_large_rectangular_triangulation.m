clear; close all;
n = 11;
[vertices,faces] = rectangular_grid(n,n);
vertices = vertices - vertices(:,(end+1)/2);
vertices = vertices*(n-1);


plotMesh(vertices,faces);
view([0,90])
axis equal;

save('datasets/large_rectangular.mat', 'vertices', 'faces');