function FeedBack = Caculate_Ka(den ,constant_den ,ts)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
m = 1; n = 1;
for Ka = -100 : 0.01 : 100
    den(4) = Ka + constant_den;
    
    A = Routh(den);
    
    if A == 1
        p(m) = Ka;
        m = m + 1;
    end
end
ResultMin = p(1);
ResultMax = p(m-1);

for Ka = ResultMin :0.01 : ResultMax
    den(4) = Ka + constant_den;
    num = Ka;
    sys = tf(num ,den);
    [y ,t] = step(sys);
    
    A = analysis_sys(y ,t);
    ymax = ts *1.02;
    ymin = ts *0.98;
    
    if A(3) >= ymin && A(3) <= ymax
        r2(n) = Ka;
        n = n + 1;
    end
end
   
result = (r2(1) + r2(n-1)) / 2;
FeedBack = [ResultMin/8 ,ResultMax/8 ,result/8];    
end

