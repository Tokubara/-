format long
eps=1E-16;
M=1;
h=logspace(-16,0,50);
true=cos(1);
round_err=2*eps./h;
trunc_err=M*h/2;
total_err=round_err+trunc_err;
loglog(h,round_err,'--'...
,h,trunc_err,'--',h,total_err,'--',h,abs(true-(sin(1+h)-sin(1))./h),'-')
legend('舍入误差限','截断误差限','总误差限','真实误差')
axis([1E-16 1 1E-17 1])