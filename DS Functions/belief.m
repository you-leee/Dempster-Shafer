% Function for deteming belief function values from masses
%
% input:  mMap -> Map container with:
%           -> keys -> labels of the classes and all the subsets of them in
%           increasing order in a cell array of characters. 
%           Number of classes can be maximum 10.
%           Example: classes = {1,2,3}; keys = {0,1,2,3,12,13,23,123} 
%           or any subset of this.
%           -> m ->  rowvector of masses in the order of the keys
% output: bel -> belief function values map in the order of the keys

function [ bel ] = belief( m )

if abs(sum(cell2mat(values(m)))-1) > 0.00000000000001
     error('belief:sumCheck', 'The sum of masses is not 1')
end;

len_m = length(values(m));

if log2(len_m) > 10
     error('belief:classNumCheck', 'There are more than 10 classes')
end;

key = keys(m);
bel = containers.Map(key,zeros([1,len_m]));

for i=1:len_m
    tmpKeys = allSubsetsElementsOfKey(key, key{i});
    for j=1:length(tmpKeys)
        bel(key{i}) = bel(key{i}) + m(tmpKeys{j});
    end;
end;

end

