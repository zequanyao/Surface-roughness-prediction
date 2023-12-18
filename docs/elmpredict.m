function Y = elmpredict(P,IW,B,LW,AF,TYPE)
% Predict udsing extreme learning machine
% Input
% P   - Input Matrix of Training Set  (R*N)
% IW  - Input Weight Matrix (N*R)
% B   - Bias Matrix  (N*1)
% LW  - Layer Weight Matrix (N*S)
% AF  - activation Function:
% TYPE - Regression (0) or Classification (1)
% Output
% Y   - Simulate Output Matrix (S*N)
if nargin < 6
    error('ELM:Arguments','Not enough input arguments.');
end
% Calculate the Layer Output Matrix H
N = size(P,2);
BiasMatrix = repmat(B,1,N);
tempH = IW * P + BiasMatrix;
switch AF
    case 'sig'
        H = 1 ./ (1 + exp(-tempH));
    case 'sin'
        H = sin(tempH);
    case 'hardlim'
        H = hardlim(tempH);
end
% Calculate the Simulate Output
Y = (H' * LW)';
if TYPE == 1
    temp_Y = zeros(size(Y));
    for i = 1:size(Y,2)
        [~,index] = max(Y(:,i));
        temp_Y(index,i) = 1;
    end
    Y = vec2ind(temp_Y); 
end