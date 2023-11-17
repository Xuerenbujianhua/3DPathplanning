%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

clc;clear;close all
%载入函数路径
addpath(genpath('./ACO3D'))
addpath(genpath('./Astar3D'))
addpath(genpath('./RRT3D'))
addpath(genpath('./Evaluation'))
Algorithm_name={'ACO','Astar','RRT'};
%地图规模在Makemap3D函数中设置
map = Makemap3D;%地图
source=[10 10 1]; %起点
goal=[450 400 50];%终点
max_item = 1000;%最大迭代次数
comparative_data ={};%记录需要比较的内容
Global_data={};
Straight_distance = sqrt(sum((source-goal).^2, 2));%直线距离
fprintf('起点到终点的直线距离： \n%d\n\n',Straight_distance); 
Global_data(1,end+1) = {num2str(source)};
Global_data(1,end+1) = {num2str(goal)};
Global_data(1,end+1) = {Straight_distance};
t1=clock;
%% ********蚁群算法********************************
figure(1)
plot3DMap(map);
text(source(1),source(2),source(3),'起点','color','r');
text(goal(1),goal(2),goal(3),'终点','color','r');
scatter3(source(1),source(2),source(3),"filled","g");
scatter3(goal(1),goal(2),goal(3),"filled","b");
title('ACO');
popNum = 10; %蚁群数量
tic
[aco_path,aco_cost,aco_Number_of_searches,aco_Number_of_successful_searches,aco_Number_of_failed_searches] = aco(source,goal,map,popNum);%蚁群主函数
aco_time = toc;
fprintf('ACO 历时：%0.3f 秒\n',aco_time); 
hold on
plot3(aco_path(:,1),aco_path(:,2),aco_path(:,3),'LineWidth',2,'color','r');
view(-30,30);
fprintf('ACO 路径长度：%d \n\n',aco_cost); 
[aco_max_turning_angle,aco_turning_num,aco_index] = Max_turning_angle(aco_path,1);
comparative_data(1,end+1) = {aco_time};
comparative_data(2,end) = {aco_cost};
comparative_data(3,end) = {size(aco_path,1)};
comparative_data(4,end) = {aco_Number_of_searches};
comparative_data(5,end) = {aco_Number_of_successful_searches};
comparative_data(6,end) = {aco_Number_of_successful_searches/aco_Number_of_searches};
comparative_data(7,end) = {aco_max_turning_angle};
comparative_data(8,end) = {aco_turning_num};
%% ************Astar********************************
figure(2)
plot3DMap(map);
text(source(1),source(2),source(3),'起点','color','r');
text(goal(1),goal(2),goal(3),'终点','color','r');
scatter3(source(1),source(2),source(3),"filled","g");
scatter3(goal(1),goal(2),goal(3),"filled","b");
title('Astar');
tic%计算运行时间
[astar_path,astar_cost,astar_Number_of_searches,astar_Number_of_successful_searches,astar_Number_of_failed_searches] = Astar_main(source,goal,map,max_item);%A*主函数
astar_time = toc;
fprintf('Astar 历时：%0.3f 秒\n',astar_time); 
plot3(astar_path(:,1),astar_path(:,2),astar_path(:,3),'LineWidth',2,'color','r');
view(-30,30);
fprintf('Astar 路径长度：%d\n\n',astar_cost); 
[astar_max_turning_angle,astar_turning_num,astar_index] = Max_turning_angle(astar_path,1);
%记录展示数据
comparative_data(1,end+1) = {astar_time};
comparative_data(2,end) = {astar_cost};
comparative_data(3,end) = {size(astar_path,1)};
comparative_data(4,end) = {astar_Number_of_searches};
comparative_data(5,end) = {astar_Number_of_successful_searches};
comparative_data(6,end) = {astar_Number_of_successful_searches/astar_Number_of_searches};
comparative_data(7,end) = {astar_max_turning_angle};
comparative_data(8,end) = {astar_turning_num};

%% ****************RRT********************************
% subplot(1,3,3); 
figure(3)
plot3DMap(map);
text(source(1),source(2),source(3),'起点','color','r');
text(goal(1),goal(2),goal(3),'终点','color','r');
scatter3(source(1),source(2),source(3),"filled","g");
scatter3(goal(1),goal(2),goal(3),"filled","b");
title('RRT');
step = 10;%设置步长
tic
[rrt_path,rrt_cost,rrt_Number_of_searches,rrt_Number_of_successful_searches,rrt_Number_of_failed_searches] = RRT_main(source,goal,map,step);%RRT主函数
rrt_time = toc;
fprintf('RRT 历时：%0.3f 秒\n',rrt_time); 
plot3(rrt_path(:,1),rrt_path(:,2),rrt_path(:,3),'LineWidth',2,'color','r');
view(-30,30);
fprintf('RRT 路径长度：%d \n\n',rrt_cost); 
[rrt_max_turning_angle,rrt_turning_num,rrt_index] = Max_turning_angle(rrt_path,1);
%记录搜索覆盖范围
comparative_data(1,end+1) = {toc};
comparative_data(2,end) = {rrt_cost};
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

%三种算法展示到一张图中
figure(4)
plot3DMap(map);
text(source(1),source(2),source(3),'起点','color','r');
text(goal(1),goal(2),goal(3),'终点','color','r');
h1 = plot3(aco_path(:,1),aco_path(:,2),aco_path(:,3),'LineWidth',2,'color','r');
h2 = plot3(astar_path(:,1),astar_path(:,2),astar_path(:,3),'LineWidth',2,'color','k');
h3 = plot3(rrt_path(:,1),rrt_path(:,2),rrt_path(:,3),'LineWidth',2,'color','m');
legend([h1,h2,h3],'蚁群','A*','RRT')
%legend("boxoff")
view(-30,30);



