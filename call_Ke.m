function [ke,Be,D] = call_Ke(Nodes, Ele, E, miu, t)
%函数作用：计算某一单元的单元刚度矩阵
I = Ele(:, 2); J = Ele(:, 3); M = Ele(:, 4);
% I
I_index= Nodes(I,:);
xi = I_index(:,2);yi = I_index(:,3);

% J
J_index= Nodes(J,:);
xj = J_index(:,2);yj = J_index(:,3);

% M
M_index= Nodes(M,:);
xm = M_index(:,2);ym = M_index(:,3);

bi = yj - ym; ci = xm - xj;
bj = ym - yi; cj = xi - xm;
bm = yi - yj; cm = xj - xi;

Ae = det([1,xi,yi; 1,xj,yj; 1,xm,ym]) * 0.5;

% 几何矩阵
Be = [bi, 0, bj, 0, bm, 0;
    0, ci, 0, cj, 0, cm;
    ci, bi, cj, bj, cm, bm] * 0.5 / Ae;

% 本构方程
A1 = E/(1-miu*miu);
A2 = miu;
A3 = (1 - miu) / 2;

D =  A1  * [1, A2, 0;
    A2, 1, 0;
    0, 0, A3];
ke = t.* Ae * Be' * D * Be;
% K1 = zeros(2 * size(Nodes,1), 2 * size(Nodes,1));
% K2 = zeros(2 * size(Nodes,1), 2 * size(Nodes,1));

% tic;
% K1([2 * I - 1, 2 * I],[2 * I - 1, 2 * I]) = ke(1:2, 1:2);
% K1([2 * I - 1, 2 * I],[2 * J - 1, 2 * J]) = ke(1:2, 3:4);
% K1([2 * I - 1, 2 * I],[2 * M - 1, 2 * M]) = ke(1:2, 5:6);
% 
% K1([2 * J - 1, 2 * J],[2 * I - 1, 2 * I]) = ke(3:4, 1:2);
% K1([2 * J - 1, 2 * J],[2 * J - 1, 2 * J]) = ke(3:4, 3:4);
% K1([2 * J - 1, 2 * J],[2 * M - 1, 2 * M]) = ke(3:4, 5:6);
% 
% K1([2 * M - 1, 2 * M],[2 * I - 1, 2 * I]) = ke(5:6, 1:2);
% K1([2 * M - 1, 2 * M],[2 * J - 1, 2 * J]) = ke(5:6, 3:4);
% K1([2 * M - 1, 2 * M],[2 * M - 1, 2 * M]) = ke(5:6, 5:6);
% time1 = toc;
% index_r = [I, J, M];
% index_c = [I, J, M];
% tic
% for i = 1:1:size(index_r,2)
%     row = index_r(i);
%     for j = 1:1:size(index_c,2)
%         clo = index_c(j);
%        K2([2*row-1,2*row],[2*clo-1,2*clo]) = ke(2*i-1:2*i, 2*j-1:2*j);
%     end
% end
% time2 = toc;
% a = isequal(K1, K2);% 检验二者是否相等
%time1 = 0.0107; time2 = 0.0067选择循环


end