%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

%共有：A1:C1281，为计算方便只读取一部分
function map = Makemap3D
%三个不同规模地图中的规划效果
%1：  51，500
%2：  1000，1000
%3：  51,1000
Ddata = xlsread('3D_data.xlsx','sheet1','A1:C101');
X = Ddata(:,1).*0.1;%x列参数命名 数据缩放，便于绘制和观察
Y = Ddata(:,2).*0.1;%y列参数命名
Z = Ddata(:,3).*2;%z列参数命名
%此处规定无人机大小：1m x 1m x 0.5 m
%一般居民楼顶层面积为150平方米,此处定义为15*10
width = 15; %建筑物底面宽度
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
%% 创建障碍物/禁飞区域，根据具体情况而定
%创建障碍物时，需将规定区域赋非零值，该值可作为该区域的权值
%权值越大，表示飞行经过此区域的代价越大
%可将权值按等级划分，暂定障碍物区域权值为1-10
% 围墙
% data(100:101,50:210,1:10)=1;
% data(200:201,50:210,1:10)=1;
% data(100:201,50:51,1:10)=1;
% data(100:201,210:211,1:10)=1;

%% 绘图
set(0,'defaultfigurecolor','w')
plot3DMap(data);
map = data;
%保存地图数据
save('data.mat','data');
