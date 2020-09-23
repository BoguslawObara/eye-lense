function [x,y,z] = AIrotate_about_x(angle_intox, x, y, z)

xyz = [x.'   ;
        y.'  ;
        z.'] ;
rot_x = [1, 0, 0    ;
         0, cos(angle_intox), sin(angle_intox) ;
         0, -sin(angle_intox),  cos(angle_intox)] ;
     
xyz_rot = []    ; 
for i =1:length(x)

    xyz_no = rot_x * xyz(:,i);
    xyz_rot = [xyz_rot, xyz_no];
end
    
x = xyz_rot(1,:); x=x.' ;
y = xyz_rot(2,:); y=y.' ;
z = xyz_rot(3,:); z=z.' ;

end


% This is the original Python code for this function
% def rotate_about_x(Rot_theta,xs,ys,zs):
%     '''This function defines a matrix that rotates an xyz data set abut the x-axis by some theta
%     Inputs: angle of rotation, xyz coordinates 
%     Outputs: rotated xyz coordinates'''
%     xyz = np.matrix((xs, ys, zs))
%     Rot_x = np.matrix([[1, 0, 0], 
%                        [0, np.cos(Rot_theta), np.sin(Rot_theta)], 
%                        [0,-np.sin(Rot_theta),np.cos(Rot_theta)]])
%     xyz_Rot =[]
%     for i in range(len(xs)):
%         xyz_no = Rot_x*xyz[:,i]
%         xyz_Rot.append((xyz_no))
%    
%     xyz_Rot = np.array((xyz_Rot))
% 
%     xs = xyz_Rot[:,0].reshape((-1,))
%     ys = xyz_Rot[:,1].reshape((-1,))
%     zs = xyz_Rot[:,2].reshape((-1,))
% 
%     return xs, ys, zs
