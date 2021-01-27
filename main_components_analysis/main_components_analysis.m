clc,clear;
load sn.txt;%加载原始数据文件
[m,n] = size(sn);%得到指标变量的数目m和评价对象的数目n
x0 = sn(:,[1 : n-1]);%得到x矩阵
y0 = sn(:,n);%得到y向量
r = corrcoef(x0);%计算相关系数矩阵x0
xd = zscore(x0);%对设计矩阵进行标准化处理
yd = zscore(y0);%对y0进行标准化处理
[vec1,lamda,rate] = pcacov(r);
%vec1为r的特征向量
%lamda为r的特征值
%rate为各个主成分的贡献率
f = repmat(sign(sum(vec1)),size(vec1,1),1);
%构造和vec1同维数的元素为±1的矩阵
vec2 = vec1 .* f;%修改特征向量的正负号，使得特征向量的所有分量和为正
contr = cumsum(rate);%计算累积贡献率，第i个分量表示前i个主成分的贡献率
df = xd * vec2; %计算所主有成分的得分
num = input('请选择主成分的个数：');
hg1 = df(:,1:num)\yd; %主成分变量z的回归系数，这里由于数据标准化，回归方程的常数项为0
hg2 = vec2(:,1:num) * hg1; %标准化后变化量x~的回归方程系数
hg3 = [mean(y0) - std(y0) * mean(x0) ./ std(x0) * hg2, std(y0) * hg2'./ std(x0)];
%计算原始变量x回归方程的系数
fprintf('y = % f',hg3(1));%开始显示主成分回归结果
for i = 2 : n
    if hg3(i) > 0
        fprintf(' + % f * x%d', hg3(i), i - 1);
    else
        fprintf(' % f * x%d', hg3(i), i - 1);
    end
end
fprintf('\n');
rmse = sqrt(sum((hg3(1) + x0 * hg3(2:end)' - y0) .^ 2) /(m - num));%计算回归分析的剩余标准差（拟合了num个参数）