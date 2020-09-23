function [xnew,ynew,znew] = AIcenter_to_origin(x,y,z,center)
xnew = x - center(:,1);
ynew = y - center(:,2);
znew = z - center(:,3);
