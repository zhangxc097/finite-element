%% -------------------基于简单三角形单元的有限元计算--------------------
%% --------------------------初始化-----------------------------------
clc; clear all; close all

%% --------------------------读取数据---------------------------------
addpath(genpath(pwd)) 
Nodes = xlsread("information.xlsx", 1);% 结点信息
Eles = xlsread("information.xlsx", 2); % 单元信息
Loads = xlsread("information.xlsx", 3); % 外载荷
DisplacementConstraints = xlsread("information.xlsx", 4); % 位移约束
draw_geometry(Nodes, Eles);
fprintf('Data imported SUCCESSFULLY ... \n');
fprintf('Program paused. Press enter to continue.\n');
pause;

%% ------------------------计算刚度矩阵--------------------------------
%E = input('请输入弹性模量：');miu = input('请输入泊松比：');t = input('请输入材料的厚度：');
E = 2e11;miu = 0;t = 1;
K = call_K_total(Nodes, Eles, E, miu, t);
check_K(K);
warning off MATLAB:xlswrite:AddSheet
xlswrite([pwd, '\重要参数.xlsx'],K, '总体刚度矩阵');
fprintf('Program paused. Press enter to continue.\n');
pause;

%% ---------------------------位移------------------------------------
F_load =call_F_load(Nodes, Eles, Loads);
Displacement = call_Displacement(F_load, K, DisplacementConstraints);

warning off MATLAB:xlswrite:AddSheet
xlswrite([pwd, '\重要参数.xlsx'],Displacement, '位移');
fprintf('Program paused. Press enter to continue.\n');
pause;

%% --------------------------支反力-----------------------------------
ReacForce = call_ReactionForce(K, Displacement, F_load);
warning off MATLAB:xlswrite:AddSheet
xlswrite([pwd, '\重要参数.xlsx'],Displacement, '支反力');
fprintf('Program paused. Press enter to continue.\n');
pause;

%% -------------------------应力&应变---------------------------------
[Stress,Strain] = call_Stress_Strain(Displacement, Nodes, Eles, E, miu, t);
warning off MATLAB:xlswrite:AddSheet
xlswrite([pwd, '\重要参数.xlsx'],Stress, '应力');
warning off MATLAB:xlswrite:AddSheet
xlswrite([pwd, '\重要参数.xlsx'],Strain, '应变');
fprintf('Program paused. Press enter to continue.\n');
pause;

%% -----------------------应力&应变云图-------------------------------
draw_nephogram(Nodes, Eles, Stress,Strain)
fprintf('Program paused. Press enter to continue.\n');
pause;





