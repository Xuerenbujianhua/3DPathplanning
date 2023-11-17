%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

function h=distanceCost3(a,b)         %% distanceCost.m
	h = sqrt(sum((a-b).^2, 2));
end