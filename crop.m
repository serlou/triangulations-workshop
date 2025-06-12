function [vertices,faces] = crop(vertices,faces,dim,a,b)

indi = find(vertices(dim,:)<a | vertices(dim,:)>b);
vertices(:,indi) = [];
for i=1:length(indi)
    ind = indi(i);
    bool = any(faces == ind,1);
    faces(:,bool) = [];
end
for i=length(indi):-1:1
    bool = faces(:)>=indi(i);
    faces(bool) = faces(bool) - 1;
end