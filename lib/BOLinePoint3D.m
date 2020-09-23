function xi = BOLinePoint3D(x1,x2,x0)
%%  HELP
% x1,x2 - points on the line 
% x0 - point
% xi - intersection point
%% Def
a = x1; %line - x1
b = x2; % line - x2
c = x0; %point - x0
%% Find x2 - x1
ab = b - a; 
%% -(x1 - x0).(x2 - x1) / (|x2 - x1|^2)
t = -(a - c)*(ab.') / (ab*ab.'); %// Calculate t
%% Find point of intersection
xi = a + (b - a)*t;
end