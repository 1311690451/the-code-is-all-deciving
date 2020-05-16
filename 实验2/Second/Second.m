% K1 = 3;    K2 = 2;  K3 = 1;
% den1 = [0.5 ,1];   den3 = conv([1 ,1] ,[0.25 ,1]);
% g1 = tf([K1] ,den1);  g2 = K2;     g3 = tf([K3] ,den3);
% sys = feedback(series(series(g1 ,g2) ,g3) ,[1]);
K = 1;          ts = 4.00;                            %init
num = [8*K];    den = [1 7 14 8*(1+K)];             %抽象形式
A = Caculate_Ka(den ,8 ,ts);

den(4) = 8 + 8 * A(3);
num = A(3) * 8;

[z ,p ,k] = tf2zp(num ,den);
sys = zpk(z ,p ,k);

sysn2 = tf(num ,den);
t = 0 : 0.01 :12;
[y ,t] = step(sysn2 ,t);
B = analysis_sys(y ,t);
pos = B(4);
B(3)

figure(1);
pzmap(sys);

sprintf('k取值范围%.2f~%.2f\n',A(1) ,A(2))
sprintf('调节时间为4s时，k值为：%.2f\n',A(3))

sprintf('特征根：')
roots(den)                                 %特征根

sprintf('\n超调量为：%f\n' ,pos)
