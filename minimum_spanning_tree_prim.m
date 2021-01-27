clc,clear;
a = zeros(7);%初始化邻接矩阵
a(1,2) = 50;a(1,3) = 60;
a(2,4) = 65;a(2,5) = 40;
a(3,4) = 52;a(3,7) = 45;
a(4,5) = 50;a(4,6) = 30;a(4,7) = 42;
a(5,6) = 70;%设置路径权值
a = a + a';%构造对角阵，表示无向图
a(a == 0) = inf;%没有路径用权值无穷大表示
result(1 : length(a)) = inf;%result用来存储结果，即最小生成树
pb(1:length(a)) = 0;pb(1) = 1;%pb存放标号信息，i顶点成为Pi标号时pb(i) = 1，否则pb(i) = 0
minDist(1:length(a)) = inf;%minDist存放当前节点所能到达的所有的节点的路径权值
parent = 1;result(1) = parent;%parent指向当前所处的位置
index = 2;%结果向量的索引

while sum(pb) < length(a)%遍历所有的节点后结束
    tb = find(pb == 0);%找到所有尚未遍历的节点
    for i = tb
        if minDist(i) > a(parent,i)
            minDist(i) = a(parent,i);
        end
    end%更新minDist列表
    temp = find(minDist == min(minDist));%找到minDist列表中最小的路径所对应的节点
    temp = temp(1);%最小路径的节点可能有很多个，取其中的第一个
    pb(temp) = 1;parent = temp;minDist(temp) = inf;%标记该节点为已遍历，将该节点作为新的观察点，该路径退出比较（路权视作∞）
    result(index) = temp;index = index + 1;%更新结果向量
end