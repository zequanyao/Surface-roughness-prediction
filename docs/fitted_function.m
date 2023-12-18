clear all;
num=xlsread('Monitored_signal.xlsx');
T=num(:,1);%time
Accelerate=num(:,4);%vibration signal
L=length(T);%the length of the data
n=floor(L/1333);%segment the signal every one rotation period
for i=1:1:n
   a1(:,i)=Accelerate(1+1333*(i-1):1333*i);%segment the vibration
   maxa1(i,1)=max(a1(:,i));%max value
end
l1=-32.8:0.2:-32.8+0.2*(n-1);%corresponding position of the vibration
p=polyfit(l1,maxa1,2);%fit the scatter
clc_acc= polyval(p,l1);
figure(1)
plot(l1,maxa1,'o')
hold on
plot(l1,clc_acc)
hold off
xlabel('Position/mm');
ylabel('Acceleration/g');
set(gcf,'position',[100,80,800,500]);