function check_K(K)
% 函数的作用：检查刚度矩阵是否符合基本要求
if K ~=K'
    disp("刚度矩阵不是对称阵");
    return
else
    disp("刚度矩阵符合基本要求");
end

end