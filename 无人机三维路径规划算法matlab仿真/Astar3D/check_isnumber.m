%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

function [isnumber,index] = check_isnumber(nextNode,openList)      
%检查nextNode是否在openList中，若在则返回其行
    isnumber = false;
    index = 0;
    for j = 1:size(openList,1) %按行遍历
            %if(all(ismember(nextNode, openList(j,:))))
                if(nextNode(1)==openList(j,1) && nextNode(2)==openList(j,2) && nextNode(3)== openList(j,3))
                    isnumber = true;%子节点在开列表中
                    index = j;%记录该节点的行
                    break;
                end    
            %end    
     end  