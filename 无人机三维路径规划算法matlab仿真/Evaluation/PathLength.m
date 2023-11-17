%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

function pathLength = PathLength(path)
pathLength=0;
for i=1:length(path(:,1))-1
    pathLength = pathLength + distance(path(i,1),path(i,2),path(i,3),path(i+1,1),path(i+1,2),path(i+1,3));
end 

