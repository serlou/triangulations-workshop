clear; close all;
n = 21;
[vertices,faces] = equilateral_grid(n,n);
vertices = vertices - vertices(:,(end+1)/2);
vertices = vertices*(n-1);
[vertices,faces] = crop(vertices,faces,1,-6.1,6.1);
[vertices,faces] = crop(vertices,faces,2,-6.1,6.1);


plotMesh(vertices,faces);
view([0,90])
axis equal;

save('datasets/large_equilateral.mat', 'vertices', 'faces');