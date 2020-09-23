function im = BONormalizeImageND(im)
%% Normalize image
im = double(im); im = (im - min(im(:))) ./ (max(im(:)) - min(im(:))); 
end