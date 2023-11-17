%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！
% 需考虑的评价指标：
% 平滑性
% 最大转角 30-45度 
% 鲁棒性
% 最小转弯次数
% 搜索回报率 = 找到的解决方案数量 / 扩展的节点数量 
% 覆盖面积 
% 距离 
% 时间 
% 轨迹优化：保证曲率的连续性

%飞行速度 8m/s-16m/s
%飞行高度 30-50m
%飞行距离 5km
%A*（A-star）是一种启发式算法，也称为最佳优先搜索算法
%启发式算法的搜索路径可能不是最短路径
%subplot(1,3,1); 
function Show_Comparative_result(Global_data,comparative_data)
%comparative_data:表格中要展示的数据
f = uifigure;
t = uitable(f, 'Data', comparative_data);
t.RowName = {' 搜索耗时(s) ', ' 路径长度(m) ', ' 路径栅格数目(航点数目) ',' 总搜索栅格数目 ',' 可行的栅格数目 ','搜索回报率','最大转弯角(度)','转弯超过45度的次数(次)','优化后最大转弯角度','优化后转弯超过5度的次数','优化后路径长度（米）'};%行名称
t.ColumnName = {'ACO','Astar','RRT','最优项'};%列名称
t.ColumnWidth = {90, 90, 90};
t.Position = [20 60 510 230];%规划表格位置
%Position中四位数字
%left 父容器的内部左边缘与表的外部左边缘之间的距离
%bottom	父容器的内部下边缘与表的外部下边缘之间的距离
%width	表的左右外部边缘之间的距离
%height	表的上下外部边缘之间的距离

b = uitable(f, 'Data', Global_data);
b.ColumnName = {'起点','终点','起点到终点的直线距离(m) '};%列名称
b.ColumnWidth = {90, 90};
b.Position = [20 330 400 52];%规划表格位置



