%Function for deteming  the bayesian probabilities with the plausibility
%   transformation method
%
%   [P(A)=Pl(A)/summ(Pl(x)) for all x]
%   

function [ P ] = P_pl( keys, m )

pl_m = plausibility(containers.Map(keys,m));
single_keys = cell([1 log2(length(keys))]);
single_pls = zeros([1 log2(length(keys))]);

index = 1;
for i=2:length(keys)
    if(length(keys{i}) == 1)
        single_keys{index} = keys{i};
        single_pls(index) = pl_m(single_keys{index});
        index = index + 1;   
    end;
end;

P = containers.Map(single_keys,single_pls/sum(single_pls));

end