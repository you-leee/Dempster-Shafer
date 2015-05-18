%Function for deteming  the bayesian probabilities with the pignistic
%   transformation method
%
%   [P(x)=sum(m(A)/|A|) for all x subset A]
%   

function [ P ] = P_m( m )

Keys = keys(m);
single_keys = cell([1 log2(length(Keys))]);
P_m = zeros([1 log2(length(Keys))]);
index = 1;

for i = 2:length(Keys)
    if length(Keys{i}) == 1
        tmpKeys = allSubsetsContainingKey(Keys, Keys{i});
        single_keys{index} = Keys{i};
        for j = 1:length(tmpKeys)
            P_m(index) = P_m(index) + m(tmpKeys{j})/length(tmpKeys{j});
        end;
        index = index + 1;
    end;
end;

P = containers.Map(single_keys, P_m);

end