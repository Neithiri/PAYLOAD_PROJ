%%%%%%%%%%%%%%%%%%%%%%%%% PAYLOAD DESIGN PROJECT %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%      LINK BUDGET       %%%%%%%%%%%%%%%%%%%%%%%%%
clearvars; close all; clc;

%% Conversions
dB2LinearScale_SNR_sigma_gain_NF = @(SNR_dB) 10^(SNR_dB/10);
dB2LinearScale_losses = @(L_dB) 10^(L_dB/20);

%% 0) Constants
c = physconst('lightspeed'); % speed of light in vacuum [m/s]
k_B = physconst('boltzmann'); % Boltzmann constant [J/K]

%% 1) Setting parameters
nb_arrays = 3; % nb of arrays [-]
nb_antennas = 15; % nb of antennas per array [-]

SNR_dB = 5; % Signal to Noise Ratio [dB]
SNR = dB2LinearScale_SNR_sigma_gain_NF(SNR_dB); % Signal to Noise Ratio [-]

R = 800e3; % detection range of the target, R = 800 km [m]
f = 6E9; % frequency of the radiation, f = 6 GHz [Hz]
lambda = c/f; % wavelength of the radiation [m]
eta_g = 0.6; % atenna gain efficiency [-]

sigma_0_dB = -20; % normalized radar cross-section (from paper) [dB]
sigma_0 = dB2LinearScale_SNR_sigma_gain_NF(sigma_0_dB); % normalized radar cross-section [-]
A_s = pi*(50e3/2)^2; % area covered on the sea, circle of 50 km diameter [m²]
sigma_t = sigma_0*A_s; % radar cross-section area [m²]

%% 2) Computation of the Noise Power
NF = 5; % noise figure of the receiver [dB]
F = dB2LinearScale_SNR_sigma_gain_NF(NF); % system noise factor [-]

T0_ref = 290; % reference temperature to which the noise figure is referred [K]

T_sys = (F - 1)*T0_ref; % system temperature [K]

B = 25e3; % transmitted bandwidth, B = 25 kHz [Hz]

P_N = k_B*T_sys*B; % Noise Power [W]

%% 3) Computation of the received power
P_RX = SNR*P_N;

%% 4) Computation of the antenna gains
%% For sake of simplicity we consider the same parameters for both TX and
%% RX antennas
G_TX_dB = 19.3; % gain of the TX antenna [dB]
G_TX = dB2LinearScale_SNR_sigma_gain_NF(G_TX_dB); % gain of the TX antenna [-]
G_RX = G_TX; % gain of the RX antenna [-]

%% 5) Computation of the losses
% TRANSMITTER LOSSES
L_TX_dB = -3; % transmitter losses [dB]
L_TX = dB2LinearScale_losses(L_TX_dB); % transmitter losses [-]

% RECEIVER LOSSES
L_RX_dB = -3; % receiver losses [dB]
L_RX = dB2LinearScale_losses(L_RX_dB); % receiver losses [-]

% POINTING LOSSES (we neglect them as we have same TX and RX)
% eta = 0.1; % pointing accuracy, e = +-0.1° [deg]
% theta = 3; % beamwidth of the RX and TX antennas, theta = 3° [deg]
% L_p_dB = -12*(eta/theta)^2; % pointing losses [dB]
% L_p = dB2LinearScale_losses(L_p_dB); % pointing losses [-]

% 2-WAY PROPAGATION LOSSES
    % ATMOSPHERIC LOSSES
L_atm_dB = -0.04*2; % atmospheric losses (from graph) [dB]
L_atm = dB2LinearScale_losses(L_atm_dB); % atmospheric losses [-]

    % FREE SPACE LOSSES
L_space = lambda/(8*pi*R); % space losses [-]

L_a = L_atm + L_space; % 2-way propagating losses [-]

%% 6) Computation of the transmitted power
numerator = P_RX*(4*pi)^3*R^4*eta_g;
% denominator = G_TX*G_RX*L_TX*L_RX*lambda^2*L_p*L_a*sigma_t;
denominator = G_TX*G_RX*L_TX*L_RX*lambda^2*L_a*sigma_t;

P_TX = numerator/denominator; % transmitted power for one antenna [W]

P_tot = P_TX*nb_antennas*nb_arrays; % total transmitted power [W]

%% 7) Computation of the number of antennas for one array

%% 8) Let's print the outputs
fprintf("Received power: P_RX = %d W\n", P_RX);
fprintf("Transmitted power: P_TX = %d W\n", P_TX);
fprintf("Total transmitted power: P_tot = %d W\n", P_tot);
