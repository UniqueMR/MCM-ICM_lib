clc,clear;
yt = load('fadian.txt');%原始发电总量数据以列向量的方式存储在变量yt中
n = length(yt);
alpha = 0.3;%设置α值
st1(1) = yt(1);st2(1) = yt(1);%设置st(1)和st(2)的初始值
for i = 2 : n
    st1(i) = alpha * yt(i) + (1 - alpha) * st1(i - 1);
    st2(i) = alpha * st1(i) + (1 - alpha) * st2(i - 1);
end
%求二阶指数平滑值
xlswrite('fadian_pred.xls',[st1',st2'])%将二阶指数平滑数据写入xls文件前两列
at = 2 * st1 - st2;
bt = alpha/(1 - alpha) * (st1 - st2);
%求预测模型参数a和b
yhat = at + bt;
%最后一个分量为1986年的预测值
xlswrite('fadian_pred.xls',yhat','Sheet1','C2');%把预测值写入第三列
str = ['C',int2str(n + 2)];%准备写1987年的预测值位置的字符串
xlswrite('fadian_pred.xls',at(n) + 2 * bt(n),'Sheet1',str);%写入1987年的预测值
