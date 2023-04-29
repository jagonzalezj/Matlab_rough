clc
close all
clear all

b=-1/4
N=20


x=0:1/N:1;
%y=0:celpa:1;
%     ud1=rand(length(x),1);
%     gd1=randn(length(x),1);
%     ramdoms=[ud1 gd1]
    
    BB=load('ramdoms.txt')
    ud1=BB(:,1)
    gd1=BB(:,2)


% for yy=1:length(y)
for h=1:1
for i=1:length(x)
    %%%% _--------- 1 D --------------
    A(i)=1/(ud1(i)^2+gd1(i)^2)^(b/2);
    z(i)=cos(2*pi*(gd1(i)*x(i)));%+ud1(i)
    z1(i)=A(i)*cos(2*pi*(gd1(i)*x(i)));%+ud1(i)
    z2(i)=A(i)*cos(2*pi*(gd1(i)*x(i))+ud1(i));   
    %plot(x(i),z(i),'-o');hold on;%ylim([-1 -0.4])
    %[xx yy]=meshgrid(x,y)
    %z=0.05*cos(2*pi*(m*xx+n*yy))
    %surf(xx,yy,z,'edgecolor','none','facecolor','interp','facelighting','gouraud')
    %axis equal
end

subplot(1,2,2*h-1);plot(x,z,'-o','linewidth',1,'markersize', 6), hold on
plot(x,z1,'k-s','linewidth',1,'markersize', 6)
plot(x,z2,'r-^','linewidth',1,'markersize', 6)
plot(x,cos(2*pi*x),'g-','linewidth',1)
hold off

subplot(1,2,2*h);plot(x,smooth(z),'-o','linewidth',1,'markersize', 6), hold on
plot(x,smooth(z1),'k-s','linewidth',1,'markersize', 6)
plot(x,smooth(z2),'r-^','linewidth',1,'markersize', 6)
plot(x,cos(2*pi*x),'g-','linewidth',1)
hold off

%legend({'$\frac{1}{r^3}$','$cos(2*pi*(gd*x))$','$cos(2*pi*(gd*x))$','$cos(2*pi*(gd*x))$'},'interpreter','latex');
  %set(h,'Interpreter','latex')
end

%print primerab -djpeg -r600
% end
