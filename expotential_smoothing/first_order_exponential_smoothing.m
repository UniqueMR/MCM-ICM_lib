clc,clear;
yt = load('dianqi.txt');%实际销售额数据以列向量的方式存储在yt中
n = length(yt); 
alpha = [0.2 0.5 0.8];%α的备选值
m = length(alpha);
yhat(1,[1:m]) = (yt(1) + yt(2))/2;%设置三种α下的初始值
for i = 2 : n
    yhat(i,:) = alpha * yt(i - 1) + (1 - alpha) .* yhat(i - 1,:);
end
%计算三种α取值下的指数平滑值
err = sqrt(mean((repmat(yt,1,m) - yhat) .^ 2));
%计算三种α取值下预测值的方差
xlswrite('dianqi_pred.xls',yhat);%将预测值写入到xls文件中
yhat1988 = alpha * yt(n) + (1 - alpha) .* yhat(n,:);%预测三种α取值下1988年的销量