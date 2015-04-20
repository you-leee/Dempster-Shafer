function [ m ] = NumRecOutput2Mass( corr, halfNumCount, pComplete, t )
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
%           1000-10000 and 2000-20000 (m(500) = t[1] and m(500, 5000) = 1-
%           t[1])
%           
%   Output:  -m vector, containing the masses for the banknotes

pNotComplete = 1- pComplete;
corr0 = corr(4);
corr1 = corr(1);
corr2 = corr(2);
corr5 = corr(3);
t1 = t(2);
t2 = t(3);
t5 = t(1);
maxCorr = max(corr);

m = zeros(1, 64);

%ATLAGOLNI kell meg

%1, 2, 5, 0 OR 10, 20, 50, 00
if(halfNumCount <= 2)
    
    %1, 2, 5, 0 OR 10, 20, 50, 00
    if(halfNumCount == 2 && pNotComplete > 0)
        m(15) = corr1; %1 - m(1000, 10000)
        m(19) = corr2; %2 - m(2000, 20000)
        m(10) = corr5; %5 - m(500, 5000)
        m(64) = corr0; %0 - m(ALL)
        
        %Itt kene meg sulyozni a maxCorr-ral??
        
    %1, 2, 5, 0
    else
        m(15) = corr1; %1 - m(1000, 10000)
        m(19) = corr2; %2 - m(2000, 20000)
        m(10) = corr5; %5 - m(500, 5000)
        m(64) = corr0; %0 - m(ALL)
        
        %Itt kene meg sulyozni a maxCorr-ral??
        
    end;
    %Vegen majd kiemelni ide kozoseket
    m = m / sum(m);

    
%10, 20, 50, 00  OR  100, 200, 500, 000
elseif(halfNumCount > 2 && halfNumCount <= 4)
    
    %10, 20, 50, 00  OR  100, 200, 500, 000
    if(halfNumCount == 4 && pNotComplete > 0)
        m(15) = corr1 * pComplete; %10 - m(1000, 10000)
        m(19) = corr2 * pComplete; %20 - m(2000, 20000)
        m(10) = corr5 * pComplete; %50 - m(500, 5000)
        
        %Meg johetne, hogy 500-asnal pont 2 db 0 van
        m(64) = corr0 * pComplete; %00
        
        
        m(15) = corr1 * pNotComplete; %100 - m(1000, 10000)
        m(19) = corr2 * pNotComplete; %200 - m(2000, 20000)
        m(1) = t5 * corr5 * pNotComplete; %500 - m(500)
        m(10) = (1 - t5) * corr5 * pNotComplete; %500 - m(500, 5000)
        
        %Meg johetne, hogy ezreseknel pont 3 db 0 van
        m(63) = corr0 * pNotComplete; %000
        
        %Itt kene meg sulyozni a maxCorr-ral??
        
    %10, 20, 50, 00 
    else
        m(15) = corr1; %10 - (1000, 10000)
        m(19) = corr2; %20 - (2000, 20000)
        m(10) = corr5; %50 - (500, 5000)
        
        %Meg johetne, hogy 500-asnal pont 2 db 0 van
        m(64) = corr0; %00 - (ALL)
        
        %Itt kene meg sulyozni a maxCorr-ral??
        
    end;
    %Vegen majd kiemelni ide kozoseket
    m = m / sum(m);

    
elseif (halfNumCount > 4 && halfNumCount <= 6)
    %100, 200, 500 000  OR  1000, 2000, 5000, 0000
    if(halfNumCount == 6 && pNotComplete > 0)
        m(15) = corr1 * pComplete; %100 - m(1000, 10000)
        m(19) = corr2 * pComplete; %200 - m(2000, 20000)
        m(1) = t5 * corr5 * pComplete; %500 - m(500)
        m(10) = (1 - t5) * corr5 * pComplete; %500 - m(500, 5000)
        
        %Meg johetne, hogy ezreseknel pont 3 db 0 van
        m(63) = corr0 * pComplete; %000 - m(1000, 2000, 5000, 10000, 20000)
        
        
        m(2) = t1 * corr1 * pNotComplete; %1000 - m(1000)
        m(15) = (1 - t1) * corr1 * pNotComplete; %1000 - m(1000, 10000)
        m(3) = t2 * corr2 * pNotComplete; %2000 - m(2000)
        m(19) = (1 - t2) * corr2 * pNotComplete; %2000 - m(2000, 20000)
        m(4) = corr5 * pNotComplete; %5000 - m(5000)
        
        m(22) = corr0 * pNotComplete; %0000 - m(10000, 20000)
        
        %Itt kene meg sulyozni a maxCorr-ral??
        
    %100, 200 500, 000
    else
        m(15) = corr1; %100 - m(1000, 10000)
        m(19) = corr2; %200 - m(2000, 20000)
        m(1) = t5 * corr5; %500 - m(500)
        m(10) = (1 - t5) * corr5; %500 - m(500, 5000)
        
        %Meg johetne, hogy ezreseknel pont 3 db 0 van
        m(63) = corr0; %000 - m(1000, 2000, 5000, 10000, 20000)
        
        %Itt kene meg sulyozni a maxCorr-ral??
        
    end;
    %Vegen majd kiemelni ide kozoseket
    m = m / sum(m);
    

%1000, 2000, 5000, 0000  OR  10000, 20000
elseif(halfNumCount > 6 && halfNumCount <= 8)
    
    %1000, 2000, 5000, 0000  OR  10000, 20000
    if(halfNumCount == 8 && pNotComplete > 0)
        m(2) = t1 * corr1 * pComplete; %1000 - m(1000)
        m(15) = (1 - t1) * corr1 * pComplete; %1000 - m(1000, 10000)
        m(3) = t2 * corr2 * pComplete; %2000 - m(2000)
        m(19) = (1 - t2) * corr2 * pComplete; %2000 - m(2000, 20000)
        m(4) = corr5 * pComplete; %5000 - m(5000)   
        m(22) = corr0 * pComplete; %0000 - m(10000, 20000)
         
        m(6) = corr1 * pNotComplete; %10000 - m(1000)
        m(7) = corr2 * pNotComplete; %20000 - m(2000)
        
        %Itt kene meg sulyozni a maxCorr-ral??
        
    %1000, 2000, 5000, 0000
    else
        m(2) = t1 * corr1; %1000 - m(1000)
        m(15) = (1 - t1) * corr1; %1000 - m(1000, 10000)
        m(3) = t2 * corr2; %2000 - m(2000)
        m(19) = (1 - t2) * corr2; %2000 - m(2000, 20000)
        m(4) = corr5; %5000 - m(5000)   
        m(22) = corr0; %0000 - m(10000, 20000)
        
        %Itt kene meg sulyozni a maxCorr-ral??
    end;
    
    %Vegen majd kiemelni ide kozoseket
    m = m / sum(m);
    
   
%10000, 20000       
else
    m(6) = corr1; %10000 - m(1000)
    m(7) = corr2; %20000 - m(2000)
        
    %Itt kene meg sulyozni a maxCorr-ral??
    
    m = m / sum(m);
end;


end



