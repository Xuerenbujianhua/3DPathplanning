%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

%bezier路径平滑算法，暂时未考虑平滑之后的路径是否穿越障碍物
function bezier_path = bezier( vertices )
%vertices ：待平滑路径
NumPoint=size(vertices,1)-1;%点的个数
t=0:1/100:1;
x=[];y=[];z=[];
x=(1-t).^(NumPoint)*vertices(1,1);
y=(1-t).^(NumPoint)*vertices(1,2);
z=(1-t).^(NumPoint)*vertices(1,3);
 for j=1:NumPoint
      w=factorial(sym(NumPoint))/(factorial(sym(j))*factorial(sym(NumPoint-j)))*(1-t).^(NumPoint-j).*t.^(j);
      x=x+w*vertices(j+1,1);
      y=y+w*vertices(j+1,2);
      z=z+w*vertices(j+1,3);  
end
%返回结果
bezier_path=[];
bezier_path(:,1) = x;
bezier_path(:,2) = y;
bezier_path(:,3) = z;
end