clear all;
load('keys.mat')
t = [0.5, 0.5, 0.5];

Messages = cell(10,1);
Corr = zeros(10, 4);
HalfNumCount = zeros(10, 1);
P_Complete = zeros(10, 1);

RelDistPattern = zeros(10, 1);
IDsPattern = zeros(10, 1);

RelDistColor = zeros(10, 6);
IDsColor = zeros(10, 6);

%1
Messages{1} = 'Nem teljesen jól felismerhetõ 500-as fõleg számok szempontjából, minta közepesen felismerhetõ, szín jól felismerhetõ, de másik 2000-es és 10000-es is szóba jöhet';
Corr(1,:) = [0.1, 0, 0.05, 0.4];
HalfNumCount(1,:) = 5;
P_Complete(1,:) = 0.8;

RelDistPattern(1,:) = 0.6;
IDsPattern(1,:) = 1;

RelDistColor(1,:) = [0.2, 1, 0.4, 1, 0.5, 1];
IDsColor(1,:) = [1, 2, 3, 4, 5, 6];

%2
Messages{2} = 'Nem teljesen jól felismerhetõ 500-as, minta szempontjából csak a címer látszik, számok jól felismerhetõk, szín jól felismerhetõ, de 10000-es is szóba jöhet';
Corr(2,:) = [0.05, 0.05, 0, 0.85];
HalfNumCount(2,:) = 6;
P_Complete(2,:) = 1;

RelDistPattern(2,:) = 0.2;
IDsPattern(2,:) = 123456;

RelDistColor(2,:) = [0.15, 1, 1, 1, 0.45, 1];
IDsColor(2,:) = [1, 2, 3, 4, 5, 6];

%3
Messages{3} = 'Rosszul felismerhetõ 500-as, minta szempontjából szinte semmi sem látszik, számok nagyjából felismerhetõk, de 0-val is nagy a korreláció, színre 500-hoz és 2000-hez van viszonylag közel';
Corr(3,:) = [0.5, 0, 0.05, 0.6];
HalfNumCount(3,:) = 6;
P_Complete(3,:) = 0.9;

RelDistPattern(3,:) = 1.5;
IDsPattern(3,:) = 1;

RelDistColor(3,:) = [0.4, 1.5, 0.4, 1.5, 1.5, 1.5];
IDsColor(3,:) = [1, 2, 3, 4, 5, 6];

%4
Messages{4} = 'Nem felismerhetõ 500-as, minta szempontjából semmi sem látszik, számok sem felismerhetõk, színre valamennyire felismeri';
Corr(4,:) = [0, 0, 0, 0];
HalfNumCount(4,:) = 0;
P_Complete(4,:) = 1;

RelDistPattern(4,:) = 1.5;
IDsPattern(4,:) = 1;

RelDistColor(4,:) = [0.8, 1.5, 1.5, 1.5, 1.5, 1.5];
IDsColor(4,:) = [1, 2, 3, 4, 5, 6];

%5
Messages{5} = 'Nem felismerhetõ 2000-es, minta szempontjából semmi sem látszik, számoknál 0-val kezdõdõ, de 5-6 félszámjegyû, színre valamennyire felismeri, de 500-as is lehetne';
Corr(5,:) = [0.95, 0, 0, 0];
HalfNumCount(5,:) = 5;
P_Complete(5,:) = 0.5;

RelDistPattern(5,:) = 1.5;
IDsPattern(5,:) = 1;

RelDistColor(5,:) = [0.6, 1.5, 0.3, 1.5, 1.5, 1.5];
IDsColor(5,:) = [1, 2, 3, 4, 5, 6];

%6
Messages{6} = 'Egyértelmû 2000-es, minta szempontjából közel van, számoknál egyértelmû a számosság, nagyon korrelál 2-sel, de picit 0-val is, színre nagyon közel van 2000-hez';
Corr(6,:) = [0.2, 0, 1, 0];
HalfNumCount(6,:) = 8;
P_Complete(6,:) = 1;

RelDistPattern(6,:) = 0.1;
IDsPattern(6,:) = 3;

RelDistColor(6,:) = [1, 1.5, 0.05, 1.5, 1.5, 1.5];
IDsColor(6,:) = [1, 2, 3, 4, 5, 6];

%7
Messages{7} = 'Nem látunk semmit';
Corr(7,:) = [0, 0, 0, 0];
HalfNumCount(7,:) = 0;
P_Complete(7,:) = 1;

RelDistPattern(7,:) = 1.9;
IDsPattern(7,:) = 1;

RelDistColor(7,:) = [1.5, 1.5, 1.5, 1.5, 1.5, 1.5];
IDsColor(7,:) = [1, 2, 3, 4, 5, 6];


for i = 1:7
    M_number = NumRecOutput2Mass(Corr(i,:), HalfNumCount(i,:), P_Complete(i,:), t, Keys);
    M_pattern = PatternOutput2Mass(RelDistPattern(i,:), IDsPattern(i,:), Keys);
    M_color = ColorOutput2Mass(RelDistColor(i,:),IDsColor(i,:),Keys);

    tmp1 = GPA(M_color, M_pattern);
    tmp2 = m_DS(tmp1);
    tmp3 = GPA(tmp2, M_number);
    M_combi = m_DS(tmp3);
    
    if(sum(cell2mat(values(M_combi))) ~= 1)
        m_values = cell2mat(values(M_combi));
        m_keys = keys(M_combi);
        m_values = m_values / sum(m_values);
        M_combi = containers.Map(m_keys,m_values);
    end;


    fprintf('\nEset: %s', Messages{i});
    fprintf('\n')
    fprintf('Mass\n')
    fprintf(' 500      1000     2000     5000     10000    20000    Negative Banknote ALL\n')
    fprintf('% f', M_combi('1'), M_combi('2'), M_combi('3'), M_combi('4'), M_combi('5'), M_combi('6'), M_combi('7'), M_combi('123456'), M_combi('1234567'))

    bel = belief(M_combi);
    fprintf('\n')
    fprintf('Belief and Plausibility\n')
    fprintf(' 500      1000     2000     5000     10000    20000    Negative\n')
    fprintf('% f', bel('1'), bel('2'), bel('3'), bel('4'), bel('5'), bel('6'), bel('7'))

    plaus = plausibility(M_combi);
    fprintf('\n')
    fprintf('% f', plaus('1'), plaus('2'), plaus('3'), plaus('4'), plaus('5'), plaus('6'), plaus('7'))
    fprintf('\n')
end;