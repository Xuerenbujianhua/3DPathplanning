%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

%% 定义基础数据，包括地图行列的长度，起点位置等
function [astar_path,astar_cost,Number_of_searches,Number_of_successful_searches,Number_of_failed_searches] = Astar_main(source,goal,map,max_item)
%Number_of_failed_searches 尚未使用

%Number_of_searches ;%记录搜索过的总栅格数目：成功+失败
dy_SearchArea =[];  % 动态绘制搜索区域
sideMAX = 1;%计算f时h的权值
Max_item = max_item;%最大迭代次数
Number_of_searches = 0;%记录搜索过的总栅格数目：成功+失败
Number_of_successful_searches = 0;%搜索成功的数目
Number_of_failed_searches=0;%失败的搜索数目
%% 建立openList和closeList
% 初始时，openList只有起点，closeList为空
% openList（n*6）记录点的位置信息，G、H、F值
openList = [source,0,0,0];
% closeList记录位置信息和距离权值F值
closeList = [];
%% 初始化path，即从起点到地图任意点的路径矩阵(n*2)***************************
% 对于起点，其路径是已知的，写入起点路径
path = source;
%% ******A*算法***************************
item = 0;% 运行次数
while item<=Max_item
    %sfprintf('第 %d 次迭代\n',item);
    item = item+1;   
    %1.搜索移动代价最小的节点,并返回其行数，min函数返回值为[值，位置]
    [~,idxNode] = min(openList(:,6));%f值在openList的第六列
    node = openList(idxNode,1:3);%将代价最小的节点坐标作为父节点
    % 2、判断是否搜索到终点
    if isequal(node,goal)
        break
    end
    % ******3、在openList选中最小的F值点作为父节点
    %返回父节点的所有可行子节点
    nextNodes = Astat_NextNode(map,closeList,node);
    Number_of_searches=Number_of_searches+26;%搜索总数
    % *******4、判断父节点周围子节点情况，并将子节点依次添加或者更新到openList中
    for i = 1:size(nextNodes,1)
        nextNode = nextNodes(i,:);
        Number_of_successful_searches=Number_of_successful_searches+1;    
        % 计算代价函数
        rowNode=node(1);colNode=node(2);heightNode=node(3); 
        row_nextNode=nextNode(1);col_nextNode=nextNode(2);height_nextNode=nextNode(3);
        row_goalPos=goal(1);col_goalPos=goal(2);height_goalPos=goal(3);
        %原本的g值 + 通常意义上的模，欧几里德范数
        g = openList(idxNode,4)+ norm( [rowNode,colNode,heightNode] -[row_nextNode,col_nextNode,height_nextNode]);
        %计算h   
       
        h = (abs(row_goalPos - row_nextNode) + abs(col_goalPos - col_nextNode)+abs(height_goalPos - height_nextNode));
        %计算f
        f = g +sideMAX * h;
        
        % 判断该子节点是否存在在openList中
        [inOpen,idx_nextNode] = check_isnumber(nextNode, openList);
        % ******如果存在，则需要比较F值，取F值小的更新F和G、H同时更新路径
        if inOpen && f < openList(idx_nextNode,6)
            openList(idx_nextNode,4) = g;
            openList(idx_nextNode,5) = h;
            openList(idx_nextNode,6) = f;
            %由于画图的原因，此处了交换的x和y，同Astat_NextNode函数一样;
            path = [path;nextNode(1),nextNode(2),nextNode(3)];
        end
        % *******如果不存在，则添加到openList表中
        if ~inOpen
            openList(end+1,:) = [nextNode,g,h,f];
            path = [path;nextNode(1),nextNode(2),nextNode(3)];
        end
        dy_SearchArea = [dy_SearchArea;nextNode];
    end
    
    % 将父节点从openList中移除，添加到closeList中
    closeList(end+1,: ) = [openList(idxNode,1:3), openList(idxNode,6)];
    openList(idxNode,:)= [];
     %画出实时路线
     %plot3(closeList(:,1),closeList(:,2),closeList(:,3),'LineWidth',1,'color','r');
     %pause(0.01); %暂停方便观察
   
end
%% 返回结果

% 计算路径长度 
%计算路径长度
% pathLength = 0;
% for i=1:length(closeList(:,1))-1
%     pathLength = pathLength + distanceCost3(closeList(i,1:3),closeList(i+1,1:3));
% end 
pathLength = closeList(end,4);%路径长度

astar_path = closeList;%返回结果
astar_cost = pathLength;

%fprintf('Astar总搜索数目：%d \nAstar搜索成功的数目 ：%d\nAstar路径点数 ：%d\n\n',Number_of_searches,Number_of_successful_searches,size(closeList));











