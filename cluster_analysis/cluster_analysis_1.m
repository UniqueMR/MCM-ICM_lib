clc,clear;
load yj.txt;%提取销售员业绩矩阵
[m,n] = size(yj);%提取评价指标个数n和销售员个数m
d = zeros(m);
d = mandist(yj'); %求矩阵向量组之间的两两绝对距离（dij表示销售员i和销售员j之间的距离）
d = tril(d);%截取下三角元素
nd = nonzeros(d);%去掉d中的0元素，非0元素按列排列
nd = union([],nd);%去掉重复的非零元素，并按照由小到大的顺序排列
for i = 1:m-1 %m个评价对象最多需要m - 1次合成
    nd_min = min(nd);
    [row,col] = find(d == nd_min);%找到业绩绝对距离最小的两组销售员
    tm = union(row,col);%将业绩差距最小的两组销售员归为一类
    tm = reshape(tm,1,length(tm));%把数组tm变成行向量
    fprintf('第%d次合成，平台高度为%d时的分类结果为：%s\n',i,nd_min,int2str(tm));
    nd(nd == nd_min) = [];%删除已经归类的元素
    if length(nd) == 0
        break;
    end
end
