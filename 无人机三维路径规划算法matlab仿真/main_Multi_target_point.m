%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

%多目标点的路径规划
clc;clear;close all
%载入函数路径
addpath(genpath('./ACO3D'))
addpath(genpath('./Astar3D'))
addpath(genpath('./RRT3D'))
addpath(genpath('./makemap'))
addpath(genpath('./Evaluation'))
Algorithm_name={'ACO','Astar','RRT'};
%地图规模在Makemap3D函数中设置
map = Makemap3D_100;%地图
goal=[10 10 50;100 150 120;100 350 20;430 150 50];%起点与目标点
max_item = 10000;%最大迭代次数
comparative_data ={};%记录需要比较的内容
Global_data={};
Straight_distance = 'NULL';%直线距离
fprintf('多目标点路径规划\n\n'); 
Global_data(1,end+1) = {num2str(goal(1,:))};
Global_data(1,end+1) = {num2str(goal(end,:))};
Global_data(1,end+1) = {Straight_distance};
%resolution =1;%栅格的边长
% num = ceil(sqrt(sum(([abs(source(1)-goal(1)), abs(source(2)-goal(2)), abs(source(3)-goal(3))] / resolution ).^2)));
% fprintf('起点到终点直线方向栅格数： \n%d\n\n',num); 
t1=clock;
%% ********蚁群算法********************************
figure(1)
plot3DMap(map);
title('ACO');
text(goal(1,1),goal(1,2),goal(1,3),'起点','color','r');
text(goal(end,1),goal(end,2),goal(end,3),'终点','color','r');
popNum = 10; %蚁群数量
aco_length=0;
tic
aco_path=[];
for i =1:size(goal,1)-1
    scatter3(goal(i,1),goal(i,2),goal(i,3),"filled","g");
    scatter3(goal(i+1,1),goal(i+1,2),goal(i+1,3),"filled","b");
    [temp_path,aco_cost,aco_Number_of_searches,aco_Number_of_successful_searches] = aco(goal(i,:),goal(i+1,:),map,popNum);%蚁群主函数
    aco_path = [aco_path;temp_path];
    aco_length = aco_length+aco_cost;
end
aco_time = toc;
fprintf('ACO 历时：%0.3f 秒\n',aco_time); 
hold on
plot3(aco_path(:,1),aco_path(:,2),aco_path(:,3),'LineWidth',2,'color','r');
view(-30,30);
fprintf('ACO 路径长度：%d \n\n',aco_cost); 
[aco_max_turning_angle,aco_turning_num,aco_index] = Max_turning_angle(aco_path,1);
comparative_data(1,end+1) = {aco_time};
comparative_data(2,end) = {aco_length};
comparative_data(3,end) = {size(aco_path,1)};
comparative_data(4,end) = {aco_Number_of_searches};
comparative_data(5,end) = {aco_Number_of_successful_searches};
comparative_data(6,end) = {aco_Number_of_successful_searches/aco_Number_of_searches};
comparative_data(7,end) = {aco_max_turning_angle};
comparative_data(8,end) = {aco_turning_num};
%% ************Astar********************************
figure(2)
plot3DMap(map);
text(goal(1,1),goal(1,2),goal(1,3),'起点','color','r');
text(goal(end,1),goal(end,2),goal(end,3),'终点','color','r');
title('Astar');
astar_length=0;
tic%计算运行时间
astar_path=[];
for i =1:size(goal,1)-1
    scatter3(goal(i,1),goal(i,2),goal(i,3),"filled","g");
    scatter3(goal(i+1,1),goal(i+1,2),goal(i+1,3),"filled","b");
    [temp_path,astar_cost,astar_Number_of_searches,astar_Number_of_successful_searches,astar_Number_of_failed_searches] = Astar_main(goal(i,:),goal(i+1,:),map,max_item);%A*主函数
    astar_path = [astar_path;temp_path];
    astar_length=astar_length+astar_cost;
