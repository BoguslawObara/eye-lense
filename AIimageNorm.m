%% Set data and perform SVD
% MRp = [p1 ;
%        p2 ;
%        p3]; %add to this matrix for every point you have, the more points
%               % the more accurate
% MRp = importdata('C:\Users\Archie\OneDrive\matlabtest.txt');

function [x,y,z,p1,p2,p3] = AIimageNorm(x,y,z,p1,p2,p3)

MRp = [p1 ;
       p2 ;
       p3]; %add to this matrix for every point you have, the more points
              % the more accurate

avg = mean(MRp, 1);
MRpc = (MRp - avg); %centre the data
[U, D, V] = svd(MRpc); %single value decomposition

%% Set direction of best fit line and expand

dir = V(:, 1); %direction of best fit line

mult = 20*length(MRp)

linepts = [dir(1)*-mult, dir(2)*-mult, dir(3)*-mult ;
           dir(1)*mult, dir(2)*mult, dir(3)*mult] ; %expand for plot
linepts = linepts + avg ; %move data back
%% Plot check
figure

plot3(linepts(:,1), linepts(:,2), linepts(:,3))
hold on
scatter3(MRp(:,1), MRp(:,2), MRp(:,3), 10)
scatter3(x,y,z, 10, 'filled')
xlabel('x') ; ylabel('y'), zlabel('z');
title('Initial data with line fit and selected points')
hold off
%% Rotation into xy plane

[dirx,angle_intox] = AIrotate_into_x(dir);
[x,y,z] = AIrotate_about_x(angle_intox, x,y,z);
[MRp(:,1), MRp(:,2), MRp(:,3)] = AIrotate_about_x(angle_intox, MRp(:,1), MRp(:,2), MRp(:,3));
%% Rotation to become parallel with x axis

x_axis = [1,0,0];
% angle_px = 2*pi - acos(dot(x_axis, dirx))
angle_px = acos(dot(x_axis, dirx)) -2*pi

[x,y,z] = AIrotate_about_z(angle_px, x,y,z);
[MRp(:,1), MRp(:,2), MRp(:,3)] = AIrotate_about_z(angle_px, MRp(:,1), MRp(:,2), MRp(:,3));


if mean(MRp(:,2)) > mean(y)
    disp('mean(Mrp) > mean(ys)')

    [x,y,z] = AIrotate_about_z(pi, x,y,z);
    [MRp(:,1), MRp(:,2), MRp(:,3)] = AIrotate_about_z(pi, MRp(:,1), MRp(:,2), MRp(:,3));
end

[x,y,z] = AIrotate_about_z(pi, x,y,z);
[MRp(:,1), MRp(:,2), MRp(:,3)] = AIrotate_about_z(pi, MRp(:,1), MRp(:,2), MRp(:,3));

p1 = MRp(1,:);
p2 = MRp(2,:);
p3 = MRp(3,:);
%% Other plots


% Use this for an xy projection
figure
hold on
% plot(linepts(:,1), linepts(:,2))
scatter(MRp(:,1), MRp(:,2))
scatter(x,y,10,'filled')
hold off
end