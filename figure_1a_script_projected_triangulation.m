% generates matlab figure and tikz file

clear; close all;

filename = 'outputs/projected_triangulation';

vertices = [
    0 1 0   1.2
    -0.3 0 0.5 1
    2 4 3   2.5
];

faces = [
    1 2
    2 3
    3 4
];

dashed_lines = 1:4;
custom_labels = {{'$(x_i,y_i,z_i)$',[0.1,-0.05]},{'$(x_i,y_i)$',[0.1,0]},{'$z_i$',[0.05,0]}};
make_projected_figure(filename, vertices, faces, dashed_lines, custom_labels);