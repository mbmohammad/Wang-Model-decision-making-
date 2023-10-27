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
Tampa = 2;      % AMPAr
gamma = 0.641;
dt = 0.5;
mu0       = 30.0;      % External stimulus strength
thresh    = 15;        % Decision threshold
noise_amp = 0.02;      % Noise amplitude into selective populations
N_trials  = 50 ;       % Total number of trials
Tstim     = 1500;
%%
correctness = TD==SR;
figure
uniqueCoherences = unique(coherence);
tVector = 0:dt*5/dt:dt*(3000/dt-5/dt);
means = 5:5:50;
for i  = 1:5
    for j = 1:10
        [r1_traj,r2_traj] = myWang(Tnmda,Tampa,gamma,uniqueCoherences(i),means(j),thresh,noise_amp,N_trials,dt);
        labels = r1_traj > thresh;
        for k = 1:50
            RTVal = length(find(labels(k,:) == 0));
            RTValues1(j,k) = tVector(RTVal) - 400;
        end
    end
    variance = var(RTValues1'/1000);
    errorbar(means,mean(RTValues1'/1000),variance,'o-','LineWidth',1)
    hold on
end
xticks(means)
xlabel('Coherence level (Hz)','Interpreter','latex')
ylabel('Reaction Time(s)','Interpreter','latex')
legend(['$c^\prime$ = ',num2str(uniqueCoherences(1))],['$c^\prime$ = ',num2str(uniqueCoherences(2))],['$c^\prime$ = ',num2str(uniqueCoherences(3))] ...
    ,['$c^\prime$ = ',num2str(uniqueCoherences(4))],['$c^\prime$ = ',num2str(uniqueCoherences(5))],'Interpreter','latex')
