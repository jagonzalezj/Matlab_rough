clc
close all
clear all
p=['k','g','y','b']



x=0:0.01:1;

y1=cos(x);
plot(x,y1,'-k','linewidth',4),hold on

y2=cos(2*pi*x);
plot(x,y2,'-g','linewidth',3),hold on

plot(x,y1+y2,'*')

y3=cos(2*pi*x+pi/0.2);
plot(x,y3,'-y','linewidth',3),hold on




y4=cos(2*pi*x+3*pi/2);
plot(x,y4,'-o'),hold on

plot(x,(9)^(-1.8/2)*(y4+y3+y1),'k*')