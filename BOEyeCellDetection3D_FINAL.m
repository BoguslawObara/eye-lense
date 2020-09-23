%% Clear
clc; close all; clear all;
%% Path - Libs
addpath('./lib/');
addpath('./lib/BOBlobDetector3D');
%% Load image
dirname = 'F:/AlexiaEye/TIFFS/';
%dirname = 'change this';
filename = 'LENS01';
%filename = 'file name';
file_ext = '.tif';
%file_ext = '.tif''
%% Res
rx = 1; ry = rx; rz = 1515.2/6224.4;
%change rz = x/y to image metadata
%% Load images
ims = BOReadImage3DC([dirname filename file_ext]);
%% Gray
ims = squeeze(max(ims,[],3));
ims = BONormalizeImageND(ims);
%% Filter 
% disp('Filter');
% rx = 17; rz = 100; f = rz/rx;
% s = 12; s = [s s s/f];
% se = fspecial3('gaussian',s);
% imsf = imfilter(ims,se,'replicate');
%% Normalise images
%imsf = BONormalizeImageND(imsf);
%% Detect Centroids
ns = 1.5; t = 0.05; 
% change ns = threshold t = circularity
ns = [ns*rx ns*ry ns*rz];
np = BOBlobDetector3D(ims,[],ns,t);
%% Plot
figure; BOPlotMaxProjection2D(ims,np,1,1);
%% Save
x = np(:,1); y = np(:,2); z = np(:,3);
Lenx = length(x)
save(['./mat/' filename '_xyz.mat'],'x','y','z');
dlmwrite([dirname filename '_cart.txt'],np(:,1:3),'delimiter','\t');