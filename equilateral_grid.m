function [vertices,faces] = equilateral_grid(nx,ny)

[X,Y]=meshgrid(0:nx-1,0:ny-1);

X= X/(nx-1);
Y= Y/(nx-1);

A = [1,0; 0.5,sqrt(3)/2]';
X1 = A(1,1)*X + A(1,2)*Y;
Y1 = A(2,1)*X + A(2,2)*Y;
Z1 = zeros(size(X1));

s1=size(X,1); s2=size(X,2);
vertices = [X1(:) Y1(:) Z1(:)]';
faces=[];
for i=1:s2-1
    faces = [faces, s1*(i-1)+ [1:s1-1 ; 2:s1 ; (1:size(X,1)-1)+s1] ];
    faces = [faces, s1*(i-1)+ [2:s1 ; (1:size(X,1)-1)+s1 ; (1:size(X,1)-1)+s1+1] ];
end
% [vertices,faces] = crop(vertices,faces,1,Z2(1,end),Z2(end,1));