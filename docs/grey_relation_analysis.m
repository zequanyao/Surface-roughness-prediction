%grey relation analysis
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

%%
%Normalization
Ra1=Ra1./(1/250*sum(Ra1));
x0=x0./(1/250*sum(x0));
x1=x1./(1/250*sum(x1));
x2=x2./(1/250*sum(x2));
x3=x3./(1/250*sum(x3));
x4=x4./(1/250*sum(x4));
x5=x5./(1/250*sum(x5));
x6=x6./(1/250*sum(x6));
x7=x7./(1/250*sum(x7));
x8=x8./(1/250*sum(x8));
x9=x9./(1/250*sum(x9));
x10=x10./(1/250*sum(x10));
x11=x11./(1/250*sum(x11));
x12=x12./(1/250*sum(x12));
x13=x13./(1/250*sum(x13));
x14=x14./(1/250*sum(x14));
x15=x15./(1/250*sum(x15));
x16=x16./(1/250*sum(x16));
x17=x17./(1/250*sum(x17));
x18=x18./(1/250*sum(x18));
x19=x19./(1/250*sum(x19));
x20=x20./(1/250*sum(x20));
x21=x21./(1/250*sum(x21));
x22=x22./(1/250*sum(x22));
x23=x23./(1/250*sum(x23));
x24=x24./(1/250*sum(x24));
x25=x25./(1/250*sum(x25));
x26=x26./(1/250*sum(x26));

%%
%求两级最大差和两级最小差
global_min = min(min(abs([x0;x1;x2;x3;x4;x5;x6;x7;x8;x9;x10;x11;x12;x13;x14;x15;x16;x17;x18;x19;x20;x21;x22;x23;x24;x25;x26] - repmat(Ra1, [27, 1]))));
global_max = max(max(abs([x0;x1;x2;x3;x4;x5;x6;x7;x8;x9;x10;x11;x12;x13;x14;x15;x16;x17;x18;x19;x20;x21;x22;x23;x24;x25;x26] - repmat(Ra1, [27, 1]))));

%%
% set rho
rho = 0.5;

%%
% calculate zeta relation coefficients
zeta_0 = (global_min + rho * global_max) ./ (abs(Ra1 - x0) + rho * global_max);
zeta_1 = (global_min + rho * global_max) ./ (abs(Ra1 - x1) + rho * global_max);
zeta_2 = (global_min + rho * global_max) ./ (abs(Ra1 - x2) + rho * global_max);
zeta_3 = (global_min + rho * global_max) ./ (abs(Ra1 - x3) + rho * global_max);
zeta_4 = (global_min + rho * global_max) ./ (abs(Ra1 - x4) + rho * global_max);
zeta_5 = (global_min + rho * global_max) ./ (abs(Ra1 - x5) + rho * global_max);
zeta_6 = (global_min + rho * global_max) ./ (abs(Ra1 - x6) + rho * global_max);
zeta_7 = (global_min + rho * global_max) ./ (abs(Ra1 - x7) + rho * global_max);
zeta_8 = (global_min + rho * global_max) ./ (abs(Ra1 - x8) + rho * global_max);
zeta_9 = (global_min + rho * global_max) ./ (abs(Ra1 - x9) + rho * global_max);
zeta_10 = (global_min + rho * global_max) ./ (abs(Ra1 - x10) + rho * global_max);
zeta_11 = (global_min + rho * global_max) ./ (abs(Ra1 - x11) + rho * global_max);
zeta_12 = (global_min + rho * global_max) ./ (abs(Ra1 - x12) + rho * global_max);
zeta_13 = (global_min + rho * global_max) ./ (abs(Ra1 - x13) + rho * global_max);
zeta_14 = (global_min + rho * global_max) ./ (abs(Ra1 - x14) + rho * global_max);
zeta_15 = (global_min + rho * global_max) ./ (abs(Ra1 - x15) + rho * global_max);
zeta_16 = (global_min + rho * global_max) ./ (abs(Ra1 - x16) + rho * global_max);
zeta_17 = (global_min + rho * global_max) ./ (abs(Ra1 - x17) + rho * global_max);
zeta_18 = (global_min + rho * global_max) ./ (abs(Ra1 - x18) + rho * global_max);
zeta_19 = (global_min + rho * global_max) ./ (abs(Ra1 - x19) + rho * global_max);
zeta_20 = (global_min + rho * global_max) ./ (abs(Ra1 - x20) + rho * global_max);
zeta_21 = (global_min + rho * global_max) ./ (abs(Ra1 - x21) + rho * global_max);
zeta_22 = (global_min + rho * global_max) ./ (abs(Ra1 - x22) + rho * global_max);
zeta_23 = (global_min + rho * global_max) ./ (abs(Ra1 - x23) + rho * global_max);
zeta_24 = (global_min + rho * global_max) ./ (abs(Ra1 - x24) + rho * global_max);
zeta_25 = (global_min + rho * global_max) ./ (abs(Ra1 - x25) + rho * global_max);
zeta_26 = (global_min + rho * global_max) ./ (abs(Ra1 - x26) + rho * global_max);

%%
%grey relational grade 
r0=1/250*sum(zeta_0);
r1=1/250*sum(zeta_1);
r2=1/250*sum(zeta_2);
r3=1/250*sum(zeta_3);
r4=1/250*sum(zeta_4);
r5=1/250*sum(zeta_5);
r6=1/250*sum(zeta_6);
r7=1/250*sum(zeta_7);
r8=1/250*sum(zeta_8);
r9=1/250*sum(zeta_9);
r10=1/250*sum(zeta_10);
r11=1/250*sum(zeta_11);
r12=1/250*sum(zeta_12);
r13=1/250*sum(zeta_13);
r14=1/250*sum(zeta_14);
r15=1/250*sum(zeta_15);
r16=1/250*sum(zeta_16);
r17=1/250*sum(zeta_17);
r18=1/250*sum(zeta_18);
r19=1/250*sum(zeta_19);
r20=1/250*sum(zeta_20);
r21=1/250*sum(zeta_21);
r22=1/250*sum(zeta_22);
r23=1/250*sum(zeta_23);
r24=1/250*sum(zeta_24);
r25=1/250*sum(zeta_25);
r26=1/250*sum(zeta_26);

r=[r0;r1;r2;r3;r4;r5;r6;r7;r8;r9;r10;r11;r12;r13;r14;r15;r16;r17;r18;r19;r20;r21;r22;r23;r24;r25;r26];