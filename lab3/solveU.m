function x=solveU(U,b)
    %解这个方程Ux=b，其中U是一个上三角矩阵
if(~istriu(U)),error('U不是上三角矩阵');end
n=size(U,1);
if(n~=size(b,1)||size(b,2)~=1),error('U和b的形状不对');end
x=zeros(n,1);
for(i=fliplr(1:n))
    x(i)=b(i);
    for(j=(i+1):n) %这里不需要fliplr
        x(i)=x(i)-x(j)*U(i,j);
    end
    x(i)=x(i)/U(i,i);
end