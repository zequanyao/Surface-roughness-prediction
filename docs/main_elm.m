%%
clc
close all
clear all
all_data=xlsread('extracted features.xlsx');
Ra1=all_data(:,3);%surface roughness
[x0,peak]=deal(all_data(:,5));%peak
[x1,valley]=deal(all_data(:,6));%valley
[x2,peak_valley]=deal(all_data(:,7));%PV
[x3,half_peak_valley]=deal(all_data(:,8));%HPV
[x4,peak_RMS]=deal(all_data(:,9));%RMS-P
[x5,valley_RMS]=deal(all_data(:,10));%RMS-V
[x6,peak_valley_RMS]=deal(all_data(:,11));%RMS-PV
[x7,stda]=deal(all_data(:,12));%Std
[x8,RMS]=deal(all_data(:,13));%RMS
[x9,cf]=deal(all_data(:,14));%CF
[x10,pf]=deal(all_data(:,15));%PF
[x11,gf]=deal(all_data(:,16));%GF
[x12,msf]=deal(all_data(:,17));%MSF
[x13,vf]=deal(all_data(:,18));%VF
[x14,energy_1_3]=deal(all_data(:,19));%L3-1
[x15,energy_2_3]=deal(all_data(:,20));%L3-2
[x16,energy_3_3]=deal(all_data(:,21));%L3-3
[x17,ee]=deal(all_data(:,22));%energy entropy


%%
%calculate average values
for i=1:1:50
    Ra1_1(i,1)=mean(Ra1(1+5*(i-1):5*i));
    features(i,1)=mean(x0(1+5*(i-1):5*i));
    features(i,2)=mean(x1(1+5*(i-1):5*i));
    features(i,3)=mean(x2(1+5*(i-1):5*i));
    features(i,4)=mean(x3(1+5*(i-1):5*i));
    features(i,5)=mean(x4(1+5*(i-1):5*i));
    features(i,6)=mean(x5(1+5*(i-1):5*i));
    features(i,7)=mean(x6(1+5*(i-1):5*i));
    features(i,8)=mean(x7(1+5*(i-1):5*i));
    features(i,9)=mean(x8(1+5*(i-1):5*i));
    features(i,10)=mean(x9(1+5*(i-1):5*i));
    features(i,11)=mean(x10(1+5*(i-1):5*i));
    features(i,12)=mean(x11(1+5*(i-1):5*i));
    features(i,13)=mean(x12(1+5*(i-1):5*i));
    features(i,14)=mean(x13(1+5*(i-1):5*i));
    features(i,15)=mean(x14(1+5*(i-1):5*i));
    features(i,16)=mean(x15(1+5*(i-1):5*i));
    features(i,17)=mean(x16(1+5*(i-1):5*i));
    features(i,18)=mean(x17(1+5*(i-1):5*i));
end

%%
% 1. import data
classes=Ra1_1;

% 2. split dataset
X_train = [];
Y_train = [];
X_test = [];
Y_test = [];
n=randperm(10);
for i = 1:5
    temp_input = features((i-1)*10+1:i*10,:);
    temp_output = classes((i-1)*10+1:i*10,:);  
    % training set
    X_train = [X_train temp_input(n(1:8),:)'];
    Y_train = [Y_train temp_output(n(1:8),:)'];
    % testing set
    X_test = [X_test temp_input(n(9:10),:)'];
    Y_test = [Y_test temp_output(n(9:10),:)'];
end
N = size(P_test,2);%矩阵P_test的列数
%% 3. normlization
%%
% input features
[Xn_train,inputps] = mapminmax(X_train);
Xn_test = mapminmax('apply',X_test,inputps);
%%
% output
[Yn_train,outputps] = mapminmax(Y_train);
Yn_test = mapminmax('apply',Y_test,outputps);

%% 4. ELM training and testing
for j=5:1:40
    
[IW,B,LW,AF,TYPE] = elmtrain(Xn_train,Yn_train,j,'sig',0);

%% 5. ELM testing
tn_sim_1 = elmpredict(Xn_test,IW,B,LW,AF,TYPE);%testing set
tn_sim_2 = elmpredict(Xn_train,IW,B,LW,AF,TYPE);%training set

%%
% reverse normalization
T_sim_1 = mapminmax('reverse',tn_sim_1,outputps);%testing set
T_sim_2 = mapminmax('reverse',tn_sim_2,outputps);%training set

%% 6. results comparison
result_1 = [Y_test' T_sim_1'];
result_2 = [Y_train' T_sim_2'];
%%
% MSE
E = mse(T_sim_1 - Y_test);

%%
% R2
N = length(Y_test);
R2=(N*sum(T_sim_1.*Y_test)-sum(T_sim_1)*sum(Y_test))^2/((N*sum((T_sim_1).^2)-(sum(T_sim_1))^2)*(N*sum((Y_test).^2)-(sum(Y_test))^2)); 

%%
% MAPE
error_1=mean(abs((Y_test'-T_sim_1'))./Y_test');%testing set
error_2=mean(abs((Y_train'-T_sim_2'))./Y_train');%training set
disp(['testing set error = ' num2str(error_1) ]);
disp(['training set error = ' num2str(error_2) ]);

Out1(1,j-4)=error_1;
Out1(2,j-4)=error_2;
Out1(3,j-4)=R2;
Out1(4,j-4)=E;
Out2(j-4,:)=T_sim_1;

%% 7. figure
figure(j-4)
plot(1:N,Y_test,'r-*',1:N,T_sim_1,'b:o')
grid on
legend('Measured','Predicted')
xlabel('Samples')
ylabel('Surface roughness/um')
string = {'Comparison of ELM results';['(mse = ' num2str(E) ' R^2 = ' num2str(R2) ' testing error = ' num2str(error_1) 'hidden nodes=' num2str(j) ')']};
title(string)
end