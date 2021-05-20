function ReacForce = call_ReactionForce(K, Displacement, F_load)
% 函数作用：计算支反力

F_total = K * Displacement;
ReacForce = F_total - F_load;

end