function [ m ] = FirstNumber2Mass( corr )
%Function for determing the mass-es from correlations between the claster
%outputs and the numbers on the banknote
%
%   Input:  -corr vector,where coloumns are the correlations for 1, 2, 5
%   Output:  -m vector, containing the masses for the banknotes

corrSum = sum(corr);
m = zeros(1, 64);

%If there is no correlation
if(corrSum == 0)
    m(64) = 1;
    return;
end;

mConf1 = zeros(1, 64);
mConf1(2) = corr(3); %500
mConf1(3) = corr(1); %1000
mConf1(4) = corr(2); %2000
mConf1(5) = corr(3); %5000
mConf1(6) = corr(1); %10000
mConf1(7) = corr(2); %20000
mConf1(2:7) = mConf1(2:7) / 2;


mConf1 = mConf1/sum(mConf1(2:7));

m = Claster2Mass(mConf1, max(corr));

end

