%% Clear
clc; clear all; close all;
%% Setup
dirname_in = './images/';
dirname_mat_in = './mat/';
dirname_out = 'F:/AlexiaEye/TIFFS/';
%dirname_out = 'change_this'
filename_in = 'LENS01';
%filename_in = 'change this'
ext = '.tif';
ext_mat = '.mat';
ext_analysis = '.txt';
%% Load images
% im = BOReadImage3DC([dirname_in filename_in ext]);
% im = im(:,:,1);
% im = BONormalizeImageND(im);
%% Load mat
load([dirname_mat_in filename_in '_xyz' ext_mat]);
%% flip
xt = x;
x = y;
y = xt;
clear xt;
%% Resolution CHANGE
if strcmp(filename_in,'LENS01') || strcmp(filename_in,'LENS05')
    rx = 0.75;
    ry = 0.75;
    rz = 2.815;
% change to image metadata
end
if strcmp(filename_in,'LENS06') || strcmp(filename_in,'LENS12')
    rx = 1.513;
    ry = 1.513;
    rz = 7.064;
% change to image metadata
else
    rx = 1.513;
    ry = 1.513;
    rz = 5.997;
% change to image metadata
end
%% Settings CHANGE
if strcmp(filename_in,'LENS01')
    p1 = [140,952,53];
    p2 = [680,890,53];
    p3 = [864,130,53];
end
% pixel xyz for points
if strcmp(filename_in,'LENS02')
    p1 = [196,110,49];
    p2 = [164,616,49];
    p3 = [840,944,49];
end
% compile all samples
%%pp xyz




%% Scale
% p1 = p1 .* [rx ry rz];
% p2 = p2 .* [rx ry rz];
% p3 = p3 .* [rx ry rz];

%pp1 = pp1 .* [rx ry rz];
%pp2 = pp2 .* [rx ry rz];
%pp3 = pp3 .* [rx ry rz];

x = x * rx;
y = y * ry;
z = z * rz;
%% plot for selection of points (if needed)
figure

scatter3(x,y,z, 10, 'filled')
xlabel('x') ; ylabel('y'), zlabel('z');
title('Initial data')
% p1 = [1336, 273.9, 455.8];
% p2 = [1510, 854.8, 455.8];
% p3 = [1466, 1148, 503.7];
p1 = [907.8, 1428, 473.8];
p2 = [1145, 1354, 467.8];
p3 = [1452, 1144, 473.8];
%% Normalise data
[x,y,z,p1,p2,p3] = AIimageNorm(x,y,z,p1,p2,p3) ;

%% Fit Circle
[center,rad,v1,v2] = circlefit3d(p1,p2,p3);

%final rotations
z_axis = [0,0,1];
angle_pz = -acos(dot(z_axis, cross(v1,v2))) 
% disp('anglez')
% disp(angle_pz)

[x,y,z] = AIrotate_about_x(angle_pz, x,y,z);

px = [p1(1), p2(1), p3(1)].';
py = [p1(2), p2(2), p3(2)].';
pz = [p1(3), p2(3), p3(3)].';
[px,py,pz] = AIrotate_about_x(angle_pz, px,py,pz);

p1 = [px(1), py(1), pz(1)] ;
p2 = [px(2), py(2), pz(2)] ;
p3 = [px(3), py(3), pz(3)] ;

%% Fit Circle (on moved data) and final rotation
[center,rad,v1,v2] = circlefit3d(p1,p2,p3);
[rho,theta,r] = cart2sph(x,y,z);

px = [p1(1), p2(1), p3(1)].';
py = [p1(2), p2(2), p3(2)].';
pz = [p1(3), p2(3), p3(3)].';

[x,y,z] = AIcenter_to_origin(x,y,z,center);
[px,py,pz] = AIcenter_to_origin(px,py,pz,center);

[x,y,z] = AIrotate_about_x(-pi/2, x,y,z);
[px,py,pz] = AIrotate_about_x(-pi/2, px,py,pz);

p1 = [px(1), py(1), pz(1)] ;
p2 = [px(2), py(2), pz(2)] ;
p3 = [px(3), py(3), pz(3)] ;

if mean(pz) < mean(z)
    disp('mean of selected points z < mean of all points z')
    z = -z;
end

if mean(py) < mean(y)
    disp('mean of selected points y < mean of all points y')
    y = -y;
end
%% Shift data to accout for noise, avoid dramatic shift by errant points
if max(y) < 150
    disp('taking away the real y')
    p1(2)=p1(2)-max(y) ; p2(2)=p2(2)-max(y) ; p3(2)=p3(2)-max(y) ;
    y = y - max(y);
else
    disp('taking away 150')
    p1(2)=p1(2)-150 ; p2(2)=p2(2)-150 ; p3(2)=p3(2)-150 ;
    y = y - 150;
end
%% Final Circle Fit + Find vector
[center,rad,v1,v2] = circlefit3d(p1,p2,p3);

