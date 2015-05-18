% clear all
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %***** Test for different properties of banknote **********%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %How many zeros are in the picture? (0, 1, 2, 3, 4, tobb)
% %key_zeros = {'0','1','2','3','4','5','12','13','14','15','23','24','25','34','35','45','123','124','125','134','135','145','234','235','245','345','1234','1235','1245','1345','2345','12345'};
% %OR: (2,3,4) -> because that's the relevant information for us
% key_zeros = {'0','1','2','3','12','13','23','123'};
% 
% %What number is on the picture? (1, 2, 5)
% key_numbers = {'0','1','2','3','12','13','23','123'};
% 
% 
% %%%%%%%%%%%%*** Claster test ***%%%%%%%%%%
% Claster_zeros = zeros(10,3);
% Claster_zeros(1,:) = [2,1,1];
% Claster_zeros(2,:) = [6,0,0];
% Claster_zeros(3,:) = [6,1,1];
% Claster_zeros(4,:) = [5,2,2];
% Claster_zeros(5,:) = [5,3,0];
% Claster_zeros(6,:) = [1,4,1];
% Claster_zeros(7,:) = [0,5,0];
% Claster_zeros(8,:) = [0,5,0];
% Claster_zeros(9,:) = [0,5,1];
% Claster_zeros(10,:) = [5,0,0];
% 
% Claster_numbers = zeros(10,3);
% Claster_numbers(1,:) = [1,2,4];
% Claster_numbers(2,:) = [0,0,5];
% Claster_numbers(3,:) = [0,0,5];
% Claster_numbers(4,:) = [1,2,5];
% Claster_numbers(5,:) = [0,0,0];
% Claster_numbers(6,:) = [1,4,3];
% Claster_numbers(7,:) = [0,5,1];
% Claster_numbers(8,:) = [0,5,0];
% Claster_numbers(9,:) = [5,0,0];
% Claster_numbers(10,:) = [5,1,1];
% 
% confidence = 0.95;
% Keys = {'0','1','2','3','4','5','6','12','13','14','15','16','23','24','25','26','34','35','36','45','46','56','123','124','125','126','134','135','136','145','146','156','234','235','236','245','246','256','345','346','356','456','1234','1235','1236','1245','1246','1256','1345','1346','1356','1456','2345','2346','2356','2456','3456','12345','12346','12356','12456','13456','23456','123456'};
% M_zeros = zeros(10, 64);
% M_numbers = zeros(10, 64);
% for i = 1:10
%     M_zeros(i,:) = ClasterZeros2Mass(Claster_zeros(i,:), confidence);
%     M_numbers(i,:) = ClasterNumbers2Mass(Claster_numbers(i,:), confidence);
%     q = GPA(containers.Map(Keys,M_zeros(i,:)), containers.Map(Keys,M_numbers(i,:)));
%     
%     result = m_DS(q);
%     
%     %Nem jon ki 1-re a summa..Kerekitesi hiba vagy mas??
%     result('123456') = result('123456') + 1 - sum(cell2mat(values(result)));
%     
%     fprintf('\n\nIteration: ')
%     fprintf('%u',i)
%     fprintf('\nClaster zeros:')
%     fprintf('% u',Claster_zeros(i,:))
%     fprintf('\nClaster numbers:')
%     fprintf('% u',Claster_numbers(i,:))
%     fprintf('\n')
%     bel = belief(result);
%     fprintf('Belief and Plausibility\n')
%     fprintf(' 500      1000     2000     5000     10000    20000\n')
%     fprintf('% f', bel('1'), bel('2'), bel('3'), bel('4'), bel('5'), bel('6'))
%     
%     plaus = plausibility(result);
%     fprintf('\n')
%     fprintf('% f', plaus('1'), plaus('2'), plaus('3'), plaus('4'), plaus('5'), plaus('6'))
% end;





