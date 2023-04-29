clc
close all
clear all


N=70;
M=N;
% sfrN=-N:N;
% sfrM=-M:M;
m=0+1*randn(N,M);

%%% autocorrelation function
%%%%% FIRST PART CIRCULAR FILTER
a=0.20;
k=-13:1:13;
l=k;
sig=1;
bx=4;
by=12;


% z(:,:)=[0];
salida=[];

for ii=1:N/2
    for jj=1:M/2

z=0;
        for i=1:length(k);
            for j=1:length(l);
                if or(k(i),l(j)) == 0
                else
                    argu=2*pi*a*sqrt(k(i)^2 + l(j)^2);
                    bes=besselj(1,argu);
                    hkl=a*(bes/(k(i)^2 + l(j)^2)^(1/2));
%                     z=z+(m(ii+i,jj+j)*hkl);
                    
                    Rzz=(sig^2)*exp(-2.3*((k(i)/bx)^2 + (l(j)/by)^2)^(1/2));
                    z=z+(m(ii+i,jj+j)*Rzz);

                    

                end
            end
        end
        Z(ii,jj)=z;
    end
 
end

% [K,L]=meshgrid(k,l);
% surf(K,L,Datos);
% figure

[x,y]=meshgrid(1:1:length(Z(1,:)),1:1:length(Z(:,1)));
surf(x,y,Z,'edgecolor','none','facecolor','interp');


