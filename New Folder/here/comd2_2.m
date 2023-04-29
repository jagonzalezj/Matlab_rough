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
B=[1.2 1.8 2 2.8];
% B=0.8
% C1=0.0001;
C1=0.01;
N=30;
M=N;
sfrN=-N:N;
sfrM=-M:M;

for G=1:1, b=B(G)
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
    x=0:dx:1;
    y=0:dy:1;
    [xx yy]=meshgrid(x,y);

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
        % figure %('Color','white')
        %surf(xx,yy,1.01+C1*(z),'edgecolor','none','facecolor','interp'); hold on
        %contour3m(xx',yy',0.01*(z),50)%,'EdgeColor','black')%,50,'LineColor','black'); grid off
    end

    %%%%%%%%%%  STATISTICS----------------------
    % mean(z(:))
    % %%%% Mean line
    % line=(sum(z(:)))/length(z(:))
    % %%%% STD
    % standarddev=std(z(:))
    % stdev=sqrt(sum(((z(:)-line)).^2)/length(z(:)))
    % %%%% RMS
    % rms=sqrt(sum(((z(:))).^2)/length(z(:)))
    % %%%% Skewness
    % skewness(z(:))
    % skew=sum(((z(:)-line)).^3)/(length(z(:))*stdev^3)
    % %%%% kurtosis
    % kurtosis(z(:))
    % kur=sum(((z(:)-line)).^4)/(length(z(:))*stdev^4)
    % hist(z(:),18)
    %break
    %%%%%%%%%%% --------------------------------


    z=C1*z; % normalization
    %z=max(repeatedz)-max(z(:))+z;   % desplacement to top

    % A=A(tama(1)/1.15:end,:);  %%%% remove for full size atoms positions
    % tama=size(A);

    % save z.txt z -ascii
    % save x.txt x -ascii
    % save y.txt y -ascii
    %
    % save xx.txt xx -ascii
    % save yy.txt yy -ascii
    if G==1
        ax(1)=axes('position',[0.01 0.60 0.50 0.40]);

    elseif G==2
        ax(2)=axes('position',[0.01 0.23 0.50 0.40]);

    elseif G==3
        ax(3)=axes('position',[0.50 0.60 0.50 0.40]);
    else
        ax(4)=axes('position',[0.50 0.23 0.50 0.40]);
    end




    surf(xx,yy,z,'edgecolor','none','facecolor','interp'); % axis equal; grid off% hold on;
%          xlabel('X (\mum)','fontsize',16)
%          ylabel('Y (\mum)','fontsize',16)
%          Zlabel('Z (\mum)','fontsize',16)
    set(gca,'fontsize',16)
    set(gca,'ZTick',[])
    %set(gca,'YTick',0:0.2:1)
    %set(gca,'XTick',0:0.2:1)
    caxis([-0.05 0.06]);
    %  set(gca,'ZTick',[])
    set(gca,'yTick',[])
    set(gca,'xTick',[])
    %set(gca, 'visible', 'off');
    axis equal
    grid off


    if G==1
        text(0.01,0.90,0.30,'A','fontsize',16)
    elseif G==2
        text(0.01,0.90,0.30,'B','fontsize',16)
    elseif G==3
        text(0.01,0.90,0.30,'C','fontsize',16)
    else
        text(0.01,0.90,0.30,'D','fontsize',16)
    end

end
h=colorbar('south')
set(h,'position',[0.1 0.05 0.85 0.05],'FontSize',18)
xlabel(h,'normalized height')


%plot3(A(:,1),A(:,2),A(:,3),'ko','MarkerFaceColor',[0.5 0.5 0.5],'MarkerSize',5)

% plot3(A(tama(1)/1.2:end,1),A(tama(1)/1.2:end,2),A(tama(1)/1.2:end,3),'ko','MarkerFaceColor',[0.5 0.5 0.5],'MarkerSize',5)
% %%%%%  FIGURE PROPIERTIES.............
%  xlabel('X','fontsize',14)
%  ylabel('Y','fontsize',14)
%  set(gca,'fontsize',14)
%  set(gca,'ZTick',[])
% set(gca,'yTick',[])
%  set(gca,'xTick',[])
% set(gca,'YTick',0:0.2:1)
% set(gca,'XTick',0:0.2:1)
% title('Rough Surface')
%  axis equal;
% shading interp;
% camlight;
% axis tight
% camproj('perspective')
% camproj('orthographic')
%  grid off
% grid off; colormap('jet');% hcb=colorbar; %title(hcb,'Height','fontsize',14);
% caxis([-0.05 0.06]);
% colorbar('fontsize',14)  %,'location','south')
%
%
% print('-djpeg','-r600','tredB')