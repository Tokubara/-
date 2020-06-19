function [res,count]=dampedNewton(f_,df_,st,mode,ep)
    %count表示迭代次数
    if(nargin==3), ep=1E-4;mode=true; %默认有阻尼
    elseif(nargin==4)
        ep=1E-4;
    end
    max_iter=600;
    x0=st;
    count=0;
    while(true)
        count=count+1;
        tmp=f_(x0)/df_(x0); %之后多次计算要用，这里先存下来
        x1=x0-tmp; %初始的x1
        if(mode) %如果要求用阻尼
        lambda=1;
        while(abs(f_(x1))>abs(f_(x0))) %应该是绝对值的减小吧，不是真减小
            %所以是为什么需要i呢？
            x1=x0-lambda*tmp;
            lambda=lambda/2;
        end
        %fprintf("x=%d,lambda:%d\n",x1,lambda);
        end
        if(abs(x0-x1)<ep || abs(f_(x1))<ep)
            break
        elseif(count>max_iter)
            error("不收敛");
        end
        x0=x1;
    end
    res=x1;
