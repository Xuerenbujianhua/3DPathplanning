%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

function pheromone=initial_pheromone(pheromone,point_end,mapdata)
%% 
%point_end   input       终点
%pheromone   output      信息素
[x_max,y_max,z_max] = size(mapdata);%获取地图大小
for x=1:x_max
    for y=1:y_max
        for z=1:z_max
            pheromone(x,y,z)=5000/distance(x,y,z,point_end(1),point_end(2),point_end(3));
        end
    end
end
