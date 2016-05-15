clear all;
load('keys.mat')
t = [0.5, 0.5, 0.5];
testLength = 9;

Messages = cell(testLength,1);
Corr = zeros(testLength, 4);
HalfNumCount = zeros(testLength, 1);
P_Complete = zeros(testLength, 1);

RelDistPattern = zeros(testLength, 1);
IDsPattern = zeros(testLength, 1);

RelDistColor = zeros(testLength, 6);
IDsColor_row = [1,2,3,4,5,6];
IDsColor = repmat(IDsColor_row,testLength,1);

%1
Messages{1} = 'Semmi sincs a kepen';
Corr(1,:) = [0, 0, 0, 0];
HalfNumCount(1,:) = 0;
P_Complete(1,:) = 0;

RelDistPattern(1,:) = 1.6;
IDsPattern(1,:) = 1;

RelDistColor(1,:) = [1.2, 1.2, 1.2, 1.2, 1.2, 1.2];
IDsColor(1,:) = [1, 2, 3, 4, 5, 6];

%2
Messages{2} = 'Csak a cimert ismerjuk fel';
Corr(2,:) = [0, 0, 0, 0];
HalfNumCount(2,:) = 0;
P_Complete(2,:) = 1;

RelDistPattern(2,:) = 0;
IDsPattern(2,:) = 123456;

RelDistColor(2,:) = [1, 1, 1, 1, 1, 1];
IDsColor(2,:) = [1, 2, 3, 4, 5, 6];

%3
Messages{3} = 'Számoknál nem egyértelmû 2000 és 20000 között, többi nem tud semmit';
Corr(3,:) = [0, 1, 0, 0];
HalfNumCount(3,:) = 7;
P_Complete(3,:) = 0;

RelDistPattern(3,:) = 1;
IDsPattern(3,:) = 1;

RelDistColor(3,:) = [1, 1, 1, 1, 1, 1];
IDsColor(3,:) = [1, 2, 3, 4, 5, 6];

%4
Messages{4} = 'Számoknál csak azt látjuk, hogy 000 és többi nem tud semmit';
Corr(4,:) = [0, 0, 0, 1];
HalfNumCount(4,:) = 6;
P_Complete(4,:) = 1;

RelDistPattern(4,:) = 1;
IDsPattern(4,:) = 1;

RelDistColor(4,:) = [1, 1, 1, 1, 1, 1];
IDsColor(4,:) = [1, 2, 3, 4, 5, 6];

%5
Messages{5} = 'Számoknál csak azt látjuk, hogy 000, de színfelismerõ nagyjából felismeri, hogy 5000-es';
Corr(5,:) = [0, 0, 0, 1];
HalfNumCount(5,:) = 6;
P_Complete(5,:) = 1;

RelDistPattern(5,:) = 1;
IDsPattern(5,:) = 1;

RelDistColor(5,:) = [1, 1, 1, 0.5, 1, 1];
IDsColor(5,:) = [1, 2, 3, 4, 5, 6];

%6
Messages{6} = 'Ellentmondó szín és minta, szín szerint 500-as, minta szerint 2000-es';
Corr(6,:) = [0, 0, 0, 0];
HalfNumCount(6,:) = 0;
P_Complete(6,:) = 1;

RelDistPattern(6,:) = 0.1;
IDsPattern(6,:) = 3;

RelDistColor(6,:) = [0.1, 1, 1, 1, 1, 1];
IDsColor(6,:) = [1, 2, 3, 4, 5, 6];

%7
Messages{7} = 'Negatív szín és minta szempontjából, de szám egyértelmûen 500-as';
Corr(7,:) = [0, 0, 0.75, 0];
HalfNumCount(7,:) = 6;
P_Complete(7,:) = 1;

RelDistPattern(7,:) = 1.2;
IDsPattern(7,:) = 1;

RelDistColor(7,:) = [1.2, 1.2, 1.2, 1.2, 1.2, 1.2];
IDsColor(7,:) = [1, 2, 3, 4, 5, 6];

