function [pos_UAV_Pol_True,pos_UAV_Cart_True] = extractUAVtrue(uav_data_fpath,t_equi)
% extract - This function is used to plot the relevant graphs for question
% 1 B
%
% INPUT  ---> M,e (M is the mean anomaly and e is the eccentricity)
% OUTPUT --->
% Author ---> Samanvay Karambhe, 2016

% Import coordinates
UAV_data           = importdata(uav_data_fpath);

% Extract Time data
time_true          = UAV_data(:,1)-t_equi;
[nTimes2 timeVal2] = hist(time_true(:),unique(time_true));

% Extract UAV Position data
pos_UAV_Cart_True(1,:)   = UAV_data(:,2);
pos_UAV_Cart_True(2,:)   = UAV_data(:,3);
pos_UAV_Cart_True(3,:)   = UAV_data(:,4);

% Re-organise array

% Convert NED to Polar Coordinates
pos_UAV_Pol_True        = cartesian2polar(pos_UAV_Cart_True);


end

