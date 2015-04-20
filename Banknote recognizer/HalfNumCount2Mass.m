function [ m ] = HalfNumCount2Mass( halfNumCount, pComplete, corr0 )
%Function for determing the mass-es from the count of half numbers, the
%probability, that the first number is recognized as a whole number
%and the correlation with 0 for the first number
%
%   Input:  -halfNumCount integer, the count of half numbers on the
%   banknote
%           -pComplete double, the probability, that the first number is
%           recognized as a whole number
%           -corr0 double, the correlation with 0 for the first number
%   Output:  -m vector, containing the masses for the banknotes

m = zeros(1, 64);
mConf1 = zeros(1, 64);
k = 1;
pNotComplete = 1- pComplete;


if(halfNumCount <= 4)
    %(10, 20, 50, 00)  OR  (100, 200,) 500, 000
    if(halfNumCount == 4 && pNotComplete > 0)
        mConf1(2) = (1 - corr0 * k) * pNotComplete; % 500 - 500
        mConf1(3) = (corr0 * k) * pNotComplete; %1000 - 000
        mConf1(4) = (corr0 * k) * pNotComplete; %2000
        mConf1(5) = (corr0 * k) * pNotComplete; %5000
        mConf1(6) = (corr0 * k) * pNotComplete; %10000
        mConf1(7) = (corr0 * k) * pNotComplete; %20000
        mConf1(64) = pComplete; %10, 20, 50, 00
        
        mConf1 = mConf1 / sum(mConf1);
        %maxConf = max(mConf1);
        m = Claster2Mass(mConf1, 1);
    %(10, 20, 50, 00 )
    else
        m(64) = 1;
    end;
    

elseif (halfNumCount > 4 && halfNumCount <= 6)
    %(100, 200, 500,) 000  OR  1000, 2000, 5000, 0000
    if(halfNumCount == 6 && pNotComplete > 0)
        mConf1(3) = (1 - corr0 * k) * pNotComplete; %1000
        mConf1(4) = (1 - corr0 * k) * pNotComplete; %2000
        mConf1(5) = (1 - corr0 * k) * pNotComplete; %5000
        mConf1(6) = (corr0 * k) * pNotComplete; %10000
        mConf1(7) = (corr0 * k) * pNotComplete; %20000
        
        mConf1(2) = (1 - corr0 * k) * pComplete; %500
        mConf1(3) = mConf1(3) + (corr0 * k) * pComplete; %1000
        mConf1(4) = mConf1(4) + (corr0 * k) * pComplete; %2000
        mConf1(5) = mConf1(5) + (corr0 * k) * pComplete; %5000
        mConf1(6) = mConf1(6) + (corr0 * k) * pComplete; %10000
        mConf1(7) = mConf1(7) + (corr0 * k) * pComplete; %20000
        
        mConf1(3) = mConf1(3) / 2; %1000
        mConf1(4) = mConf1(4) / 2; %2000
        mConf1(5) = mConf1(5) / 2; %5000
        mConf1(6) = mConf1(6) / 2; %10000
        mConf1(7) = mConf1(7) / 2; %20000

        mConf1(2:7) = mConf1(2:7) / sum(mConf1(2:7));
        %maxConf = max(mConf1);
        m = Claster2Mass(mConf1, 1);
        
    %(100, 200,) 500, 000
    else
        mConf1(2) = 1 - corr0 * k; %500
        mConf1(3) = corr0 * k; %1000
        mConf1(4) = corr0 * k; %2000
        mConf1(5) = corr0 * k; %5000
        mConf1(6) = corr0 * k; %10000
        mConf1(7) = corr0 * k; %20000
        
        mConf1(2:7) = mConf1(2:7) / sum(mConf1(2:7));
        %maxConf = max(mConf1);
        m = Claster2Mass(mConf1, 1);
    end;

    

elseif(halfNumCount > 6 && halfNumCount <= 8)
    %1000, 2000, 5000, 0000  OR  10000, 20000
    if(halfNumCount == 8 && pNotComplete > 0)
        mConf1(3) = (1 - corr0 * k) * pNotComplete; %1000
        mConf1(4) = (1 - corr0 * k) * pNotComplete; %2000
        mConf1(5) = (1 - corr0 * k) * pNotComplete; %5000
        mConf1(6) = (corr0 * k) * pNotComplete; %10000
        mConf1(7) = (corr0 * k) * pNotComplete; %20000
        
        mConf1(6) = mConf1(6) + (1 - corr0 * k) * pComplete; %10000
        mConf1(7) = mConf1(7) + (1 - corr0 * k) * pComplete; %20000
        
        mConf1(6) = mConf1(6) / 2; %10000
        mConf1(7) = mConf1(7) / 2; %20000
        
        mConf1(3:7) = mConf1(3:7) / sum(mConf1(3:7));
        %maxConf = max(mConf1);
        m = Claster2Mass(mConf1, 1);
        
    %1000, 2000, 5000, 0000
    else
        mConf1(3) = 1 - corr0 * k; %1000
        mConf1(4) = 1 - corr0 * k; %2000
        mConf1(5) = 1 - corr0 * k; %5000
        mConf1(6) = corr0 * k; %10000
        mConf1(7) = corr0 * k; %20000
        
        mConf1(3:7) = mConf1(3:7) / sum(mConf1(3:7));
        %maxConf = max(mConf1);
        m = Claster2Mass(mConf1, 1);
    end;
   
%10000, 20000       
else
    mConf1(6) = 1 - corr0 * k; %10000
    mConf1(7) = 1 - corr0 * k; %20000
    
    mConf1(6:7) = mConf1(6:7) / sum(mConf1(6:7));
    %maxConf = max(mConf1);
    m = Claster2Mass(mConf1, 1);
end;

end

