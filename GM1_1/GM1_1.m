clc,clear;
a = load('gm.txt');
[n, m] = size(a);
x0 = a(:,m);%提取原始数据
lamda = x0(1 : n-1) ./ x0(2 : n);%计算级比
range = minmax(lamda');
%计算级比的范围
%minmax函数求每一行的最小值和最大值，输出时最小值在左，最大值在右
x1 = cumsum(x0);
%累加运算
%x1i表示从x01到x0i的累加
B = [-0.5 * (x1(1 : n - 1) + x1(2 : n)),ones(n - 1,1)];
Y = x0(2 : n);
%构造数据矩阵B和Y
u = B \ Y;
%求拟合参数
%u(1) = a,u(2) = b
syms x(t)%t为符号变量，x(t)为符号函数
x = dsolve(diff(x) + u(1) * x == u(2), x(0) == x0(1));%求微分方程的符号解
xt = vpa(x,6);
%以小数形式显示微分方程的解
%设置精度为6位有效数字
predict1 = subs(x,t,[0 : n - 1]);
%求已知数据的预测值
%将数值代入微分方程
%new = [0 : n - 1],old = t利用new替换old
predict1 = double(predict1);
%将符号数转化为数值类型，否则无法进行差分运算
predict = [x0(1), diff(predict1)];
%差分运算，还原数据
%第一年的预测值和真实值相等
%后面的预测值等于yuce1前后相邻元素的差
epsilon = x0' - predict;%计算残差
delta = abs(epsilon ./ x0');%计算相对误差
rho = 1 - (1 - 0.5*u(1))/(1 + 0.5 * u(1)) * lamda';%计算级比偏差值
display = [(1 : n)',a(:,1),x0,predict',epsilon',delta',[0 rho]'];
xlswrite('result.xls',display);
