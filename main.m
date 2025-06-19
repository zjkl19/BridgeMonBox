function main()
% main  ——  BridgeMonBox 入口（R2023b）
%
% 修改下方两行，设置本次批量绘图的时间段

tStart = datetime("2023-08-01 00:00:00");
tEnd   = datetime("2023-08-31 23:59:59");

generate_group_boxplots(tStart, tEnd);   % 调用核心函数
end
