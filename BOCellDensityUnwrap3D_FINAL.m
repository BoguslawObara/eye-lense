%% Clear
clc; close all; clear all;
%% Settings
dirname = 'F:/AlexiaEye/TIFFS/';
%dirname = 'change this';
filename = 'LENS01';
%filename = 'change this';
file_ext = '.tif';
file_ext2 = '.png';
%% Load XYZ in rect
load(['./mat/' filename '_xyz_r.mat']);
%% Res
rx = 1515.2; ry = rx; rz = 5977.4;
%change rx and rz to image metadata;
%% Fit
p = polyfitn([xs,ys],zs,3);
zg = polyvaln(p,[xs,ys]);
zgli = polyvaln(p,[yli',xli']);
%% Plot
% figure;
% plot3(ys,xs,zs,'g.');
% hold on;
% plot3(ys,xs,zg,'ro');
% plot3(xli,yli,zgli,'b-');
% box on; ax = gca; ax.BoxStyle = 'full';
%% Divide line into segments
ns = 100; % number of segments
%d = sqrt(diff(xli').^2 + diff(yli').^2 + diff(zgli).^2);
d = sqrt(diff(rx*xli').^2 + diff(ry*yli').^2 + diff(rz*zgli).^2);
ds = sum(d);
dsc = cumsum(d);
dn = ds/ns;
idx = zeros(ns+1,1);
idx(ns+1) = length(d);
for i=0:ns-1
    idx(i+1) = find(dsc>i*dn,1,'first');
end
%% Sort points into segments
sg = zeros(length(xs),1);
for i=1:ns
    p1 = [yli(idx(i)) xli(idx(i)) zgli(idx(i))];
    p2 = [yli(idx(i+1)) xli(idx(i+1)) zgli(idx(i+1))];
    %[p1; p2]
    for j=1:length(xs)
        p0 = [xs(j) ys(j) zs(j)];
        pi = BOLinePoint3D(p1,p2,p0);
        %hold on;
        % Is intersection point on the line segment?
        n1 = norm(pi-p1) + norm(pi-p2);
        n2 = norm(p1-p2);
        if abs(n1-n2)<1
            sg(j) = i;
            %plot3(pi(2),pi(1),pi(3), 'r.');
        end
    end
end
%% Plot
cmap = jet(ns+1);
figure;
%plot3(ys,xs,zs,'g.');
hold on;
%plot3(ys,xs,zg,'ro');
plot3(xli,yli,zgli,'b-');
for i=1:ns+1
    plot3(xli(idx(i)),yli(idx(i)),zgli(idx(i)),'bo');
end    
for i=0:ns
    plot3(ys(sg==i),xs(sg==i),zs(sg==i),'.','MarkerSize',10,'MarkerFaceColor',cmap(i+1,:));
end
view(3); box on; ax = gca; ax.BoxStyle = 'full';
print('-dpng','-r300',['./plot/' filename '_stripes.png']);
%% Hist
for i=1:ns
    h(i) = sum(sg==i);
end
%figure; plot(1:ns,h,'r.-');
figure; plot(1:ns,h/ds,'r.-');
print('-dpng','-r300',['./plot/' filename '_density.png']);
%return
%% Plot
%% Load imagesH = [(1:ns)' h'];
ims = BOReadImage3DC([dirname filename file_ext]);
ims = squeeze(max(ims,[],3));
ims = BONormalizeImageND(ims);
imm = max(ims,[],3); % max projection of stack
%
figure; imagesc(imm); colormap gray; axis off; axis equal; axis tight;
hold on; plot(xli,yli,'r-','LineWidth',2);
%hold on; plot(ys,xs,'g.');
for i=1:ns
    plot(ys(sg==i),xs(sg==i),'o','MarkerSize',2,'MarkerFaceColor',cmap(i,:));
end
print('-dpng','-r300',['./plot/' filename '_stripes_im.png']);
%% Save
D = [xs ys zs sg];
H = [(1:ns)' (h/ds)'];
dlmwrite(['./mat/' filename '_xyz_class.txt'],D,'delimiter','\t');
dlmwrite(['./mat/' filename '_hist_class.txt'],H,'delimiter','\t');