基于栅格地图的无人机三维路径规划算法matlab代码

1.代码结构说明
ACO3D：包含蚁群算法的全部内容，其入口函数aco.m
Astar3D：包含A*算法的全部内容，其入口函数Astar_main.m
RRT3D：包含RRT算法的全部内容，其入口函数RRT_main.m
Evaluation:包含算法评价的全部内容，包括计算距离、路径长度、最大转弯角
Makemap3D：包含设计的不同规模的地图，此文件可有可无
3D_data.xlsx :三维地图数据，此数据可以根据自己的需求更改
bezier.m  :贝塞尔曲线路径平滑算法
main.m:主函数入口，其中所有文件名中带“main”的都是可运行的函数入口，其区别在于调用的地图不同。
Makemap3D.m：制作三维地图数据，可以在此设计自己的三维地图
plot3DMap.m：根据数据绘制三维地图
Show_Comparative_result.m：将算法评价的结果以表格的形式展现出来

注：
（1）三种路径规划算法都可独立运行，可以选择删除main函数中的内容，也可以选择自己编写main函数来
调用路径规划算法的入口函数
（2）遇到不知含义的参数，可以选择更改参数大小并查看运行结果的变化来推断参数的作用

2.运行版本：
matlab 2021a及以上
若打开后出现中文乱码，则是由于版本不符合的原因，可以选择复制代码到新文件或更换版本。


3.参考：

Bilibili：https://www.bilibili.com/video/BV1Qz4y1a7sY/?spm_id_from=333.999.0.0&vd_source=c5d972a40f6877b991f3c691467df568

CSDN：https://blog.csdn.net/qq_51985653/article/details/130354767

统一ID：雪人不见花









