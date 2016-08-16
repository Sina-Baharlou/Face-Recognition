% calculate the eigenvalues 
% V is the matrix containing the eigen vectors
% E is the matrix containing the eigen values 
function [V,E]=eigen(M)


% calculate the size of the matrix
m_size=size(M);

% Calculate the covariance 
c=1/(m_size(2)-1)*(M'*M);%cov(M);

% Calculate the eigen vectors of M'
[U,E]=eig(c);




% sort eigen vectors 
[sorted_eig, index] = sort(sum(E));
index=fliplr(index);
sorted_eig=fliplr(sorted_eig);

V = U(:,[index]);

% calculate the eigen vectors for M
V=M*V;

% calcuate the eigen values 
E=sqrt(sum(V.^2));

% normalize the eigenvectors 
V = V ./ (ones(m_size(1),1) * E);

E=sorted_eig;

end
