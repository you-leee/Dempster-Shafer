function [ m ] = ClasterNumbers2Mass( c, conf )

%Function for determing the mass-es from 1-NN clasterization of the number
%on the banknote
%   Input:  -c vector,where coloumns are the number of votes for 2 zeros, 3 
%   zeros and 4 zeros
%           -conf constant, the confidence of the clusterizer
%   Output:  -m vector,containing the masses for the banknotes


votesSum = sum(c);
c = c/votesSum;
m = zeros(1,64);

if(votesSum == 0)
    m(64) = 1;
    return;
end;

mConf1 = zeros(1,64);
mConf1(2) = c(3); %500
mConf1(3) = c(1); %1000
mConf1(4) = c(2); %2000
mConf1(5) = c(3); %5000
mConf1(6) = c(1); %10000
mConf1(7) = c(2); %20000

mConf1 = mConf1/sum(mConf1(2:7));

m = Claster2Mass(mConf1, conf);

%sum(m)

end

