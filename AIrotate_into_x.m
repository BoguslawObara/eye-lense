function [dirx, angle_intox] = AIrotate_into_x(dir)
y = dir(2); z = dir(3) ;

d = sqrt(y^2 + z^2) ;

rot_into_x = [1, 0,    0    ;
              0, y/d,  z/d  ;
              0, -z/d, y/d]  ;

dirx = rot_into_x*dir ;

angle_intox = acos(y/d) ; 

disp('dirx =') ; disp (dirx)
disp('angle =') ; disp(angle_intox)
end


% This is the original python code for this function.
% def rotate_into_x(dir):
%     '''This function defines a matrix that rotates an arbitrary vector into the xy-plane.
%     Inputs: xyz vector 
%     Outputs: xyz vector rotated into the xy-plane, angle of rotation'''
%     y, z = dir[1], dir[2]
%     d = np.sqrt(y**2 + z**2)
%     rot_into_x = np.matrix([[1, 0, 0], 
%                             [0, y/d, z/d], 
%                             [0, -z/d, y/d]])
%     dirxmat = np.matmul(rot_into_x, dir)
%     dirx = np.zeros(3)
%     dirx[0], dirx[1], dirx[2] = dirxmat[0], dirxmat[1], dirxmat[2]
%     
%     angle = np.arccos(y/np.sqrt(y**2 + z**2))
%     
%     return dirx, angle
