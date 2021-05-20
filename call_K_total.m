function K = call_K_total(Nodes, Eles, E, miu, t)
% 函数作用：计算整体刚度矩阵

K = zeros(2 * size(Nodes,1), 2 * size(Nodes,1));
% 下面嵌套了三层循环：
%   第一层：循环出每个单元，并计算出该单元的单元刚度矩阵；
%   第二、三层：将单元刚度矩阵放到大矩阵K中。elno为element_no.的缩写
for elno = 1:1:size(Eles,1)
    Ele = Eles(elno,:);
    [ke, ~, ~] = call_Ke(Nodes, Ele, E, miu, t);
    I = Ele(:, 2); J = Ele(:, 3); M = Ele(:, 4);
    index_r = [I, J, M];
    index_c = [I, J, M];
    for i = 1:1:size(index_r,2)
        row = index_r(i);
        for j = 1:1:size(index_c,2)
            clo = index_c(j);
            K([2*row-1,2*row],[2*clo-1,2*clo])  = K([2*row-1,2*row],[2*clo-1,2*clo])+ ke(2*i-1:2*i, 2*j-1:2*j);
        end
    end
end

end