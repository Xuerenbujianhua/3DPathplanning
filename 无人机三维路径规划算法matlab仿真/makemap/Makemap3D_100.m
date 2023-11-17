%共有：A1:C1281，为计算方便只读取一部分
function map = Makemap3D_100
%三个不同规模地图中的规划效果
Ddata = xlsread('3D_data.xlsx','sheet1','A1:C101');
X = Ddata(:,1).*0.1;%x列参数命名 数据缩放，便于绘制和观察
Y = Ddata(:,2).*0.1;%y列参数命名
Z = Ddata(:,3).*2;%z列参数命名
width = 10; %建筑物底面宽度
height =10; %建筑物底面长度
%关闭警告
warning('off')
%% 创建栅格地图
data_size = 500; % 栅格大小 
% 创建一个大小为500x500x500的空白三维矩阵
data = zeros(data_size, data_size, data_size); 
%三维地图数据赋值-----建筑物群
for i = 1:size(Ddata,1)
    x = X(i);
    y = Y(i);
    z = Z(i);
    %data为三维0-1矩阵，存储地图数据，数值为1表示此处存在障碍物
    data(x:(x+width),y:(y+height),1:z) = 1;
end
%% 绘图
plot3DMap(data);
map = data;
