%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

%返回路径中的最大转弯角、最大转弯次数，最大转角位置，
function [max_turning_angle,turning_num,index] = Max_turning_angle(path,flag)
n = size(path, 1);
angale_list = [];
%限制最大转弯角度为45度
if flag==1 
    Restricted_turning_angle = 45;
else 
    Restricted_turning_angle = 15;
end
turning_num = 0;%记录超过最大转弯角的转弯次数
for i = 2:n-1
    % 计算向量v1和v2
    v1 = path(i, 1:3) - path(i-1, 1:3);
    v2 = path(i+1, 1:3) - path(i, 1:3);
    % 计算向量v1和v2的夹角
    cos_theta = dot(v1, v2) / (norm(v1) * norm(v2));
    turning_angle = acos(cos_theta) * 180 / pi;%弧度制下的夹角大小，通过将弧度转换为角度得到角度制下的夹角
    % 更新最大转弯角
    angale_list = [angale_list;turning_angle];
    if turning_angle > Restricted_turning_angle
        turning_num  = turning_num+1;
    end
end
[max_turning_angle,index] = max(angale_list);%求最大转弯角及其位置
end