end
astar_time = toc;
fprintf('Astar 历时：%0.3f 秒\n',astar_time); 
plot3(astar_path(:,1),astar_path(:,2),astar_path(:,3),'LineWidth',2,'color','r');
view(-30,30);
fprintf('Astar 路径长度：%d\n\n',astar_cost); 
[astar_max_turning_angle,astar_turning_num,astar_index] = Max_turning_angle(astar_path,1);
%记录展示数据
comparative_data(1,end+1) = {astar_time};
comparative_data(2,end) = {astar_length};
comparative_data(3,end) = {size(astar_path,1)};
comparative_data(4,end) = {astar_Number_of_searches};
comparative_data(5,end) = {astar_Number_of_successful_searches};
comparative_data(6,end) = {astar_Number_of_successful_searches/astar_Number_of_searches};
comparative_data(7,end) = {astar_max_turning_angle};
comparative_data(8,end) = {astar_turning_num};


%% ****************RRT********************************
figure(3)
plot3DMap(map);
text(goal(1,1),goal(1,2),goal(1,3),'起点','color','r');
text(goal(end,1),goal(end,2),goal(end,3),'终点','color','r');
title('RRT');
step = 10;%步长
rrt_length=0;
rrt_path=[];
tic
for i =1:size(goal,1)-1
    scatter3(goal(i,1),goal(i,2),goal(i,3),"filled","g");
    scatter3(goal(i+1,1),goal(i+1,2),goal(i+1,3),"filled","b");
    [temp_path,rrt_cost,rrt_Number_of_searches,rrt_Number_of_successful_searches,rrt_Number_of_failed_searches] = RRT_main(goal(i,:),goal(i+1,:),map,step);%RRT主函数
    rrt_path = [rrt_path;temp_path];
    rrt_length = rrt_length+rrt_cost;
end
rrt_time = toc;
fprintf('RRT 历时：%0.3f 秒\n',rrt_time); 
plot3(rrt_path(:,1),rrt_path(:,2),rrt_path(:,3),'LineWidth',2,'color','r');
view(-30,30);
fprintf('RRT 路径长度：%d \n\n',rrt_length); 
[rrt_max_turning_angle,rrt_turning_num,rrt_index] = Max_turning_angle(rrt_path,1);
%记录搜索覆盖范围
comparative_data(1,end+1) = {toc};
comparative_data(2,end) = {rrt_length};
comparative_data(3,end) = {size(rrt_path,1)};
comparative_data(4,end) = {rrt_Number_of_searches};
comparative_data(5,end) = {rrt_Number_of_successful_searches};
comparative_data(6,end) = {rrt_Number_of_successful_searches/rrt_Number_of_searches};
comparative_data(7,end) = {rrt_max_turning_angle};
comparative_data(8,end) = {rrt_turning_num};
%% 打印运行时间
t2=clock;
fprintf('程序总运行时间：%0.3f 秒\n\n', etime(t2,t1));
%计算最优项 ，其中展示表格顺序为aco、astar、rrt
comparative_data(1,end+1) = {Algorithm_name{Min_value(comparative_data{1,1},comparative_data{1,2},comparative_data{1,3})}};
for i = 2:size(comparative_data,1)
    %求每行的最小值
    comparative_data(i,end) = {Algorithm_name{Min_value(comparative_data{i,1},comparative_data{i,2},comparative_data{i,3})}};
end
%求最大值
comparative_data(6,end) = {Algorithm_name{Max_value(comparative_data{6,1},comparative_data{6,2},comparative_data{6,3})}};


%展示比较结果
Show_Comparative_result(Global_data,comparative_data)


%% 三种算法展示到一张图中
figure(4)
plot3DMap(map);
title('多目标点路径规划');
text(goal(1,1),goal(1,2),goal(1,3),'起点','color','b');
for i =1:size(goal,1)-1
    nowPointName = "目标点"+num2str(i);
    scatter3(goal(i+1,1),goal(i+1,2),goal(i+1,3),"filled","k");
    text(goal(i+1,1),goal(i+1,2),goal(i+1,3),nowPointName,'color','r');
end
h1 = plot3(aco_path(:,1),aco_path(:,2),aco_path(:,3),'LineWidth',2,'color','r');
h2 = plot3(astar_path(:,1),astar_path(:,2),astar_path(:,3),'LineWidth',2,'color','k');
h3 = plot3(rrt_path(:,1),rrt_path(:,2),rrt_path(:,3),'LineWidth',2,'color','m');
legend([h1,h2,h3],'蚁群','A*','RRT')
%legend("boxoff")
view(-30,30);