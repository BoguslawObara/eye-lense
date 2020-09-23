%% Create graphs
% % Use this to plot all of the data. It creates scatter plots, bar charts
% and the density scatter. Comment each section in and out as appropriate
% and read the text at the top for help
%% Setup
dirname_in = './images/';
dirname_mat_in = 'C:\Users\Archie\OneDrive\ShapeAndPositions\Cartesian\';
dirname_out = 'C:\Users\Archie\OneDrive\ShapeAndPositions\Cartesian\';
filename_in1 = 'M111MONTHS_cart';
filename_in2 = 'M211MONTHS_cart';
filename_in3 = 'M311MONTHS_cart';
filename_in4 = 'M411MONTHS_cart';
ext = '.tif';
ext_mat = '.txt';
ext_analysis = '.txt';
%% Load mat
data1 = load([dirname_mat_in filename_in1 ext_mat]);
x1=data1(1,:);
y1=data1(2,:);
z1=data1(3,:);
data2 = load([dirname_mat_in filename_in2 ext_mat]);
x2=data2(1,:);
y2=data2(2,:);
z2=data2(3,:);
data3 = load([dirname_mat_in filename_in3 ext_mat]);
x3=data3(1,:);
y3=data3(2,:);
z3=data3(3,:);
data4 = load([dirname_mat_in filename_in4 ext_mat]);
x4=data4(1,:);
y4=data4(2,:);
z4=data4(3,:);

%% A small Amount of normalisation for presentation
x1 = x1 - (mean(x1)-mean(x3));
x2 = x2 - (mean(x2)-mean(x3));
x4 = x4 - (mean(x4)-mean(x3));

y1 = y1 - (mean(y1)-mean(y3));
y2 = y2 - (mean(y2)-mean(y3));
y4 = y4 - (mean(y4)-mean(y3));

z1 = z1 - (mean(z1)-mean(z3));
z2 = z2 - (mean(z2)-mean(z3));
z4 = z4 - (mean(z4)-mean(z3));
% 
% % if the graphs still dont line up use these lines to change by inspection
% % None of this changes the data at all mostly just accounts for noise
y2 = y2 +90;
y3 = y3 +90;
%% Plot the Samples On a Scatter Plot
% % In order to set colour change '.' to 'b.'

figure
hold on
plot3(x1,y1,z1,'.','MarkerSize',3, 'DisplayName', 'Sample A')
plot3(x2,y2,z2','.','MarkerSize',3, 'DisplayName', 'Sample B')
plot3(x3,y3,z3','.','MarkerSize',3, 'DisplayName', 'Sample C')
plot3(x4,y4,z4','.','MarkerSize',3, 'DisplayName', 'Sample D')
xlabel('x [\mum]') ; ylabel('y [\mum]'), zlabel('z [\mum]');
legend
pbaspect([2 1.6 1.8])
view(106,13)
hold off

%% Projections in xy, zy and xz
% figure
% hold on
% scatter(z1,y1,5,'filled')
% scatter(z2,y2,5,'filled')
% xlabel('z [\mum]') ; ylabel('y [\mum]');
% hold off
% 
% figure
% hold on
% scatter(x1,y1,5,'filled')
% scatter(x2,y2,5,'filled')
% xlabel('x [\mum]') ; ylabel('y [\mum]');
% hold off
% 
% figure
% hold on
% scatter(x1,z1,10,'filled')
% scatter(x2,z2,10,'filled')
% xlabel('x [\mum]') ; ylabel('z [\mum]');
% hold off

%% Cell Count Bar Chart
figure
bardatx = categorical({'Sample A' 'Sample B' 'Sample C' 'Sample D'});
bardaty = [length(x1),length(x2),length(x3),length(x4)];
b = bar(bardatx, bardaty);

% Just a colour change of bars to match scatter 
b.FaceColor = 'flat';
b.CData(1,:) = [0, 0.4470, 0.7410]; b.CData(2,:) = [0.8500, 0.3250, 0.0980]; 
b.CData(3,:) = [0.9290, 0.6940, 0.1250]	; b.CData(4,:) = [0.4940, 0.1840, 0.5560]; 

curtick = get(gca, 'YTick');
set(gca, 'YTickLabel', cellstr(num2str(curtick(:))));
ylabel('Cell Count');

%% Radii Ratio Bar Chart
% % the data here should be taken from the radii results from the rest of
% the code

figure
bardatx = categorical({'Sample A' 'Sample B' 'Sample C' 'Sample D'});
bardaty = [0.708697711
0.521945613
0.542857763
0.84705062];
b = bar(bardatx, bardaty);

% Just a colour change of bars to match scatter 
b.FaceColor = 'flat';
b.CData(1,:) = [0, 0.4470, 0.7410]; b.CData(2,:) = [0.8500, 0.3250, 0.0980]; 
b.CData(3,:) = [0.9290, 0.6940, 0.1250]	; b.CData(4,:) = [0.4940, 0.1840, 0.5560]; 

curtick = get(gca, 'YTick');
set(gca, 'YTickLabel', cellstr(num2str(curtick(:))));
ylabel('Aspect Ratio [R_{minor} / R_{major}]');

%% Density scatter plot
% % Change the Positional array to be filled with whatever data you want
Positional = [x4, 
        y4, 
        z4];
a = Positional';
n = zeros(size(a,1),1); % Set up array for number of nearby points
tol = 2000;              % Tolerance for (squared) distance to count as "nearby" 
sz = size(a,1);         % Shorthand for size of data
% Loop over every point
for ii = 1:sz;
    dists = sum((repmat(a(ii,:), sz, 1) - a).^2, 2); % Get standard Euclidean distance 
    n(ii) = nnz(dists < tol); % Count number of points within tolerance
end
% Plot, colouring by an nx3 RGB array, in this case just 
% scaling the colour map of jet
colormap jet
scatter3(a(:,1), a(:,2), a(:,3), [200], [n./max(n)], 'filled');
xlabel('x [\mum]') ; ylabel('y [\mum]'), zlabel('z [\mum]');
pbaspect([2 1.6 1.8]);
view(-50,22);
grid on;

%% Animation 
% % This will use the data from above 
% NOTE: Remember the change the filename in the CaptureFigVid Function

figure;
clf;
scatter3(a(:,1), a(:,2), a(:,3), [200], [n./max(n)], 'filled');
xlabel('x [\mum]') ; ylabel('y [\mum]'), zlabel('z [\mum]');
daspect([1.8 1.6 1.6]);axis tight;
OptionZ.FrameRate=15;OptionZ.Duration=15;OptionZ.Periodic=true;
colormap jet

CaptureFigVid([-20,10;-110,10;-190,10;-290,10;-380,10], 'M411MONTHSAnimation',OptionZ)



