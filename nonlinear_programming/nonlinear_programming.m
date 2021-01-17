[x, y] = fmincon('func1', rand(3,1), [],[],[],[],zeros(3,1),[],'func2');
%优化函数fmincon[x,fval,exitflag,output,lambda,grad,hessian]=fmincon（fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)；
%输入：fun：要求解的函数 x0：函数fun参数值初始化 A,b：参数值的线性不等式约束 Aeq,beq：参数值的线性等式约束
%lb,ub：参数值的上界和下界 nonlcon：参数值的非线性约束
%输出：x：最优参数值 fval：最优参数值位置处目标函数的值
x,y = y;