%%%%%%%%%%%%%*** Numrecognizer test ***%%%%%%%%%%
% Corr = zeros(10, 4);
% HalfNumCount = zeros(10, 1);
% P_Complete = zeros(10, 1);
% Messages = cell(10,1);
% 
% %biztos, hogy 1000-es minden szempontból
% Corr(1,:) = [1, 0, 0, 0];
% HalfNumCount(1,:) = 8;
% P_Complete(1,:) = 1;
% Messages{1} = 'biztos, hogy 1000-es minden szempontból';
% 
% %biztos, hogy 1-es és nem biztos, hogy egésznek veszi(8-9)
% Corr(2,:) = [1, 0, 0, 0];
% HalfNumCount(2,:) = 8;
% P_Complete(2,:) = 0.3;
% Messages{2} = 'biztos, hogy 1-es és nem biztos, hogy egésznek veszi';
% 
% %nem tudok semmit az elsõ számról, és a számosság sem segít
% Corr(3,:) = [0, 0, 0, 0];
% HalfNumCount(3,:) = 2;
% P_Complete(3,:) = 0.5;
% Messages{3} = 'nem tudok semmit az elsõ számról, és a számosság sem segít';
% 
% %nem tudok semmit az elsõ számról, számosság bizonytalan(8-9)
% Corr(4,:) = [0, 0, 0, 0];
% HalfNumCount(4,:) = 8;
% P_Complete(4,:) = 0.5;
% Messages{4} = 'nem tudok semmit az elsõ számról, számosság bizonytalan(8-9)';
% 
% %nem tudok semmit a számosságról, de elsõ szám biztos, hogy 2-es
% Corr(5,:) = [0, 1, 0, 0];
% HalfNumCount(5,:) = 3;
% P_Complete(5,:) = 0;
% Messages{5} = 'nem tudok semmit a számosságról, de elsõ szám biztos, hogy 2-es';
% 
% %nem tudok semmit a számosságról, és elsõ sem biztos
% Corr(6,:) = [0, 0.4, 0.3, 0];
% HalfNumCount(6,:) = 3;
% P_Complete(6,:) = 0;
% Messages{6} = 'nem tudok semmit a számosságról, és elsõ sem biztos';
% 
% %Valszeg 0-val kezdodik és páros a számosság, valszeg nem egész szának
% %veszi
% Corr(7,:) = [0.2, 0.2, 0.01, 0.7];
% HalfNumCount(7,:) = 8;
% P_Complete(7,:) = 0.2;
% Messages{7} = 'Valszeg 0-val kezdodik és számosság bizonytalan(8-9)';
% 
% %Valszeg 0-val kezdodik és egyértelmû a számosság
% Corr(8,:) = [0.2, 0.2, 0.01, 0.7];
% HalfNumCount(8,:) = 5;
% P_Complete(8,:) = 0.9;
% Messages{8} = 'Valszeg 0-val kezdodik és egyértelmû a számosság';
% 
% %Keveset tudok a számról(minden korreláció kicsi), de tuti 7 darab félszámjegy
% Corr(9,:) = [0.2, 0.2, 0.01, 0.08];
% HalfNumCount(9,:) = 7;
% P_Complete(9,:) = 0;
% Messages{9} = 'Keveset tudok a számról, de tuti 7 darab félszámjegy';
% 
% %Keveset tudok a számról, és számosság is határeset
% Corr(10,:) = [0.2, 0.2, 0.01, 0.08];
% HalfNumCount(10,:) = 8;
% P_Complete(10,:) = 0.5;
% Messages{10} = 'Keveset tudok a számról, és számosság is határeset';
% 
% Keys = {'0','1','2','3','4','5','6','12','13','14','15','16','23','24','25','26','34','35','36','45','46','56','123','124','125','126','134','135','136','145','146','156','234','235','236','245','246','256','345','346','356','456','1234','1235','1236','1245','1246','1256','1345','1346','1356','1456','2345','2346','2356','2456','3456','12345','12346','12356','12456','13456','23456','123456'};
% M_count = zeros(10, 64);
% M_numbers = zeros(10, 64);
% for i = 1:10
%     M_count(i,:) = HalfNumCount2Mass(HalfNumCount(i), P_Complete(i), Corr(i,4));
%     M_numbers(i,:) = FirstNumber2Mass(Corr(i,1:3));
%     q = GPA(containers.Map(Keys,M_count(i,:)), containers.Map(Keys,M_numbers(i,:)));
%     
%     result = m_DS(q);
%     
%     
%     fprintf('\nCase: %s', Messages{i});
%     fprintf('\n')
%     bel = belief(result);
%     fprintf('Belief and Plausibility\n')
%     fprintf(' 500      1000     2000     5000     10000    20000\n')
%     fprintf('% f', bel('1'), bel('2'), bel('3'), bel('4'), bel('5'), bel('6'))
%     
%     plaus = plausibility(result);
%     fprintf('\n')
%     fprintf('% f', plaus('1'), plaus('2'), plaus('3'), plaus('4'), plaus('5'), plaus('6'))
%     fprintf('\n')
% end;


