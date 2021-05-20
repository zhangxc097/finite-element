function [I, J, M] = draw_geometry(Nodes, Eles)
% 函数的作用：对三角形单元作图，并返回三角形单元的节点信息数组

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

figure(1)
for i = 1:1:size(Eles,1)
    x_vectoe = [Ix(i,:), Jx(i,:), Mx(i,:), Ix(i,:)];
    y_vectoe = [Iy(i,:), Jy(i,:), My(i,:), Iy(i,:)];
    line(x_vectoe, y_vectoe, 'Color', 'red', 'LineStyle','-', 'LineWidth',3);
end
hold on
scatter([Ix', Jx', Mx'], [Iy', Jy', My'], 100, 'MarkerEdgeColor',[0 .5 .5], ...
    'MarkerFaceColor',[0 .7 .7], ...
    'LineWidth',2)
[t, s] = title('单元划分示意图', ...
    ['结点数 ',num2str(size(Nodes,1)), '  单元数量 ',num2str(size(Eles,1))]);
t.FontSize = 16;s.FontSize = 12;
s.FontAngle = 'italic';

hold off


end