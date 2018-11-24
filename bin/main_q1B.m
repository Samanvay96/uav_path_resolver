% Clear workspace, close all open figure & clear the command window
clear all
close all;
clc;

% Extract the data from the text file
% Add other folders to path
addpath('../data', '../lib/', '../lib/conversion');

% Load constants
constants();

% Initialise Ground Station Position
% Defining Sydney Ground Station Coordinates
lat        = deg2rad(-34.76);
long       = deg2rad(150.03);
alt        = 680;
pos_llh_gs = [lat;long;alt];

% File Name
uav_data_fpath = 'UAVPosition_F1.txt';

% Import pseudorange data
pseudo_data = importdata('GPS_pseudorange_F1.txt');

% Load ECEF position values of satellites
load ECEFPos

%% Categorising time values

% Vernal Equinox time
equinox_time = 7347737.336;

% Store time data
times     = pseudo_data(:,1) - equinox_time;

% Obtain the unique time values
% nTimes is an array containing the total number of occurences of single time
% value
% timeVal is an array containing all unique timevalues
[total_occurences time_values] = hist(times(:),unique(times));

% Cummulative Time Array
cummulative_times = cumsum(total_occurences);

% Increment time values
% timeVal = timeVal + 1;

%% Observed UAV Positions

% Obtain the polar coordinates of UAV w.r.t Ground Station
[pos_UAV_Cart_obs,pos_UAV_Pol_Obs, pos_ECEF_gs, UAVVel, UAVPos] = UAVpolarCoor(time_values,...
                                         cummulative_times, pseudo_data, ECEFPos, pos_llh_gs);

%% Extract true UAV Position data from text files

% % Obtain polar coordinates of true measurements
[pos_UAV_Pol_True, pos_UAV_Cart_True] = extractUAVtrue(uav_data_fpath,equinox_time);

%% Catalog the position of the satellites during UAV Tracking

% Find satellite position w.r.t ground station
[pos_Sat_Pol_Obs] = findSatPos(ECEFPos, pos_ECEF_gs, pos_llh_gs);


%% Calculate the DOP for each time value

% Calculate the best and worst satellite configurations according to DOP
[bestSatConfig, worstSatConfig, DOP, maxDOPIndex, minDOPIndex] = findDOP(UAVVel, pos_Sat_Pol_Obs);

%% Save relevant data as a structured array for plotting

plotData.timeArray         = times;
plotData.pos_UAV_Cart_obs  = pos_UAV_Cart_obs;
plotData.pos_UAV_Pol_Obs   = pos_UAV_Pol_Obs;
plotData.pos_ECEF_gs       = pos_ECEF_gs;
plotData.UAVVel            = UAVVel;
plotData.UAVPos            = UAVPos;
plotData.pos_UAV_Pol_True  = pos_UAV_Pol_True;
plotData.pos_UAV_Cart_True = pos_UAV_Cart_True;
plotData.pos_Sat_Pol_Obs   = pos_Sat_Pol_Obs;
plotData.bestSatConfig     = bestSatConfig;
plotData.worstSatConfig    = worstSatConfig;
plotData.DOP               = DOP;
plotData.maxDOPIndex       = maxDOPIndex;
plotData.minDOPIndex       = minDOPIndex;
plotData.nTimes            = total_occurences;
plotData.pseudo_data       = pseudo_data;
plotData.cumArray          = cummulative_times;

%% Plot graphs
plotq1B(plotData)
