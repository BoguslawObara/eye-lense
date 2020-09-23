function BOPlotMaxProjection2D(im,np,rx,ry)
%%
np(:,1) = np(:,1)/rx;
np(:,2) = np(:,2)/ry;
%%
immax = max(im,[],3);
immax = double(immax); immax = (immax - min(immax(:))) / (max(immax(:)) - min(immax(:))); 
imagesc(immax), colormap gray; hold on; axis equal; axis tight;
set(gca,'xtick',[]); set(gca,'ytick',[]);
plot(np(:,2),np(:,1),'.r');
end