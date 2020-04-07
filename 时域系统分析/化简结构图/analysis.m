function index_date = analysis(y ,x ,t)
%计算动态性能的指标 此处显示有关此函数的摘要
%  tr   上升时间    10%-90%
%  tp   峰值时间    到峰值时间
%  pos  超调量      超出量的占比
%  ts   调节时间    上下浮动5%的时间
maxy = max(y);                      %响应的最大偏移量
yss = y(length(t));                 %响应的终值

pos = 100*(maxy - yss)/yss;         %求超调量

%------------峰值时间tp------------%
for i = 1:length(t)
    if y(i) == maxy
        n = i;end
end
tp = (n - 1)*0.01;                    %峰值时间
%------------峰值时间tp------------%

%--------------上下限-----------%
y1 = 1.05 * yss;
y2 = 0.95 * yss;

y3 = 0.1 * yss;
y4 = 0.9 * yss;
%--------------上下限--------------%

%--------------调节时间ts-----------%
i = length(t);
while i > 0
    i = i - 1;
    if y(i) >= y1 || y(i)<=y2;m = i;break;
    end
end
ts = (m-1)*0.01;                    %调节时间
%--------------调节时间ts-----------%

%--------------上升时间tr-----------%
i = 1;
while i > 0
    i = i + 1;
    if y(i) >= y3 && y(i) <= y4;m = i;
    elseif y(i) > y4;break;end
end
tr = (m - 1) * 0.01;             %上升时间
%--------------上升时间tr-----------%

index_date = [tr ,tp ,ts ,pos];
end