v = cross(v1,v2);
k = max(z);
xv = center(:,1)+ k*v(:,1);
yv = center(:,2)+ k*v(:,2);
zv = center(:,3)+ k*v(:,3);
%% Vector-Vector Angle
xp = x - center(:,1);
yp = y - center(:,2);
zp = z - center(:,3);
xvp = xv - center(:,1);
yvp = yv - center(:,2);
zvp = zv - center(:,3);
a = BOVectorVectorAngle3D(xp,yp,zp,xvp,yvp,zvp);
[m,idx] = min(a);
xc = x(idx); yc = y(idx); zc = z(idx);
%% Distances 
dp1 = norm(center-p1);
dp2 = norm(center-p2);
dp3 = norm(center-p3);
dv = norm(center-[xv,yv,zv]);
%% 3 points to normal vector angle & dist
nx = center(:,1)-xv;
ny = center(:,2)-yv;
nz = center(:,3)-zv;
% a1 = BOVectorVectorAngle3D(nx,ny,nz,center(:,1)-pp1(:,1),center(:,2)-pp1(:,2),center(:,3)-pp1(:,3));
% a2 = BOVectorVectorAngle3D(nx,ny,nz,center(:,1)-pp2(:,1),center(:,2)-pp2(:,2),center(:,3)-pp2(:,3));
% a3 = BOVectorVectorAngle3D(nx,ny,nz,center(:,1)-pp3(:,1),center(:,2)-pp3(:,2),center(:,3)-pp3(:,3));
% dpp1 = norm(center-pp1);
% dpp2 = norm(center-pp2);
% dpp3 = norm(center-pp3);

%% Plot
figure; 

plot3(p1(:,1),p1(:,2),p1(:,3),'bo'); hold on;
plot3(p2(:,1),p2(:,2),p2(:,3),'bo');
plot3(p3(:,1),p3(:,2),p3(:,3),'bo');
xlabel('x') ; ylabel('y'), zlabel('z');
xr = zeros(361,1);
yr = zeros(361,1);
zr = zeros(361,1);
for i=1:361
    a = i/180*pi;
    xr(i) = center(:,1)+sin(a)*rad.*v1(:,1)+cos(a)*rad.*v2(:,1);
    yr(i) = center(:,2)+sin(a)*rad.*v1(:,2)+cos(a)*rad.*v2(:,2);
    zr(i) = center(:,3)+sin(a)*rad.*v1(:,3)+cos(a)*rad.*v2(:,3);
end

% disp(center(:,1))
% disp(center(:,2))
% disp(center(:,3))
plot3(xr,yr,zr,'m.');
plot3(center(:,1),center(:,2),center(:,3),'r*');
%plot3(y,x,z,'g.','MarkerSize',3); % Plot nuclei


plot3(x,y,z,'g.','MarkerSize',3); % Plot nuclei
% plot3(xnew,ynew,znew,'b.','MarkerSize',3); % Plot nuclei
plot3([center(:,1) xv],[center(:,2) yv],[center(:,3) zv],'r-');
% plot3([center(:,1) pp1(:,1)],[center(:,2) pp1(:,2)],[center(:,3) pp1(:,3)],'k-');
% plot3([center(:,1) pp2(:,1)],[center(:,2) pp2(:,2)],[center(:,3) pp2(:,3)],'k-');
% plot3([center(:,1) pp3(:,1)],[center(:,2) pp3(:,2)],[center(:,3) pp3(:,3)],'k-');
plot3(xv,yv,zv,'ro');
plot3(xc,yc,zc,'b*');
axis equal; % comment out
box on; 
ax = gca;
ax.BoxStyle = 'full';
print([dirname_out filename_in 'geometry'],'-dpng','-r300')

figure
scatter(z,y,10,'filled')
xlabel('z') ; ylabel('y');

figure
scatter(x,y,10,'filled')
xlabel('x') ; ylabel('y');

figure
scatter(x,z,10,'filled')
xlabel('x') ; ylabel('z');

%% Save
names = {'X';'Y';'Z'};
T = table(x,y,z,'VariableNames',names);
writetable(T,[dirname_out filename_in '_table_xyz' ext_analysis],'Delimiter','\t');

names = {'XP';'YP';'ZP'};
T = table(xc,yc,zc,'VariableNames',names);
writetable(T,[dirname_out filename_in '_table_xyz_p' ext_analysis],'Delimiter','\t');

names = {'DP1';'DP2P';'DP3';'DV'};
T = table(dp1,dp2,dp3,dv,'VariableNames',names);
writetable(T,[dirname_out filename_in '_table_xyz_d' ext_analysis],'Delimiter','\t');

names = {'A1';'A2';'A3';'D1';'D2';'D3'};
% T = table(a1,a2,a3,dpp1,dpp2,dpp3,'VariableNames',names);
% writetable(T,[dirname_out filename_in '_table_xyz_pp' ext_analysis],'Delimiter','\t');

return
%% OLD
% [ center, radii, evecs, v, chi2 ] = ellipsoid_fit( [ y x z ], '' );
% %% plot
% % draw data
% figure,
% plot3( y, x, z, '.r' );
% hold on;
% 
% %draw fit
% mind = min( [ x y z ] );
% maxd = max( [ x y z ] );
% nsteps = 50;
% step = ( maxd - mind ) / nsteps;
% [ xm, ym, zm ] = meshgrid( linspace( mind(1) - step(1), maxd(1) + step(1), nsteps ), linspace( mind(2) - step(2), maxd(2) + step(2), nsteps ), linspace( mind(3) - step(3), maxd(3) + step(3), nsteps ) );
% 
% Ellipsoid = v(1) *xm.*xm +   v(2) * ym.*ym + v(3) * zm.*zm + ...
%           2*v(4) *xm.*ym + 2*v(5)*xm.*zm + 2*v(6) * ym.*zm + ...
%           2*v(7) *xm    + 2*v(8)*ym    + 2*v(9) * zm;
% p = patch( isosurface( xm, ym, zm, Ellipsoid, -v(10) ) );
% hold off;
% set( p, 'FaceColor', 'g', 'EdgeColor', 'none' );
% view( -70, 40 );
% axis vis3d;
% camlight;
% lighting phong;
