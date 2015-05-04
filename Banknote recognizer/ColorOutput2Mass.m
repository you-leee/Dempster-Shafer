function [ m ] = ColorOutput2Mass( relDist, classID, Keys )
%Function for determing the mass-es from colors of a banknote.
%
%   Input:  -relDist double vector with values > 0, the relative 
%           distances(actual distance/tolerance limit) from the claster 
%           center. 0: exact match, 1: on the limit.
%           -classID integer vector, the IDs of the classes belonging to 
%           the distances in the same order
%   Output: -m vector, containing the masses for the banknotes

m = containers.Map(Keys,zeros(1, 128));

x_norm = (-2:.001:2);
max_norm = max(normpdf(x_norm));

min_relDist = min(relDist);
len = length(relDist);


if(min_relDist >= 1)
    normDivider = len;
    for i = 1:len
        if(relDist(i) ~= 1)
            m_certain = normpdf(relDist(i), 0, max_norm);
            
            %m(not banknote)
            m('7') = m('7') + 1- m_certain;
            %m(banknotes, not banknote)
            m('1234567') = m('1234567') + m_certain;
        else
            normDivider = normDivider - 1;
        end;
    end;
    %All the rel. distances are 1
    if(normDivider == 0)
        m('1234567') = 1;
        return;
    end;
    
    m('7') = m('7') / normDivider;
    m('1234567') = m('1234567') / normDivider;
    return;
    
else
    index = 1;
    m_certain_sum = 0;
    for i = 1:len
        %Collect IDs relDistances, where the values fit into the pos. 
        %interval
        if(relDist(i) < 1)
            pos_relDists(index) = relDist(i);
            pos_classIDs(index) = classID(i);
            index = index + 1;
        end;
    end;
    
    for i = 1:index - 1
        %Get the index and value of the "farest" rel. dist.
        [max_relDist, max_index] = max(pos_relDists);
        
        if(i == 1)
            m_certain = normpdf(max_relDist, 0, max_norm);
            m_certain_sum = m_certain_sum + m_certain;
            if(index == 2)
                m_max = m_certain;
            end;
        else
            if(i == index - 1)
                m_new_certain = normpdf(max_relDist, 0, max_norm);
                m_certain = m_new_certain - m_certain_sum;
                m_max = m_new_certain;
            else
                m_certain = normpdf(max_relDist, 0, max_norm) - m_certain_sum;
                m_certain_sum = m_certain_sum + m_certain;
            end;
        end;

        m(num2str(sort(pos_classIDs),'%1d')) = m_certain;
        
        %Remove element from pos_relDists and pos_classIDs
        pos_relDists(max_index) = [];
        pos_classIDs(max_index) = [];
    end;
    
    m_values = values(m);
    m_sum = sum([m_values{:}]);
    
    m('123456') = (1 - m_sum) * m_max;
    m('1234567') = (1 - m_sum) * (1 - m_max);
end;
    
end