%%%%%%%%%%%%%%%%%%%%%%%%% PAYLOAD DESIGN PROJECT %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%      LINK BUDGET       %%%%%%%%%%%%%%%%%%%%%%%%%
%% Conversions
dB2LinearScale = @(L_dB) 10^(L_dB/10);

%% 0) Constants
c = 3e8; % speed of light in vacuum [m/s]
k_B = 1.38e-23; % Boltzmann constant [J/K]

%% 1) Setting parameters
SNR_dB = 5; % Signal to Noise Ratio [dB]
SNR = dB2LinearScale(SNR_dB); % Signal to Noise Ratio [-]

R = 800e3; % detection range of the target,R = 800 km [m]
f = 6E9; % frequency of the radiation, f = 6 GHz [Hz]
lambda = c/f; % wavelength of the radiation [m]

sigma_0_dB = -15; % normalized radar cross-section (from paper) [dB]
sigma_0 = dB2LinearScale(sigma_0_dB); % normalized radar cross-section [-]
A_s = 0; % area covered on the sea [m²]
sigma_t = sigma_0*A_s; % radar cross-section area [m²]

%% 2) Computation of the Noise Power
T_MR = 270; % mean radiating temperature of the antenna [K]
A_m = 0.9; % attenuation [-] 1 -> clear sky
T_A = (1 - A_m)*T_MR; % antenna noise temperature [K]
T_LNA = 300; % LNA equivalent noise temperature [K]

T_sys = T_a + T_LNA; % system equivalent noise temperature [K]
B_3dB = 300e6; % 3-dB bandwidth of the TX and RX antennas [Hz]
B = 1.12*B_3dB; % equivalent noise bandwidth [Hz]

P_N = k_B*T_sys*B; % Noise Power [W]

%% 3) Computation of the received power
P_RX = SNR*P_N;

%% 4) Computation of the antenna gains
%% For sake of simplicity we consider the same parameters for both TX and
%% RX antennas
A = 0; % physical area of the antenna [-]
epsilon = 0.8; % antenna efficiency [-]
A_eff = A*epsilon; % effective area of the antenna

G_TX = 4*pi*A_eff/lambda^2; % gain of the TX antenna [-]
G_RX = 4*pi*A_eff/lambda^2; % gain of the RX antenna [-]

%% 5) Computation of the losses
% TRANSMITTER LOSSES
L_TX_dB = -3; % transmitter losses [dB]
L_TX = dB2LinearScale(L_TX_dB); % transmitter losses [-]

% RECEIVER LOSSES
L_RX_dB = -3; % receiver losses [dB]
L_RX = dB2LinearScale(L_RX_dB); % receiver losses [-]

% POINTING LOSSES
e = 0.1; % pointing accuracy, e = +-0.1° [deg]
theta = 0; % beamwidth of the RX and TX antennas [deg]
L_p_dB = -12/(e/theta)^2; % pointing losses [dB]
L_p = dB2LinearScale(L_p_dB); % pointing losses [-]

% SIGNAL PROCESSING LOSSES
L_S = 0;

% 2-WAY PROPAGATION LOSSES
    % ATMOSPHERIC LOSSES
L_atm_dB = 0; % atmospheric losses (from graph) [dB]
L_atm = dB2LinearScale(L_atm_dB); % atmospheric losses [-]

    % FREE SPACE LOSSES
L_space_dB = 20*log10(lambda/8*pi*R); % space losses [dB]
L_space = dB2LinearScale(L_space_dB); % space losses [-]

L_a = L_atm + L_space; % 2-way propagating losses [-]

%% 6) Computation of the transmitted power
numerator = P_RX*(4*pi)^3*R^4;
denominator = G_TX*L_TX*G_RX*L_RX*lambda^2*L_p*L_S*L_a*sigma_t;

P_TX = numerator/denominator; % transmitted power [W]
