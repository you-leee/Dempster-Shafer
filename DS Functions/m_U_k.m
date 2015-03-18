%Function for deteming  the joint mass with Inagaki's unified rule 
%   [m12(0) = 0]
%   [m12(A) = (1+kq(0))q(A)]
%   [m12(X) = (1+kq(0))q(X)+(1+kq(0)-k)q(0)]

function [ m ] = m_U_k( q, k )

X = int2str(max(cellfun(@str2double,keys(q))));
q_0 = q('0');
q_X = q(X);

q_Values = cell2mat(values(q));
q_Values = q_Values * (1+k*q_0);
q_Values(1) = 0;
key_Values = keys(q);
m = containers.Map(key_Values,q_Values);
m(X) = (1+k*q_0)*q_X+(1+k*q_0-k)*q_0;

end