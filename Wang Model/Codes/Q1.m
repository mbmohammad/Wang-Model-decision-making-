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
Tnmda = 107;    % NMDAr
Tampa = 4.5;      % AMPAr
gamma = 0.641;
dt = 0.5;
mu0       = 30.0;      % External stimulus strength
thresh    = 17.5;        % Decision threshold
noise_amp = 0.02;      % Noise amplitude into selective populations
N_trials  = 50 ;       % Total number of trials
Tstim     = 1500;
%%
figure
uniqueCoherences = unique(coherence);
colors = {'g', 'r', 'b', 'y', 'm'};
for j = 1:length(uniqueCoherences)
    % we use the following matrices in upcoming questions
%     RT1(j,:) = RT(coherence == uniqueCoherences(j));
%     ACC_tot(j,:) = sum(ACC(correctness == uniqueCoherences(j)))/length(ACC(correctness == uniqueCoherences(j)));
    [r1_traj,r2_traj] = myWang(Tnmda,Tampa,gamma,uniqueCoherences(j),mu0,thresh,noise_amp,N_trials,dt);    
    
    N_traj = 10:10:50; % Total number of trajectories
for ww = 1:N_traj
    L(2*j - 1) = plot([dt*50/dt:dt*5/dt:dt*(3000/dt-50/dt)],r1_traj(ww,1:end-10),colors{j});hold on;
    L(2*j) = plot([dt*50/dt:dt*5/dt:dt*(3000/dt)],r2_traj(ww,1:end),colors{j},'LineStyle','--');hold on;
end
    yline(thresh) 
end
legend(L, {['$R_1$, $c^\prime$ = ',num2str(uniqueCoherences(1)),''] ['$R_2$, $c^\prime$ = ',num2str(uniqueCoherences(1)),'']...
    ['$R_1$, $c^\prime$ = ',num2str(uniqueCoherences(2)),''] ['$R_2$, $c^\prime$ = ',num2str(uniqueCoherences(2)),'']...
    ['$R_1$, $c^\prime$ = ',num2str(uniqueCoherences(3)),''] ['$R_2$, $c^\prime$ = ',num2str(uniqueCoherences(3)),'']...
    ['$R_1$, $c^\prime$ = ',num2str(uniqueCoherences(4)),''] ['$R_2$, $c^\prime$ = ',num2str(uniqueCoherences(4)),'']...
    ['$R_1$, $c^\prime$ = ',num2str(uniqueCoherences(5)),''] ['$R_2$, $c^\prime$ = ',num2str(uniqueCoherences(5)),'']},...
    'location','northwest' ,'Interpreter','latex')

xlabel("Time(ms)")
ylabel("Firing rate(Hz)")


