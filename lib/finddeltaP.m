function deltaP = finddeltaP(squareRoot,pseudoRangeUse,cbu)
% finddeltaP - This function is called to calculate deltaP given certain
% inputs
%
% INPUT  ---> squareRoot, pseudoRangeUse, cbu
% OUTPUT ---> deltaP
% Author ---> Samanvay Karambhe, 2016

% Save individual vectors in an array
pVec = squareRoot + cbu;

% Calculate deltaP
deltaP = pseudoRangeUse - pVec';

end

