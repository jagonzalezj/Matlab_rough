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
%B=[0.2 0.4 0.6 0.8 1.2 1.4 1.6 1.8 2 2.2 2.4 2.6 2.8 3 3.2 3.4 3.6 3.8 4 ];
B=[1.2 1.8];
C1=0.01;
N=30;
M=N;
sfrN=-N:N;
sfrM=-M:M;



for betas=1:length(B)
    datos=[];
for G=1:3, b=B(betas);
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
         figure %('Color','white')
        surf(xx,yy,1.01+C1*(z),'edgecolor','none','facecolor','interp'); hold on
        contour3m(xx',yy',0.01*(z),50)%,'EdgeColor','black')%,50,'LineColor','black'); grid off
    end
    z=C1*z; % normalization
    %%%%%%%%%%  STATISTICS----------------------
    line=mean(z(:));
    % %%%% Mean line
    %line=(sum(z(:)))/length(z(:))
    % %%%% STD
    standarddev=std(z(:));
    % stdev=sqrt(sum(((z(:)-line)).^2)/length(z(:)))
    % %%%% RMS
    rms=sqrt(sum(((z(:))).^2)/length(z(:)));
    % %%%% Skewness
    sk=skewness(z(:));
    % skew=sum(((z(:)-line)).^3)/(length(z(:))*stdev^3)
    % %%%% kurtosis
    kur=kurtosis(z(:));
    % kur=sum(((z(:)-line)).^4)/(length(z(:))*stdev^4)

    datos(G,:)=[b line standarddev rms abs(sk) kur];
    % hist(z(:),18)
    %break
    %%%%%%%%%%% --------------------------------


    %z=C1*z; % normalization
    %z=max(repeatedz)-max(z(:))+z;   % desplacement to top

    % A=A(tama(1)/1.15:end,:);  %%%% remove for full size atoms positions
    % tama=size(A);

    % save z.txt z -ascii
    % save x.txt x -ascii
    % save y.txt y -ascii
    %
    % save xx.txt xx -ascii
    % save yy.txt yy -ascii
    %     if G==1
    %         ax(1)=axes('position',[0.05 0.55 0.35 0.40]);
    %     elseif G==2
    %         ax(2)=axes('position',[0.05 0.05 0.35 0.40]);
    %
    %     elseif G==3
    %         ax(3)=axes('position',[0.45 0.55 0.35 0.40]);
    %     else
    %         ax(4)=axes('position',[0.45 0.05 0.35 0.40]);
    %     end




    %surf(xx,yy,z,'edgecolor','none','facecolor','interp'); % axis equal; grid off% hold on;
    %     %xlabel('X','fontsize',14)
    %     %ylabel('Y','fontsize',14)
    %     set(gca,'fontsize',14)
    %     set(gca,'ZTick',[])
    %     set(gca,'YTick',0:0.2:1)
    %     set(gca,'XTick',0:0.2:1)
    %     caxis([-0.05 0.06]);

end

datos(G+1,:)=[0];
datos(G+2,:)=[mean(datos(1:G,:))];
salida(betas,:)=[datos(G+2,:)];
end

pause
subplot(1,2,1)
%ax(1)=axes('position',[0.02 0.20 0.40 0.80])
[AX,H1,H2]=plotyy(salida(:,1),salida(:,4),salida(:,1),salida(:,2));
set(H1,'marker','s','MarkerSize',10,'linewidth',2);
set(H2,'marker','o','MarkerSize',10,'linewidth',2);
set(get(AX(1),'Ylabel'),'String','RMS','fontsize',14) 
set(get(AX(2),'Ylabel'),'String','l','fontsize',14)
xlabel('b','fontsize',16)
set(AX(1),'YTick',0:0.05:0.3,'fontsize',14,'linewidth',2)
set(AX(2),'YTick',-1:0.5:2,'fontsize',14,'linewidth',2)
set(AX(2),'ylim',([-1 2]))
axis(AX,'square'), hold on
hold off

subplot(1,2,2)
[AX,H1,H2]=plotyy(salida(:,1),salida(:,5),salida(:,1),salida(:,6));
set(H1,'marker','s','MarkerSize',10,'linewidth',2);
set(H2,'marker','o','MarkerSize',10,'linewidth',2);
set(get(AX(1),'Ylabel'),'String','sk','fontsize',14) 
set(get(AX(2),'Ylabel'),'String','K','fontsize',14)
xlabel('b','fontsize',16)
set(AX(1),'YTick',0:0.2:1,'fontsize',14,'linewidth',2)
set(AX(2),'YTick',0:0.5:3.5,'fontsize',14,'linewidth',2)
axis(AX,'square')
% h=colorbar
% set(h,'position',[0.85 0.05 0.05 0.90])

%plot3(A(:,1),A(:,2),A(:,3),'ko','MarkerFaceColor',[0.5 0.5 0.5],'MarkerSize',5)

% plot3(A(tama(1)/1.2:end,1),A(tama(1)/1.2:end,2),A(tama(1)/1.2:end,3),'ko','MarkerFaceColor',[0.5 0.5 0.5],'MarkerSize',5)
% %%%%%  FIGURE PROPIERTIES.............
%  xlabel('X','fontsize',14)
%  ylabel('Y','fontsize',14)
%  set(gca,'fontsize',14)
%  set(gca,'ZTick',[])
% set(gca,'yTick',[])
% set(gca,'xTick',[])
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