%% Clear
clc; close all; clear all;
%%


filename = '6week03';
B = dlmread(['./mat/' filename '_hist_class.txt']);
filename = 'E6';
A = dlmread(['./mat/' filename '_hist_class.txt']);







%% Figure
figure; 

plot(B(:,1),B(:,2),'r.-'); hold on;
plot(A(:,1),A(:,2),'b.-');





