%%%%%%%%%%%%%%%%%%%%%%%%% PAYLOAD DESIGN PROJECT %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%      LINK BUDGET       %%%%%%%%%%%%%%%%%%%%%%%%%

%% 1) Setting parameters
R = 800e3; % detection range of the target [km]
sigma_0 = 0; % normalized radar cross-section [-]
A_g = 0; % area covered on the sea [m²]
sigma_t = sigma_0*A; % radar cross-section area [m²]

SNR = 0; % Signal to Noise Ratio

%% 2) Computation of the Noise Power
P_N = 0; % Noise Power


%% 3) Computation of the received power
P_RX = SNR*P_N;


%% 4) Computation of the losses


%% 5) Computation of the transmitted power

