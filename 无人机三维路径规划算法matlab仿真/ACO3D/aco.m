%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

function [path,aco_cost,Number_of_searches,Number_of_successful_searches,Number_of_failed_searches]=aco(point1,point2,mapdata,popNum)
PopNum=popNum;    %种群个数
BestFitness=[];     %最佳个体
iter_max=100;%迭代次数
[x_max,y_max,z_max] = size(mapdata);%获取地图大小
%% 信息素初始化
pheromone=ones(x_max,y_max,z_max);
pheromone=initial_pheromone(pheromone,point2,mapdata);
Number_of_searches=0;
Number_of_successful_searches=0;
Number_of_failed_searches=0;
%初始化搜索路径
[flag,judges,paths,pheromone,number_of_searches,number_of_successful_searches,number_of_failed_searches]=searchpath(PopNum,pheromone,point1,point2,mapdata);
%计算搜索的栅格数目
Number_of_searches = Number_of_searches+number_of_searches;
Number_of_successful_searches=Number_of_successful_searches+number_of_successful_searches;
Number_of_failed_searches=Number_of_failed_searches+number_of_failed_searches;

fitness=CacuFit(judges,paths,PopNum);           %适应度计算
[bestfitness,bestindex]=min(fitness);           %最佳适应度
bestpath=paths{1,bestindex};                    %最佳路径
%[worstfitness,worstindex]=max(fitness);		%最坏适应度
%worstpath=paths{1,worstindex};					%最坏路径
BestFitness=[BestFitness;bestfitness];          %适应度值记录

%% 信息素更新
rou=0.3;%信息素衰减系数
cfit=200/bestfitness;%信息素增量
[n,m]=size(bestpath);
for i=1:n
    %根据具体更新相应的信息素
	pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))=(1-rou)*pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))+rou*cfit;
end

maxpathcost=[];
%% 循环寻找最优路径
for iter=1:iter_max
    %% 路径搜索
    Number_of_searches = Number_of_searches+1;
    if flag==1
        break;
    end
    [flag,judges,paths,pheromone,Number_of_searches,Number_of_successful_searches,Number_of_failed_searches]=searchpath(PopNum,pheromone,point1,point2,mapdata);
    Number_of_searches = Number_of_searches+number_of_searches;
    Number_of_successful_searches=Number_of_successful_searches+number_of_successful_searches;
    Number_of_failed_searches=Number_of_failed_searches+number_of_failed_searches;

    %% 适应度值计算更新
    fitness=CacuFit(judges,paths,PopNum);%适应度越小越好
    [newbestfitness,newbestindex]=min(fitness);
    
    
    if newbestfitness<bestfitness
        bestfitness=newbestfitness;
		bestpath=paths{1,newbestindex};   
    end
    
    %%画图用,figure(2)
    %maxpathcost_1=path_cost(bestpath);
    %maxpathcost=[maxpathcost;maxpathcost_1];
    
    %画出实时路线
     %plot3(bestpath(:,1),bestpath(:,2),bestpath(:,3),'LineWidth',1,'color','r');
     %pause(0.01); %暂停方便观察
    
	BestFitness=[BestFitness;bestfitness];
    
    %% 更新信息素
    cfit=200/bestfitness;
	[n,m]=size(bestpath);
	for i=1:n
		pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))=(1-rou)*pheromone(bestpath(i,1),bestpath(i,2),bestpath(i,3))+rou*cfit;
    end
   
end%for

% 最佳路径
path = bestpath;
%aco_cost=bestfitness;最佳适应度

%计算路径长度
pathLength = 0;
for i=1:length(bestpath(:,1))-1
    pathLength = pathLength + distance(bestpath(i,1),bestpath(i,2),bestpath(i,3),bestpath(i+1,1),bestpath(i+1,2),bestpath(i+1,3));
end 
aco_cost = pathLength;




	




