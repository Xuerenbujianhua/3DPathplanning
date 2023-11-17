%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

%检查新扩展路径是否会经历障碍物，若途径障碍物则不可行
function feasible=checkPath3(node,newPos,map)
    feasible=false;%默认路径不可行
    %判断新旧节点是否在可行范围内
    if (feasiblePoint3(node,map) && feasiblePoint3(newPos,map))
        %判断新旧节点的连线是否穿越障碍物
        p1 = node;
        p2 = newPos;
        % 计算直线的参数形式和长度
        v = p2 - p1; line_length = norm(v);
        % 计算均匀分布的点的点的数目
        num_points = ceil(line_length);
        point_distances = linspace(0, line_length, num_points);
        points_on_line = repmat(p1, num_points, 1) + (point_distances' ./ line_length) * v;
        %遍历直线上的所有点，以判断直线是否经过障碍物
        points_on_line_floor = floor(points_on_line);
        feasible_path=true;
        for i = 1:num_points
            x = points_on_line_floor(i,1);
            y = points_on_line_floor(i,2);
            z = points_on_line_floor(i,3);
            if map(x,y,z) ~= 0%此处遭遇障碍物
               
                feasible_path=false;
                              break;
            end
        end%for
        
       if feasible_path
           
        feasible=true;
       end
    end%if
    
    
    
    
end






% function feasible=checkPath3(node,newPos,map)
% feasible=true;%默认路径可行
% 
% movingVec = [newPos(1)-node(1),newPos(2)-node(2),newPos(3)-node(3)];
% movingVec = movingVec/sqrt(sum(movingVec.^2)); %单位化
% for R=0:0.5:sqrt(sum((node-newPos).^2))
%     posCheck=node + R .* movingVec;
%     %ceil向上取整,floor向下取整
%     if ~(feasiblePoint3(ceil(posCheck),map) && feasiblePoint3(floor(posCheck),map))
%         feasible=false;break;
%     end
% end
% if ~feasiblePoint3(newPos,map), feasible=false; end
% end





