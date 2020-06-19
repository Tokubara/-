function [y,count]=solveSOR(A,b,omega,st,ep,max_iter)
    n=size(A,1);
    if(nargin==2), st=zeros(n,1);ep=1E-3;max_iter=300;omega=1.2;
    elseif(nargin==3)
        st=zeros(n,1);ep=1E-3;max_iter=300;
    end
    function x=getnewx(x)
        % global x;
        % y=zeros(n,1);
        for(i=1:n)
            x(i)=x(i)*(1-omega)+omega*(b(i)-sum(A(i,:).*x')+A(i,i)*x(i))/A(i,i);
        end
    end
x=st;
y=getnewx(x); %只是为了做到do while
count=0;
while(norm(x-y,inf)>=ep)
    x=y;
    y=getnewx(x);
    count=count+1;
    if(count>max_iter)
        error('不收敛');
    end
end
end