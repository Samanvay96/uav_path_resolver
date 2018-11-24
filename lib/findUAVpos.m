function [UAVPos,UAVVel] = findUAVpos(timeVal,cumArray,pseudo_data,ECEFPos)
% findUAVpos - This function is used to find the UAV position based on
% given data
%
% INPUT  ---> timeVal,cumArray,pseudo_data,ECEFPos
% OUTPUT ---> SatPos
% Author ---> Samanvay Karambhe, 2016

count = 1;

for i = 1:size(timeVal,1)

% Find Limits
[lim1,lim2] = findLimits(cumArray,i);

% Pseudo Range & Satellite Number
pseudoRange = pseudo_data(lim1:lim2,3);
satNum      = pseudo_data(lim1:lim2,2);

% Picking 4 values
if length(pseudoRange) >= 4

    pseudoRangeUse = pseudoRange(1:end);
    satNumUse      = satNum(1:end);

end

% Extracting 4 points from ECEF Array
ECEFPosUSE     = ECEFPos(:,i,satNumUse);

% Initialise x_0
x0_old = [0; 0; 0;0];

% Initialise Error
err = 1;
tol = 1e-6;

if length(pseudoRange) >= 4

    while max(err) > tol

        % Calculate new x0
        [x0_new,H] = findx0(x0_old,ECEFPosUSE,pseudoRangeUse);

        % Calculate Error
        err     = abs(x0_new-x0_old)./abs(x0_old);

        % Update x0_old
        x0_old  = x0_new;

    end

    A = inv(H'*H);
    V = diag(A);

    UAVPos(:,count) = x0_old;
    UAVVel(:,count) = V;
    count           = count + 1;

else

    A = inv(H'*H);
    V = diag(A);

    UAVPos(:,count) = UAVPos(:,count-1);
    UAVVel(:,count) = V;
    count           = count + 1;

end

end

end

