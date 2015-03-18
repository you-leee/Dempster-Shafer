%Function for deteming  the amount of conflict between two mass sets,
%   in other words, the normalization factor K.
%
%   [sum(m1(B)*m2(C)) ,where (B intersect C) = 0]
%
%Note: used to calculate GPA

function [ K ] = conflict( mMap1, mMap2 )

K = 0;
key1 = keys(mMap1);
key2 = keys(mMap2);

for i=2:length(key1)
    for j=2:length(key2)
        if(isempty(intersect(key1{i},key2{j})))
            K = K + mMap1(key1{i})*mMap2(key2{j});
        end;
    end;
end;

end

