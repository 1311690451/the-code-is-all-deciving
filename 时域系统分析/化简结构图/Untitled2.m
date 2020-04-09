t = 0 : 0.01 : 12;

%---------------------- a ----------------------------%
%p134-3.7-a
%输出：化简函数，阶跃响应图
sysg1 = tf([1], [1 ,0 ,0]);
sysa = feedback(sysg1 ,[1])

figure(1);
step(sysa ,t);grid;
[a.y ,a.x] = step(sysa ,t);
xlabel('t');ylabel('c(t)');title('a step response');
%---------------分析动态性能指标-------------------------%
A = analysis(a.y ,a.x ,t);
%---------------分析动态性能指标-------------------------%
%---------------------- a ----------------------------%

%---------------------- b ----------------------------%
%p134-3.7-b
%输出：化简函数，阶跃响应图
b.sysg1 = tf([1 ,1] ,[1]);
b.numg2 = [1]; b.deng2 = [1 ,0 ,0];
b.sysg2 = tf(b.numg2 ,b.deng2);
sysb = feedback(series(b.sysg1 ,b.sysg2) ,[1])

figure(2);
step(sysb ,t);grid;
[b.y ,b.x] = step(sysb ,t);
%---------------分析动态性能指标-------------------------%
B = analysis(b.y ,b.x ,t);
%---------------分析动态性能指标-------------------------%

xlabel('t');ylabel('c(t)');title('b step response');
%---------------------- b ----------------------------%

%---------------------- c ----------------------------%
%p134-3.7-c
%输出：化简函数，阶跃响应图
c.sysg1 = tf([1] ,[1 ,0 ,0]);
c.sysg2 = tf([1 ,0] ,[1]);
c.sysg3 = [1];
sysc = feedback(c.sysg1 ,parallel(c.sysg2 ,c.sysg3))

figure(3);
step(sysc ,t);grid;
[c.y ,c.x] = step(sysc ,t);
%---------------分析动态性能指标-------------------------%
C = analysis(c.y ,c.x ,t);
%---------------分析动态性能指标-------------------------%

xlabel('t');ylabel('c(t)');title('c step response');
grid;
%---------------------- c ----------------------------%

%---------------------- 列表 ----------------------------%
%输入：计算之后a，b，c结构体
%输出表格
disp('notice: tr:上升时间 tp:峰值时间  ts：调节时间   pos:超调量');
name = {'a' ;'b' ;'c'};
tr = [A(1) ;B(1) ;C(1)];
tp = [A(2) ;B(2) ;C(2)];
ts = [A(3) ;B(3) ;C(3)];
pos = [A(4) ;B(4) ;C(4)];
table(tr ,tp ,ts ,pos ,'RowNames',name)
%---------------------- 列表 ----------------------------%