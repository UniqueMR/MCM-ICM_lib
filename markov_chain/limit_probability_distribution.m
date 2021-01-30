clc,clear,format rat %有理分数的数据格式
p = [0.8 0.1 0.1;0.5 0.1 0.4;0.5 0.3 0.2]; %初始化转移矩阵
a = [p' - eye(3);ones(1,3)]; %构造方程组az = b的系数矩阵
b = [zeros(3,1);1];%求方程组的解
p_limit = a\b; 
%求方程组的解
%满足约束i.P * P_lim = P_lim，ii.Σpj = 1
format %恢复到短小数的格式