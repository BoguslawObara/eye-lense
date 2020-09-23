function density = AImeasure_density(poss, theta, phi, half_angle)

uHat = [sin(theta)*sin(phi) ;   %unit length of 1
        sin(theta)*cos(phi)  ;   %central ray of cone
        cos(theta)] ;
area = 1;
%Unit vectors for each cell
vLens = sqrt(sum(poss.^2,2)) ;   %sums each square of each row, magnitude of position
vHat = poss ./ vLens;
thetas = [];
for i=1:length(vLens)
    cos_theta = dot(uHat,vHat(i,:));
    thetas = [thetas, acos(cos_theta)];
end
[thetamin, thetaargmin] = min(thetas);
if thetamin < half_angle
    adj = vLens(thetaargmin);
    area = pi * sqrt(adj*tan(half_angle));
end
good_poss = find(thetas < half_angle)
density = length(good_poss)/area;
end
    
%% below is the python code from which the above was adapted
% def measure_density(poss, theta, phi, half_angle):

%     uHat = [np.sin(theta)*np.sin(phi),        #unit length of 1, xyz
%             np.sin(theta)*np.cos(phi),        #central ray of cone
%             np.cos(theta) ]
%     area = 1
%     # Unit vectors for each cell
%     vLens = ((poss**2).sum(axis=1)**.5)                  #sums each row, x + y + z, magnitude of position
%     vHat = poss / vLens[:, np.newaxis]      #each row divided by vLens, newaxis switches it to a column (vector of nuclei)
%     cos_theta = [np.dot(uHat, _vHat) for _vHat in vHat]   #angle between each (dot product rule)
%     cos_theta = np.array(cos_theta)
%     theta = np.arccos(cos_theta)                 #angle between each in a numpy array    
%     if min(theta) < half_angle:
%         adj = vLens[theta.argmin()]
%         area = np.pi * (adj*np.tan(half_angle))**2
%         areatest.append(area)
%     good_poss = poss[np.where(theta < half_angle)]      #poss is xyz
%     return len(good_poss)/area