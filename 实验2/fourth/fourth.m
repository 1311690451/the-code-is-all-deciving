num = [1 1.5 0.5];  den = conv([1 0] ,conv([20 1] ,conv([10 1] ,[0.5 1])));
G0 = tf(num ,den);
sys = feedback(G0 ,1);
rlocus(sys);
[k,p]=rlocfind(sys)

K = 280;
G1 = K * G0;
sysn2 = feedback(G1 ,1);

figure(2);
step(sysn2);grid;
[y ,t] = step(sysn2);
A = analysis_sys(y ,t);
pos(1) = A(4);
ts(1) = A(3);

t = 0 :0.005 :40;u = t;
figure(3);
lsim(num ,den ,u ,t);grid;                      %单位斜坡输入响应
%===============================================================%
den3 = cell2mat(sysn2.num)/K;   num_c = cell2mat(sysn2.den);
num3 = num_c(5) / K;
Gp = tf(num3 ,den3);

sys3 = series(Gp ,sys);

figure(4);
rlocus(sys3);
[k,p]=rlocfind(sys3)

sys4 = series(Gp ,sysn2);

figure(5);
step(sysn2);grid;
[y2 ,t2] = step(sys4);
B = analysis_sys(y2 ,t2);
pos(2) = B(4);
ts(2) = B(3);


t = 0 :0.005 :15;u = t;
figure(6);
num_f = cell2mat(sys4.num); den_f = cell2mat(sys4.den);
lsim(num_f ,den_f ,u ,t);grid;                      %单位斜坡输入响应