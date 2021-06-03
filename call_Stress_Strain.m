function [Stress,Strain] = call_Stress_Strain(Displacement, Nodes, Eles, E, miu, t)
% 函数作用：计算应力应变

Stress = zeros(3,size(Eles,1));
Strain = zeros(3,size(Eles,1));
for elno = 1:1:size(Eles,1)
    Ele = Eles(elno,:);
    [~, Be, D] = call_Ke(Nodes, Ele, E, miu, t);
    Ele(:, 1) = [];
    % 组装单元内的位移
    Ele_Displacement = zeros(2 * size(Ele,2), 1);
    for i = 1:1:size(Ele,2)
        Node = Ele(:, i);
        Ele_Displacement((2*i-1:2*i),:) = Displacement(2*Node-1:2*Node,:);
    end
    Strain(:,elno) = Be * Ele_Displacement;
    Stress(:,elno) = D * Be * Ele_Displacement;    
end
end