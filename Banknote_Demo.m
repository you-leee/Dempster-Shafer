clear all;
load('keys.mat')
load('votes_May_24_2015__19_51_37.mat')
t = [0.5, 0.5, 0.5];
testLength = 14;

% Messages = cell(10,1);
Corr = zeros(testLength, 4);
HalfNumCount = zeros(testLength, 1);
P_Complete = zeros(testLength, 1);

RelDistPattern = zeros(testLength, 1);
IDsPattern = zeros(testLength, 1);

% RelDistColor = zeros(testLength, 6);
% RelDistColor(1,:) = [0.8, 1, 0.75, 1, 1, 1]; %48
% RelDistColor(2,:) = [1, 1, 0.9, 1, 1, 1]; %91
% RelDistColor(3,:) = [1, 1, 1, 1, 0.99, 0.1]; %96
% RelDistColor(4,:) = [1, 1, 1, 1, 1, 0.6]; %98
% RelDistColor(5,:) = [0.85, 1, 0.95, 1, 1, 0.95]; %147
% RelDistColor(6,:) = [1, 0.15, 1, 1, 1, 1]; %169
% RelDistColor(7,:) = [0.5, 1, 0.8, 1, 1, 1]; %183
% RelDistColor(8,:) = [0.8, 1, 0.95, 1, 1, 1]; %198
% RelDistColor(9,:) = [0.95, 1, 1, 1, 1, 1]; %211
% RelDistColor(10,:) = [0.95, 1, 1, 1, 1, 1]; %214
% RelDistColor(11,:) = [0.2, 1, 0.8, 1, 1, 1]; %259
% RelDistColor(12,:) = [1, 0.9, 1, 1, 0.3, 1]; %280
% RelDistColor(13,:) = [1.5, 1.5, 1, 1, 1, 1]; %282
% RelDistColor(14,:) = [1, 0.9, 1, 0.9, 0.3, 1]; %303
% 
% IDsColor_row = [1,2,3,4,5,6];
% IDsColor = repmat(IDsColor_row,testLength,1);


indices = [48,91,96,98,147,169,183,198,211,214,259,280,282,303];

for i=1:testLength
    Corr_temp = numberDetails(indices(i), 6:9);
    Corr_temp(Corr_temp<0) = 0;
    Corr(i,:) = Corr_temp;
    HalfNumCount(i,:) = numberDetails(indices(i), 5);
    %If rightDist > numwidth
    if numberDetails(indices(i), 3) > numberDetails(indices(i), 4)
        P_Complete(i,:) = 1;
    else
        P_Complete(i,:) = 0;
    end;
    
    notZeroIndex = find(face(indices(i), 2:7));
    if ~isempty(notZeroIndex)
        RelDistPattern(i,:) = faceRelDists(indices(i),2);
        IDsPattern(i,:) = face(indices(i), notZeroIndex(1));
    else
        RelDistPattern(i,:) = 1;
        IDsPattern(i,:) = 7;
    end;
    
end;


for i = 5:5
    M_number = NumRecOutput2Mass(Corr(i,:), HalfNumCount(i,:), P_Complete(i,:), t, Keys);
    M_pattern = PatternOutput2Mass(RelDistPattern(i,:), IDsPattern(i,:), Keys);
%     M_color = ColorOutput2Mass(RelDistColor(i,:),IDsColor(i,:),Keys);

    tmp1 = GPA(M_number, M_pattern);
    
    M_ds_tmp1 = m_DS(tmp1);
%     M_ds_tmp2 = GPA(M_ds_tmp1, M_color);
    M_ds_combi = M_ds_tmp1;% m_DS(M_ds_tmp2);
    
%     M_y_tmp1 = m_Y(tmp1);
%     M_y_tmp2 = GPA(M_y_tmp1, M_color);
%     M_y_combi = M_y_tmp1;%m_Y(M_y_tmp2);
    
    if(sum(cell2mat(values(M_ds_combi))) ~= 1.0)
        warning('The sum of the masses is not 1, it is: %d', sum(cell2mat(values(M_ds_combi))))
        m_values = cell2mat(values(M_ds_combi));
        m_keys = keys(M_ds_combi);
        m_values = m_values / sum(m_values);
        M_ds_combi = containers.Map(m_keys,m_values);
    end;
%     if(sum(cell2mat(values(M_y_combi))) ~= 1.0)
%         warning('The sum of the masses is not 1, it is: %d', sum(cell2mat(values(M_y_combi))))
%         m_values = cell2mat(values(M_y_combi));
%         m_keys = keys(M_y_combi);
%         m_values = m_values / sum(m_values);
%         M_y_combi = containers.Map(m_keys,m_values);
%     end;


    %fprintf('\nEset %s', strcat(num2str(i), ':', Messages{i}));
    fprintf('\n')
    fprintf('Mass ds és yager\n')
    fprintf(' 500      1000     2000     5000     10000    20000    Negative Banknote ALL\n')
    fprintf('% f', M_ds_combi('1'), M_ds_combi('2'), M_ds_combi('3'), M_ds_combi('4'), M_ds_combi('5'), M_ds_combi('6'), M_ds_combi('7'), M_ds_combi('123456'), M_ds_combi('1234567'))
