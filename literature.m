clear
clc
%http://www.programering.com/q/MzM0ETNwATA.html
N=512;
L=0.05;
delta=0.05;%Surface RMS roughness
betax=10;%The correlation length x in the direction of
betay=10;
C=1;%Power spectral density

dx=L/N;dy=dx;
NN=-N/2:N/2-1;
[Nx,Ny]=meshgrid(NN,NN);
taux=dx.*Nx;tauy=dy.*Ny;

%%To generate a specified from the rough surface correlation function
eta=randn(N,N);%Gauss white noise
A=fft2(eta);%Fu Liye transform
R=zeros(N,N);
R=delta^2*exp(-2.3*((taux/betax).^2+(tauy/betay).^2).^0.5);%The autocorrelation function
Gz=1/(2*pi^2).*fft2(R);%The power spectral density function
H=(Gz/C).^0.5;%Transfer function
Z=H.*A;%Fourier transform surface height
z=ifft2(Z);%The surface height distribution

figure(1)
%meshz(abs(z));
surf(Nx,Ny,abs(z),'edgecolor','none','facecolor','interp')
% title('rough surface');
 %axis equal
