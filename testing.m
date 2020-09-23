% clc
% 
% a= importdata('C:\Users\Archie\OneDrive\matlabtest.txt');
% 
% size(a)
% ismatrix(a)

% a = 5;
% main(a)
% 
% v_r = [11, 12, 13]
% 
% hlp = v_r(1); me = v_r(2);
% 
% hlp
% me
% 
% help = [4,5,6,3,5,78,34,2,7,8,3] ;
% length(help)
% for i =1:length(help)
%     disp(i)
% end


% asdf = []
% for i =1:4
%     zxcv = qwer(:,i) * 2;
%     asdf = [asdf, zxcv] ;
% end
% 
% asdf
% qwer = [1,2,3,4
%         5,6,7,8
%         9,10,11,12] ;
%     
% % qwer(:,2)
% 
%  = [x ;
%         y ;
%         z];
%   
%   size()
%   size(x)
% %   pi
% 
% qwer = [1,2,3
%         5,6,7
%         9,10,11] ;
% qwerlens = sqrt(sum(qwer.^2,2))
% 
% qwer ./ qwerlens
% 


% qwer = [1,78,32,6,89,800,3,4,7,89,87,34,3,4,6,8,5,32]
% asdf = find(qwer > 10)
% 
% area =1
% 
% thetas = linspace(0, pi, 10)
% thetas - pi

% A = [1,2,3]
% B = [1,2,3]


% rad_minor = norm(pole)
% rad_major = rad
% disp(['the distance from the centre of the circle to the pole (minor axis) is', num2str(rad_minor)])
% disp(['the radius of the circle fit (major axis) is', num2str(rad_major)])


% densityScatter([x1,y1])
% 
% zxcv = [x2, 
%         y2, 
%         z2];
% 
% figure
% scatter_kde(x1',y1', 'filled', 'MarkerSize', 100)

% a = zxcv';
% n = zeros(size(a,1),1); % Set up array for number of nearby points
% tol = 2000;              % Tolerance for (squared) distance to count as "nearby" 
% sz = size(a,1);         % Shorthand for size of data
% % Loop over every point
% for ii = 1:sz;
%     dists = sum((repmat(a(ii,:), sz, 1) - a).^2, 2); % Get standard Euclidean distance 
%     n(ii) = nnz(dists < tol); % Count number of points within tolerance
% end
% % Plot, colouring by an nx3 RGB array, in this case just 
% % scaling the red and having no green or blue.
% colormap jet
% scatter3(a(:,1), a(:,2), a(:,3), [200], [n./max(n)], 'filled');
% grid on;
% 
% [n./max(n), zeros(numel(n),2)]
% n./max(n)
% 
figure;
clf;
plot3(x1,y1,z1,'.','MarkerSize',3, 'DisplayName', 'Sample A')
daspect([1,1,.3]);axis tight;
OptionZ.FrameRate=15;OptionZ.Duration=5.5;OptionZ.Periodic=true;


CaptureFigVid([-20,10;-110,10;-190,80;-290,10;-380,10], 'WellMadeVid',OptionZ)





