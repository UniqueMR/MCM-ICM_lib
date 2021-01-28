clc,clear;
a = load('pg.txt');%将原始数据保存在pg.txt中，并将A,B,C,D替换成相应的值
[nums, measures] = size(a);
b = zscore(a);%将原始数据标准化存储在b中
E = [1 4 2 8 2;1/4 1 1/2 2 1/2;1/2 2 1 4 1;1/8 1/2 1/4 1 1/4;1/2 2 1 4 1];
%E为主观设置的成对比较判断矩阵
%代表因素之间相对的重要程度
[vec,val] = eigs(E,1);%求模的最大特征值以及对应的特征向量
w = vec/sum(vec);%求归一化特征向量，即权重（权重和为1）
w = repmat(w',16,1);%扩充为与数据矩阵相同的维度
c = b .* w;%计算加权属性
cstar = max(c); %求正理想解（包含每一列的最大元素）
c0 = min(c); %求负理想解（包含每一列的最小元素）
for i = 1 : nums
    sstar(i) = norm(c(i,:) - cstar);
    %利用c(i,:) - cstar向量的范数求c(i,:)到正理想解cstar的距离
    s0(i) = norm(c(i,:) - c0);
    %求到负理想解的距离
end

f = s0 ./ (sstar + s0);%计算各个对象的排序指标值（综合评价指数）
xlswrite('book3.xls',[sstar' s0' f']);%将计算结果写入excel文件，便于将来制表
[sc, ind] = sort(f,'descend');%求排序结果
xlswrite('result.xls',[ind' sc']);%将排序结果写入excel文件
