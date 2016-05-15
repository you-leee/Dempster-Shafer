function [ m ] = PatternOutput2Mass( relDist, classID, Keys)
%Function for determing the mass-es from the patterns of a banknote
%
%   Input:  -relDist double with values > 0, the minimal relative 
%           distance(actual distance/tolerance limit) from the claster 
%           center. 0: exact match, 1: on the limit
%           -classID integer , the ID of the class belonging to the 
%           distance
%   Output: -m vector, containing the masses for the banknotes

m = containers.Map(Keys,zeros(1, 128));

if(relDist == 1)
    m('1234567') = 1;
    return;
end;

if(relDist == 0)
    m(num2str(classID,'%1d')) = 1;
    return;
end;


x_norm = (-2:.001:2);
max_norm = max(normpdf(x_norm));
m_certain = (cos(relDist.*pi/2)+normpdf(relDist,0,max_norm))/2;

%For one input:
if(relDist < 1)
    m(num2str(classID,'%1d')) = m_certain;
    %m(banknotes)
    if(classID == 123456)
         m('123456') = m('123456') + ((1 - m_certain) * m_certain);
    else
         m('123456') = (1 - m_certain) * m_certain;
    end;
   
    %m(banknotes, not banknote)
    m('1234567') = (1 - m_certain) * (1 - m_certain);
else
    if(m_certain < 0)
        m_certain = -1 * m_certain;
    end;
    %m(not banknote)
    m('7') = 1- m_certain;
    %m(banknotes, not banknote)
    m('1234567') = m_certain;
end;
end