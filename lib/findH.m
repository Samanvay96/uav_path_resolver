function [H, squareRoot] = findH(ECEFPos4, x0)
% findH - The aim of this function is to calculate the jacobian given ECEF
% coordinates of the satellite and [x,y,z,cbu] values
%
% INPUT  ---> ECEFPos4,x0
% OUTPUT ---> H,squareRoot
% Author ---> Samanvay Karambhe, 2016

% Initial x,y,z
x   = x0(1);
y   = x0(2);
z   = x0(3);
cbu = x0(4);

for i = 1:size(ECEFPos4,3)

    % Initialise x,y,z of the satellite in the ECEF frame
    X_svi = ECEFPos4(1,:,i);
    Y_svi = ECEFPos4(2,:,i);
    Z_svi = ECEFPos4(3,:,i);

    % Calculate the denominator
    den    = sqrt((X_svi - x)^2 + (Y_svi - y)^2 + (Z_svi - z)^2);

    % Calculate the derivatives
    dpi_dx   = -(X_svi - x)/den;
    dpi_dy   = -(Y_svi - y)/den;
    dpi_dz   = -(Z_svi - z)/den;
    dpi_dcbu = 1;

    % Form the H matrix
    H(i,:)   = [dpi_dx,dpi_dy,dpi_dz,dpi_dcbu];

    % For the squareRoot matrix of denominators
    squareRoot(i) = den;

end

end

