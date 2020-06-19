function x=solveL(L,b)
    %解这个方程Lx=b，而不是LL'=b，其中L是一个下三角矩阵
if(~istril(L)),error('L不是下三角矩阵');end
n=size(L,1);
if(n~=size(b,1)||size(b,2)~=1),error('L和b的形状不对');end
x=zeros(n,1);
for(i=1:n)
    x(i)=b(i);
    for(j=1:(i-1))
        x(i)=x(i)-x(j)*L(i,j);
    end
    x(i)=x(i)/L(i,i);
end


%希望到时候，能够把上三角矩阵方程的求解写在同一个函数
    