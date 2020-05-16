%看分离点的k值

num = [1 20];   den = [1 24 144 0];
G0 = tf(num,den);
figure(1);

rlocus(G0);axis([-30 10 -50 50]);               %根轨迹

K = 10;
G = K*G0;
sys = feedback(G ,1);
figure(2);
t = 0 : 0.01 : 10;
step(sys,t);
axis([0 10 0 1.2]);grid;                        %单位阶跃输入响应

den2 = cell2mat(sys.den);
B = roots(den2);