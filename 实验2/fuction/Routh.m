function FeedBack = Routh(den)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
%------------------劳斯表------------------%
row = length(den);                   %获得特征方程的阶数
den = reshape(den ,1 ,row);          %重塑特征列表
%------------------劳斯表------------------%

%------------------ 构建 ------------------%
if mod(row ,2) == 0
    list = row / 2;                   %列
else 
    list = (row + 1) / 2;
    den = [den ,0];                   %重构
end

routh = reshape(den ,2 ,list);

%=============== init ===============%
RouthTable = zeros(row ,list);       %init for routh
RouthTable(1 : 2 , :) = routh;
%=============== init ===============%
%------------------ 构建 ------------------%

%劳斯表中某行的第一列项为0，而其余项不为0或全不为零
%--------- S1(第一列为0，剩下的不为0) ------%
i = 3;
while 1
    if RouthTable(i - 1 , 1) == 0 && sum(RouthTable(i - 1, 2 : n1)) ~= 0
        den = conv(den , [1 3]);           %conv new
        row = length(den);
        if mod(row ,2) == 0
          list = row / 2;                   %列
        else 
          list = (row + 1) / 2;
          den = [den ,0];                   %重构
        end
        routh = reshape(den ,2 ,list);

        %=============== init ===============%
        RouthTable = zeros(row ,list);       %init for routh
        RouthTable(1 : 2 , :) = routh;
        %=============== init ===============%
        i = 3;
    end   
    %=============== caculate ===============%
    ai = RouthTable(i-2 , 1)/RouthTable(i-1 , 1);
    for j = 1:list - 1
        RouthTable(i ,j) = RouthTable(i-2 ,j+1)-ai * RouthTable(i-1,j+1);
    end
    %=============== caculate ===============%
%--------- S1(第一列为0，剩下的不为0) ------%

%------------------ S2(全零) --------------%
if sum(RouthTable(i ,:))==0
    k = 0;
    n = 1;
    F = zeros(1 ,list);
    %=============求导================%
    while row - i - k >= 0
        F(n) = row - i + 1 - k;
        k = k + 2;
        n = n + 1;
    end
    RouthTable(i ,:)=RouthTable(i - 1 ,:).*F(1 ,:);
    %=============求导================%
end    
%------------------ S2(全零) --------------%

%------------------  reload  --------------%
i = i + 1;
if i > row  
    break  
end
end
%------------------  reload  --------------%

%----------------- concusion  -------------%
r = find(RouthTable(: ,1) < 0);
if isempty(r) == 1
    FeedBack = 1;
else 
    FeedBack = 0;
end
%----------------- concusion  -------------%
end