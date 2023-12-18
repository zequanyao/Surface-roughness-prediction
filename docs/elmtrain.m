function [IW,B,LW,AF,TYPE] = elmtrain(P,T,N,AF,TYPE)
% Training of extreme learning machine
% Input:
% P   - Input Matrix of Training Set  (R*N)
% T   - Output Matrix of Training Set (S*N)
% N   - Number of Hidden Neurons 
% AF  - Activation Function:
% TYPE - Regression (0) or Classification (1)
% Output
% IW  - Input Weight Matrix (N*R)
% B   - Bias Matrix  (N*1)
% LW  - Layer Weight Matrix (N*S)
if nargin < 2
    error('ELM:Arguments','Not enough input arguments.');
end
if nargin < 3
    N = size(P,2);
end
if nargin < 4
    AF = 'sig';
end
if nargin < 5
    TYPE = 0;
end
if size(P,2) ~= size(T,2)
    error('ELM:Arguments','The columns of P and T must be same.');
end
[R,N] = size(P);
if TYPE  == 1
    T  = ind2vec(T);
end
[S,N] = size(T);
% Randomly Generate the Input Weight Matrix
IW = rand(N,R) * 2 - 1;
% Randomly Generate the Bias Matrix
B = rand(N,1);
BiasMatrix = repmat(B,1,N);
% Calculate the Layer Output Matrix H
tempH = IW * P + BiasMatrix;
switch AF
    case 'sig'
        H = 1 ./ (1 + exp(-tempH));
    case 'sin'
        H = sin(tempH);
    case 'hardlim'
        H = hardlim(tempH);
end
% Calculate the Output Weight Matrix
LW = pinv(H') * T';
