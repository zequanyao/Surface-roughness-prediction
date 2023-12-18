clear all;
close all;
num=xlsread('Signal_under_S900.xlsx');
T=num(:,1);%time
A=num(:,2);%vibration
L=length(T);%length of signal
orig=zeros(L,1);
l1=-51.678:3/20000:51.678;%corresponding position of each data point
l=l1';
for i=1:1:L
    orig(i,1)=-0.01358*l(i,1).^2-0.03363*l(i,1)+50.07;%fitted curve
end
ans1=max(orig);%the max value of the fitted function
for i=1:1:L
    xishu(i,1)=ans1/orig(i,1);
    newA(i,1)=xishu(i,1).*A(i,1);
end
figure(1);
plot(l,A,'b:');
xlabel('Position/mm')
ylabel('Original vibration/g');
title('Original vibration signal');
set(gcf,'position',[100,80,800,500]);
figure(2);
plot(l,newA,'r-.');
xlabel('Position/mm')
ylabel('Compensated vibration/g');
title('Compensated vibration signal');
set(gcf,'position',[100,80,800,500]);