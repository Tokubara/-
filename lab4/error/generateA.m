function [A,b,correct]=generateAb(ep,a,n)
    h=1/n;
    A=diag(repelem(-(2*ep+h),n-1))+diag(repelem(ep+h,n-2),1)+diag(repelem(ep,n-2),-1);
    b=repelem(a*h^2,n-1)';
    b(n-1)=b(n-1)-ep-h;
    x=(1:(n-1))/n;
    correct=(1-a)/(1-exp(-1/ep))*(1-exp(-x/ep))+a*x;