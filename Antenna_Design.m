%%%%%%%%%%%%%%%%%%%%%%%%% PAYLOAD DESIGN PROJECT %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%      ANTENNA DESIGN    %%%%%%%%%%%%%%%%%%%%%%%%%
clearvars; close all; clc;

%% Constants
c = 3e8; % speed of light in vacuum [m/s]

%% Antenna parameters
f = 6e9; % antenna frequency, f = 6 GHz [Hz]
lambda = c/f; % antenna wavelength [m]
a = 20.193e-3; % a = 20.193 mm [m]
b = 40.386e-3; % antenna 2nd dimension, b = 40.386 mm [m]
f_co = 3.712e9; % antenna cut-off frequency [Hz]
lambda_co = c/f_co; % antenna cut-off wavelength [m]
theta = 3; % antenna beamwidth [deg]

%% 1) Computation of the guide wavelength
lambda_g = lambda/sqrt(1 - (lambda/lambda_co)^2 );

%% 2) Computation of the number of slots
N = floor(4*50.7*lambda/(theta*lambda_g)); % number of slots

%% 3) Computation of the gain
G_dB = 10*log10(N*lambda_g/2/lambda); % antenna gain [dB]

%% 4) Computation of the slot thickness
t_slot = 0.1*lambda; % slot thickness [m]

%% 5) Computation of the length of one slot
l_slot = 0.5*lambda; % length of one slot [m]

%% 6) Computation of the distance between slots' centers
D = lambda/2;


%% TEST
f_test = 6e9;
lambda_test = c/f_test;
f_co_test = 4.301e9;
lambda_co_test = c/f_co_test; % antenna cut-off wavelength [m]
lambda_g_test = lambda_test/sqrt(1 - (lambda/lambda_co_test)^2 );
G_test = 22;
N_test = 2*lambda/lambda_g_test*10^(G_test/10);

l_slot_test = 0.5*lambda_test;

l_slot_test*N_test