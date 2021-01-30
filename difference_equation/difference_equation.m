%问题：每月交保费200元到59岁年底，60岁开始领取养老保险每月2282元，25岁起投保。假定人的寿命为75岁。求保险公司为了兑现保险责任，每月应该有多少投资收益率
clc,clear;
M = 600;N = 420;p = 200;q = 2282;
%M代表600个月（50年）
%N代表420个月（35年）
eq = @(x) x^M - (1 + q/p) * x^(M-N) + q/p;
x = fzero(eq,[1.0001,1.5]);