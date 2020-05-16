global date;
date = 1;

Ka =20;
num = [Ka * 30];   den = [0.1 1 Ka * 30];      
sys = tf(num ,den);

figure(1);
t = 0 :0.01 :1.2;   step(sys ,t);grid;          %单位阶跃响应

figure(2);
t = 0 :0.005 :0.6;u = t;
lsim(num ,den ,u ,t);grid;                      %单位斜坡输入响应
sysne = tf(-1 ,den);

figure(3);
t = 0 :0.01 :1.2;
step(sysne ,t);grid;                            %单位阶跃扰动响应

t1 = 120;    t2 = 120;
A = analysis_Ka(den ,30 ,num ,-1 ,t1 ,t2);

fprintf('在调节时间最小的情况下K值最优解为：%d\n',A(1));
fprintf('在稳态误差最小的情况下K值最优解为：%d\n',A(2));