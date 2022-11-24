%%%%%%%%%%%%%%%%%%%%%%%%% PAYLOAD DESIGN PROJECT %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%      ANTENNA DESIGN    %%%%%%%%%%%%%%%%%%%%%%%%%
clearvars; close all; clc;

%% Constants
c = physconst('lightspeed'); % speed of light in vacuum [m/s]

%% Antenna parameters
f = 6e9; % antenna frequency, f = 6 GHz [Hz]
lambda = c/f; % antenna wavelength [m]
a = 20.193e-3; % a = 20.193 mm [m]
b = 40.386e-3; % antenna 2nd dimension, b = 40.386 mm [m]
f_co = 4.301e9; % antenna cut-off frequency [Hz]
lambda_co = c/f_co; % antenna cut-off wavelength [m]
theta = 1.2; % antenna beamwidth [deg]

%% 1) Computation of the guide wavelength
lambda_g = lambda/sqrt(1 - (lambda/lambda_co)^2);

%% 2) Computation of the number of slots
N = floor( 50.7*4*lambda/(theta*lambda_g) );

%% 3) Computation of the antenna gain
G_dB = 10*log10(N*lambda_g/(2*lambda));

%% 3) Print outputs
fprintf("Antenna gain (maximum): G = %d dB\n", G_dB);
