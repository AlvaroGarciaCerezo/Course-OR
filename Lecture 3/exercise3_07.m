% Course OR
% Álvaro García Cerezo
% 2026
% Lecture 3
% Exercise 7

clear;
close all;
clc;

% Run exercise3_06.m.
exercise3_06;

% Export weight data.
set1 = 'd';
description = 'Parameter Rho(d) Weight of representative day d [days]';
outputFileName = 'dataRho';
M2G1set(set1,description,weight,outputFileName);

% Export demand data.
set1 = 'd';
set2 = 'h';
description = 'Parameter PD(d,h) Power demanded in representative day d and hour h [MW]';
outputFileName = 'dataPD';
M2G2sets(set1,set2,description,demandRDs,outputFileName);

% Export PV data.
set1 = 'd';
set2 = 'h';
description = 'Parameter APV(d,h) Availability of the production capacity of the photovoltaic generating unit in representatiev day d and hour h [MW]';
outputFileName = 'dataAPV';
M2G2sets(set1,set2,description,pvRDs,outputFileName);

% Export wind data.
set1 = 'd';
set2 = 'h';
description = 'Parameter AW(d,h) Availability of the production capacity of the wind-power generating unit in representatiev day d and hour h [MW]';
outputFileName = 'dataAW';
M2G2sets(set1,set2,description,windRDs,outputFileName);
