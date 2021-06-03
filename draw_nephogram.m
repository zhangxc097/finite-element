function draw_nephogram(Nodes, Eles, Stress,Strain)
% 函数作用：做出应力云图和应变云图

I = Eles(:, 2);
J = Eles(:, 3);
M = Eles(:, 4);
% I
I_index = Nodes(I,:);
Ix = I_index(:,2);
Iy = I_index(:,3);
% J
J_index = Nodes(J,:);
Jx = J_index(:,2);
Jy = J_index(:,3);
% M
M_index = Nodes(M,:);
Mx = M_index(:,2);
My = M_index(:,3);
% Stess
stress = mean(Stress);
% Strain
strain = mean(Strain);
% 每个节点的应力平均
Eles(:,1) = [];%删除第一列
Stress_nodes = zeros(1,max(max(Eles)));
Strain_nodes = zeros(1,max(max(Eles)));
for i = 1:1:size(Nodes,1)
    [Eleno,~]= find(Eles ==i);
    stress_node = sum(stress(:,Eleno))/length(Eleno); % 有相同结点做应力、应变平均
    strain_node = sum(strain(:,Eleno))/length(Eleno);
    Stress_nodes(1,i) = stress_node;
    Strain_nodes(1,i) = strain_node;
end   
% 将每个结点上的应力应变组装到每个单元内，并作平均
Stress_Eles = zeros(1,size(Eles,1));
Strain_Eles = zeros(1,size(Eles,1));
for i = 1:1:size(Eles,1)
    stress_node = sum(Stress_nodes(:,Eles(i,:))) / 3;
    strain_node = sum(Strain_nodes(:,Eles(i,:))) / 3;
    Stress_Eles(1,i) = stress_node;
    Strain_Eles(1,i) = strain_node;
end
Stress_Eles = mapminmax(Stress_Eles);
Strain_Eles = mapminmax(Strain_Eles);
% RGB
color_stress = [abs(Stress_Eles)', abs(1-abs(Stress_Eles))', abs(1-abs(Stress_Eles))'];
color_strain = [abs(Strain_Eles)', abs(1-abs(Strain_Eles))', abs(1-abs(Strain_Eles))'];

% stress作图
figure(2)
hold off
for i = 1:1:size(Eles,1)
    hold on
    x_vector = [Ix(i,:), Jx(i,:), Mx(i,:), Ix(i,:)];
    y_vector = [Iy(i,:), Jy(i,:), My(i,:), Iy(i,:)];
    patch(x_vector, y_vector, color_stress(i,:))
end
colorbar;
title('应力云图','FontSize',20)
hold off

% strain作图
figure(3)
for i = 1:1:size(Eles,1)
    hold on
    x_vector = [Ix(i,:), Jx(i,:), Mx(i,:), Ix(i,:)];
    y_vector = [Iy(i,:), Jy(i,:), My(i,:), Iy(i,:)];
    patch(x_vector, y_vector, color_strain(i,:))
end
colorbar;
title('应变云图','FontSize',20)
hold off

end