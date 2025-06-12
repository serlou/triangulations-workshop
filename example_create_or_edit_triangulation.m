clear; close all;

% [vertices,faces] = edit_triangulation();

load('datasets/triangulation2.mat');
[vertices,faces] = edit_triangulation(vertices,faces);


% save('outputs/triangulation2.mat','vertices','faces');