clear all;
% load('keys.mat')
% t = [0.5, 0.5, 0.5];
% 
% M_color = ColorOutput2Mass([0.4, 0.1],[1, 4],Keys);
% M_pattern = PatternOutput2Mass(0.3, 1, Keys);
% M_number = NumRecOutput2Mass([0.01, 0.01, 0.01, 0.2], 7, 0.5, t, Keys);
% 
% tmp1 = GPA(M_color, M_pattern);
% tmp2 = m_DS(tmp1);
% tmp3 = GPA(tmp2, M_number);
% M_combi = m_DS(tmp3);
% 
% if(sum(cell2mat(values(M_combi))) ~= 1.0)
%     warning('The sum of the masses is not 1, it is: %d', sum(cell2mat(values(M_combi))))
%     m_values = cell2mat(values(M_combi));
%     m_keys = keys(M_combi);
%     m_values = m_values / sum(m_values);
%     M_combi = containers.Map(m_keys,m_values);
% end;
% 
% fprintf('Mass\n')
% fprintf(' 500      1000     2000     5000     10000    20000    Negative  Banknote   ALL\n')
% fprintf('% f', M_combi('1'), M_combi('2'), M_combi('3'), M_combi('4'), M_combi('5'), M_combi('6'), M_combi('7'), M_combi('123456'), M_combi('1234567'))
% 
% bel = belief(M_combi);
% fprintf('\n')
% fprintf('Belief, Plausibility\n')
% fprintf(' 500      1000     2000     5000     10000    20000    Negative\n')
% fprintf('% f', bel('1'), bel('2'), bel('3'), bel('4'), bel('5'), bel('6'), bel('7'))
% fprintf('\n')
%     
% plaus = plausibility(M_combi);
% fprintf('% f', plaus('1'), plaus('2'), plaus('3'), plaus('4'), plaus('5'), plaus('6'), plaus('7'))
% fprintf('\n')
% 
% P_plaus = P_pl(plaus);
% P_pignistic = P_m(M_combi);
% fprintf('\n')
% fprintf('Probabilities(plaus and pignistic)\n')
% fprintf('% f', P_plaus('1'), P_plaus('2'), P_plaus('3'), P_plaus('4'), P_plaus('5'), P_plaus('6'), P_plaus('7'))
% fprintf('\n')
% fprintf('% f', P_pignistic('1'), P_pignistic('2'), P_pignistic('3'), P_pignistic('4'), P_pignistic('5'), P_pignistic('6'), P_pignistic('7'))
% fprintf('\n')

Keys = {'0', '1', '2', '3', '12', '13', '23', '123'};
M_11 = [0, 0.1, 0.1, 0.3, 0.5, 0, 0, 0];
P_11 = P_pl_m(Keys, M_11);
M_12 = [0, 0.4, 0.1, 0, 0.2, 0, 0.3, 0];
P_12 = P_pl_m(Keys, M_12);

M_21 = [0, 0.9, 0, 0, 0, 0, 0, 0.1];
P_21 = P_pl_m(Keys, M_21);
M_22 = [0, 0, 1, 0, 0, 0, 0, 0];
P_22 = P_pl_m(Keys, M_22);

% M_combi = containers.Map(Keys,M_12);%m_U_ext(GPA(containers.Map(Keys,M_11), containers.Map(Keys,M_12)));
% values(P_11)
% values(P_12)

M_combi = m_U_ext(GPA(containers.Map(Keys,M_21), containers.Map(Keys,M_22)));
values(P_21)
values(P_22)

fprintf('Mass\n')
fprintf(' 1        2       3       ALL\n')
fprintf('% f', M_combi('1'), M_combi('2'), M_combi('3'), M_combi('123'))

bel = belief(M_combi);
fprintf('\n')
fprintf('Belief, Plausibility\n')
fprintf('% f', bel('1'), bel('2'), bel('3'))
fprintf('\n')
    
plaus = plausibility(M_combi);
fprintf('% f', plaus('1'), plaus('2'), plaus('3'))
fprintf('\n')

P_plaus = P_pl(plaus);
P_pignistic = P_m(M_combi);
fprintf('\n')
fprintf('Probabilities(plaus and pignistic)\n')
fprintf('% f', P_plaus('1'), P_plaus('2'), P_plaus('3'))
fprintf('\n')
fprintf('% f', P_pignistic('1'), P_pignistic('2'), P_pignistic('3'))
fprintf('\n')