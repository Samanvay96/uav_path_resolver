function [x0_new, H] = findx0(x0_old, ECEFPosUSE, pseudoRangeUse)
% findx0 - This function uses Non-Linear Least Squares method to calculate
% the UAV Position
%
% INPUT  ---> x0_old, ECEFPosUSE, pseudoRangeUse
% OUTPUT ---> x0_new
% Author ---> Samanvay Karambhe, 2016

    % Initialise clock bias
    cbu = x0_old(4);

    % Find H
    [H,squareRoot] = findH(ECEFPosUSE,x0_old);

    % Calculate deltaP
    deltaP = finddeltaP(squareRoot,pseudoRangeUse,cbu);

    % Calcualte deltaX
    deltaX = (inv(H'*H))*H'*deltaP;

    % Update x0_new and err
    x0_new  = x0_old + deltaX;

end

