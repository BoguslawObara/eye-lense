function [x,y,z] = AIrotate_about_z(rot_theta, x, y, z)

xyz = [x.'   ;
        y.'  ;
        z.'] ;
rot_x = [cos(rot_theta), -sin(rot_theta), 0    ;
         sin(rot_theta), cos(rot_theta), 0 ;
         0, 0,  1] ;
     
xyz_rot = []    ; 
for i =1:length(x)

    xyz_no = rot_x * xyz(:,i);
    xyz_rot = [xyz_rot, xyz_no];
end
    
x = xyz_rot(1,:); x=x.' ;
y = xyz_rot(2,:); y=y.' ;
z = xyz_rot(3,:); z=z.' ;

end


%% Below is the original function in python
% def rotate_about_z(theta_rot,xs,ys,zs):
%     '''This function defines a matrix that rotates an xyz data set abut the z-axis by some theta
%     Inputs: angle of rotation, xyz coordinates 
%     Outputs: rotated xyz coordinates'''
%     xyz = np.matrix((xs, ys, zs))
%     Rot_z = np.matrix([[np.cos(theta_rot), -np.sin(theta_rot), 0], 
%                        [np.sin(theta_rot), np.cos(theta_rot), 0], 
%                        [0,0,1]])
%     xyz_Rot =[]
%     for i in range(len(xs)):
%         xyz_no = np.matmul(Rot_z,xyz[:,i])
%         xyz_Rot.append((xyz_no))
%    
%     xyz_Rot = np.array((xyz_Rot))
% 
%     xs = xyz_Rot[:,0].reshape((-1,))
%     ys = xyz_Rot[:,1].reshape((-1,))
%     zs = xyz_Rot[:,2].reshape((-1,))