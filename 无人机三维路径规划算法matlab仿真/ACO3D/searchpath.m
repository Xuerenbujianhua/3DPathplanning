%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

function [flag,judges,paths,pheromone,Number_of_searches,Number_of_successful_searches,Number_of_failed_searches]=searchpath(PopNum,pheromone,point1,point2,mapdata)
%% 该函数用蚁群算法的搜索路径
%judges            是否成功搜索到路径
%PopNum            input     蚂蚁数量
%pheromone         input    信息素
%mapdata           input    地图高度
%point1,point2     input    开始点
%path              output   规划路径
%pheromone         output   信息素

%% 搜索参数
xcMax=1; %蚂蚁横向最大变动
ycMax=1; %蚂蚁纵向最大变动
zcMax=1; %蚂蚁垂直最大变动
decr=0.99;  %信息素衰减概率
[x_max,y_max,z_max] = size(mapdata);%获取地图大小
judges=ones(1,PopNum);
paths=cell(1,PopNum);
flag=0;
Number_of_searches=0;
Number_of_successful_searches=0;
Number_of_failed_searches=0;

%% 循环搜索路径
for pi=1:PopNum
    len=1;
    path(len,1:3)=point1(1:3);
    NowPoint=point1(1:3);
    while distance(NowPoint(1),NowPoint(2),NowPoint(3),point2(1),point2(2),point2(3))
        count=1;
        %% 计算点的适应度值
        for x=-xcMax:xcMax
            for y=-ycMax:ycMax
                for z=-zcMax:zcMax
                    Number_of_searches = Number_of_searches+1;
                    %数据处理
                    if x==0&&y==0&&z==0
                        continue;
                    end
                    %新节点受否在地图范围内
                    if((NowPoint(1)+x<=y_max)&&(NowPoint(2)+y<=x_max)&&(NowPoint(3)+z<=z_max)&&NowPoint(1)+x>0&&NowPoint(2)+y>0&&NowPoint(3)+z>0)
                        %此处互换了x和y的位置？
                        %若此时当前节点在障碍物内，则跳过本次循环
                        if mapdata(NowPoint(2)+y,NowPoint(1)+x,NowPoint(3)+z)~=0
                            Number_of_failed_searches=Number_of_failed_searches+1;
                            continue;
                        end
                        
                        NextPoint(count,:)=[NowPoint(1)+x,NowPoint(2)+y,NowPoint(3)+z];
                        qfz(count)=CacuQfz(NextPoint(count,:),NowPoint,point2,mapdata);
                        qz(count)=qfz(count)*pheromone(NextPoint(count,1),NextPoint(count,2),NextPoint(count,3));
                        %qz(count)=pheromone(NextPoint(count,1),NextPoint(count,2),NextPoint(count,3));
                        if   qz(count)==0
                            continue;
                        else
                            count=count+1;
                            Number_of_successful_searches=Number_of_successful_searches+1;
                        end
                    end
                    
                %x,y,z    
                end
            end
        end
        
        if count==1
            len=round(2*len/3);
            NowPoint=path(1,1:3);
            continue;
        end
        
        
        % 选择下一个点
        [max_1,index]=max(qz);%找到启发值最大点(26个点)
        temp_m=find(qz==max_1);%找到点的位置
        index_m=randperm(size(temp_m,2),1);%size(temp_m,2)返回temp_m列的个数
        index=temp_m(index_m);
        
       %%  轮盘赌更简单方式
%          P = qz/sum(qz);% 轮盘赌法选择下一个访问城市
%          Pc = cumsum(P);     %累加函数，把前几个累加到1
%          target_index = find(Pc >= rand);
%          index = target_index(1);        
        %% 基于轮盘赌法选择下一个点
%        if isempty(find(qz==inf,1))==0
%            index=find(qz==inf,1);
%       else
%            if rand>5
%                sum_qz=qz/sum(qz);
%                P_qz=cumsum(sum_qz);
%                index=find(P_qz>=rand);
%            else
%                [max_1,index]=max(qz);               
%                temp_m=find(qz==max_1);
%                index_m=randperm(size(temp_m,2),1);
%                index=temp_m(index_m);
%            end
%        end
       
        %debug
        assert(isempty(NextPoint)==0)
        assert(isempty(qz)==0)
        assert(isempty(index)==0)


        oldpoint=NextPoint(index(1),:);
        %assert(isequal(NowPoint,oldpoint))
        NowPoint=oldpoint;
        pheromone(oldpoint(1),oldpoint(2),oldpoint(3))=decr*pheromone(oldpoint(1),oldpoint(2),oldpoint(3));
        
        %路径保存，最多10000*3
        len=len+1;
        if len>10000
            judges(1,pi)=0;
            flag=1;%flag==1表示在10000次搜索之后没有没有找到一条路径
            break;
        end
        path(len,1:3)=NowPoint;
        NextPoint=[];
        qz=[];
        qfz=[];
    end
    
    paths{1,pi}=path;
    path=[];
end
