% Function for deteming plausibility function values from masses
%
% input:  mMap -> Map container with:
%         -> keys -> labels of the classes and all the subsets of them in
%         increasing order in a cell array of characters. 
%         Number of classes can be maximum 10.
%         Example: classes = {1,2,3}; keys = {0,1,2,3,12,13,23,123} 
%         or any subset of this.
%         -> m ->  rowvector of masses in the order of the keys
% output: bel -> plausibility function values map in in the order of the keys

function [ plaus ] = plausibility( m )

if abs(sum(cell2mat(values(m)))-1) > 0.00000000000001
     error('plausibility:sumCheck', 'The sum of masses is not 1')
end;

len_m = length(values(m));

if log2(len_m) > 10
     error('plausibility:classNumCheck', 'There are more than 10 classes')
end;

key = keys(m);
plaus = containers.Map(key,zeros([1,len_m]));

for i=1:len_m
    tmpKeys = allSubsetsContainingKey(key, key{i});
    for j=1:length(tmpKeys)
        plaus(key{i}) = plaus(key{i}) + m(tmpKeys{j});
    end;
end;

end

