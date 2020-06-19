function [d1,d2]=lab3(n,db)
    %db是一个数，没
    H=hilbMatrix(n);
    x=ones(n,1);
    b=H*x;
    if(nargin==1)
        my_x=solveSPD(H,b);
        d1=norm(b-H*my_x,Inf);
        d2=norm(my_x-x,Inf);
    elseif(nargin==2)
        b1=b+db*ones(n,1);
        my_x=solveSPD(H,b1);
        d1=norm(b1-H*my_x,Inf); %这里要不要加上扰动，看到一些人的做法是要加的
        d2=norm(my_x-x,Inf);
    end
        