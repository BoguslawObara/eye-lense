function np = BOBlobDetector3D(imn,imm,ns,t,f)
%%  BOBlobDetector3D - 3D blob detector
%   
%   REFERENCE:
%       B. Obara and A. Jabeen and N. Fernandez and P. P. Laissue,
%       A novel method for quantified, superresolved, three-dimensional 
%       colocalisation of isotropic, fluorescent particles,
%       Histochemistry and Cell Biology, 139, 3, 391-402, 2013 
%
%   INPUT:
%       imn     - blob channel
%       imm     - membrane channel
%       ns      - blob size[pixels] = 
%                   ns[microns]*[1/resolutionx 1/resolutiony 1/resolutionz]
%       t       - lowest intensity bound,
%
%   OUTPUT:
%       np      - detected blob positions
%                   np(:,1) -> x
%                   np(:,2) -> y
%                   np(:,3) -> z
%                   np(:,4) -> average intensity of blob volumes
%                   np(:,5) -> average LoG intensity of blob volumes
%
%   AUTHOR:
%       Boguslaw Obara, http://boguslawobara.net/
%
%   VERSION:
%       0.1 - 30/06/2009 First implementation
%       0.2 - 04/06/2010 LoG + revision
%       0.3 - 24/09/2010 Speed up
%%
if nargin<5; f = 1.1; end
ns(ns<1) = 1;
%% LoG
imlog = BOBlobFilter3D(imn,ns);
%% Finding seeds
np = BOSeedSearch3D(imlog,ns,t);
%% Filtering
dt = BOMaskDescriptor3D(imn,imlog,np,ns);
if ~isempty(imm)
    np = BOProfileDescriptor3D(imm,np,dt,f*ns);
else
    np = BOStatDescriptor3D(imn,np,dt,f*ns);
end
%% Average intensity values          
np(:,5) = dt(np(:,4),1);
np(:,6) = dt(np(:,4),2);
%np(:,7) = dt(np(:,4),3);
np(:,4) = []; % remove indices
end