%     fprintf('\n')
%     fprintf('% f', M_y_combi('1'), M_y_combi('2'), M_y_combi('3'), M_y_combi('4'), M_y_combi('5'), M_y_combi('6'), M_y_combi('7'), M_y_combi('123456'), M_y_combi('1234567'))

    bel_ds = belief(M_ds_combi);
%     bel_y = belief(M_y_combi);
    fprintf('\n')
    fprintf('Belief, Plausibility for ds and yager\n')
    fprintf(' 500      1000     2000     5000     10000    20000    Negative\n')
    fprintf('% f', bel_ds('1'), bel_ds('2'), bel_ds('3'), bel_ds('4'), bel_ds('5'), bel_ds('6'), bel_ds('7'))
%     fprintf('\n')
%     fprintf('% f', bel_y('1'), bel_y('2'), bel_y('3'), bel_y('4'), bel_y('5'), bel_y('6'), bel_y('7'))
    
    plaus_ds = plausibility(M_ds_combi);
%     plaus_y = plausibility(M_y_combi);
    fprintf('\n')
    fprintf('% f', plaus_ds('1'), plaus_ds('2'), plaus_ds('3'), plaus_ds('4'), plaus_ds('5'), plaus_ds('6'), plaus_ds('7'))
    fprintf('\n')
%     fprintf('% f', plaus_y('1'), plaus_y('2'), plaus_y('3'), plaus_y('4'), plaus_y('5'), plaus_y('6'), plaus_y('7'))
%     fprintf('\n')
    
    P_pignistic_ds = P_m(M_ds_combi);
%     P_pignistic_y = P_m(M_y_combi);
    P_votes = sumVote(indices(i),2:7);
    fprintf('\n')
    fprintf('Probability(from mass(ds and yager) and real)\n')
    fprintf('% f', P_pignistic_ds('1'), P_pignistic_ds('2'), P_pignistic_ds('3'), P_pignistic_ds('4'), P_pignistic_ds('5'), P_pignistic_ds('6'), P_pignistic_ds('7'))
    fprintf('\n')
%     fprintf('% f', P_pignistic_y('1'), P_pignistic_y('2'), P_pignistic_y('3'), P_pignistic_y('4'), P_pignistic_y('5'), P_pignistic_y('6'), P_pignistic_y('7'))
%     fprintf('\n')
    fprintf('% f', P_votes(1), P_votes(2), P_votes(3), P_votes(4), P_votes(5), P_votes(6))
    fprintf('\n')
    
    
    ds500 = [M_ds_combi('1'); bel_ds('1'); plaus_ds('1'); P_pignistic_ds('1'); P_votes(1)];
    ds1000 = [M_ds_combi('2'); bel_ds('2'); plaus_ds('2'); P_pignistic_ds('2'); P_votes(2)];
    ds2000 = [M_ds_combi('3'); bel_ds('3'); plaus_ds('3'); P_pignistic_ds('3'); P_votes(3)];
    ds5000 = [M_ds_combi('4'); bel_ds('4'); plaus_ds('4'); P_pignistic_ds('4'); P_votes(4)];
    ds10000 = [M_ds_combi('5'); bel_ds('5'); plaus_ds('5'); P_pignistic_ds('5'); P_votes(5)];
    ds20000 = [M_ds_combi('6'); bel_ds('6'); plaus_ds('6'); P_pignistic_ds('6'); P_votes(6)];
    dsNegative = [M_ds_combi('7'); bel_ds('7'); plaus_ds('7'); P_pignistic_ds('7'); -666];
    
%     y500 = [M_y_combi('1'); bel_y('1'); plaus_y('1'); P_pignistic_y('1'); P_votes(1)];
%     y1000 = [M_y_combi('2'); bel_y('2'); plaus_y('2'); P_pignistic_y('2'); P_votes(2)];
%     y2000 = [M_y_combi('3'); bel_y('3'); plaus_y('3'); P_pignistic_y('3'); P_votes(3)];
%     y5000 = [M_y_combi('4'); bel_y('4'); plaus_y('4'); P_pignistic_y('4'); P_votes(4)];
%     y10000 = [M_y_combi('5'); bel_y('5'); plaus_y('5'); P_pignistic_y('5'); P_votes(5)];
%     y20000 = [M_y_combi('6'); bel_y('6'); plaus_y('6'); P_pignistic_y('6'); P_votes(6)];
%     yNegative = [M_y_combi('7'); bel_y('7'); plaus_y('7'); P_pignistic_y('7'); -666];
    
    file_ds = strcat('DS_experiment_2_', num2str(i), '.xls');
%     file_y = strcat('Y_experiment_2_', num2str(i), '.xls');
    T_ds = table(ds500, ds1000, ds2000, ds5000, ds10000, ds20000, dsNegative, 'RowNames', {'Combined mass'; 'Belief'; 'Plausibility'; 'Probability with pignistic transformation'; 'Probability from bionic votes'});
%     T_y = table(y500, y1000, y2000, y5000, y10000, y20000, yNegative, 'RowNames', {'Combined mass'; 'Belief'; 'Plausibility'; 'Probability with pignistic transformation'; 'Probability from bionic votes'});
    
    writetable(T_ds,file_ds,'WriteRowNames',true);
%     writetable(T_y,file_y,'WriteRowNames',true);
end;