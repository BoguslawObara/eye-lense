function im = BOReadImage3D(path,n)
%% Read
info = imfinfo(path);
nf = length(info);
if nargin>1
    nf = n;
end
for i=1:nf
    im(:,:,i) = imread(path,i);
end
end