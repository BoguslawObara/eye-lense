%% Create the grid of density plots

xyz = [x.'   ;
        y.'  ;
        z.'] ;
poss = xyz.' ;  %x,y,z on the row

nthetas = 50;
nphis = 2*nthetas;

ThetaPoint = 1;

thetas = linspace(0, pi, nthetas);
phis = linspace(0, 2*pi, nphis); % Take last one off because of phase wrapping

grid = zeros(nthetas, nphis);
phi_data = zeros(nphis); theta_data = zeros(nthetas) ;
half_angle = pi/nthetas;
%% Loop to run the measure density function

for iy=1:nthetas
    
    disp(['Thetapoint', num2str(ThetaPoint)])
    ThetaPoint = ThetaPoint + 1;
    for ix=1:nphis
        grid(iy, ix) = AImeasure_density(poss, thetas(iy), phis(ix), half_angle);
        disp('.')
    end
    disp('/n')
end

rad_minor = norm(pole);
rad_major = rad;

disp(['the distance from the centre of the circle to the pole (minor axis) is', num2str(rad_minor)])
disp(['the radius of the circle fit (major axis) is', num2str(rad_major)])
%% below in the python code from which this was adapted
% '''This block does the main action of the code, it projects the cone described in the thesis and produces an array
% poss = np.array((xs, ys, zs)).T    #makes it x , y, z on the row
% 
% 
% nthetas = 50        # This line is essentially the resolution of the colour map, nthetas*2*nthetas cones will be projected
% nphis = 2*nthetas
% ThetaPoint = 1
% thetas = np.linspace(0, pi, nthetas)
% phis = np.linspace(0, 2*pi, nphis+1)[:-1] # Take last one off because of phase wrapping
% grid = np.zeros((nthetas, nphis))
% phi_data = np.zeros(nphis)
% theta_data = np.zeros(nthetas)
% 
% for iy in range(nthetas):
%     print "ThetaPoint", ThetaPoint
%     ThetaPoint = ThetaPoint + 1
%     for ix in range(nphis):
%         grid[iy, ix] = measure_density(poss, thetas[iy], phis[ix], half_angle=pi/nthetas)
%         print '.',
%     print '\n'
% grid = np.array(grid)
% 
% endtime = time.time()
% print(endtime - starttime)