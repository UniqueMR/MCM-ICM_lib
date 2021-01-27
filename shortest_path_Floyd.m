clear,clc;
n = 6;a = zeros(n);%邻接矩阵初始化
a(1,2) = 50;a(1,4) = 40;a(1,5) = 25;a(1,6) = 10;
a(2,3) = 15;a(2,4) = 20;a(2,6) = 25;
a(3,4) = 10;a(3,5) = 20;
a(4,5) = 10;a(4,6) = 25;
a(5,6) = 55;
%录入路径距离
a = a + a';%由于图为无向图，邻接矩阵为对角矩阵
a(a == 0) = inf;%将所有没有两通的节点路权设为∞
a([1:n+1:n^2]) = 0;%对角线元素替换成0（Matlab中数据是逐列存储的）
path = zeros(n);%path用来存储最短路径下终点的前一个节点,0表示没有前一个节点，即直接到达
for k = 1 : n
    for i = 1 : n
        for j = 1 : n %利用i和j遍历邻接矩阵
            if a(i,j) > a(i,k) + a(k,j)%检查经过k节点会不会使得路径变得更短
                a(i,j) = a(i,k) + a(k,j);%更新路径长度
                path(i,j) = k;%更新最短路径下的前一个节点
            end
        end
    end
end