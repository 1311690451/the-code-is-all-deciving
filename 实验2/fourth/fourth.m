%pos 为超调量
%ts为超调量
num = [1 1.5 0.5];  den = conv([1 0] ,conv([20 1] ,conv([10 1] ,[0.5 1])));
G0 = tf(num ,den);
sys = feedback(G0 ,1);
figure(1);
rlocus(sys);
[k,p]=rlocfind(sys)

K = 280;
G1 = K * G0;
sysn2 = feedback(G1 ,1);                         %传递函数

[y ,t] = step(sysn2);
A = analysis_sys(y ,t);
pos(1) = A(4); 
ts(1) = A(3);

t = 0 :0.005 :40;u = t;
figure(2);
lsim(sysn2 ,u ,t);grid;                      %单位斜坡输入响应

figure(3);
sysne = tf(-1 ,cell2mat(sysn2.den));
step(sysne);grid;                               %单位阶跃扰动
%===============================================================%
den3 = cell2mat(sysn2.num)/K;   num_c = cell2mat(sysn2.den);
num3 = num_c(5) / K;
Gp = tf(num3 ,den3);

sys3 = series(Gp ,sys);                             %根轨迹概略得传递函数

figure(4);
rlocus(sys3);
[k,p]=rlocfind(sys3)

sys4 = series(Gp ,sysn2);

[y2 ,t2] = step(sys4);
B = analysis_sys(y2 ,t2);
pos(2) = B(4);
ts(2) = B(3);


t = 0 :0.005 :15;u = t;
figure(5);
lsim(sys4 ,u ,t);grid;                      %单位斜坡输入响应

figure(6);
sysne2 = tf(-1 ,cell2mat(sys4.den));
step(sysne2);grid;                               %单位阶跃扰动

fprintf('两个系统的超调量分别为%.2f\t%.2f\n',pos(1),pos(2))
fprintf('两个系统的调节时间分别为%.2f\t%.2f\n',ts(1),ts(2))