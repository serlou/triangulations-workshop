function [vertices,faces] = rectangular_grid(nx,ny)

[X,Y]=meshgrid(0:nx-1,0:ny-1);

X= X/(nx-1);
Y= Y/(nx-1);
Z= zeros(size(X));

s1=size(X,1); s2=size(X,2);
vertices = [X(:) Y(:) Z(:)]';
faces=[];
for i=1:s2-1
    faces = [faces, s1*(i-1)+ [1:s1-1 ; 2:s1 ; (2:size(X,1))+s1] ];
    faces = [faces, s1*(i-1)+ [1:s1-1 ; (2:size(X,1))+s1 ; (2:size(X,1))+s1-1] ];
end