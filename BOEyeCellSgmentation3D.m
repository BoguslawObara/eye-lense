%% Clear
clc; close all; clear all;
%% Path - Libs
addpath('../../BOMatlabLib/BONormalizeImageND');
addpath('../../BOMatlabLib/BOBlobDetector3D');
addpath('../../BOMatlabLib/BOLocalThreshold3D');
addpath('../../2013/BOBlobColocalisation3D/BOColocalisation3D');
addpath('../../2013/BOBlobTracking3D');
addpath('../../BOMatlabLib/BOLocalThreshold3D');
%% Load image
dirname = '/home/boguslaw/DURHAM/Projects/Durham_2016/Eye/';
%dirname = '/media/boguslaw/My Passport/BACKUP/DURHAM/Projects/Durham_2016/Eye/';
%dirname = 'C:\BACKUP\DURHAM\Projects\Durham_2016\Eye\';
%filename = 'AlexiaEyePin2';
%filename = 'lens02';
%filename = 'lens36';
%filename = 'lens38';
%filename = 'lens42';
%filename = 'lens68';
filename = 'lens17_pole';
file_ext = '.tif';
%% Res
rx = 0.6667; ry = rx; rz = 0.2;
%% Load images
ims = BOReadImage3DC([dirname filename file_ext]);
%% Gray
ims = squeeze(max(ims,[],3));
ims = ims(500:550,500:550,1:10);
ims = BONormalizeImageND(ims);
%% Filter 
% disp('Filter');
% rx = 17; rz = 100; f = rz/rx;
% s = 12; s = [s s s/f];
% se = fspecial3('gaussian',s);
% imsf = imfilter(ims,se,'replicate');
%% Normalise images
%imsf = BONormalizeImageND(imsf);
%% Segmentation
%t = graythresh(ims);
%imth = ims>0.25;
n = 30; c = -40;
imth = BOMeanThreshold3D(ims,n,c);
figure; imagesc(max(imth,[],3)); colormap jet; axis off; axis equal; axis tight;
return
%% Label
imlabel = bwlabeln(imth);
%% Plot
figure; imagesc(max(ims,[],3)); colormap jet; axis off; axis equal; axis tight;
figure; imagesc(max(imth,[],3)); colormap jet; axis off; axis equal; axis tight;
figure; imagesc(max(imlabel,[],3)); colormap jet; axis off; axis equal; axis tight;
%% Save
%save(['./mat/' filename '_th.mat'],'imth','imlabel');