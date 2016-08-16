% create binary vector 
% n = size of the vector 
% m = index of high bit 

function v=bvector(n,m)
% create vector 
v=zeros(n,1);
% put m element to high 
v(m)=1;
end
