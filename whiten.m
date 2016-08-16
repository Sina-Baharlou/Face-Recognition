% whiten the data 
% x = input matrix
% X = output whitened data
% WZ = whiten matrix 

function [X,WZ]=whiten(x)

% subtract the mean 
[SM,M]=subMean(x);

% calculate the covariance matrix of data'
c=cov(SM');

% get the whiten matrix 
WZ=2*inv(sqrtm(c))  ;

% whiten the data
X=WZ*SM;

end
