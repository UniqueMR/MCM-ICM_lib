%设一随机系统的状态空间E = {1,2,3,4},记录观测系统所处的状态如下：
%4	3	2	1	4	3	1	1	2	3
%2	1	2	3	4	4	3	3	1	1
%1	3	3	2	1	2	2	2	4	4
%2	3	2	3	1	1	2	4	3	1
%若该系统可以用马氏模型描述，则估计转移概率pij
clc,clear,format rat %有理分数的数据格式
a = [4	3	2	1	4	3	1	1	2	3
2	1	2	3	4	4	3	3	1	1
1	3	3	2	1	2	2	2	4	4
2	3	2	3	1	1	2	4	3	1];
a = a';
a = a(:)';%将a转化为行向量
for i = 1 : 4
    for j = 1 : 4
        f(i,j) = length(findstr([i j],a)); %统计子字符串'ij'的个数（由状态i转换为状态j出现了多少次）
    end
end
ni = sum(f,2); %计算矩阵的行和
phat = f ./ repmat(ni,1,size(f,2));%求状态转移的频率（保证在任何i下pj的和为1）
format%恢复到短小数的显示格式