%8
Messages{8} = 'Egyértelmû 1000-es';
Corr(8,:) = [1, 0, 0, 0];
HalfNumCount(8,:) = 8;
P_Complete(8,:) = 1;

RelDistPattern(8,:) = 0;
IDsPattern(8,:) = 2;

RelDistColor(8,:) = [1, 0, 1, 1, 1, 1];
IDsColor(8,:) = [1, 2, 3, 4, 5, 6];

%9
Messages{9} = 'Minden szempontból bizonytalan 10000-es, viszont nincsen ellentmondás';
Corr(9,:) = [0.2, 0, 0, 0];
HalfNumCount(9,:) = 8;
P_Complete(9,:) = 0;

RelDistPattern(9,:) = 0.9;
IDsPattern(9,:) = 5;

RelDistColor(9,:) = [1, 1, 1, 1, 0.9, 1];
IDsColor(9,:) = [1, 2, 3, 4, 5, 6];

for i = 7:7
    M_number = NumRecOutput2Mass(Corr(i,:), HalfNumCount(i,:), P_Complete(i,:), t, Keys);
    M_pattern = PatternOutput2Mass(RelDistPattern(i,:), IDsPattern(i,:), Keys);
    M_color = ColorOutput2Mass(RelDistColor(i,:),IDsColor(i,:),Keys);

    tmp1 = GPA(M_number, M_pattern);
    
    M_ds_tmp1 = m_DS(tmp1);
    M_ds_tmp2 = GPA(M_ds_tmp1, M_color);
    M_ds_combi = m_DS(M_ds_tmp2);
    
    M_y_tmp1 = m_Y(tmp1);
    M_y_tmp2 = GPA(M_y_tmp1, M_color);
    M_y_combi = m_Y(M_y_tmp2);
    
    if(sum(cell2mat(values(M_ds_combi))) ~= 1.0)
        warning('The sum of the masses is not 1, it is: %d', sum(cell2mat(values(M_ds_combi))))
        m_values = cell2mat(values(M_ds_combi));
        m_keys = keys(M_ds_combi);
        m_values = m_values / sum(m_values);
        M_ds_combi = containers.Map(m_keys,m_values);
    end;
    if(sum(cell2mat(values(M_y_combi))) ~= 1.0)
        warning('The sum of the masses is not 1, it is: %d', sum(cell2mat(values(M_y_combi))))
        m_values = cell2mat(values(M_y_combi));
        m_keys = keys(M_y_combi);
        m_values = m_values / sum(m_values);
        M_y_combi = containers.Map(m_keys,m_values);
    end;


    %fprintf('\nEset %s', strcat(num2str(i), ':', Messages{i}));
    fprintf('\n')
    fprintf('Mass ds és yager\n')
    fprintf(' 500      1000     2000     5000     10000    20000    Negative Banknote ALL\n')
    fprintf('% f', M_ds_combi('1'), M_ds_combi('2'), M_ds_combi('3'), M_ds_combi('4'), M_ds_combi('5'), M_ds_combi('6'), M_ds_combi('7'), M_ds_combi('123456'), M_ds_combi('1234567'))
    fprintf('\n')
    fprintf('% f', M_y_combi('1'), M_y_combi('2'), M_y_combi('3'), M_y_combi('4'), M_y_combi('5'), M_y_combi('6'), M_y_combi('7'), M_y_combi('123456'), M_y_combi('1234567'))

    bel_ds = belief(M_ds_combi);
    bel_y = belief(M_y_combi);
    fprintf('\n')
    fprintf('Belief, Plausibility for ds and yager\n')
    fprintf(' 500      1000     2000     5000     10000    20000    Negative\n')
    fprintf('% f', bel_ds('1'), bel_ds('2'), bel_ds('3'), bel_ds('4'), bel_ds('5'), bel_ds('6'), bel_ds('7'))
    fprintf('\n')
    fprintf('% f', bel_y('1'), bel_y('2'), bel_y('3'), bel_y('4'), bel_y('5'), bel_y('6'), bel_y('7'))
    
    plaus_ds = plausibility(M_ds_combi);
    plaus_y = plausibility(M_y_combi);
    fprintf('\n')
    fprintf('% f', plaus_ds('1'), plaus_ds('2'), plaus_ds('3'), plaus_ds('4'), plaus_ds('5'), plaus_ds('6'), plaus_ds('7'))
    fprintf('\n')
    fprintf('% f', plaus_y('1'), plaus_y('2'), plaus_y('3'), plaus_y('4'), plaus_y('5'), plaus_y('6'), plaus_y('7'))
    fprintf('\n')
    
    P_pignistic_ds = P_m(M_ds_combi);
    P_pignistic_y = P_m(M_y_combi);
    fprintf('\n')
    fprintf('Probability(from mass(ds and yager) and real)\n')
    fprintf('% f', P_pignistic_ds('1'), P_pignistic_ds('2'), P_pignistic_ds('3'), P_pignistic_ds('4'), P_pignistic_ds('5'), P_pignistic_ds('6'), P_pignistic_ds('7'))
    fprintf('\n')
    fprintf('% f', P_pignistic_y('1'), P_pignistic_y('2'), P_pignistic_y('3'), P_pignistic_y('4'), P_pignistic_y('5'), P_pignistic_y('6'), P_pignistic_y('7'))
    fprintf('\n')
    
    
    ds500 = [M_ds_combi('1'); bel_ds('1'); plaus_ds('1'); P_pignistic_ds('1')];
    ds1000 = [M_ds_combi('2'); bel_ds('2'); plaus_ds('2'); P_pignistic_ds('2')];
    ds2000 = [M_ds_combi('3'); bel_ds('3'); plaus_ds('3'); P_pignistic_ds('3')];
    ds5000 = [M_ds_combi('4'); bel_ds('4'); plaus_ds('4'); P_pignistic_ds('4')];
    ds10000 = [M_ds_combi('5'); bel_ds('5'); plaus_ds('5'); P_pignistic_ds('5')];
    ds20000 = [M_ds_combi('6'); bel_ds('6'); plaus_ds('6'); P_pignistic_ds('6')];
    dsNegative = [M_ds_combi('7'); bel_ds('7'); plaus_ds('7'); P_pignistic_ds('7')];
    
    y500 = [M_y_combi('1'); bel_y('1'); plaus_y('1'); P_pignistic_y('1')];
    y1000 = [M_y_combi('2'); bel_y('2'); plaus_y('2'); P_pignistic_y('2')];
    y2000 = [M_y_combi('3'); bel_y('3'); plaus_y('3'); P_pignistic_y('3')];
    y5000 = [M_y_combi('4'); bel_y('4'); plaus_y('4'); P_pignistic_y('4')];
    y10000 = [M_y_combi('5'); bel_y('5'); plaus_y('5'); P_pignistic_y('5')];
    y20000 = [M_y_combi('6'); bel_y('6'); plaus_y('6'); P_pignistic_y('6')];
    yNegative = [M_y_combi('7'); bel_y('7'); plaus_y('7'); P_pignistic_y('7')];
    
    file_ds = strcat('DS_', num2str(i), '.xls');
    file_y = strcat('Y_', num2str(i), '.xls');
    T_ds = table(ds500, ds1000, ds2000, ds5000, ds10000, ds20000, dsNegative, 'RowNames', {'Combined mass'; 'Belief'; 'Plausibility'; 'Probability with pignistic transformation'});
    T_y = table(y500, y1000, y2000, y5000, y10000, y20000, yNegative, 'RowNames', {'Combined mass'; 'Belief'; 'Plausibility'; 'Probability with pignistic transformation'});
    
    writetable(T_ds,file_ds,'WriteRowNames',true);
    writetable(T_y,file_y,'WriteRowNames',true);
end;