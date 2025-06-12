% generates matlab figure and tikz file

clear; close all;

filename = 'outputs/projected_triangulation_refined';

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

[vertices,faces] = B111Subdivision(vertices,faces);
vertices(3,5) = vertices(3,5) + 0.3;
vertices(3,6) = vertices(3,6) + 0.6;
vertices(3,7) = vertices(3,7) - 0.2;
vertices(3,8) = vertices(3,8) - 0.1;
vertices(3,9) = vertices(3,9) + 0.2;

dashed_lines = 1:4;
make_projected_figure(filename,vertices,faces,dashed_lines);