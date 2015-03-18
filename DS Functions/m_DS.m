%Function for deteming  the joint mass with Dempster's rule of combination 
%   [m12(0)=0]
%   [m12(A) = q(A)/(1-q(0))]
%   [m12(X) = q(X)/(1-q(0))]

function [ m ] = m_DS(q)

K = q('0');
q_Values = cell2mat(values(q));
q_Values = q_Values / (1-K);
q_Values(1) = 0;
key_Values = keys(q);
m = containers.Map(key_Values,q_Values);

end