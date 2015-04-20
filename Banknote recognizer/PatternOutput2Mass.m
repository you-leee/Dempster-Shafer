function [ m ] = PatternOutput2Mass( relDist, classID )
%Function for determing the mass-es from the count of half numbers, the
%probability, that the first number is recognized as a whole number
%and the correlation with 0 for the first number
%
%   Input:  -relDist double vector with values within 0...2, the relative 
%           distances(actual distance/tolerance limit) from the claster 
%           center. 0: exact match, 1: on the limit, 2: exact negative
%           -classID integer vector, the IDs of the classes belonging to 
%           the distances in the same order
%   Output: -m vector, containing the masses for the banknotes

m = zeros(1, 128);

if(relDist == 1)
    m(128) = 1;
    return;
end;

if(relDist == 0)
    m(classID) = 1;
    return;
end;


x_norm = (-2:.001:2);
max_norm = max(normpdf(x_norm));
norm = normpdf(x_norm, 0, max_norm);
plot(x_norm, norm)

m_certain = normpdf(relDist, 0, max_norm);
%For one input:
if(relDist < 1)
    m(classID) = m_certain;
    %m(banknotes)
    m(121) = (1 - m_certain) * m_certain;
    %m(banknotes, not banknote)
    m(128) = (1 - m_certain) * (1 - m_certain);
else
    %m(not banknote)
    m(7) = 1- m_certain;
    %m(banknotes, not banknote)
    m(128) = m_certain;
end;
end