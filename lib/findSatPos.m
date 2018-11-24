function [pos_Sat_Pol_Obs] = findSatPos( ECEFPos,pos_ECEF_gs,pos_llh_gs)

% findSatPos - This function converts satellite positions to local geodetic 
% coordinates w.r.t ground station
%
% INPUT  ---> ECEFPos (ECEFPos of all satellites)
% OUTPUT ---> pos_Sat_lg_Obs, pos_Sat_Pol_Obs (Observed LG Coordinates in cartesian,
%             Observed LG Coordinates in polar)
% Author ---> Samanvay Karambhe, 2016

% Position of satellite for first 300s
ECEFPos_Sat = ECEFPos(1:3,1:300,:);

% Satellite Position relative to ground station
pos_Sat_ecef_obs  = bsxfun(@minus,ECEFPos_Sat,pos_ECEF_gs);

% Initialise vector
pos_Sat_lg_Obs    = ones(3,300,31);

% Convert Satellite position from ECEF to LG
for i = 1:31

    % Convert observed satellite coordinates from ECEF to LG
    pos_Sat_lg_Obs(:,:,i)    = ecef2lg(pos_Sat_ecef_obs(:,:,i),pos_llh_gs);

end

% Convert observed satellite coordinates from cartesian to polar
pos_Sat_Pol_Obs = cartesian2polar(pos_Sat_lg_Obs);

end

