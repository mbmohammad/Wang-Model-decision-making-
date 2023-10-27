%%
clc; clearvars; close all;
subData = load('subData.mat');
subDataMatrix = table2array(subData.subData);
coherence = subDataMatrix(:,1);
RT = subDataMatrix(:,2);
SR = subDataMatrix(:,3);
TD = subDataMatrix(:,4);
%%
correctness = TD==SR;
Tnmda = 100;    % NMDAr
Tampa = 3.25;      % AMPAr
gamma = 0.641;
dt = 0.5;
mu0       = 30.0;      % External stimulus strength
thresh    = 17.5;        % Decision threshold
noise_amp = 0.02;      % Noise amplitude into selective populations
N_trials  = 50 ;       % Total number of trials
Tstim     = 1500;
%%
uniqueCoherences = unique(coherence);
for j = 1:length(uniqueCoherences)
    RTs(j,:) = RT(coherence == uniqueCoherences(j));
%     ACC_tot(j,:) = sum(correctness(correctness == uniqueCoherences(j)))/length(correctness(correctness == uniqueCoherences(j)));
    [r1_traj,r2_traj] = myWang(Tnmda,Tampa,gamma,uniqueCoherences(j),mu0,thresh,noise_amp,N_trials,dt); 
    labels = r1_traj > thresh;
    for i = 1:50
        RTVal(j,i) = length(find(labels(i,:) == 0));
%         if ~isempty(find(labels(i,:) == 1, 1)) 
%             accuracy(i) = 1;
%         else
%             accuracy(i) = 0;
%         end
    end
%     accuracy(j) = sum(accuracy)/50;
end
%%
tVector = 0:dt*5/dt:dt*(3000/dt-5/dt);
for i = 1:5
    RTValues1(i,:) = (tVector(RTVal(i,:)) - 400)/1000;
    variance(i) = var(RTValues1(i,:));
end
for i = 1:5
    RTValues = RTs(i,:)/1000;
    RTValues = RTValues';
    variance1(i) = var(RTValues(:,1));
end
figure
errorbar(uniqueCoherences,mean(RTValues1'),variance,'ys-','LineWidth',2)
xlabel('Coherence Level','Interpreter','latex')
ylabel('Reaction Time(s)','Interpreter','latex')
title('Wang Model','Interpreter','latex')
figure
% hold on
errorbar(uniqueCoherences,mean(RTs')/1000,variance1,'bo-','LineWidth',0.5) 
xticks(uniqueCoherences)
xlabel('Coherence Level','Interpreter','latex')
ylabel('Reaction Time(s)','Interpreter','latex')
title('Real Data','Interpreter','latex')
% % legend('Wang Model','Real Data','Interpreter','latex')

