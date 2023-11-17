%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

%检测当前point在map中是否发生碰撞，若碰撞则该点不可行
function feasible=feasiblePoint3(point,map)
feasible=false;%默认不可行
%向下取整，以保证索引在栅格地图中的合理性
x = floor(point(1));
y = floor(point(2));
z = floor(point(3));
%获取地图范围，并防止越界
[x_max,y_max,z_max ] = size(map) ;
if x > y_max || y >x_max || z>z_max || x<=0 || y<=0|| z<=0
        feasible = false;
else %若不越界则判断是否可行
    %在地图中交换了x，y的位置
   %fprintf('x=%d  y=%d z=%d\n',x,y,z); 
     if map(y,x,z) == 0 %未发生碰撞
            feasible = true;%则可行
     end

end

end
