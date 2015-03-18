%Function for deteming  the joint ground probability assignment(q)
%
%   [q12(A) = sum(m1(B)*m2(C)) ,where (B intersect C) = A]
%   

function [ q ] = GPA( m1, m2 )

K = conflict( m1, m2 );
q = containers.Map();
key1 = keys(m1);
key2 = keys(m2);

for i=1:length(key1)
    for j=1:length(key2)
        tempKey = intersect(key1{i},key2{j});
        if(not(isempty(tempKey)))
            if(isKey(q,tempKey))
                q(tempKey) = m1(key1{i})*m2(key2{j}) + q(tempKey);
            else
                q(tempKey) = m1(key1{i})*m2(key2{j});
            end;
        end;
    end;
end;
q('0') = K;
end

