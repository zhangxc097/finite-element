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
stress = mapminmax(mean(Stress));
% Strain
strain = mapminmax(mean(Strain));
% RGB
color_stress = [abs(stress)', abs(1-abs(stress))', abs(1-abs(stress))'];
color_strain = [abs(strain)', abs(1-abs(strain))', abs(1-abs(strain))'];

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
title('应力云图')
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
title('应变云图')
hold off

end