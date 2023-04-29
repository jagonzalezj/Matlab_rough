clc
close all
clear all

%%%%%%%%%%%%%%%%%%  lOADING FILES OF ATOMS POSITIONS
A=load('alum.cfg');
tama=size(A);
repeatedx=unique(A(:,1)); dx=repeatedx(2);         % The second element of repeated is the Delta dx dy dz
repeatedy=unique(A(:,2)); dy=repeatedy(2);
repeatedz=unique(A(:,3)); dz=repeatedz(2);

%%%%%%%%%%%%%%%%%%%  Parameters for surface-------------------------
B=1.9;
C1=0.01;
N=30;
M=N;
sfrN=-N:N;
sfrM=-M:M;
% %%%%%%%     RANDOM NUMBERS GENERATION  NORMAL/UNIFORM-------------
%%%%%%%%  NORMAL
m=0+1*randn(length(sfrM),length(sfrN));
%%%%%%   UNIFORM
n=-pi/2+(pi/2+pi/2).*rand(length(sfrM),length(sfrN));

% save('nra.txt','n','-ascii');       %% for using saved random matrices
% save('mra.txt','m','-ascii');
% n=load('nra.txt');
% m=load('mra.txt');   %%%%%-------------------------------------------

%%%%%%%%%  PLOTING STATITICAL ANALYSIS OF RANDOM NUMBERS
% %%%%%%%%  NORMAL
% subplot(2,2,2),hist(m(:))
% [x,y]=meshgrid(1:length(sfrN),1:length(sfrN))      %compatible with comsol
% subplot(2,2,1);surf(x,y,m,'edgecolor','none','facecolor','interp'), grid off

% %%%%%%   UNIFORM
% subplot(2,2,4),hist(n(:))  % reshape(A,[],1)
% [x,y]=meshgrid(1:length(sfrN),1:length(sfrN))
% subplot(2,2,3);surf(x,y,n,'edgecolor','none','facecolor','interp'); grid
% off
%%%%%%%---------------------------------------------

% x=-0.5:1/100:0.5;
% y=-0.5:1/100:0.5;
x=0:dx:2;
y=0:dy:2;
[xx yy]=meshgrid(x,y);
for L=1:length(B);b=B(L);
    z(:,:)=[0];
    for h=1:length(sfrM)      %M%length(m);
        for i=1:length(sfrN)  %N%length(n);
            if or(sfrM(h),sfrN(i)) == 0
            else
                mod=(sfrM(h)^2+sfrN(i)^2)^(-b/2);
                %mod=1;
                z=z+(m(h,i)*mod*cos(2*pi*(sfrM(h)*xx+sfrN(i)*yy)+n(h,i)));
                %z=z+(mod*cos(pi*(xx+yy)));
            end
        end
    end
    % figure %('Color','white')
    % %subplot(2,2,L);
    %surf(xx,yy,1.01+C1*(z),'edgecolor','none','facecolor','interp'); hold on
    %contour3m(xx',yy',0.01*(z),50)%,'EdgeColor','black')%,50,'LineColor','black'); grid off
    grid off; colormap('jet'); hcb=colorbar; %title(hcb,'Height','fontsize',14);%caxis([-0.05 0.05]);
end
z=C1*z; % normalization
z=max(repeatedz)-max(z(:))+z;   % desplacement to top

nlay=ceil((max(z(:))-min(z(:)))/dz)+1
%surf(xx,yy,(1-max(C1*z(:)))+C1*(z),'edgecolor','none','facecolor','interp'); hold on;

surf(xx,yy,z,'edgecolor','none','facecolor','interp'); hold on;
%adcount=[A (1:tama(1))']           % Add Count in last column
adcount=A;  % temporalmente
%D=sortrows(adcount,3)              % Organize by planes respect to z

   
%plot3(A(:,1),A(:,2),A(:,3),'ko','MarkerFaceColor',[0.5 0.5 0.5],'MarkerSize',5)





%%%%%%  FIGURE PROPIERTIES.............
 %xlabel('X','fontsize',12)
 %ylabel('Y','fontsize',12)
 set(gca,'fontsize',12)
 %set(gca,'ZTick',[])
 %set(gca,'yTick',[])
 %set(gca,'xTick',[])
% title('Rough Surface')
 axis equal;
% shading interp;
% camlight;
% axis tight
% camproj('perspective')
% camproj('orthographic')
 grid off
