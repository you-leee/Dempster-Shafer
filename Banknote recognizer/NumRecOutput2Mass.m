function [ m ] = NumRecOutput2Mass( corr, halfNumCount, pComplete, t , Keys)
%Function for determing the mass-es from the count of half numbers, the
%probability, that the first number is recognized as a whole number
%and the correlation with 0 for the first number
%
%   Input:  -corr double vector, the correlations with 1, 2, 5 and 0 for 
%            the first number
%           -halfNumCount integer, the count of half numbers on the
%            banknote
%           -pComplete double, the probability, that the first number is
%            recognized as a whole number
%           -t vector, the weights (0...1) to distinguise between 500-5000, 
%           1000-10000 and 2000-20000 (m(500) => t[1] and m(500, 5000) => 1
%            - t[1])
%           
%   Output:  -m vector, containing the masses for the banknotes

pNotComplete = 1- pComplete;

x_norm = (0:.001:2);
max_norm = max(normpdf(x_norm));

if(corr(1) == 1)
    corr1 = 1;
elseif(corr(1) == 0)
    corr1 = 0;
else
    %corr1 = normpdf(corr(1), 1, max_norm);
    corr1 = (sin(corr(1).*pi/2)+normpdf(corr(1),1,max_norm))/2;
end;

if(corr(2) == 1)
    corr2 = 1;
elseif(corr(2) == 0)
    corr2 = 0;
else
    %corr2 = normpdf(corr(2), 1, max_norm);
    corr2 = (sin(corr(2).*pi/2)+normpdf(corr(2),1,max_norm))/2;
end;

if(corr(3) == 1)
    corr5 = 1;
elseif(corr(3) == 0)
    corr5 = 0;
else
    %corr5 = normpdf(corr(3), 1, max_norm);
    corr5 = (sin(corr(3).*pi/2)+normpdf(corr(3),1,max_norm))/2;
end;

if(corr(4) == 1)
    corr0 = 1;
elseif(corr(4) == 0)
    corr0 = 0;
else
    %corr0 = normpdf(corr(4), 1, max_norm);
    corr0 = (sin(corr(4).*pi/2)+normpdf(corr(4),1,max_norm))/2;
end;


t1 = t(2);
t2 = t(3);
t5 = t(1);

m = containers.Map(Keys,zeros(1, 128));


%1, 2, 5, 0 OR 10, 20, 50, 00
if(halfNumCount <= 2)
    m('25') = corr1; %1 - m(1000, 10000)
    m('36') = corr2; %2 - m(2000, 20000)
    m('14') = corr5; %5 - m(500, 5000)
    m('123456') = corr0; %0 - m(banknote)     
  
    
%10, 20, 50, 00  OR  100, 200, 500, 000
elseif(halfNumCount > 2 && halfNumCount <= 4)
    
    %10, 20, 50, 00  OR  100, 200, 500, 000
    if(halfNumCount == 4 && pNotComplete > 0)
        m('14') = corr5 * (((1 - t5) *  pNotComplete) + pComplete) / 2; %50, 500 - m(500, 5000)
        m('1') = t5 * corr5 * pNotComplete; %500 - m(500)
        m('23456') = corr0 * pNotComplete; %000 - m(1000,2000,5000,10000,20000)
        
    %10, 20, 50, 00 
    else 
        m('14') = corr5; %50 - (500, 5000)
    end;
    m('123456') = corr0 * pComplete; %00 - m(banknote)
    m('25') = corr1; %10 - (1000, 10000)
    m('36') = corr2; %20 - (2000, 20000)
    
    
%100, 200, 500 000  OR  1000, 2000, 5000, 0000
elseif (halfNumCount > 4 && halfNumCount <= 6)
    
    %100, 200, 500 000  OR  1000, 2000, 5000, 0000
    if(halfNumCount == 6 && pNotComplete > 0)
        m('25') = corr1 * (pComplete + ((1 - t1) * pNotComplete)) / 2; %100, 1000 - m(1000, 10000)
        m('36') = corr2 * (pComplete + ((1 - t2) * pNotComplete)) / 2; %200, 2000 - m(2000, 20000)
        
        m('2') = t1 * corr1 * pNotComplete; %1000 - m(1000)
        m('3') = t2 * corr2 * pNotComplete; %2000 - m(2000)
        m('4') = corr5 * pNotComplete; %5000 - m(5000)
        m('67') = corr0 * pNotComplete; %0000 - m(10000, 20000)
        
    %100, 200 500, 000
    else
        m('25') = corr1; %100 - m(1000, 10000)
        m('36') = corr2; %200 - m(2000, 20000)
    end;
    m('1') = t5 * corr5 * pComplete; %500 - m(500)
    m('14') = (1 - t5) * corr5 * pComplete; %500 - m(500, 5000)
    m('23456') = corr0 * pComplete; %000 - m(1000, 2000, 5000, 10000, 20000)
    

%1000, 2000, 5000, 0000  OR  10000, 20000
elseif(halfNumCount > 6 && halfNumCount <= 8)
    
    %1000, 2000, 5000, 0000  OR  10000, 20000
    if(halfNumCount == 8 && pNotComplete > 0) 
        m('5') = corr1 * pNotComplete; %10000 - m(10000)
        m('6') = corr2 * pNotComplete; %20000 - m(20000) 
    end;
    m('2') = t1 * corr1 * pComplete; %1000 - m(1000)
    m('3') = t2 * corr2 * pComplete; %2000 - m(2000)
    m('4') = corr5 * pComplete; %5000 - m(5000)
    m('25') = (1 - t1) * corr1 * pComplete; %1000 - m(1000, 10000)
    m('36') = (1 - t2) * corr2 * pComplete; %2000 - m(2000, 20000)  
    m('56') = corr0 * pComplete; %0000 - m(10000, 20000)
    
   
%10000, 20000       
else
    m('5') = corr1; %10000 - m(1000)
    m('6') = corr2; %20000 - m(2000)
end;

max_corr = max([corr0,corr1,corr2,corr5]);
    
m('123456') = (1 - max_corr) * max_corr; %m(banknote)
m('1234567') = (1 - max_corr) * (1 - max_corr); % m(all)

m_keys = keys(m);
m_values = cell2mat(values(m));
m_sum = sum(m_values);
m_values = m_values / m_sum;

m = containers.Map(m_keys,m_values);



end



