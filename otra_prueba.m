clc
close all
clear all


%%%%%%%%  NORMAL
N=100
% m=round(5*randn(10,1))
m =(randn(N,N))
subplot(2,2,1); imagesc(m)
subplot(2,2,2),hist(m(:))
[x,y]=meshgrid(1:N,1:N)
subplot(2,2,3);surf(x,y,m,'edgecolor','none','facecolor','interp')


%%%%%%   UNIFORM
M=100
n=10*(rand(M,M))
% n=(-pi + (pi+pi).*rand(20,1))
figure
subplot(2,2,1); imagesc(n)
subplot(2,2,2),hist(n(:))  % reshape(A,[],1)
[x,y]=meshgrid(1:M,1:M)
subplot(2,2,3);surf(x,y,n,'edgecolor','none','facecolor','interp')