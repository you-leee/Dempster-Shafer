function [ m ] = Claster2Mass( mConf1, conf )
%Function for determing the mass-es from 1-NN clasterization for some
%banknote attribute
%   Input:  -mConf1 64 length vector,where the masses of the banknotes are,
%   when the confidence is 1
%           -conf constant, the confidence of the clusterizer
%   Output:  -m vector,containing the masses for the banknotes


if(conf == 1) 
    m = mConf1;
else
    negConf = 1 - conf;
    index = 8;
    
    
    %1 element
    m(2:7) = mConf1(2:7)*conf;
    
    %2 elements
    for i = 2:6
        for j = i+1:7
            m(index) = mConf1(i) + mConf1(j);
            index = index + 1;
        end;
    end;
    
    m(8:22) = m(8:22)/sum(m(8:22));
    m(8:22) = m(8:22)*conf*negConf;
    
    %3 elements
    for i = 2:5
        for j = i+1:6
            for k = j+1:7
                m(index) = mConf1(i) + mConf1(j) + mConf1(k);
                index = index + 1;
            end;
        end;
    end;
    
    m(23:42) = m(23:42)/sum(m(23:42));
    m(23:42) = m(23:42)*conf*negConf*negConf;
    
    %4 elements
    for i = 2:4
        for j = i+1:5
            for k = j+1:6
                for l = k+1:7
                    m(index) = mConf1(i) + mConf1(j) + mConf1(k) + mConf1(l);
                    index = index + 1;
                end;
            end;
        end;
    end;
    
    m(43:57) = m(43:57)/sum(m(43:57));
    m(43:57) = m(43:57)*conf*negConf*negConf*negConf;
    
    %5 elements
    for i = 2:3
        for j = i+1:4
            for k = j+1:5
                for l = k+1:6
                    for n = l+1:7
                        m(index) = mConf1(i) + mConf1(j) + mConf1(k) + mConf1(l) + mConf1(n);
                        index = index + 1;
                    end;
                end;
            end;
        end;
    end;
    
    m(58:63) = m(58:63)/sum(m(58:63));
    m(58:63) = m(58:63)*conf*negConf*negConf*negConf*negConf;
    
    %6 elements, could be written like this also: negConf*negConf*negConf*negConf*negConf
    m(64) = (mConf1(2) + mConf1(3) + mConf1(4) + mConf1(5)+ mConf1(6)+ mConf1(7))*negConf*negConf*negConf*negConf*negConf;   
end;

end

