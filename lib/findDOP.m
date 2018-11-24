function [bestSatConfig, worstSatConfig, DOP, maxDOPIndex, minDOPIndex] = findDOP(UAVVel, pos_Sat_Pol_Obs)
% findDOP - This function calculates the best and worst satellite
% configurations for each DOP
%
% INPUT  ---> UAVVel - Array of UAV velocities w.r.t Ground Station
%             pos_Sat_Pol_Obs - Polar Coordinates of satellites w.r.t GS
% OUTPUT ---> bestSatConfig, worstSatConfig (ECEF Coordinates of satellites)
% Author ---> Samanvay Karambhe, 2016

% Initialise Velocities
Vx   = UAVVel(1,:);
Vy   = UAVVel(2,:);
Vz   = UAVVel(3,:);
Vt   = UAVVel(4,:);

% Calculating DOP
DOP.GDOP = sqrt(Vx + Vy + Vz + Vt);
DOP.PDOP = sqrt(Vx + Vy + Vz);
DOP.HDOP = sqrt(Vx + Vy);
DOP.VDOP = sqrt(Vz);
DOP.TDOP = sqrt(Vt);

% Initialising DOP Array
DOPArray  = [DOP.GDOP; DOP.PDOP; DOP.HDOP; DOP.VDOP; DOP.TDOP];

% Finding the maximum and Minimum DOP Values
[maxDOP,maxDOPIndex] = max(DOPArray,[],2);
[minDOP,minDOPIndex] = min(DOPArray,[],2);

% Find the best and worst satellite configurations (Lowest DOP = Excellent,
% Highest DOP = Bad)
bestSatConfig(:,:,:)  = pos_Sat_Pol_Obs(:,minDOPIndex,:);
worstSatConfig(:,:,:) = pos_Sat_Pol_Obs(:,maxDOPIndex,:);

end

