function [y,count]=solveIter(A,b,mode,st) 
    %mode=1/2/3分别是Jacobi/GS/SOR，而st是迭代的起点
    %对一些参数的设定
    max_iter=30000;
    omega=1.25;
    n=size(A,1);
    if(nargin==3), st=zeros(n,1);end
    function x=getNewGSx(x)
        for i=1:n
            x(i)=(b(i)-sum(A(i,:).*x')+A(i,i)*x(i))/A(i,i);
        end
    end
    function x=getNewSORx(x)
        % global x;
        % y=zeros(n,1);
        for i=1:n
            x(i)=x(i)*(1-omega)+omega*(b(i)-sum(A(i,:).*x')+A(i,i)*x(i))/A(i,i);
        end
    end
    function y=getNewJacobix(x) %其实这样会慢，本来可以用并行的，但是没想到怎么弄
        y=zeros(n,1);
        for i=1:n
            y(i)=b(i)/A(i,i)-(sum(A(i,:).*x')-A(i,i)*x(i))/A(i,i);
        end
    end
    function y=getnewx(x)
    switch mode
        case 1
            y=getNewJacobix(x);
        case 2
            y=getNewGSx(x);
        case 3
            y=getNewSORx(x);     
    end
    end
x=st;
y=getnewx(x); %只是为了做到do while
count=0;
while(true)
    x=y;
    y=getnewx(x);
    count=count+1;
    if(abs(max(x-y))<1E-3)
        break
    elseif(count>max_iter)
        error('不收敛');
    end
end
end