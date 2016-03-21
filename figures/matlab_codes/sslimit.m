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
formatt='mira/data_ReTau360';
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

% 
% figure
% loglog(procs(:,1),compxxt(:,1),'r')
% hold on
% loglog(procs(:,1),commxxt(:,1),'b')
% hold off
% %plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
% axis tight
% [x y]=ginput(1)

% keyboard
% figure
% loglog(procs(:,2),compxxt(:,2),'r')
% hold on
% loglog(procs(:,2),commxxt(:,2),'b')
% hold off
% %plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
% axis tight
% [x y]=ginput(1)

% keyboard
% figure
% loglog(procs(:,3),compxxt(:,3),'r')
% hold on
% loglog(procs(:,3),commxxt(:,3),'b')
% hold off
% %plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
% axis tight
% [x y]=ginput(1)
% 
% keyboard
%%% xxt int points
% x is nodes in logscale
x(1) = 259.5579; y(1) = 1.4926; 
x(2) = 2.2236e+03; y(2) =1.8102;
x(3) = 6.5141e+03; y(3) =3.0878;

xxt_int=[x; y];
%to find N/P one needs to do dofs/x/32

sslim_xxt=dofs(1:3)./xxt_int(1,:)/32

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
set(gca,'XTick',procs(:,1))
%[x y]=ginput(1)

figure
loglog(procs(:,2),compamg(:,2),'r')
hold on
loglog(procs(:,2),commamg(:,2),'b')
hold off
%plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
axis tight
%[x y]=ginput(1)

figure
loglog(procs(:,3),compamg(:,3),'r')
hold on
loglog(procs(:,3),commamg(:,3),'b')
hold off
%plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
axis tight
%[x y]=ginput(1)


figure
loglog(procs(:,4),compamg(:,4),'r')
hold on
loglog(procs(:,4),commamg(:,4),'b')
hold off
%plot(procs(:,1),compxxt(:,1)-commxxt(:,1),'k')
axis tight
%[x y]=ginput(1)

%%%%%%%%%%%%amg int points
x(1) = 231.5300; y(1) = 1.6765 ;
x(2) = 1.3602e+03; y(2) = 2.1183;
x(3) = 4.4047e+03; y(3) = 2.6172 ;
x(4) = 1.4145e+04; y(4) =  2.9021;
amg_int=[x; y]
%to find N/P one needs to do dofs/x/32
sslim_amg=dofs./amg_int(1,:)/32

% for j=1:4
% diffxxt(:,j)=compxxt(:,j)-commxxt(:,j);
% diffamg(:,j)=compamg(:,j)-commamg(:,j);
% end
% 
