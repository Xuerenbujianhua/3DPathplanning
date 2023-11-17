%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

function nextNodes = Astat_NextNode(map,closeList,node)
% ASTAT_NEXTNODE 对父节点周围的26个节点(三维空间中的26个临近方向)进行判断
    % 判断内容需要排除超过边界之外的、位于障碍区的、位于closeList中的三大类
[rows, cols,heights] = size(map);                             % 获取地图尺寸
r = node(1);  %父节点的位置
c = node(2);
h = node(3);
% 移动方向矩阵
movePos = [-1,1,0;0,1,0;1,1,0;-1,0,0;1,0,0;-1,-1,0;0,-1,0;1,-1,0;
     -1,1,1;0,1,1;1,1,1;-1,0,1;1,0,1;-1,-1,1;0,-1,1;1,-1,1;
     -1,1,-1;0,1,-1;1,1,-1;-1,0,-1;1,0,-1;-1,-1,-1;0,-1,-1;1,-1,-1;
     1,1,1;-1,-1,-1];      
nextNodes = [];  % 存放子节点线性索引位置的的矩阵(1*n)

% closeList内第一列存放点的索引值，单独拎出第一列来进行判断是否在closeList中
% closenode作为临时变量初始为空
closenode = [];                                         
% if的目的是为了保证初始的closeList=[]有效                                                       
if ~isempty(closeList)                                  
    closenode = closeList(:,1:3);
end
for i = 1:26
    y = r+movePos(i,1);%由于画图的原因，此处交换的x和y
    x = c+movePos(i,2);
    z = h +movePos(i,3);
    %移动之后仍在地图范围中
    if (1<x&&x<= cols) && (1<y&&y<= rows) && (1<z&&z<= heights)
        nextSub = [y,x,z];%由于画图的原因，此处交换的x和y
        if map(x, y, z) == 0 %此处无障碍物
            %检查是否在闭列表中
            [ismember,~] = check_isnumber(nextSub, closenode);
            if ~ismember
                nextNodes(end+1,:) = nextSub;%不在则添加进子节点
                
            end
  
        end
    end
end