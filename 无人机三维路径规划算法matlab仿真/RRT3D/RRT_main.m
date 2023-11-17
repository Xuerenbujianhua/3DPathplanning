%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！


function [rrt_path,rrt_cost,Number_of_searches,Number_of_successful_searches,Number_of_failed_searches] = RRT_main(source,goal,map,step)
%参数设置
[x_max,y_max,z_max ] = size(map);%地图范围
stepsize = step; %步长
threshold = 5; %阈值threshold：距离目标点的距离，小于该阈值则认为到达目标点
maxFailedAttempts = 10000;%最大迭代次数

searchSize = [x_max y_max z_max];  %搜索空间
RRTree = double([source -1]);%起点入树
pathFound = false;%是否找到可行路径
Number_of_searches = 0;%记录搜索过的总栅格数目：成功+失败
Number_of_successful_searches = 0;%搜索成功的数目
Number_of_failed_searches=0;%失败的搜索数目
%% 循环
failedAttempts = 0;
while failedAttempts <= maxFailedAttempts  % 循环增长rrt
    %% 选择一个随机配置
    Number_of_searches= Number_of_searches+1;%产生一个节点则统计数目加一
    if rand < 0.4
        sample = ceil(rand(1,3) .* searchSize);   % r随机样本整数
    else
        sample = goal; % 以样本为目标，使树生成偏向目标
    end
    %% 选择RRT树中最接近qrand的节点
    %min(B,[],dim)返回维度 dim(1行/2列) 上的最小元素 
    %A接收最小值，I接收最小值的行位置
    [A, I] = min( distanceCost3(RRTree(:,1:3),sample) ,[],1); % 求每一列的最小值
    closestNode = floor(RRTree(I(1),1:3));
    %% 在qrand的方向上从qrand最近移动一段增量距离
%     %方法一：
%     %计算直线的参数形式
%     p1 = closestNode; p2 = sample; v = p2 - p1;
%     %syms t;line = p1 + t*v;
%     % 计算直线长度
%     line_length = norm(v);
%     % 计算新点的位置
%     % 距离起点stepsize个单位长度
%     newPoint = floor(p1 + (stepsize / line_length) * v);  % 沿着直线方向移动
%     %方法二
    movingVec = [sample(1)-closestNode(1),sample(2)-closestNode(2),sample(3)-closestNode(3)];
    movingVec = movingVec/sqrt(sum(movingVec.^2));  %单位化
    newPoint = floor(closestNode + stepsize * movingVec);
    newPoint_isfeasible = checkPath3(closestNode, newPoint, map);
    
     if ~newPoint_isfeasible % 是否将树中最近的节点扩展到新点是可行的
        failedAttempts = failedAttempts + 1;
        Number_of_failed_searches=Number_of_failed_searches+1;
        continue;
     end
    %新节点可行,则该统计数目加1
    Number_of_successful_searches = Number_of_successful_searches+1;
    %到达目标点
    if distanceCost3(newPoint,goal) < threshold, pathFound = true; break; end 
    [A, I2] = min( distanceCost3(RRTree(:,1:3),newPoint) ,[],1); % 检查新节点是否已经存在于树中
    if distanceCost3(newPoint,RRTree(I2(1),1:3)) < threshold, failedAttempts = failedAttempts + 1; continue; end 
    
    RRTree = [RRTree; newPoint I(1)]; % 添加节点
    failedAttempts = 0;
    
    %plot3([closestNode(1);newPoint(1)],[closestNode(2);newPoint(2)],[closestNode(3);newPoint(3)],'LineWidth',1); 
    %pause(0.01);%暂停方便观察
end
if pathFound, plot3([closestNode(1);goal(1)],[closestNode(2);goal(2)],[closestNode(3);goal(3)]); end
if ~pathFound, disp('no path found. maximum attempts reached'); end
%% 从父信息检索路径
path = goal;
prev = I(1);
while prev > 0
    path = [RRTree(prev,1:3); path];
    prev = RRTree(prev,4);
end
%计算路径长度
pathLength = 0;
for i=1:length(path(:,1))-1, pathLength = pathLength + distanceCost3(path(i,1:3),path(i+1,1:3)); end 

rrt_path = path;%返回结果
rrt_cost=pathLength;

