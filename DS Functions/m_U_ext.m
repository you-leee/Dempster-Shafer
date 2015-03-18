%Function for deteming  the joint mass with Inagaki's extra rule 
%   [m12(0) = 0]
%   [m12(A) = {(1-q(X))/(1-q(X)-q(0))}q(A)]
%   [m12(X) = q(X)]

function [ m ] = m_U_ext(q)

X = int2str(max(cellfun(@str2double,keys(q))));
K = q('0') + q(X);
q_X = q(X);

q_Values = cell2mat(values(q));
q_Values = q_Values * ((1-q_X) / (1-K));
q_Values(1) = 0;
key_Values = keys(q);
m = containers.Map(key_Values,q_Values);
m(X) = q_X;

end