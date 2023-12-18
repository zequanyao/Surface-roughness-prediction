%% MIC
clc
close all
all_data=xlsread('all features.xlsx');
Ra1=all_data(:,3);%surface roughness
[x0,peak]=deal(all_data(:,5));%peak
[x1,valley]=deal(all_data(:,6));%valley
[x2,peak_valley]=deal(all_data(:,7));%PV
[x3,half_peak_and_valley]=deal(all_data(:,8));%HPV
[x4,peak_RMS]=deal(all_data(:,9));%RMS-P
[x5,valley_RMS]=deal(all_data(:,10));%RMS-V
[x6,peak_valley_RMS]=deal(all_data(:,11));%RMS-PV
[x7,mean]=deal(all_data(:,12));%mean
[x8,var]=deal(all_data(:,13));%Var
[x9,std]=deal(all_data(:,14));%Std
[x10,RMS]=deal(all_data(:,15));%RMS
[x11,ske]=deal(all_data(:,16));%Ske
[x12,kur]=deal(all_data(:,17));%Kur
[x13,arv]=deal(all_data(:,18));%ARV
[x14,kf]=deal(all_data(:,19));%KF
[x15,cf]=deal(all_data(:,20));%CF
[x16,ff]=deal(all_data(:,21));%FF
[x17,pf]=deal(all_data(:,22));%PF
[x18,mf]=deal(all_data(:,23));%MF
[x19,gf]=deal(all_data(:,24));%GF
[x20,msf]=deal(all_data(:,25));%MSF
[x21,vf]=deal(all_data(:,26));%VF
[x22,energy_1_3]=deal(all_data(:,27));%L3-1
[x23,energy_2_3]=deal(all_data(:,28));%L3-2
[x24,energy_3_3]=deal(all_data(:,29));%L3-3
[x25,energy_4_3]=deal(all_data(:,30));%L3-4
[x26,energy_entropy]=deal(all_data(:,51));%energy entropy
L=length(Ra1);

%%
%calculate mutual information coefficient
mu_in_co(1,1)=calc_mi(Ra1,x0,L);
mu_in_co(1,2)=calc_mi(Ra1,x1,L);
mu_in_co(1,3)=calc_mi(Ra1,x2,L);
mu_in_co(1,4)=calc_mi(Ra1,x3,L);
mu_in_co(1,5)=calc_mi(Ra1,x4,L);
mu_in_co(1,6)=calc_mi(Ra1,x5,L);
mu_in_co(1,7)=calc_mi(Ra1,x6,L);
mu_in_co(1,8)=calc_mi(Ra1,x7,L);
mu_in_co(1,9)=calc_mi(Ra1,x8,L);
mu_in_co(1,10)=calc_mi(Ra1,x9,L);
mu_in_co(1,11)=calc_mi(Ra1,x10,L);
mu_in_co(1,12)=calc_mi(Ra1,x11,L);
mu_in_co(1,13)=calc_mi(Ra1,x12,L);
mu_in_co(1,14)=calc_mi(Ra1,x13,L);
mu_in_co(1,15)=calc_mi(Ra1,x14,L);
mu_in_co(1,16)=calc_mi(Ra1,x15,L);
mu_in_co(1,17)=calc_mi(Ra1,x16,L);
mu_in_co(1,18)=calc_mi(Ra1,x17,L);
mu_in_co(1,19)=calc_mi(Ra1,x18,L);
mu_in_co(1,20)=calc_mi(Ra1,x19,L);
mu_in_co(1,21)=calc_mi(Ra1,x20,L);
mu_in_co(1,22)=calc_mi(Ra1,x21,L);
mu_in_co(1,23)=calc_mi(Ra1,x22,L);
mu_in_co(1,24)=calc_mi(Ra1,x23,L);
mu_in_co(1,25)=calc_mi(Ra1,x24,L);
mu_in_co(1,26)=calc_mi(Ra1,x25,L);
mu_in_co(1,27)=calc_mi(Ra1,x26,L);