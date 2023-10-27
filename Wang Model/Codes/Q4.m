%%
clc; clearvars; close all;
subData = load('subData.mat');
subDataMatrix = table2array(subData.subData);
coherenceserence = subDataMatrix(:,1);
RT = subDataMatrix(:,2);
SR = subDataMatrix(:,3);
TD = subDataMatrix(:,4);
%%
correctness = TD==SR;
Tnmda = 100;    % NMDAr
Tampa = 2;      % AMPAr
gamma = 0.641;
dt = 0.5;
mu0       = 30.0;      % External stimulus strength
thresh    = 15;        % Decision threshold
noise_amp = 0.02;      % Noise amplitude into selective populations
N_trials  = 50 ;       % Total number of trials
Tstim     = 1500;
%%
coherences = [7 9 12 16 30 65 90];
newRT = zeros(3, length(coherences));
acc11 = zeros(3, length(coherences));
for k=1:length(coherences)
    for kk=1:3
        [r1, ~]= myWang(Tnmda,Tampa,gamma,coherences(k),mu0,thresh,noise_amp,N_trials,dt); 
        r1=r1(:,101:400);
for ii=1:50
    temp1=find(r1(ii,:)>=15);    
    if temp1~[];
        rt1(ii)=temp1(1);
    else
        rt1(ii)=0;
    end
end
rt1=rt1*dt + 0.35;
myRT=mean(rt1);

        newRT(kk, k) = myRT;
    end
end

figure()
plot(coherences, newRT(1,:)/100, 'g', 'LineWidth',1);
hold on
plot(coherences, newRT(2,:)/100, 'b', 'LineWidth',1);
hold on
plot(coherences, newRT(3,:)/100, 'r', 'LineWidth',1);
legend('$w_+ = 1.68$', '$w_+ = 1.70$', '$w_+ = 1.72$','Interpreter','latex')
xlabel('coherence','Interpreter','latex')
ylabel('Reaction Time(s)','Interpreter','latex')
xticks(coherences)

%%



