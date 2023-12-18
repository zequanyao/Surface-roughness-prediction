clc
clear
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
%%
for i=1:1:n
    position_1(:,i)=position(1+data_len*(i-1):data_len*i);
    position_2(i,1)=mean(position_1(:,i));
    newA_1(:,i)=newA(1+data_len*(i-1):data_len*i);
    acc_maxx(i,1)=0;
    acc_minn(i,1)=0;
        for j=1:1:m
            c1(:,j)=newA_1(point_num*(j-1)+1:point_num*j,i);
            c2(j,1)=max(c1(:,j));%max value
            c3(j,1)=-1*min(c1(:,j));%min value
            c4(j,1)=c2(j,1)+c3(j,1);
            acc_maxx(i,1)=acc_maxx(i,1)+max(c1(:,j));
            acc_minn(i,1)=acc_minn(i,1)+min(c1(:,j));
        end
 %feature extraction
        acc_max(i,1)=acc_maxx(i,1)/m;%peak
        acc_min(i,1)=acc_minn(i,1)/m;%valley
        acc_pk(i,1)=acc_max(i,1)-acc_min(i,1);%PV
        acc_max_rms(i,1)=sqrt((sum(c2.^2))/m);%RMS-P
        acc_min_rms(i,1)=sqrt((sum(c3.^2))/m);%RMS-V
        acc_pk_rms(i,1)=sqrt((sum(c4.^2))/m);%RMS-PV
        acc_mean(i,1)=mean(newA_1(:,i));%mean
        acc_var(i,1)=var(newA_1(:,i));%Var
        acc_std(i,1)=std(newA_1(:,i));%Std
        acc_rms(i,1)=rms(newA_1(:,i));%RMS
        acc_kur(i,1)=kurtosis(newA_1(:,i));%Kur
        acc_ske(i,1)=skewness(newA_1(:,i));%Ske
        acc_av(i,1)=mean(abs(newA_1(:,i)));%ARV
        acc_kf(i,1)=sum(newA_1(:,i).^4)/sqrt(sum(newA_1(:,i).^2));%KF
        acc_ff(i,1)=acc_rms(i,1)/acc_av(i,1);%FF
        acc_cf(i,1)=acc_pk(i,1)/acc_rms(i,1);%CF
        acc_pf(i,1)=acc_pk(i,1)/acc_av(i,1);%PF
        acc_xr(i,1)=mean(sqrt(abs(newA_1(:,i))))^2;
        acc_mf(i,1)=acc_pk(i,1)/acc_xr(i,1);%MF
end 
