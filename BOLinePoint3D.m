%% Clear
clc; close all; clear all;
%% Line
p1 = [1 1 2];
p2 = [20 28 90];
%% Point
p0 = [50 30 67];
%% Perpendicular to the line
pi = BOLinePoint3D(p1,p2,p0);
%% Is intersection point on the line segment?
n1 = norm(pi-p1) + norm(pi-p2);
n2 = norm(p1-p2);
if n1==n2
    disp('point on');
else
    disp('point out');
end
%% Plot
figure;
% Plot line
plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)]);
hold on;
% Plot point of interest in red
plot3(p0(1), p0(2), p0(3), 'r.');
% Plot intersection point in green
plot3(pi(1), pi(2), pi(3), 'g.');
% Plot line from intersection point to point of interest in black
plot3([p0(1) pi(1)], [p0(2) pi(2)],  [p0(3) pi(3)], 'k');
% Turn on a grid
grid;    