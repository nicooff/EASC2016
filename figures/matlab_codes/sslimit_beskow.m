clear all
close all

headerlinesIn=0;
delimiterIn=' ';

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

for j=1:length(b)
formatt='../beskow/data_ReTau180_beskow';
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
formatt='../beskow/data_ReTau360_beskow';
filename=sprintf(formatt,b(j));
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
formatt='../beskow/data_ReTau550_beskow';
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
formatt='../beskow/data_ReTau1000_beskow';
filename=sprintf(formatt);
A = importdata(filename,delimiterIn,headerlinesIn);
i=find(procs(:,3)==A(1,1));
ll=length(A(:,1));
procs(i:i+ll-1,4)=A(:,1);
totalxxt(i:i+ll-1,4)=A(:,2);
commxxt(i:i+ll-1,4)=A(:,3);
compxxt(i:i+ll-1,4)=A(:,4);
totalamg(i:i+ll-1,4)=A(:,5);
commamg(i:i+ll-1,4)=A(:,6);
compamg(i:i+ll-1,4)=A(:,7);
end


% %weak scaling lot
% totamg=totalamg(2:end,:);
% imagesc(log(b(2:end)*32),log(dofs),totamg')
% colormap pink
% ylabel('No. gridpoints')
% xlabel('No. MPI ranks')
% axis xy
% axis square
% colorbar


figure
loglog(procs(:,1),compxxt(:,1),'r')
hold on
loglog(procs(:,1),commxxt(:,1),'b')
hold off
%plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
axis tight
[x1 y1]=ginput(1)

%keyboard
figure
loglog(procs(:,2),compxxt(:,2),'r')
hold on
loglog(procs(:,2),commxxt(:,2),'b')
hold off
%plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
axis tight
[x2 y2]=ginput(1)

% keyboard
figure
loglog(procs(:,3),compxxt(:,3),'r')
hold on
loglog(procs(:,3),commxxt(:,3),'b')
hold off
%plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
axis tight
[x3 y3]=ginput(1)
% 
% keyboard

figure
loglog(procs(:,4),compxxt(:,4),'r')
hold on
loglog(procs(:,4),commxxt(:,4),'b')
hold off
%plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
axis tight
[x4 y4]=ginput(1)
% 
% keyboard
%%% xxt int points
% x is nodes in logscale
x(1) = x1; y(1) = y1; 
x(2) = x2; y(2) = y2;
x(3) = x3; y(3) = y3;
x(4) = x4; y(4) = y4;

xxt_int=[x; y];
%to find N/P one needs to do dofs/x/32

sslim_xxt=dofs(1:4)./xxt_int(1,:)/32

% I would average this to about 2000
%%%%%%%%%%%%%%for amg
disp(['amg'])
figure
loglog(procs(:,1),compamg(:,1),'r')
hold on
loglog(procs(:,1),commamg(:,1),'b')
hold off
%plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
axis tight
%set(gca,'XTick',procs(:,1))
[x1 y1]=ginput(1)

figure
loglog(procs(:,2),compamg(:,2),'r')
hold on
loglog(procs(:,2),commamg(:,2),'b')
hold off
%plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
axis tight
[x2 y2]=ginput(1)

figure
loglog(procs(:,3),compamg(:,3),'r')
hold on
loglog(procs(:,3),commamg(:,3),'b')
hold off
%plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
axis tight
[x3 y3]=ginput(1)

figure
loglog(procs(:,4),compamg(:,4),'r')
hold on
loglog(procs(:,4),commamg(:,4),'b')
hold off
%plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
axis tight
[x4 y4]=ginput(1)

%%%%%%%%%%%%amg int points
x(1) = x1; y(1) = y1;
x(2) = x2; y(2) = y2;
x(3) = x3; y(3) = y3;
x(4) = x4; y(4) = y4;
amg_int=[x; y]
%to find N/P one needs to do dofs/x/32
sslim_amg=dofs./amg_int(1,:)/32

% for j=1:4
% diffxxt(:,j)=compxxt(:,j)-commxxt(:,j);
% diffamg(:,j)=compamg(:,j)-commamg(:,j);
% end
% 
