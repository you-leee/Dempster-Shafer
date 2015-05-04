%Function for determing all the subsets of A, containing key
%   Used to determine the plausibility
%   [(key intesect A) != 0]
%
%input: A -> cell array of characters of the keys
%       key -> specific key, for wich we want to find all the 
%       subsets of A containing it.
%output: b -> cell array of characters of the keys, containing the input key

function [ b ] = allSubsetsContainingKey( A, key )

b = cell(0);
index = 1;

for i=1:length(A)
    if(not(isempty(intersect(A{i},key))))
        b{index} = A{i};
        index = index + 1;
    end;
end;
end

