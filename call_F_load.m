function F_load = call_F_load(Nodes, Eles, Loads)
% 函数作用：将各结点的力组装到一起即F_load,

Loads(:, 1)=[];
Eles(:, 1)=[];

% 外载荷放到一起
Fr = zeros(1, 2 * size(Nodes,1));
% 第一层循环取出单元
for i = 1:1:size(Loads,1)
    Load = Loads(i,:);
    Ele = Eles(i,:);
    % 第二层循环将取出单元的每个结点取出
    for Node_no = 1:1:size(Eles,2)
        node = Ele(1, Node_no);
        Fr(1,[2*node - 1,2*node]) = Fr(1,[2*node - 1,2*node]) + ...
                                    Load(1, 2*Node_no-1:2*Node_no);
    end        
end
F_load = Fr';
end
    