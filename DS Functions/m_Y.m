%Function for deteming  the joint mass with Yager's rule of combination 
%   [m12(0)=0]
%   [m12(A) = q(A)]
%   [m12(X) = q(X)+q(0)]

function [ m ] = m_Y(q)

X = int2str(max(cellfun(@str2double,keys(q))));
m = containers.Map(keys(q),values(q));
m(X) = m(X) + m('0');
m('0') = 0;

end