clc,clear;
yt = load('fadian.txt');
n = length(yt);alpha = 0.4;
dyt = diff(yt);%求yt的一阶向前差分
dyt = [0 ; dyt];%加0补位
dyhat(2) = dyt(2);%指数平滑初始值
for i = 2 : n
    dyhat(i + 1) = alpha * dyt(i) + (1 - alpha) * dyhat(i);
end
%求差分指数平滑值
for i = 1 : n
    yhat(i + 1) = dyhat(i + 1) + yt(i);
end
%求指数平滑值
xlswrite('fadian_pred2.xls',[dyhat', yhat'])