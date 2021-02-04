clc,clear;
a = zeros(6);%邻接矩阵初始化
a(1,2) = 50;a(1,4) = 40;a(1,5) = 25;a(1,6) = 10;
a(2,3) = 15;a(2,4) = 20;a(2,6) = 25;
a(3,4) = 10;a(3,5) = 20;
a(4,5) = 10;a(4,6) = 25;
a(5,6) = 55;
%录入路径距离
a = a + a';%由于图为无向图，邻接矩阵为对角矩阵
a(a == 0) = inf;%将所有没有两通的节点路权设为∞
pb(1:length(a)) = 0;pb(1) = 1;%pb存放标号信息，i顶点成为Pi标号时pb(i) = 1，否则pb(i) = 0
index1 = 1;%index1存放标号顶点顺序
index2 = ones(1,length(a));%index2存放标号顶点索引: 到第i顶点最短通路中第i顶点前一顶点的序号
d(1:length(a)) = inf;d(1) = 0;%d存放由起始点到第i顶点最短通路的值
temp = 1;%最新的P标号的顶点

while sum(pb) < length(a)%当仍有点没有被遍历到的时候，执行循环
    tb = find(pb == 0);%找到没有成为标号的节点
    d(tb) = min(d(tb),d(temp) + a(temp,tb));%更新temp节点所能到达节点的路径
    tmpb = find(d(tb) == min(d(tb)));%找到temp节点能到达的所有节点中路径最短的那个节点
    temp = tb(tmpb(1));%跳到新的节点%可能有多个点同时达到最小值，只能取其中的一个
    pb(temp) = 1;%标记说明新的节点已经到达
    index1 = [index1,temp];%按顺序记录已经到达的节点
    temp2 = find(d(index1) == d(temp) - a(temp,index1));
    index2(temp) = index1(temp2(1));%找到第i顶点最短通路中第i顶点前一顶点的序号
end

d, index1,index2;

as = sparse(a);
view(biograph(as,[],'ShowW','ON'));
    