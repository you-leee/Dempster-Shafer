%Function for determing all the subsets of A, whos elements are a subset of key.
%   Used to determine the belief
%   [(A(i) subset_of key)]
%
%input: A -> cell array of characters of the keys
%       key -> specific key, for wich we want to find all the 
%       subsets of A, whos elements are a subset of key.
%output: b -> cell array of characters of the keys, containing the input key

function [ b ] = allSubsetsElementsOfKey( A, key )

b = cell(0);
index = 1;

for i=1:length(A)
    isSubset = 1;
    for j=1:length(A{i})
        if(isempty(strfind(key,A{i}(j))))
            isSubset = 0;
        end;
    end;
    if (isSubset)
        b{index} = A{i};
        index = index + 1;
    end;

end

