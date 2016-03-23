clear all
close all

headerlinesIn=0;
delimiterIn=' ';

fontsize_labels = 18;
fontsize_grid   = 16;
fontname = 'Times';

%180: 8-1140
%360: 128-4096
%550: 512-16384
%1000: 2048-32768
a=[180, 360, 550, 1000];
b=[8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768]; 

nel=[36480,237120,853632, 1264032];%  
pol=[8, 8, 8, 12];%

dofs=nel.*pol.^3;
procs=NaN(size(b,2),size(a,2));
totalxxt=NaN(size(b,2),size(a,2));
commxxt=NaN(size(b,2),size(a,2));
compxxt=NaN(size(b,2),size(a,2));
totalamg=NaN*ones(size(b,2),size(a,2));
commamg=NaN(size(b,2),size(a,2));
compamg=NaN(size(b,2),size(a,2));
refamg=NaN(size(b,2),size(a,2));
effamg=NaN(size(b,2),size(a,2));


formatt='mira/data_ReTau180';
filename=sprintf(formatt);
A = importdata(filename,delimiterIn,headerlinesIn);
ll=length(A(:,1));
procs(1:ll,1)=A(:,1);
totalxxt(1:ll,1)=A(:,2);
commxxt(1:ll,1)=A(:,3);
compxxt(1:ll,1)=A(:,4);
totalamg(1:ll,1)=A(:,5);
commamg(1:ll,1)=A(:,6);
compamg(1:ll,1)=A(:,7);
refamg(:,1)=compamg(2,1)*procs(2,1)./procs(:,1);
effamg(2:end,2)=totalamg(2,1)*procs(2,1)./(totalamg(2:end,1).*procs(2:end,1));

formatt='mira/data_ReTau360';
filename=sprintf(formatt);
A = importdata(filename,delimiterIn,headerlinesIn);
i=find(procs(:,1)==A(1,1));
ll=length(A(:,1));
procs(i:i+ll-1,2)=A(:,1);
totalxxt(i:i+ll-1,2)=A(:,2);
commxxt(i:i+ll-1,2)=A(:,3);
compxxt(i:i+ll-1,2)=A(:,4);
totalamg(i:i+ll-1,2)=A(:,5);
commamg(i:i+ll-1,2)=A(:,6);
compamg(i:i+ll-1,2)=A(:,7);
refamg(:,2)=compamg(i,2)*procs(i,2)./procs(:,2);
effamg(:,2)=totalamg(i,2)*procs(i,2)./(totalamg(:,2).*procs(:,2));

formatt='mira/data_ReTau550';
filename=sprintf(formatt);
A = importdata(filename,delimiterIn,headerlinesIn);
i=find(procs(:,2)==A(1,1));
ll=length(A(:,1));
procs(i:i+ll-1,3)=A(:,1);
totalxxt(i:i+ll-1,3)=A(:,2);
commxxt(i:i+ll-1,3)=A(:,3);
compxxt(i:i+ll-1,3)=A(:,4);
totalamg(i:i+ll-1,3)=A(:,5);
commamg(i:i+ll-1,3)=A(:,6);
compamg(i:i+ll-1,3)=A(:,7);
refamg(:,3)=compamg(i,3)*procs(i,3)./procs(:,3);
effamg(:,3)=totalamg(i,3)*procs(i,3)./(totalamg(:,3).*procs(:,3));

formatt='mira/data_ReTau1000';
filename=sprintf(formatt);
A = importdata(filename,delimiterIn,headerlinesIn);
i=find(procs(:,3)==A(1,1));
ll=length(A(:,1));
procs(i:i+ll-1,4)=A(:,1);
totalxxt(i:i+ll-1,4)=NaN;
commxxt(i:i+ll-1,4)=NaN;
compxxt(i:i+ll-1,4)=NaN;
totalamg(i:i+ll-1,4)=A(:,2);
commamg(i:i+ll-1,4)=A(:,3);
compamg(i:i+ll-1,4)=A(:,4);
refamg(:,4)=compamg(i,4)*procs(i,4)./procs(:,4);
effamg(:,4)=totalamg(i,4)*procs(i,4)./(totalamg(:,4).*procs(:,4));

% %weak scaling lot
% totamg=totalamg(2:end,:);
% imagesc(log(b(2:end)*32),log(dofs),totamg')
% colormap pink
% axis xy
% axis square
% colorbar

for i=1:4
format='Scaling, ReTau%d';
filename=sprintf(format,a(i));
    
figure(i)
loglog(procs(:,i)*32,compxxt(:,i),'r', 'linewidth',2)
hold on
loglog(procs(:,i)*32,commxxt(:,i),'r--', 'linewidth',2)
loglog(procs(:,i)*32,totalxxt(:,i),'-rs', 'linewidth',2)
loglog(procs(:,i)*32,refamg(:,i),'g', 'linewidth',2)
loglog(procs(:,i)*32,compamg(:,i),'b', 'linewidth',2)
loglog(procs(:,i)*32,commamg(:,i),'b--', 'linewidth',2)
loglog(procs(:,i)*32,totalamg(:,i),'-bs', 'linewidth',2)
x0=10;
y0=10;
width=500;
height=300;
set(gcf,'units','points','position',[x0,y0,width,height])

set(gca,'XTick',procs(:,i)*32)
%set(gca,'YTick',procs(:,i)*32)
set(gca,'XTickLabel',procs(:,i))
set(gca,'FontName',fontname)
set(gca,'FontSize',fontsize_grid)
set(gca,'FontSize',fontsize_labels)
axis tight
grid on
ylabel('Time (seconds)')
xlabel('No. nodes (MPI ranks/32)')
title(filename);
ritaprint
%%%% parallel efficiency.. IS CRAP
% figure(44)
% semilogx(procs(:,i)*32,effamg(:,i),'-b*', 'linewidth',2)
% hold on
% grid on
% %rita
end

