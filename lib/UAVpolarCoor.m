function [pos_UAV_lg_obs, pos_UAV_Pol_Obs, pos_ECEF_gs, UAVVel, UAVPos] = UAVpolarCoor(timeVal, cumArray, pseudo_data, ECEFPos, pos_llh_gs)
% UAVpolarCoor- This function is used to find the polar coordinates of the
%               UAV w.r.t ground station
%
% INPUT  ---> timeVal, cumArray, pseudo_data, ECEFPos
% OUTPUT ---> pos_UAV_Pol_Obs - LG Observed UAV Polar Coordinates
%             pos_ECEF_gs     - ECEF of Ground Station
%             UAVVel          - UAV Velocities w.r.t Ground Station
%
% Author ---> Samanvay Karambhe, 2016

% Obtain the UAV Positions
[UAVPos, UAVVel] = findUAVpos(timeVal, cumArray, pseudo_data, ECEFPos);

% Converting ground station coordinates from LLH to ECEF
pos_ECEF_gs      = llhgc2ecef(pos_llh_gs);

% Determine the ECEF of UAV w.r.t Earth
pos_UAV_ecef_obs = bsxfun(@minus,UAVPos(1:3,:),pos_ECEF_gs);

% Obtain GS coordinates to ECEF ??
pos_UAV_lg_obs   = ecef2lg(pos_UAV_ecef_obs(1:3,:), pos_llh_gs);

% Convert lg coordinates to polar
pos_UAV_Pol_Obs  = cartesian2polar(pos_UAV_lg_obs);

end
