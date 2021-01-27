clc,clear;
load ssgs.txt;%将原始数据存储在ssgs.txt中
n = size(ssgs,1);%求一共有多少对象需要评价
x = ssgs(:,1:4);y = ssgs(:,5); %提取原始变量x和y的值
x = zscore(x);%数据标准化
r = corrcoef(x);%求相关系数矩阵（rij表示xi和xj的相关系数）
[vec1,val,con1] = pcacov(r);
%求相关系数矩阵的特征向量vec1,特征值val，以及各个主成分的贡献率con1
%该函数可以按照贡献率的大小自动进行排序
f1 = repmat(sign(sum(vec1)),size(vec1,1),1);
%构造和vec1同维数的元素为±1的矩阵，用以调整特征向量
vec2 = vec1 .* f1;
%利用f1对特征向量组矩阵进行调整(正负号转换)
f2 = repmat(sqrt(val)',size(vec2,1),1);
%对特征值逐个求平方根，并根据结果生成辅助矩阵f2
a = vec2 .* f2;
%利用辅助矩阵f2生成初等载荷矩阵a
num = input('请选择主因子的个数：');
am = a(:,1:num);%提出num个主因子的载荷矩阵
[bm, t] = rotatefactors(am, 'method','varimax');
%am旋转变换，bm为旋转后的载荷阵
bt = [bm,a(:,num + 1:end)];
%旋转后全部因子的载荷矩阵，前num个旋转，后面的不旋转
con2 = sum(bt .^ 2);%计算因子贡献率
check = [con1, con2' / sum(con2) * 100];%仅作理解使用，con1为没有旋转前的贡献率
rate = con2(1:num) / sum(con2);%计算因子贡献率
coef = inv(r) * bm;%计算得分函数的系数
score = x * coef;%计算各个因子的得分
weight = rate / sum(rate);%计算得分的权重
Tscore = score * weight'; %对因子的得分进行加权求和，即求各个企业的综合得分
[STscore,ind] = sort(Tscore,'descend'); %对企业进行排序
display = [score(ind,:)';STscore';ind'];%显示排序结果
%前两行：调整顺序后的因子得分
%第三行：企业的综合得分
%最后一行：排名
[ccoef,p] = corrcoef([Tscore,y]); %计算企业的综合得分和资产负债的相关系数
[d,dt,e,et,stats] = regress(Tscore,[ones(n,1),y]);%计算企业综合得分与资产负债的方程（利用一元线性回归）
%d：回归系数，是个向量（“the vector B of regression coefficients in the  linear model Y = X*B”）。
%dt：回归系数的区间估计（“a matrix BINT of 95% confidence intervals for B”）。
%e：残差（ “a vector R of residuals”）。
%et：置信区间（“a matrix RINT of intervals that can be used to diagnose outliers”）。
%stats：用于检验回归模型的统计量。有4个数值：判定系数R^2，F统计量观测值，检验的p的值，误差方差的估计。
d,stats;%显示回归系数，和相关统计量的值