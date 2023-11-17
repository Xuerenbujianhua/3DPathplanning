%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

%根据数据绘制三维地图
function plot3DMap(data)
p = patch(isosurface(data,0.5)); % 绘制立方体，并返回patch对象
p.FaceColor = [0 0 1]; % 将立方体上色为蓝色
p.EdgeColor = 'none'; % 隐藏立方体边缘
set(p, 'FaceColor', 'interp', 'EdgeColor', 'none');
% 获取顶点和颜色
v = get(p, 'Vertices');
c = interp1(linspace(min(v(:, 3)), max(v(:, 3)), 256), jet(256), v(:, 3));
% 设置颜色
set(p, 'FaceVertexCData', c);
axis equal; % 设置坐标轴刻度相等
% 设置坐标轴标签
xlabel('X方向');
ylabel('Y方向');
zlabel('Z方向');
% 保持不关闭
hold on