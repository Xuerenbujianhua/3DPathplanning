%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

function qfz=CacuQfz(point_next,point_now,point_end,mapdata)
%% 该函数用于计算各点的启发值（越大越好）
% point_next    input    下个点坐标
% point_now     input    当前点坐标
% point_end     input    终点坐标
% mapdata       input    地图数据
% qfz           output    启发值

%% 判断下个点是否可达，不可达为0
if mapdata(point_next(2),point_next(1),point_next(3))==0
    S=1;%无障碍物
else
    S=0;
end

%% 计算启发值
%D距离
D=5000/(sqrt((point_next(1)-point_end(1))^2 + (point_next(2)-point_end(2))^2 + (point_next(3)-point_end(3))^2));
% 计算高度
M=20/point_next(3);

%计算启发值
qfz=S*(M+D);

