clc;
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
for j=1:1:n
    fa=newA_1(:,j); 
    fs=20000;%sampling rate
    wpt3=wpdec(fa,3,'db8','shannon');
    
    cmag140=wpcoef(wpt3,[3,0]);%reconstruction coefficient
    cmag141=wpcoef(wpt3,[3,1]);
    cmag142=wpcoef(wpt3,[3,2]);
    cmag143=wpcoef(wpt3,[3,3]);
    cmag144=wpcoef(wpt3,[3,4]);
    cmag145=wpcoef(wpt3,[3,5]);
    cmag146=wpcoef(wpt3,[3,6]);
    cmag147=wpcoef(wpt3,[3,7]);
                        
    cmag11=norm(cmag140)^2;
    cmag12=norm(cmag141)^2;
    cmag13=norm(cmag142)^2;
    cmag14=norm(cmag143)^2;
    cmag15=norm(cmag144)^2;
    cmag16=norm(cmag145)^2;
    cmag17=norm(cmag146)^2;
    cmag18=norm(cmag147)^2;
    
    cmagnorm(j,:)=[cmag11,cmag12,cmag13,cmag14,cmag15,cmag16,cmag17,cmag18];
    cmap(j,:)=cmagnorm(j,:)/sum(cmagnorm(j,:));%energy ratio
    
    E_total=cmag11+cmag12+cmag13+cmag14+cmag15+cmag16+cmag17+cmag18;
    p_node(1)= 100*cmag11/E_total;           % the rationof each node
    p_node(2)= 100*cmag12/E_total;           
    p_node(3)= 100*cmag13/E_total;          
    p_node(4)= 100*cmag14/E_total;         
    p_node(5)= 100*cmag15/E_total;          
    p_node(6)= 100*cmag16/E_total;          
    p_node(7)= 100*cmag17/E_total;          
    p_node(8)= 100*cmag18/E_total;    
    
    % calculate energy entropy
    PE = 0;
    for k=1:8
        p(k) = (p_node(k))/100; 
        P(k) = -(p(k)*log(p(k)));
        PE = PE + P(k);
    end 
    energy_entropy(j,1)=PE;
end