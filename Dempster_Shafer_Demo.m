clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%************ Conflict and ignorance test *************
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

key = {'0','1','2','3','12','13','23','123'};
single_key = {'1','2','3'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Situation 1: Little conflict and little ignorance
m_ci_1 = [0,0.85,0.05,0,0,0,0,0.1];
P_ci_1 = P_pl_m(key,m_ci_1);
m_ci_2 = [0,0.85,0.1,0,0,0,0,0.05];
P_ci_2 = P_pl_m(key,m_ci_2);
values(P_ci_1);
values(P_ci_2);


q_ci = GPA(containers.Map(key,m_ci_1), containers.Map(key,m_ci_2));

X = int2str(max(cellfun(@str2double,keys(q_ci))));
k_ext = (1-q_ci(X))/(1-q_ci(X)-q_ci('0'));
k_DS = 1/(1-q_ci('0'));
k_interv = 0:k_ext/100:k_ext;
m_All_k_ci = eye([length(k_interv), length(key)+1]);
index = 1;
for k = k_interv
    m_temp = m_U_k(q_ci,k);
    m_All_k_ci(index,:) = [k cell2mat(values(m_temp))];
    index = index + 1;
end;

%Plotting values of m(1), m(2) and m(123) in function of k
m_plot_1 = m_All_k_ci(:,3);
m_plot_2 = m_All_k_ci(:,7);
m_plot_123 = m_All_k_ci(:,5);

figure (1)
plot(k_interv, m_plot_1, '-*r')
hold on;
plot(k_interv, m_plot_2, '-*k')
hold on;
plot(k_interv, m_plot_123, '-*c')
hold on;
errorbar(k_DS,0.5,0.5)
legend('m(1)', 'm(2)', 'm(123)', 'Location','Best')
xlabel('k')
ylabel('m')
title('Little conflict and little ignorance')

single_key
P_ci = (cellfun(@double,values(P_ci_1))+cellfun(@double,values(P_ci_2)))/2
keys(q_ci)
m_DS_ci = values(m_DS(q_ci));
bel_DS_ci = values(belief(containers.Map(keys(q_ci),m_DS_ci)))
pl_DS_ci = values(plausibility(containers.Map(keys(q_ci),m_DS_ci)))
m_Y_ci = values(m_Y(q_ci));
m_U_ext_ci = values(m_U_ext(q_ci));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Situation 2: Little conflict and big ignorance
mcI_1 = [0,0.2,0,0,0,0,0,0.8];
P_cI_1 = P_pl_m(key,mcI_1);
mcI_2 = [0,0,0.15,0,0,0,0,0.85];
P_cI_2 = P_pl_m(key,mcI_2);
values(P_cI_1);
values(P_cI_2);

q_cI = GPA(containers.Map(key,mcI_1), containers.Map(key,mcI_2));

X = int2str(max(cellfun(@str2double,keys(q_cI))));
k_ext = (1-q_cI(X))/(1-q_cI(X)-q_cI('0'));
k_DS = 1/(1-q_cI('0'));
k_interv = 0:k_ext/100:k_ext;
m_All_k_cI = eye([length(k_interv), length(key)+1]);
index = 1;
for k = k_interv
    m_temp = m_U_k(q_cI,k);
    m_All_k_cI(index,:) = [k cell2mat(values(m_temp))];
    index = index + 1;
end;

%Plotting values of m(1), m(2) and m(123) in function of k
m_plot_1 = m_All_k_cI(:,3);
m_plot_2 = m_All_k_cI(:,7);
m_plot_123 = m_All_k_cI(:,5);

figure (2)
plot(k_interv, m_plot_1, '-*r')
hold on;
plot(k_interv, m_plot_2, '-*k')
hold on;
plot(k_interv, m_plot_123, '-*c')
hold on;
errorbar(k_DS,0.5,0.5)
legend('m(1)', 'm(2)', 'm(123)', 'Location','Best')
xlabel('k')
ylabel('m')
title('Little conflict and big ignorance')

single_key
P_cI = (cellfun(@double,values(P_cI_1))+cellfun(@double,values(P_cI_2)))/2
keys(q_cI)
m_DS_cI = values(m_DS(q_cI));
bel_DS_cI = values(belief(containers.Map(keys(q_cI),m_DS_cI)))
pl_DS_cI = values(plausibility(containers.Map(keys(q_cI),m_DS_cI)))
m_Y_cI = values(m_Y(q_cI));
m_U_ext_cI = values(m_U_ext(q_cI));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Situation 3: Big conflict and little ignorance
mCi_1 = [0,0.85,0.05,0,0,0,0,0.1];
P_Ci_1 = P_pl_m(key,mCi_1);
mCi_2 = [0,0.1,0,0.8,0,0,0,0.1];
P_Ci_2 = P_pl_m(key,mCi_2);
values(P_Ci_1);
values(P_Ci_2);

q_Ci = GPA(containers.Map(key,mCi_1), containers.Map(key,mCi_2));

X = int2str(max(cellfun(@str2double,keys(q_Ci))));
k_ext = (1-q_Ci(X))/(1-q_Ci(X)-q_Ci('0'));
k_DS = 1/(1-q_Ci('0'));
k_interv = 0:k_ext/100:k_ext;
m_All_k_Ci = eye([length(k_interv), length(key)+1]);
index = 1;
for k = k_interv
    m_temp = m_U_k(q_Ci,k);
    m_All_k_Ci(index,:) = [k cell2mat(values(m_temp))];
    index = index + 1;
end;

%Plotting values of m(1), m(2), m(3) and m(123) in function of k
m_plot_1 = m_All_k_Ci(:,3);
m_plot_2 = m_All_k_Ci(:,7);
m_plot_3 = m_All_k_Ci(:,9);
m_plot_123 = m_All_k_Ci(:,5);

figure (3)
plot(k_interv, m_plot_1, '-*r')
hold on;
plot(k_interv, m_plot_2, '-*k')
hold on;
plot(k_interv, m_plot_3, '-*b')
hold on;
plot(k_interv, m_plot_123, '-*c')
hold on;
errorbar(k_DS,0.5,0.5)
legend('m(1)', 'm(2)', 'm(3)', 'm(123)', 'Location','Best')
xlabel('k')
ylabel('m')
title('Big conflict and little ignorance')

single_key
P_Ci = (cellfun(@double,values(P_Ci_1))+cellfun(@double,values(P_Ci_2)))/2
keys(q_Ci)
m_DS_Ci = values(m_DS(q_Ci));
bel_DS_Ci = values(belief(containers.Map(keys(q_Ci),m_DS_Ci)))
pl_DS_Ci = values(plausibility(containers.Map(keys(q_Ci),m_DS_Ci)))
m_Y_Ci = values(m_Y(q_Ci));
m_U_ext_Ci = values(m_U_ext(q_Ci));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Situation 4:Relative big conflict and relative big ignorance
mrCrI_1 = [0,0.55,0.05,0,0,0,0,0.4];
P_rCrI_1 = P_pl_m(key,mrCrI_1);
mrCrI_2 = [0,0,0,0.45,0,0,0,0.55];
P_rCrI_2 = P_pl_m(key,mrCrI_2);
values(P_rCrI_1);
values(P_rCrI_2);

q_rCrI = GPA(containers.Map(key,mrCrI_1), containers.Map(key,mrCrI_2));

X = int2str(max(cellfun(@str2double,keys(q_rCrI))));
k_ext = (1-q_rCrI(X))/(1-q_rCrI(X)-q_rCrI('0'));
k_DS = 1/(1-q_rCrI('0'));
k_interv = 0:k_ext/100:k_ext;
m_All_k_rCrI = eye([length(k_interv), length(key)+1]);
index = 1;
for k = k_interv
    m_temp = m_U_k(q_rCrI,k);
    m_All_k_rCrI(index,:) = [k cell2mat(values(m_temp))];
    index = index + 1;
end;

%Plotting values of m(1), m(2), m(3) and m(123) in function of k
m_plot_1 = m_All_k_rCrI(:,3);
m_plot_2 = m_All_k_rCrI(:,7);
m_plot_3 = m_All_k_rCrI(:,9);
m_plot_123 = m_All_k_rCrI(:,5);

figure (4)
plot(k_interv, m_plot_1, '-*r')
hold on;
plot(k_interv, m_plot_2, '-*k')
hold on;
plot(k_interv, m_plot_3, '-*b')
hold on;
plot(k_interv, m_plot_123, '-*c')
hold on;
errorbar(k_DS,0.5,0.5)
legend('m(1)', 'm(2)', 'm(3)', 'm(123)', 'Location','Best')
xlabel('k')
ylabel('m')
title('Relative big conflict and relative little ignorance')

single_key
P_rCrI = (cellfun(@double,values(P_rCrI_1))+cellfun(@double,values(P_rCrI_2)))/2
keys(q_rCrI)
m_DS_rCrI = values(m_DS(q_rCrI));
bel_DS_rCrI = values(belief(containers.Map(keys(q_rCrI),m_DS_rCrI)))
pl_DS_rCrI = values(plausibility(containers.Map(keys(q_rCrI),m_DS_rCrI)))
m_Y_rCrI = values(m_Y(q_rCrI));
m_U_ext_rCrI = values(m_U_ext(q_rCrI));



