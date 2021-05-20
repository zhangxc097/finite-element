function Displacement = call_Displacement(F_load, K, DisplacementConstraints)
%函数作用：通过删行删列法，求解方程

Displacement = zeros(size(K,2), 1);
% 找到位移约束为 0 的位置
DisplacementConstraints(:,1) = []; % 删除第一列起点数据
[~, DiagonalLocation] = find(DisplacementConstraints == 0);
% 将 ✳F中含有支反力置0
F_load (DiagonalLocation, :) = 0;
F_noparameter = F_load;
% 对K矩阵中乘大数A
A = 1e11 *max(max(K));
for i = 1:1:size(DiagonalLocation, 2)
    K(DiagonalLocation(i),DiagonalLocation(i)) = K(DiagonalLocation(i),DiagonalLocation(i)) * A;
end

% 删除位移为 0 的行 和 列
for i = 1:1:size(DiagonalLocation, 2)
    K(DiagonalLocation(1,i),:) = 0; K(:, DiagonalLocation(1,i)) = 0;
end
% 删除全0行
% K(all(K==0,2),:)=[];
% 删除全0列
% K(:, all(K==0,1),:)=[];
% 位移为0对应的位置删去
% F_noparameter(DiagonalLocation,:) = [];
% 得到位移非0位置的位移
% UnzeroDisp = inv(K) * F_noparameter;
% 非0位移组装到整体的位移上
% for i = 1:1:size(DiagonalLocation, 2)
%     
%     Displacement = DiagonalLocation(:, i)
%     
% end
Displacement = pinv(K) * F_noparameter;
end