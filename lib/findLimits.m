function [lim1, lim2] = findLimits(cumArray, i)
% findLimits - This function is used to find the array limits of
% cummulative array function
%
% INPUT  ---> cumArray,i
% OUTPUT ---> H,squareRoot
% Author ---> Samanvay Karambhe, 2016

% Setting array limits
if i == 1

    lim1 = 1;
else

    lim1 = cumArray(i-1) + 1;
end

lim2 = cumArray(i);

end

