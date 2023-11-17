%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

function fitness=CacuFit(judges,paths,PopNum)
%% 该函数用于计算个体适应度值(路径长度+飞行平均高度）
%path       input     路径
%fitness    input     路径

fitness=ones(1,PopNum);
for pi=1:PopNum
	path=paths{1,pi};
	[n,m]=size(path);
	fit_temp=sum(path,1)/n;%sum(a,2)行之和
	if judges(1,pi)==0%不可到达
		judge=inf;
	else
		judge=1;
	fitness(pi)=judge*(fit_temp(3)+n);
    end
end
