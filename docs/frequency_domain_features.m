clc
clear all
close all
num=xlsread('Compensated_acceleration.xlsx');
S=900;%spindele speed
position=num(:,1);%cuttinging position
newA=num(:,2)./S;%compensated acceleration
L=length(position);
data_len=5332;%number of data point within 0.8mm
n=floor(L/data_len);%segment every 0.8mm
point_num=floor(0.5*20000*60/S);%number of data point within half cutting cycle
m=floor(data_len/point_num);
for i=1:1:n
    position_1(:,i)=position(1+data_len*(i-1):data_len*i);
    position_2(i)=mean(position_1(:,i));
    newA_1(:,i)=newA(1+data_len*(i-1):data_len*i); 
end
fs=20000;%sampling rate
for j=1:1:n
fa=newA_1(:,j);   
[fapows,fafreq] = analyse_power_spectrum(fa,20000);%power spectrum
D1(:,2*j-1)=[fafreq'];%frequency
D1(:,2*j)=[fapows];%amplitude
fa_fc(j,1)=sum(D1(:,2*j-1).*D1(:,2*j))/sum(D1(:,2*j));%GF
fa_msf(j,1)=sum(D1(:,2*j-1).^2.*D1(:,2*j))/sum(D1(:,2*j));%MSF
fa_vf(j,1)=sum((D1(:,2*j-1)-fa_fc(j,1)).^2.*D1(:,2*j))/sum(D1(:,2*j));%VF
end
