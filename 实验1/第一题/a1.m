%智能1801陈智深 180407109
%version ：matlab R2020a
zeta = 0.707;num = [16];den = [1 ,8 * zeta ,16];
sys = tf(num ,den);                               %转化为传递函数
p = roots(den);                                   %roots 求多项式的根
t = 0 :0.01 :3;                                   %设定仿真时间

figure(1)                                         %创建一个窗口
impulse(sys ,t);grid                              %求取系统单位的脉冲响应    网格开
xlabel('t');ylabel('c(t)');title('impulse response');

figure(2)                                         %创建第二个窗口
step(sys ,t);grid                                 %求取系统单位的阶跃响应
xlabel('t');ylabel('c(t)');title('step response');

figure(3)
u = t;                                            %定义输入斜坡信号
lsim(sys ,u ,t ,0);grid                           %求取系统的单位斜坡响应
xlabel('t');ylabel('c(t)');title('ramp response');