clc,clear;
load yj.txt;
y = pdist(yj,'cityblock'); 
%求yj的两两行向量之间的绝对值距离
%euclidean：欧氏距离
%seuclidean：标准欧几里得距离
%cityblock：绝对值距离
%minkowski：Minkowski距离
%chebychev：chebychev距离
%mahalanobis：mahalanobis距离
%hamming：hamming距离
%cosine：两向量夹角的余弦
%correlation：样本的相关系数
%spearman：样本的spearman秩相关系数
%jaccard：jaccard系数
yc = squareform(y); %变换成距离方阵
z = linkage(y);%产生聚类等级树
dendrogram(z);%画聚类图
nums = input('请选择分类的数目：');
T = cluster(z,'maxclust',nums);%把对象划分成3类
for i = 1:nums
    tm = find(T == i);%求属于第i类的对象
    tm = reshape(tm,1,length(tm));%变成行向量
    fprintf('第%d类的有%s\n',i,int2str(tm));%显示分类结果(int2str变整数为字符串)
end
