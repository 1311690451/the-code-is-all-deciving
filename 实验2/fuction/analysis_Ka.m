function FeedBack = analysis_Ka(den ,constant ,num1 ,num2 ,t1 ,t2)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%num step-num
%num2 step-sysne-num
global date;
p = [0 0];     Te = [0 0];
if date == 1
    m = 1;n =1;
    for Ka = -1000:1000
        den(3) = Ka * constant;
        result = roots(den);

        for i = 1 : 2
             if real(result(i)) < 0
                 FeedBack = 1;
             else
                 FeedBack = 0;
             end
        end
        if FeedBack == 1
            Real(m) = Ka;
            m = m + 1;
        end
    end
    date = date + 1;
end
if Real(1) == 0
    Real(1) = Real(1) + 1;
end
    ResultMin = Real(1);
    ResultMax = Real(m-1);
%---------------------------计算开始---------------------------%    
for Ka = ResultMin : ResultMax
    den(3) = Ka * constant;
    sys = tf(num1 ,den);   [y1 ,t1] = step(sys);
    A = analysis_sys(y1 ,t1);   
    p(1) = A(3);%储存
    
    
    sysne = tf(num2 ,den);   [y2 ,t2] = step(sysne);
    yss = y2(length(t2));
%     ymax = max(y2);  ymin = min(y2);
%     pos1 = (yss - ymax)/yss;    pos2 = (ymin - yss)/yss;
%     if pos1 <= pos2
%         pos = pos1;
%     else 
%         pos = pos2;
%     end
    
    Te(1) = yss;
    %一次重载
    if date == 2
        p(2) = p(1);  Te(2) = Te(1);
        date = date + 1;
    end
    
    if p(1) < p(2) 
        p(2) = p(1); 
        r(1) = Ka;
    end
    if Te(1) <= Te(2)
        r(2) = Ka;
        Te(2) = Te(1);
    end
end
%---------------------------计算开始---------------------------%  

% %---------------------------提高精度---------------------------% 
% for Ka = -ResultMin-1 : 0.1 :ResultMax+1
%         den(3) = Ka * constant;
%         result = roots(den);
% 
%         for i = 1 : 2
%              if real(result(i)) < 0
%                  state = 1;
%              else
%                  state = 0;
%              end
%         end
%         
%         if state == 1
%             conclusion(m) = Ka;
%             m = m + 1;
%         end
%         
%         
% end
%     ResultMin = conclusion(1);
%     ResultMax = conclusion(m - 1);
%---------------------------提高精度---------------------------% 
FeedBack = [r ,ResultMin ,ResultMax];
end

