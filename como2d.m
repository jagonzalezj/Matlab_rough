clc
close all
clear all

b=1.3


%%%%%%%     RANDOM NUMBERS GENERATION  NORMAL/UNIFORM
%%%%%%%%  NORMAL
M=40
% m=round(5*randn(10,1))
%m =(randn(M,M))
m=(rand(M,M))
%m=(-pi + (pi+pi).*(rand(M,M)))
%subplot(2,2,1); imagesc(m)
subplot(2,2,2),hist(m(:))
[x,y]=meshgrid(1:M,1:M)
subplot(2,2,1);surf(x,y,m,'edgecolor','none','facecolor','interp')

%%%%%%   UNIFORM
N=40
n=(-pi + (pi+pi).*(rand(N,N)))
% n=(-pi + (pi+pi).*rand(20,1))
%figure
%subplot(2,2,1); imagesc(n)
subplot(2,2,4),hist(n(:))  % reshape(A,[],1)
[x,y]=meshgrid(1:N,1:N)
subplot(2,2,3);surf(x,y,n,'edgecolor','none','facecolor','interp')
%%%%%%%---------------------------------------------

x=0:1/100:2;
y=0:1/100:2;
[xx yy]=meshgrid(x,y);
z(:,:)=[0];
for h=1:M%length(m);
    for i=1:N%length(n);
        mod=(h^2+i^2)^(-b/2);
        z=z+(m(h,i)*mod*cos(2*pi*(h*xx+i*yy)+n(h,i)));

        %         mod=1/(m(h)^2+n(i)^2)^(-b/2);
        %         z=z+(m(h,i)*mod*cos(2*pi*(m(i)*xx+n(h)*yy)+n(h,i)));
        %subplot(2,2,i)
        %surf(xx,yy,z(:,:,i),'edgecolor','none');

    end
end
figure
surf(xx,yy,0.01*(z),'edgecolor','none','facecolor','interp');
axis equal; grid off
%plot3(x,y,z)