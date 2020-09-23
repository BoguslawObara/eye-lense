%% Clear
clc; close all; clear all;
%% Path - Libs
addpath('./lib/');
%% Settings
dirname = 'F:/AlexiaEye/TIFFS/';
%dirname = 'change this';
filename = 'LENS01';
%filename = 'change this';
file_ext = '.tif';
file_ext2 = '.png';
%% Load images
ims = BOReadImage3DC([dirname filename file_ext]);
ims = squeeze(max(ims,[],3));
ims = BONormalizeImageND(ims);
%% Load XYZ
load(['./mat/' filename '_xyz.mat']);
%% Rectangle
figure; imagesc(squeeze(max(ims,[],3))); colormap jet; axis off; axis equal; axis tight;
zoom off; [xl,yl] = ginput(2);
hold on; plot(xl,yl,'r-','LineWidth',2);
%% Line
[xli,yli,ol] = drawLine([xl(1) yl(1)],[xl(2) yl(2)]);
figure; imagesc(max(ims,[],3)); colormap jet; axis off; axis equal; axis tight;
hold on; plot(xli,yli,'r-','LineWidth',2);
%% Generate rect mask image
rh = round(sqrt((xl(1)-xl(2))^2 + (yl(1)-yl(2))^2)); % rectangle height
rw = 100;  % rectangle width
imr = ones(rh,rw); % generate rectangle image of rh x rw size
imrd = zeros(rh,rw); % generate rectangle dist image of rh x rw size
imrd(1,:) = 1;
imrd = bwdist(imrd);
imro = imrotate(imr,rad2deg(ol)); % rotate rectangle image by ol angle
imrdo = imrotate(imrd,rad2deg(ol)); % rotate rectangle dist image by ol angle
[xro,yro] = ind2sub(size(imro),find(imro==1)); % pixels in rectangle
xroc = round(mean(xro)); % centre of rotated rectangle
yroc = round(mean(yro));
xrop = xro-xroc; % move origin of the rectangle pixels to (0,0)
yrop = yro-yroc;
xlc = round(mean(xli)); % centre of the line points
ylc = round(mean(yli));
xm = xlc + xrop; % mask points
ym = ylc + yrop;
immask = zeros(size(ims,1),size(ims,2)); % mask image containing the rotated rectangle
immask(sub2ind(size(immask),ym,xm)) = 1;
immaskd = zeros(size(ims,1),size(ims,2)); % mask dist image containing the rotated rectangle
immaskd(sub2ind(size(immaskd),ym,xm)) = imrdo(sub2ind(size(imro),xro,yro));
ch = regionprops(immask,'ConvexHull');
ch = ch.ConvexHull;
%% Mask 3D
%immask3 = zeros(size(ims))==1;
%% Distance
zmin = min(z);
zmax = max(z);
zt = 0;
idx = z>zt;
xp = x(idx); yp = y(idx); zp = z(idx);
[in,on] = inpolygon(xp,yp,ch(:,2),ch(:,1));
xs = xp(in); ys = yp(in); zs = zp(in); % points in rectangle
%% Plot
imm = max(ims,[],3); % max projection of stack
imm(immask==1) = 1; % mask
figure; imagesc(imm); colormap jet; axis off; axis equal; axis tight;
hold on; plot(xli,yli,'r-','LineWidth',2);
hold on; plot(yp,xp,'y.');
hold on; plot(ys,xs,'go');
%% Save
save(['./mat/' filename '_xyz_r.mat'],'xs','ys','zs','xli','yli');